#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Generate the reference pages of docs/ from data/.

    python tools/gen_docs.py            # write the pages
    python tools/gen_docs.py --check    # fail if they are out of date

Only the pages that restate data are generated: the filter reference and the
retention table. Everything else in docs/ is hand-written prose.

v0.2.0's README documented 14 folders when the filters used 86, and its filter
table's counts were invented. Anything derived from the data is generated here
so it cannot say something the filters do not do.
"""
import argparse
import glob
import io
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import yaml  # noqa: E402

from generate import folders_of, uses_expire, version  # noqa: E402

HEADER = ("<!-- GENERATED FILE -- do not edit. Run `python tools/gen_docs.py`.\n"
          "     Source: data/categories/*.yml -->\n"
          "<!-- SPDX-License-Identifier: CC-BY-4.0 -->\n")


def load_all():
    docs = []
    for p in sorted(glob.glob("data/categories/*.yml")):
        with io.open(p, encoding="utf-8") as fh:
            docs.append(yaml.safe_load(fh))
    docs.sort(key=lambda d: d["install_order"])
    return docs


def counts(doc):
    kinds = {}
    for r in doc.get("domains", []):
        kinds[r["kind"]] = kinds.get(r["kind"], 0) + 1
    kw = 0
    ml = 0
    for g in doc.get("keyword_groups") or []:
        for lang in ("en", "vi", "zh", "ja"):
            n = len(g.get(lang) or [])
            kw += n
            if lang != "en":
                ml += n
    return kinds, kw, ml


def retentions(doc):
    out = []

    def walk(rules):
        for r in rules:
            if r.get("expire_days") is not None:
                out.append((r.get("folder") or doc["folder"], r["expire_days"]))
            walk(r.get("tiers") or [])

    walk(doc.get("rules") or [])
    return out


def page_filter_reference(docs):
    out = [HEADER, "# Filter reference", "",
           "One section per filter, in install order. **Install them in this order** —"
           " Proton applies every matching filter and, where two conflict, the last one"
           " applied wins, so the sequence runs broad categories first and specific ones"
           " last.", "",
           "Generated from `data/categories/`. Counts here are what the filters actually"
           " contain.", "",
           "| # | Filter | Folder | Domains | Keywords | Retention |",
           "|---|--------|--------|---------|----------|-----------|"]

    for d in docs:
        kinds, kw, _ml = counts(d)
        rets = sorted({days for _f, days in retentions(d)})
        r = "none" if not rets else ("%d–%d d" % (min(rets), max(rets))
                                     if len(rets) > 1 else "%d d" % rets[0])
        out.append("| %d | [`%s.sieve`](../filter/%s.sieve) | `%s` | %d | %d | %s |"
                   % (d["install_order"], d["id"], d["id"], d["folder"],
                      kinds.get("allow", 0), kw, r))

    out += ["", "---", ""]

    for d in docs:
        kinds, kw, ml = counts(d)
        out += ["## %d. %s" % (d["install_order"], d["title"]), "",
                d["description"], "",
                "- **File:** [`filter/%s.sieve`](../filter/%s.sieve)" % (d["id"], d["id"]),
                "- **Data:** [`data/categories/%s.yml`](../data/categories/%s.yml)"
                % (d["id"], d["id"]),
                "- **Domains:** %d matched" % kinds.get("allow", 0)
                + (", %d ceded to another category" % kinds["ceded"] if kinds.get("ceded") else "")
                + (", %d blocked as typosquats" % kinds["block"] if kinds.get("block") else ""),
                "- **Keywords:** %d%s" % (kw, " (%d non-English)" % ml if ml else ""),
                ]
        fold = folders_of(d)
        out.append("- **Folders (%d):** %s" % (len(fold), ", ".join("`%s`" % f for f in fold)))
        if uses_expire(d):
            rets = retentions(d)
            out.append("- **Sets delete timers:** yes — see"
                       " [Retention & auto-delete](Retention-and-Auto-Delete.md)")
            if rets:
                out.append("")
                out.append("  | Folder | Deleted after |")
                out.append("  | --- | --- |")
                seen = set()
                for f, days in rets:
                    if (f, days) in seen:
                        continue
                    seen.add((f, days))
                    out.append("  | `%s` | %d days |" % (f, days))
        else:
            out.append("- **Sets delete timers:** no — this filter never expires mail")
        out.append("")

    return "\n".join(out) + "\n"


def page_retention(docs):
    with io.open("data/shared/retention.yml", encoding="utf-8") as fh:
        ladder = yaml.safe_load(fh)

    out = [HEADER, "# Retention & auto-delete", "",
           "> [!WARNING]",
           "> `expire_days` is a **delete timer**. When it runs out Proton removes the"
           " message. This is the single most consequential thing these filters do.", "",
           "Proton's maximum is **730 days**; `tools/lint_proton.py` fails the build above"
           " that.", "",
           "## Which filters delete mail", "",
           "| Filter | Deletes? | Range |", "| --- | --- | --- |"]

    for d in docs:
        rets = sorted({days for _f, days in retentions(d)})
        if rets:
            r = "%d–%d days" % (min(rets), max(rets)) if len(rets) > 1 else "%d days" % rets[0]
            out.append("| `%s.sieve` | yes | %s |" % (d["id"], r))
        else:
            out.append("| `%s.sieve` | **no** | keeps everything |" % d["id"])

    out += ["", "## The canonical ladder", "",
            "Reuse one of these when a category needs a retention period, rather than"
            " inventing a value. v0.2.0 reimplemented the ladder in every filter and ended"
            " up with fifteen different numbers for the same handful of concepts.", "",
            "| Tier | Days | Use for |", "| --- | --- | --- |"]
    for t in ladder["tiers"]:
        days = "keep forever" if t["days"] is None else str(t["days"])
        out.append("| `%s` | %s | %s |" % (t["id"], days, "; ".join(t["use_for"])))

    out += ["", "## Never expire", "",
            "These are listed in `data/shared/retention.yml` as categories where losing a"
            " message is worse than keeping clutter:", ""]
    for n in ladder["never_expire"]:
        out.append("- `%s`" % n)

    out += ["", "## Turning it off", "",
            "Remove the `expire_days` key from the rule in"
            " [`data/categories/`](../data/categories/) and regenerate:", "",
            "```bash", "python tools/generate.py", "```", "",
            "To see every retention value a filter currently sets:", "",
            "```bash", "grep -n 'expire \"day\"' filter/shopping.sieve", "```", ""]
    return "\n".join(out) + "\n"


PAGES = {
    "docs/Filter-Reference.md": page_filter_reference,
    "docs/Retention-and-Auto-Delete.md": page_retention,
}


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args(argv)

    docs = load_all()
    drift = 0
    for path, fn in sorted(PAGES.items()):
        text = fn(docs)
        if args.check:
            current = io.open(path, encoding="utf-8").read() if os.path.exists(path) else ""
            if current != text:
                drift += 1
                print("DRIFT  %s is out of date -- run python tools/gen_docs.py" % path)
        else:
            if not os.path.isdir("docs"):
                os.makedirs("docs")
            io.open(path, "w", encoding="utf-8", newline="\n").write(text)

    if args.check:
        print("\n%d/%d generated page(s) up to date" % (len(PAGES) - drift, len(PAGES)))
        return 1 if drift else 0
    print("wrote %d page(s) to docs/ (v%s)" % (len(PAGES), version()))
    return 0


if __name__ == "__main__":
    sys.exit(main())
