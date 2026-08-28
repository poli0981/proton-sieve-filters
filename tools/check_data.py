#!/usr/bin/env python3
"""Validate data/categories/*.yml.

    python tools/check_data.py [path ...]      # default: data/categories/

Guards the traps that made the legacy Markdown lists unsafe to generate from:

* a bare TLD classified `allow` would match every message on the internet
* a typosquat classified `allow` would allowlist a phishing domain
* the same domain owned by two categories reintroduces the conflicts this
  migration resolved

Exit code 1 on any error.
"""
import collections
import glob
import io
import os
import re
import sys

try:
    import yaml
except ImportError:  # pragma: no cover
    sys.stderr.write("PyYAML is required: pip install -r tools/requirements.txt\n")
    raise SystemExit(2)

try:
    import json
    from jsonschema import Draft202012Validator
except ImportError:  # pragma: no cover
    Draft202012Validator = None

SCHEMA = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                      os.pardir, "data", "schema", "category.schema.json")

KINDS = {"allow", "block", "tld-example", "sender", "ceded"}
SCOPES = {"subdomains", "subdomains-only", "exact"}
REQUIRED = ("id", "title", "description", "install_order", "folder", "domains")

# Restricted namespaces: only accredited institutions can register under these,
# so matching the whole suffix can be deliberate -- but only via `*.suffix`.
RESTRICTED_SUFFIXES = {
    "ac.uk", "ac.jp", "ac.nz", "edu.au", "edu.sg", "edu.my", "edu.vn",
    "edu.cn", "edu.tw", "gov.uk", "gov.au",
}

# General-purpose public suffixes. Anyone can register under these, so a filter
# matching one would pull in unrelated senders.
GENERAL_SUFFIXES = {
    "com", "org", "net", "gov", "edu", "int", "mil", "io", "co", "me", "tv",
    "co.uk", "co.jp", "co.kr", "co.in", "co.nz", "co.za", "com.au", "com.br",
    "com.cn", "com.mx", "com.my", "com.sg", "com.tr", "com.tw", "org.uk",
    "net.au", "ca", "de", "fr", "es", "it", "nl", "mx", "jp", "kr", "cn",
    "in", "au", "br", "ru", "se", "no", "dk", "fi", "pl", "pt", "ch", "at",
    "be", "ie",
}
assert not (GENERAL_SUFFIXES & RESTRICTED_SUFFIXES),     "a suffix cannot be both general-purpose and restricted"

HOSTNAME = re.compile(r"^[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?"
                      r"(\.[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?)+$")


def load(path):
    with io.open(path, encoding="utf-8") as fh:
        return yaml.safe_load(fh)


def main(argv):
    targets = argv[1:] or ["data/categories"]
    files = []
    for t in targets:
        if os.path.isdir(t):
            files.extend(sorted(glob.glob(os.path.join(t, "*.yml"))))
        else:
            files.append(t)
    if not files:
        sys.stderr.write("no data files found\n")
        return 2

    errors, warnings = [], []
    owners = collections.defaultdict(list)
    orders = {}

    validator = None
    if Draft202012Validator is not None and os.path.exists(SCHEMA):
        with io.open(SCHEMA, encoding="utf-8") as fh:
            validator = Draft202012Validator(json.load(fh))
    else:
        warnings.append("jsonschema not installed -- structural validation skipped")

    for path in files:
        doc = load(path)
        cat = doc.get("id", os.path.basename(path))

        if validator is not None:
            for e in sorted(validator.iter_errors(doc), key=lambda x: list(x.path)):
                where = "/".join(str(x) for x in e.path) or "(root)"
                errors.append("%s: schema: %s: %s" % (path, where, e.message))

        for key in REQUIRED:
            if key not in doc:
                errors.append("%s: missing required key `%s`" % (path, key))

        order = doc.get("install_order")
        if order in orders:
            errors.append("%s: install_order %s is already used by %s"
                          % (path, order, orders[order]))
        orders[order] = cat

        seen = set()
        for rec in doc.get("domains", []):
            m = rec.get("match", "")
            kind = rec.get("kind")
            scope = rec.get("scope")

            if m in seen:
                errors.append("%s: `%s` listed twice" % (path, m))
            seen.add(m)

            if kind not in KINDS:
                errors.append("%s: `%s` has unknown kind %r" % (path, m, kind))
            if scope and scope not in SCOPES:
                errors.append("%s: `%s` has unknown scope %r" % (path, m, scope))

            if kind == "allow":
                owners[m].append(cat)

                if "." not in m or m in GENERAL_SUFFIXES:
                    errors.append(
                        "%s: `%s` is a general-purpose public suffix but classified "
                        "`allow` -- anyone can register under it, so it would match "
                        "unrelated senders. Use `kind: tld-example`." % (path, m))
                elif m in RESTRICTED_SUFFIXES and scope != "subdomains-only":
                    errors.append(
                        "%s: `%s` is a public suffix. Matching a whole namespace can "
                        "be deliberate, but it must use `scope: subdomains-only` so "
                        "the generator emits `*.%s` and a label is required in front."
                        % (path, m, m))
                elif not HOSTNAME.match(m):
                    errors.append("%s: `%s` is not a valid hostname" % (path, m))

            if kind == "block" and not rec.get("note"):
                warnings.append("%s: `%s` is blocked with no explanation"
                                % (path, m))

            note = (rec.get("note") or "").lower()
            if "defunct" in note or "shut down" in note:
                warnings.append("%s: `%s` is described as defunct -- consider removing"
                                % (path, m))

            if kind == "ceded" and not rec.get("ceded_to"):
                errors.append("%s: `%s` is ceded but does not say to whom" % (path, m))

        # A domain must not be blocked in one category and allowed in another.
        blocked = {r["match"] for r in doc.get("domains", []) if r.get("kind") == "block"}
        allowed = {r["match"] for r in doc.get("domains", []) if r.get("kind") == "allow"}
        for m in sorted(blocked & allowed):
            errors.append("%s: `%s` is both allowed and blocked" % (path, m))

    for m, cats in sorted(owners.items()):
        if len(cats) > 1:
            errors.append("`%s` is owned by %d categories (%s) -- exactly one must "
                          "own it; the others need `kind: ceded`"
                          % (m, len(cats), ", ".join(sorted(cats))))

    # Cross-category: a domain blocked anywhere must not be allowed anywhere.
    blocked_any = set()
    for path in files:
        doc = load(path)
        blocked_any |= {r["match"] for r in doc.get("domains", [])
                        if r.get("kind") == "block"}
    for m in sorted(blocked_any & set(owners)):
        errors.append("`%s` is blocked as a typosquat in one category and allowed "
                      "in another" % m)

    for e in errors:
        print("ERROR  %s" % e)
    for w in warnings:
        print("warn   %s" % w)

    total = sum(len(load(f).get("domains", [])) for f in files)
    print("\n%d file(s), %d domain record(s), %d error(s), %d warning(s)"
          % (len(files), total, len(errors), len(warnings)))
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
