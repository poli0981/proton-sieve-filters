#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Lint Sieve filters against Proton Mail's dialect and against the bug classes
that shipped in v0.2.0.

    python tools/lint_proton.py [path ...]      # default: filter/

Exit code 1 if any ERROR is reported. WARNINGs do not fail the build.
"""
from __future__ import annotations

import glob
import io
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from proton_dialect import (  # noqa: E402
    CORE_COMMANDS,
    MAX_EXPIRE_DAYS,
    SUPPORTED_EXTENSIONS,
    UNSUPPORTED_REGEX_SHORTHAND,
)
from sieve_eval import as_list, parse, unq  # noqa: E402

ERROR, WARN = "ERROR", "warn"


class Report:
    def __init__(self):
        self.items = []

    def add(self, level, path, where, msg):
        self.items.append((level, path, where, msg))

    @property
    def errors(self):
        return sum(1 for lvl, *_ in self.items if lvl == ERROR)

    def print(self):
        by_path = {}
        for lvl, path, where, msg in self.items:
            by_path.setdefault(path, []).append((lvl, where, msg))
        for path in sorted(by_path):
            print("\n" + path)
            for lvl, where, msg in by_path[path]:
                tag = "ERROR" if lvl == ERROR else "warn "
                print("  %s  %-10s %s" % (tag, where, msg))
        n_err = self.errors
        print("\n%d error(s), %d warning(s)" % (n_err, len(self.items) - n_err))


def read_lines(path):
    src = io.open(path, encoding="utf-8", newline="").read()
    return src.split("\r\n") if "\r\n" in src else src.split("\n")


# --------------------------------------------------------------------------- #
# Text-level checks
# --------------------------------------------------------------------------- #
def check_text(path, rep):
    lines = read_lines(path)

    req = [(i + 1, l) for i, l in enumerate(lines) if l.strip().startswith("require")]
    if not req:
        if any(l.strip() and not l.strip().startswith("#") for l in lines):
            rep.add(ERROR, path, "require", "script has code but no require statement")
        return

    lineno, line = req[0]
    declared = set(re.findall(r'"([^"]+)"', line))

    for ext in sorted(declared):
        if ext in CORE_COMMANDS:
            rep.add(ERROR, path, "L%d" % lineno,
                    '"%s" is a core Sieve command, not a capability -- naming it in '
                    "require makes Proton reject the whole script" % ext)
        elif ext not in SUPPORTED_EXTENSIONS:
            rep.add(ERROR, path, "L%d" % lineno,
                    '"%s" is not a Proton-supported extension' % ext)

    body = "\r\n".join(l for i, l in enumerate(lines) if i + 1 != lineno)
    used = set()
    if re.search(r"^\s*fileinto\b", body, re.M):
        used.add("fileinto")
    if re.search(r"^\s*(add|set|remove)flag\b", body, re.M):
        used.add("imap4flags")
    if re.search(r"^\s*expire\s", body, re.M):
        used.add("vnd.proton.expire")
    if re.search(r"^\s*reject\b", body, re.M):
        used.add("reject")
    if ":list" in body:
        used.add("extlists")
    if re.search(r"^\s*vacation\b", body, re.M):
        used.add("vacation")

    for ext in sorted(used - declared):
        rep.add(ERROR, path, "L%d" % lineno,
                '"%s" is used but not declared in require' % ext)
    for ext in sorted(declared - used - CORE_COMMANDS):
        if ext in SUPPORTED_EXTENSIONS:
            rep.add(WARN, path, "L%d" % lineno,
                    '"%s" is declared but never used' % ext)

    for i, l in enumerate(lines, 1):
        m = re.search(r'expire\s+"day"\s+"(\d+)"', l)
        if m and int(m.group(1)) > MAX_EXPIRE_DAYS:
            rep.add(ERROR, path, "L%d" % i,
                    "expire of %s days exceeds Proton's maximum of %d"
                    % (m.group(1), MAX_EXPIRE_DAYS))

    whole = "\r\n".join(lines)
    for i, l in enumerate(lines, 1):
        if re.search(r"^\s*body\b", l) or re.search(r"[^a-z_]body\s+:", l):
            rep.add(ERROR, path, "L%d" % i,
                    "body test -- Proton cannot read message content "
                    "(zero-access encryption)")
        if ":regex" in whole:
            for sh in UNSUPPORTED_REGEX_SHORTHAND:
                if sh in l:
                    rep.add(WARN, path, "L%d" % i,
                            "regex shorthand %r is not supported by Sieve" % sh)
                    break


def check_domain_literals(path, rep, tree):
    """Validate only the strings that are actually matched against From, so that
    subject keywords such as "Invoice no." are not mistaken for hostnames."""
    seen = set()
    all_lits = set()
    for node in iter_ifs(tree):
        all_lits |= from_domains(node.arguments["test"])
    for node in iter_ifs(tree):
        for lit in from_domains(node.arguments["test"]):
            if lit in seen:
                continue
            seen.add(lit)
            d = lit.lstrip("*").lstrip(".")
            if "/" in d:
                rep.add(ERROR, path, "domain",
                        '"%s" contains a URL path; address :domain never matches one' % lit)
            elif " " in d:
                rep.add(ERROR, path, "domain",
                        '"%s" contains a space and can never match' % lit)
            elif re.search(r"[^A-Za-z0-9.\-*@_]", d):
                rep.add(WARN, path, "domain",
                        '"%s" has characters invalid in a hostname' % lit)
            elif not lit.startswith("*") and "." in d and ("*." + lit) not in all_lits:
                rep.add(WARN, path, "domain",
                        '"%s" is an exact match with no "*.%s" beside it, so '
                        "subdomains are not covered" % (lit, lit))


# --------------------------------------------------------------------------- #
# AST-level checks
# --------------------------------------------------------------------------- #
def walk_tests(test, fn):
    fn(test)
    if test.name in ("anyof", "allof"):
        for t in test.arguments["tests"]:
            walk_tests(t, fn)
    elif test.name == "not":
        walk_tests(test.arguments["test"], fn)


def iter_ifs(nodes):
    for n in nodes:
        if type(n).__name__ == "IfCommand":
            yield n
            for sub in iter_ifs(n.children):
                yield sub


def from_domains(test):
    """Domains this test matches against the From header."""
    out = set()

    def visit(t):
        if t.name == "address":
            names = [x.lower() for x in as_list(t.arguments.get("header-list"))]
            if "from" in names:
                out.update(as_list(t.arguments["key-list"]))

    walk_tests(test, visit)
    return out


def check_ast(path, rep):
    try:
        tree = parse(path)
    except SyntaxError as e:
        rep.add(ERROR, path, "parse", str(e).split(": ", 1)[-1])
        return

    # 1. `size` / `not` as a bare anyof() member satisfies the gate alone, which
    #    silently swallows every message and makes later blocks dead code.
    def flag_anyof(test):
        if test.name != "anyof":
            return
        subs = test.arguments["tests"]
        if len(subs) < 2:
            return
        for s in subs:
            if s.name in ("size", "not"):
                rep.add(ERROR, path, "logic",
                        "`%s` is one of %d anyof() members -- it satisfies the gate "
                        "alone; this should almost certainly be allof()"
                        % (s.name, len(subs)))

    for node in iter_ifs(tree):
        walk_tests(node.arguments["test"], flag_anyof)

    check_domain_literals(path, rep, tree)

    # 2. A domain tested inside a nested block but absent from the top-level
    #    gate can never be reached.
    top = [n for n in tree if type(n).__name__ == "IfCommand"]
    gate, main = set(), None
    for n in top:
        d = from_domains(n.arguments["test"])
        if len(d) > len(gate):
            gate, main = d, n
    if main is not None and gate:
        for node in iter_ifs(main.children):
            d = from_domains(node.arguments["test"])
            folder = next((unq(c.arguments["mailbox"]) for c in node.children
                           if getattr(c, "name", "") == "fileinto"), "?")
            for miss in sorted(d - gate):
                rep.add(ERROR, path, "logic",
                        '%s: "%s" is absent from the top-level gate, so no message '
                        "from it can reach this block" % (folder, miss))


# --------------------------------------------------------------------------- #
# expire tiers that overwrite each other
# --------------------------------------------------------------------------- #
def check_expire_siblings(path, rep):
    lines = read_lines(path)
    depth, cur, cur_depth, groups = 0, [], None, []
    for n, line in enumerate(lines, start=1):
        code = re.sub(r"#.*$", "", line)
        is_tier = (re.match(r'^\s*expire "day" "\d+";\s*$', line)
                   and n < len(lines) and lines[n].strip() == "}")
        if is_tier:
            if cur_depth is None or depth == cur_depth:
                cur.append(n)
                cur_depth = depth
            else:
                if len(cur) > 1:
                    groups.append(cur)
                cur, cur_depth = [n], depth
        elif re.match(r"^\s*stop;\s*$", line) and cur and cur_depth is not None and depth <= cur_depth:
            if len(cur) > 1:
                groups.append(cur)
            cur, cur_depth = [], None
        depth += code.count("{") - code.count("}")
    if len(cur) > 1:
        groups.append(cur)

    for g in groups:
        rep.add(ERROR, path, "logic",
                "%d sibling expire tiers with no stop; between them (lines %s) -- the "
                "LAST match wins, so the shortest retention silently overrides the longest"
                % (len(g), ", ".join(str(x) for x in g)))


def main(argv):
    targets = argv[1:] or ["filter"]
    files = []
    for t in targets:
        if os.path.isdir(t):
            files.extend(sorted(glob.glob(os.path.join(t, "*.sieve"))))
        else:
            files.append(t)
    if not files:
        sys.stderr.write("no .sieve files found\n")
        return 2

    rep = Report()
    for f in files:
        check_text(f, rep)
        check_ast(f, rep)
        check_expire_siblings(f, rep)

    if rep.items:
        rep.print()
    else:
        print("clean: %d file(s), no findings" % len(files))
    return 1 if rep.errors else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
