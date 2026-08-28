#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Compare where a message lands under two sets of filters.

    python tools/check_roundtrip.py OLD_DIR NEW_DIR

Generating the filters from `data/` is only safe if the result routes mail the
same way, so this builds a corpus from the data itself -- one message per domain
and per subject keyword, at several sizes -- and runs it through both.

Differences are expected where the migration deliberately changed behaviour:
a domain ceded to another category, or a typosquat that now goes to Spam. Those
are reported separately from unexplained ones.
"""
import argparse
import collections
import glob
import io
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import yaml  # noqa: E402

from sieve_eval import Message, deliver  # noqa: E402

LISTS = {":addrbook:personal": set(), ":addrbook:myself": set(),
         ":incomingdefaults:spam": set()}

# Differences that are deliberate corrections rather than regressions.
EXPECTED = {
    ("news", "nationalreview.com"):
        "v0.2.0 wrote *ew.com for Entertainment Weekly, and that suffix pattern "
        "also matched nationalreview.com, filing a political magazine into "
        "News/Entertainment. The precise patterns no longer do.",
}
SIZES = [10 * 1024, 150 * 1024, 300 * 1024, 700 * 1024, 2 * 1024 * 1024]


def corpus(doc, limit_subjects=60):
    """Synthetic messages derived from this category's own data."""
    out = []
    allow = [r for r in doc.get("domains", []) if r.get("kind") == "allow"]
    ceded = [r for r in doc.get("domains", []) if r.get("kind") == "ceded"]
    blocked = [r for r in doc.get("domains", []) if r.get("kind") == "block"]

    subjects = []

    def walk(rules):
        for r in rules:
            for s in (r.get("subjects") or [])[:4]:
                if s not in subjects:
                    subjects.append(s)
            walk(r.get("tiers") or [])

    walk(doc.get("rules") or [])
    subjects = subjects[:limit_subjects] or ["hello"]

    for rec in allow[:200]:
        for subj in subjects[:6]:
            for size in (SIZES[0], SIZES[2]):
                out.append(("allow", rec["match"],
                            Message({"from": "s@" + rec["match"], "subject": subj,
                                     "to": "me@example.com"}, size=size, lists=LISTS)))
    for rec in ceded[:80]:
        out.append(("ceded", rec["match"],
                    Message({"from": "s@" + rec["match"], "subject": subjects[0],
                             "to": "me@example.com"}, size=SIZES[0], lists=LISTS)))
    for rec in blocked:
        out.append(("block", rec["match"],
                    Message({"from": "s@" + rec["match"], "subject": subjects[0],
                             "to": "me@example.com"}, size=SIZES[0], lists=LISTS)))
    # Subject-only mail from an unrelated sender, at every size band.
    for subj in subjects[:20]:
        for size in SIZES:
            out.append(("subject", subj,
                        Message({"from": "someone@unrelated.example", "subject": subj,
                                 "to": "me@example.com"}, size=size, lists=LISTS)))
    return out


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("old")
    ap.add_argument("new")
    ap.add_argument("--verbose", action="store_true")
    args = ap.parse_args(argv)

    totals = collections.Counter()
    unexplained = []

    for path in sorted(glob.glob("data/categories/*.yml")):
        cat = os.path.splitext(os.path.basename(path))[0]
        old_f = os.path.join(args.old, cat + ".sieve")
        new_f = os.path.join(args.new, cat + ".sieve")
        if not (os.path.exists(old_f) and os.path.exists(new_f)):
            continue
        with io.open(path, encoding="utf-8") as fh:
            doc = yaml.safe_load(fh)

        same = diff = 0
        by_reason = collections.Counter()
        for reason, subject_of, msg in corpus(doc):
            a = deliver(old_f, msg)
            b = deliver(new_f, msg)
            key_a = (a.folder, a.expire_days, tuple(sorted(a.flags)))
            key_b = (b.folder, b.expire_days, tuple(sorted(b.flags)))
            if key_a == key_b:
                same += 1
                continue
            diff += 1
            by_reason[reason] += 1
            if reason not in ("ceded", "block") and (cat, subject_of) not in EXPECTED:
                unexplained.append((cat, reason, subject_of, key_a, key_b))
            elif (cat, subject_of) in EXPECTED:
                by_reason["expected"] += 1
                by_reason[reason] -= 1

        totals["same"] += same
        totals["diff"] += diff
        detail = " ".join("%s=%d" % kv for kv in sorted(by_reason.items()))
        print("%-14s %5d same  %4d differ   %s" % (cat, same, diff, detail))

    print("\n%d message(s) routed identically, %d differ"
          % (totals["same"], totals["diff"]))

    if unexplained:
        print("\n%d UNEXPLAINED difference(s):" % len(unexplained))
        shown = collections.Counter()
        for cat, reason, what, a, b in unexplained:
            shown[(cat, reason)] += 1
            if shown[(cat, reason)] <= 3 or args.verbose:
                print("  %-13s %-8s %-34s old=%s new=%s"
                      % (cat, reason, str(what)[:34], a, b))
        return 1

    print("\nno unexplained differences -- every change is a ceded domain or a "
          "typosquat now routed to Spam")
    return 0


if __name__ == "__main__":
    sys.exit(main())
