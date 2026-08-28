#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Generate filter/*.sieve from data/categories/*.yml.

    python tools/generate.py            # write the filters
    python tools/generate.py --check    # fail if the committed files differ

`data/` is the source of truth. Editing a `.sieve` by hand will be overwritten;
`--check` runs in CI so that cannot happen silently.

Only `kind: allow` domains are emitted. `block` entries become a phishing rule,
`ceded` entries belong to another category, and `tld-example` entries are never
emitted at all -- a bare `com` would match every message on the internet.
"""
import argparse
import collections
import difflib
import glob
import io
import os
import sys
import textwrap

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import yaml  # noqa: E402

WIDTH = 88
INDENT = "    "


def version():
    """Single source for the version stamped into every generated file."""
    try:
        return io.open("VERSION", encoding="utf-8").read().strip()
    except OSError:
        return "0.0.0"


# --------------------------------------------------------------------------- #
# Emitting Sieve
# --------------------------------------------------------------------------- #
def q(s):
    """Quote a Sieve string."""
    return '"%s"' % str(s).replace("\\", "\\\\").replace('"', '\\"')


def string_list(values, indent, cont=None):
    """Render ["a", "b", ...] wrapped to WIDTH, continuations indented one level."""
    items = [q(v) for v in values]
    line = "[" + ", ".join(items) + "]"
    if len(indent) + len(line) <= WIDTH:
        return [indent + line]

    cont = cont if cont is not None else indent + INDENT
    out, cur = [], indent + "["
    for i, item in enumerate(items):
        piece = item + ("," if i < len(items) - 1 else "]")
        if len(cur) + 1 + len(piece) > WIDTH and cur.strip() != "[":
            out.append(cur)
            cur = cont + piece
        else:
            cur = cur + (" " if cur.rstrip().endswith(",") else "") + piece
    out.append(cur)
    return out


def patterns(rec):
    """Patterns for one domain record.

    `subdomains` deliberately emits TWO patterns rather than the shorthand
    `*example.com`. That shorthand is a suffix match, so `*ea.com` (EA) also
    matches `ikea.com` and `silversea.com`, and `*box.com` (Box) also matches
    `xbox.com`. 127 such collisions were shipping in v0.2.0.
    """
    scope = rec.get("scope") or "subdomains"
    m = rec["match"]
    if rec.get("kind") == "block":
        # login.payp4l.com is as malicious as payp4l.com, so a blocklist entry
        # always covers subdomains whatever scope the source recorded.
        return [m, "*." + m]
    if scope == "exact":
        return [m]
    if scope == "subdomains-only":
        return ["*." + m]
    return [m, "*." + m]


def test_lines(rule, allowed, indent):
    """Render the test of one rule as Sieve source lines."""
    parts = []

    doms = rule.get("domains")
    if doms:
        emit = [p for d in sorted(doms) if d in allowed for p in allowed[d]]
        if emit:
            # Keep each domain's pair adjacent rather than sorting the strings,
            # so "example.com", "*.example.com" read together.
            seen, ordered = set(), []
            for pat in emit:
                if pat not in seen:
                    seen.add(pat)
                    ordered.append(pat)
            parts.append(('address :domain :matches "from" ', ordered))

    if rule.get("subjects"):
        parts.append(('header :contains "subject" ', rule["subjects"]))
    if rule.get("from_contains"):
        parts.append(('header :contains "from" ', rule["from_contains"]))
    if rule.get("from_patterns"):
        parts.append(('header :matches "from" ', rule["from_patterns"]))

    body = []
    inner = indent + INDENT
    for i, (head, values) in enumerate(parts):
        lines = string_list(values, inner + " " * len(head), inner + INDENT)
        lines[0] = inner + head + lines[0].strip()
        body.extend(lines)
        body[-1] += ","

    if rule.get("size_under"):
        body.append("%ssize :under %s," % (inner, rule["size_under"]))
    if rule.get("size_over"):
        body.append("%ssize :over %s," % (inner, rule["size_over"]))

    if rule.get("exclude_subjects"):
        head = 'not header :contains "subject" '
        lines = string_list(rule["exclude_subjects"],
                            inner + " " * len(head), inner + INDENT)
        lines[0] = inner + head + lines[0].strip()
        body.extend(lines)
        body[-1] += ","

    if not body:
        return None

    body[-1] = body[-1].rstrip(",")

    n_terms = len(parts) + bool(rule.get("size_under")) + bool(rule.get("size_over")) \
        + bool(rule.get("exclude_subjects"))
    op = rule.get("op") or "anyof"
    # A size or exclusion test must narrow, never satisfy the gate on its own.
    if (rule.get("size_under") or rule.get("size_over") or rule.get("exclude_subjects")) \
            and n_terms > 1:
        op = "allof"

    if n_terms == 1:
        single = [l[len(INDENT):] if l.startswith(inner) else l for l in body]
        single[0] = indent + "if " + single[0].lstrip()
        single[-1] = single[-1] + " {"
        return single

    return [indent + "if %s (" % op] + body + [indent + ") {"]


def action_lines(rule, indent, expire=True):
    """Flags and filing. `expire` is emitted separately, because on a block with
    nested rules the retention is a DEFAULT: it must come after them, or it
    applies to every message instead of only the ones that fall through."""
    out = []
    for flag in rule.get("unflags") or []:
        out.append("%sremoveflag %s;" % (indent, q(flag)))
    for flag in rule.get("flags") or []:
        out.append("%saddflag %s;" % (indent, q(flag)))
    if rule.get("folder"):
        out.append("%sfileinto %s;" % (indent, q(rule["folder"])))
    if expire and rule.get("expire_days") is not None:
        out.append('%sexpire "day" %s;' % (indent, q(rule["expire_days"])))
    return out


def expire_line(rule, indent):
    if rule.get("expire_days") is None:
        return []
    return ['%sexpire "day" %s;' % (indent, q(rule["expire_days"]))]


def render_rule(rule, allowed, indent, comment=None):
    out = []
    test = test_lines(rule, allowed, indent)
    if comment:
        out.append("%s# %s" % (indent, comment))

    tiers = rule.get("tiers") or []

    if test is None:
        out += action_lines(rule, indent, expire=not tiers)
        for t in tiers:
            out += [""] + render_rule(t, allowed, indent)
        if tiers and rule.get("expire_days") is not None:
            out += ["", "%s# Default retention for anything that reached none of the"
                        " rules above." % indent]
            out += expire_line(rule, indent)
        if rule.get("stop"):
            out.append("%sstop;" % indent)
        return out

    out += test
    inner = indent + INDENT
    out += action_lines(rule, inner, expire=not tiers)
    for t in tiers:
        out.append("")
        out += render_rule(t, allowed, inner)
    if tiers and rule.get("expire_days") is not None:
        out.append("")
        out.append("%s# Default retention for anything that reached none of the rules"
                   " above." % inner)
        out += expire_line(rule, inner)
    if rule.get("stop"):
        out.append("")
        out.append("%sstop;" % inner)
    out.append(indent + "}")
    return out


# --------------------------------------------------------------------------- #
# Whole file
# --------------------------------------------------------------------------- #
def folders_of(doc):
    found = []

    def walk(rules):
        for r in rules:
            f = r.get("folder")
            if f and f not in found:
                found.append(f)
            walk(r.get("tiers") or [])

    walk(doc.get("rules") or [])
    if any(r.get("kind") == "block" for r in doc.get("domains", [])):
        blockfolder = doc.get("blocklist_folder", "Spam")
        if blockfolder not in found:
            found.append(blockfolder)
    return sorted(found)


def uses_expire(doc):
    def walk(rules):
        for r in rules:
            if r.get("expire_days") is not None:
                return True
            if walk(r.get("tiers") or []):
                return True
        return False

    return walk(doc.get("rules") or [])


def header(doc):
    lines = [
        "# %s filter -- filter/%s.sieve" % (doc["title"], doc["id"]),
        "#",
        "# GENERATED FILE -- do not edit. Edit data/categories/%s.yml and run:" % doc["id"],
        "#     python tools/generate.py",
        "#",
        "# For Proton Mail only. A paid plan is required to run this alongside other",
        "# filters: the free plan allows just one active filter at a time.",
        "#",
    ]
    lines += ["# " + l for l in textwrap.wrap(doc["description"], WIDTH - 2)]
    lines.append("#")

    fold = folders_of(doc)
    if fold:
        cur = "# Folders:"
        for i, f in enumerate(fold):
            piece = f + ("," if i < len(fold) - 1 else "")
            if len(cur) + 1 + len(piece) > WIDTH - 2:
                lines.append(cur)
                cur = "#          " + piece
            else:
                cur = cur + " " + piece
        lines.append(cur)
        lines.append("#")

    if uses_expire(doc):
        lines += [
            "# WARNING: this filter sets auto-delete timers on matched mail via",
            "#          vnd.proton.expire. Read CHANGELOG.md before installing.",
            "#",
        ]

    lines += [
        "# Install position %d of %d. Filters run in the order you install them,"
        % (doc["install_order"], doc.get("_total", doc["install_order"])),
        "# and on conflicting actions the last one wins -- see README.md for the",
        "# full order.",
        "#",
        "# Version: %s" % version(),
    ]
    return lines


def requires(doc):
    caps = ["fileinto", "imap4flags"]
    if uses_expire(doc):
        caps.append("vnd.proton.expire")
    if doc.get("whitelist") or doc.get("spam_discard"):
        caps.append("extlists")
    return "require [%s];" % ", ".join(q(c) for c in caps)


def extra_subjects(doc):
    """Keywords from keyword_groups in the languages this category enables.

    Over 700 Vietnamese, Chinese and Japanese keywords were documented in the
    legacy lists and implemented in none of the filters -- every .sieve file was
    pure ASCII, while the README advertised multi-language support.
    """
    langs = [l for l in (doc.get("languages") or ["en"]) if l != "en"]
    out = []
    for group in doc.get("keyword_groups") or []:
        for lang in langs:
            for kw in group.get(lang) or []:
                if kw not in out:
                    out.append(kw)
    return out


def render(doc, path):
    allowed = {r["match"]: patterns(r) for r in doc.get("domains", [])
               if r.get("kind") == "allow"}

    out = header(doc)
    out += ["", requires(doc), ""]

    wl = doc.get("whitelist") or []
    if wl:
        out.append("# Never touch mail from people you know.")
        if len(wl) == 1:
            out.append('if header :list "from" %s {' % q(wl[0]))
        else:
            out.append("if anyof (")
            for i, name in enumerate(wl):
                out.append('%sheader :list "from" %s%s'
                           % (INDENT, q(name), "," if i < len(wl) - 1 else ""))
            out.append(") {")
        out += [INDENT + "stop;", "}", ""]

    if doc.get("spam_discard"):
        out += [
            "# Drop what Proton already knows is spam.",
            'if header :list "from" ":incomingdefaults:spam" {',
            INDENT + "discard;",
            INDENT + "stop;",
            "}",
            "",
        ]

    blocked = sorted([r for r in doc.get("domains", []) if r.get("kind") == "block"],
                     key=lambda r: r["match"])
    if blocked:
        out += [
            "# Known typosquats of the services this filter handles. These are lookalike",
            "# domains, not the real senders -- flag them instead of filing them away.",
        ]
        head = 'if address :domain :matches "from" '
        lines = string_list([p for r in blocked for p in patterns(r)],
                            " " * len(head), INDENT)
        lines[0] = head + lines[0].strip()
        lines[-1] = lines[-1] + " {"
        out += lines
        out += [
            INDENT + "addflag %s;" % q(chr(92) + "Flagged"),
            INDENT + "fileinto %s;" % q(doc.get("blocklist_folder", "Spam")),
            "",
            INDENT + "stop;",
            "}",
            "",
        ]

    rules = doc.get("rules") or []

    # Merge the non-English keywords into the gate's subject test.
    extra = extra_subjects(doc)
    if extra and rules:
        gate = rules[0]
        gate["subjects"] = list(gate.get("subjects") or []) +             [k for k in extra if k not in (gate.get("subjects") or [])]

    for rule in rules:
        # A top-level block with no test at all applies to EVERY message. That is
        # the catch-all class of bug this project spent v0.2.1 removing, so it is
        # an error rather than something to emit and hope nobody notices.
        if test_lines(rule, allowed, "") is None:
            raise SystemExit(
                "%s: top-level rule for folder %r has no test, so it would match "
                "every message. Give it domains/subjects, or remove it."
                % (doc["id"], rule.get("folder")))
        out += render_rule(rule, allowed, "")
        out.append("")

    while out and out[-1] == "":
        out.pop()
    out.append("")
    out.append("# End of %s filter" % doc["title"])
    return "\n".join(out) + "\n"




def render_bundle(docs, spec, total):
    """Merge several categories into one script.

    Proton's free plan allows exactly ONE active filter, which makes 22 separate
    filters unusable on it. The preamble is emitted once and each category's
    rules follow in install order; every gate already ends in `stop;`, so the
    first category to match wins, exactly as it would if they were installed
    separately.
    """
    ids = spec["categories"]
    picked = docs if ids == "all" else [d for d in docs if d["id"] in ids]
    # A bundle is ONE script, so `stop;` makes the FIRST match win -- the reverse
    # of separate filters, where Proton applies every one and the LAST
    # conflicting action wins. Emitting in reverse install order makes a bundle
    # route the same way the individual filters would.
    picked = sorted(picked, key=lambda d: -d["install_order"])

    caps = ["fileinto", "imap4flags"]
    if any(uses_expire(d) for d in picked):
        caps.append("vnd.proton.expire")
    caps.append("extlists")

    fold = sorted({f for d in picked for f in folders_of(d)})

    out = [
        "# %s bundle -- bundles/%s.sieve" % (spec["title"], spec["id"]),
        "#",
        "# GENERATED FILE -- do not edit. Edit data/bundles.yml and run:",
        "#     python tools/generate.py",
        "#",
    ]
    out += ["# " + l for l in textwrap.wrap(" ".join(spec["description"].split()),
                                            WIDTH - 2)]
    out += [
        "#",
        "# This is ONE filter containing %d categories: %s."
        % (len(picked), ", ".join(d["id"] for d in picked)),
        "# Proton's free plan allows one active filter, so a bundle is the only way",
        "# to use more than one category on it.",
        "#",
    ]
    cur = "# Folders:"
    for i, f in enumerate(fold):
        piece = f + ("," if i < len(fold) - 1 else "")
        if len(cur) + 1 + len(piece) > WIDTH - 2:
            out.append(cur)
            cur = "#          " + piece
        else:
            cur = cur + " " + piece
    out += [cur, "#"]
    if any(uses_expire(d) for d in picked):
        out += [
            "# WARNING: this bundle sets auto-delete timers on matched mail via",
            "#          vnd.proton.expire. Read CHANGELOG.md before installing.",
            "#",
        ]
    out += ["# Version: %s" % version(), "", "require [%s];" % ", ".join(q(c) for c in caps), ""]

    out += [
        "# Never touch mail from people you know.",
        'if header :list "from" ":addrbook:personal" {',
        INDENT + "stop;",
        "}",
        "",
    ]
    if any(d.get("spam_discard") for d in picked):
        out += [
            "# Drop what Proton already knows is spam.",
            'if header :list "from" ":incomingdefaults:spam" {',
            INDENT + "discard;",
            INDENT + "stop;",
            "}",
            "",
        ]

    for doc in picked:
        allowed = {r["match"]: patterns(r) for r in doc.get("domains", [])
                   if r.get("kind") == "allow"}
        out += ["# " + "=" * (WIDTH - 4),
                "# %s  (install position %d of %d)"
                % (doc["title"], doc["install_order"], total),
                "# " + "=" * (WIDTH - 4), ""]

        blocked = sorted([r for r in doc.get("domains", []) if r.get("kind") == "block"],
                         key=lambda r: r["match"])
        if blocked:
            head = 'if address :domain :matches "from" '
            lines = string_list([p for r in blocked for p in patterns(r)],
                                " " * len(head), INDENT)
            lines[0] = head + lines[0].strip()
            lines[-1] += " {"
            out += lines + [
                INDENT + "addflag %s;" % q(chr(92) + "Flagged"),
                INDENT + "fileinto %s;" % q(doc.get("blocklist_folder", "Spam")),
                "",
                INDENT + "stop;",
                "}",
                "",
            ]

        rules = doc.get("rules") or []
        extra = extra_subjects(doc)
        if extra and rules:
            gate = rules[0]
            gate["subjects"] = list(gate.get("subjects") or []) +                 [k for k in extra if k not in (gate.get("subjects") or [])]
        for rule in rules:
            out += render_rule(rule, allowed, "")
            out.append("")

    while out and out[-1] == "":
        out.pop()
    out += ["", "# End of %s bundle" % spec["title"]]
    return "\n".join(out) + "\n"


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true",
                    help="fail if the committed .sieve files differ from the data")
    ap.add_argument("--out", default="filter")
    ap.add_argument("--bundle-out", default="bundles")
    args = ap.parse_args(argv)

    docs = []
    for p in sorted(glob.glob("data/categories/*.yml")):
        with io.open(p, encoding="utf-8") as fh:
            docs.append(yaml.safe_load(fh))
    docs.sort(key=lambda d: d["install_order"])
    for d in docs:
        d["_total"] = len(docs)

    drift = 0
    for doc in docs:
        path = "%s/%s.sieve" % (args.out, doc["id"])
        text = render(doc, path)
        if args.check:
            current = io.open(path, encoding="utf-8").read() if os.path.exists(path) else ""
            if current != text:
                drift += 1
                print("DRIFT  %s differs from what data/categories/%s.yml generates"
                      % (path, doc["id"]))
                for line in list(difflib.unified_diff(
                        current.split("\n"), text.split("\n"),
                        fromfile=path, tofile="generated", lineterm=""))[:14]:
                    print("    " + line)
        else:
            io.open(path, "w", encoding="utf-8", newline="\n").write(text)

    bundles = []
    if os.path.exists("data/bundles.yml"):
        with io.open("data/bundles.yml", encoding="utf-8") as fh:
            bundles = (yaml.safe_load(fh) or {}).get("bundles", [])

    for spec in bundles:
        path = "%s/%s.sieve" % (args.bundle_out, spec["id"])
        text = render_bundle(docs, spec, len(docs))
        if args.check:
            current = io.open(path, encoding="utf-8").read() if os.path.exists(path) else ""
            if current != text:
                drift += 1
                print("DRIFT  %s differs from what data/bundles.yml generates" % path)
        else:
            if not os.path.isdir(args.bundle_out):
                os.makedirs(args.bundle_out)
            io.open(path, "w", encoding="utf-8", newline="\n").write(text)

    total = len(docs) + len(bundles)
    if args.check:
        print("\n%d/%d file(s) match the data" % (total - drift, total))
        return 1 if drift else 0

    print("wrote %d filter(s) and %d bundle(s)" % (len(docs), len(bundles)))
    for spec in bundles:
        p = "%s/%s.sieve" % (args.bundle_out, spec["id"])
        print("    %-28s %8d bytes" % (p, os.path.getsize(p)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
