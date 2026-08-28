#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""One-off migration: filter/*.sieve + domain/*.md + keyword/*.md -> data/*.yml

    python tools/migrate.py [--report MIGRATION-REPORT.md]

The filters are treated as authoritative for behaviour, because they are what
actually runs. The Markdown lists contribute the typed domain classification
(allow / block / tld-example / sender) and the ~1000 multilingual keywords that
were documented but never implemented.

Nothing here is applied silently: everything quarantined, reclassified or
dropped is listed in the report for review.
"""
import argparse
import collections
import glob
import io
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import yaml  # noqa: E402

from md_parse import parse_domain_file, parse_keyword_file  # noqa: E402
from sieve_extract import extract  # noqa: E402

# --------------------------------------------------------------------------- #
# Category metadata as of the v0.2.1 bootstrap. install_order was renumbered in
# v0.3.0 once Proton's documented behaviour was checked properly: every matching
# filter is applied and the LAST conflicting action wins, so the sequence now runs
# broad categories first and specific ones last. Ownership of a contested domain
# is a curation decision -- a deterministic tiebreaker plus the explicit overrides
# below -- not a reproduction of runtime order.
# --------------------------------------------------------------------------- #
CATEGORIES = {
    "security":      dict(order=1,  title="Security & Account",
                          description="Account alerts, sign-in notifications, 2FA and breach warnings."),
    "proton":        dict(order=2,  title="Proton Service Notifications",
                          description="Mail from Proton's own services."),
    "invoice":       dict(order=3,  title="Invoices & Payments",
                          description="Receipts, invoices, payment processors and billing."),
    "legal":         dict(order=4,  title="Legal & Policy Notifications",
                          description="Terms of service, privacy policy and EULA changes."),
    "health":        dict(order=5,  title="Health & Fitness",
                          description="Medical, fitness and wellness services."),
    "travel":        dict(order=6,  title="Travel",
                          description="Flights, hotels, car hire and trip planning."),
    "study":         dict(order=7,  title="Study & Education",
                          description="Courses, universities, research and learning platforms."),
    "gaming":        dict(order=8,  title="Gaming",
                          description="Game stores, publishers, esports and gaming news."),
    "entertainment": dict(order=9,  title="Entertainment",
                          description="Streaming, music, podcasts, books and events."),
    "news":          dict(order=10, title="News & Newsletters",
                          description="News outlets and newsletter platforms."),
    "social":        dict(order=11, title="Social Media",
                          description="Social network notifications."),
    "work":          dict(order=12, title="Work",
                          description="Professional and business correspondence."),
    "shopping":      dict(order=13, title="Shopping",
                          description="E-commerce, orders, shipping and deals."),
    "spam":          dict(order=14, title="Spam",
                          description="Additional spam heuristics beyond Proton's own."),
}

# Which legacy Markdown files feed which category.
DOMAIN_MD = {
    "entertainment": "domain/domain_entertainment.md",
    "gaming": "domain/domain_gaming.md",
    "social": "domain/domain_social.md",
    "study": "domain/domain_study.md",
    "health": "domain/health_domain.md",
    "invoice": "domain/invoice_filter.md",
    "news": "domain/news.md",
    "proton": "domain/proton_domain.md",
    "shopping": "domain/shopping.md",
    "travel": "domain/travel.md",
    "work": "domain/work_domain.md",
}
KEYWORD_MD = {
    "entertainment": "keyword/keyword_entertainment.md",
    "gaming": "keyword/keyword_gaming.md",
    "social": "keyword/keyword_social_filter.md",
    "study": "keyword/study_keyword.md",
    "health": "keyword/health_keyword.md",
    "invoice": "keyword/invoice_keyword.md",
    "news": "keyword/news_keyword.md",
    "proton": "keyword/proton_keyword.md",
    "shopping": "keyword/shopping_keyword.md",
    "travel": "keyword/travel_keyword.md",
    "work": "keyword/work_keyword.md",
    "security": "keyword/security_keyword.md",
    "legal": "keyword/EULA_keyword.md",
    "spam": "keyword/sp@m_keyword.md",
}

# Entries the audit established are wrong. Applied here, listed in the report.
DEFUNCT = {
    "desura.com", "gamespy.com", "joystiq.com", "orkut.com", "periscope.tv",
    "meerkat.co", "answers.yahoo.com", "stumbleupon.com", "dramafever.com",
    "plated.com", "arivale.com", "etsystudio.com", "juno.com",
}
WRONG = {
    # domain -> why. Removed from the category named in the value's second item.
    "frontier.com": ("gaming", "Frontier Developments is frontier.co.uk, which is "
                               "also listed; frontier.com is Frontier Airlines"),
    "steam.com": ("gaming", "not Valve's domain -- steampowered.com and "
                            "steamcommunity.com are"),
}
MALFORMED = {
    "canal+.com": "canalplus.com",
}
# Documented under a new name while still listed under the old one.
RENAMED = {
    "alitalia.com": "ita-airways.com",
    "car2go.com": "share-now.com",
    "quadpay.com": "zip.co",
    "appear.in": "whereby.com",
    "sendinblue.com": "brevo.com",
    "hellosign.com": "dropboxsign.com",
    "lynda.com": "linkedin.com",
}
# The tiebreaker is deterministic but arbitrary, so for high-traffic domains
# these name the owner explicitly.
OWNER_OVERRIDE = {
    "amazon.com": "shopping",        # order confirmations dominate, not invoices
    "google.com": "work",            # Workspace, Docs sharing, Calendar
    "microsoft.com": "work",         # Microsoft 365, Teams
    "linkedin.com": "work",          # not a study platform
    "stackoverflow.com": "work",     # developer, not coursework
    "behance.net": "social",         # portfolio network
    "discord.com": "social",         # chat, not entertainment
    "eventbrite.com": "entertainment",  # events, not travel
    "github.com": "work",
    "gitlab.com": "work",
}

# Public suffixes that are RESTRICTED namespaces (only accredited institutions
# can register under them), so matching the whole suffix is deliberate. These are
# live in study.sieve as "*.ac.uk" -- the dotted form, which requires a label in
# front, unlike "*ac.uk" which would also match "hackac.uk".
ACADEMIC_SUFFIXES = {
    "ac.uk": "study", "ac.jp": "study", "edu.au": "study", "edu.sg": "study",
    "edu.my": "study", "edu.vn": "study", "edu.cn": "study", "edu.tw": "study",
}

# General-purpose public suffixes that appear in the reference lists as regional
# examples. Anyone can register under these, so they must never be emitted.
GENERAL_SUFFIXES = {"co.uk", "com.au", "com", "org", "net", "gov", "edu", "ca",
                    "de", "fr", "es", "it", "nl", "mx", "co.jp", "co.kr",
                    "co.in", "com.sg", "com.my"}

# The one entry the section heuristic cannot decide (bare, but legitimate).
MANUAL = {
    "epic.com": dict(kind="allow", scope="exact",
                     note="Epic Systems (healthcare EHR). Bare in the source, but "
                          "legitimate -- not a typosquat. Kept as an exact match."),
}


class Report:
    def __init__(self):
        self.sections = collections.OrderedDict()

    def add(self, section, line):
        self.sections.setdefault(section, []).append(line)

    def write(self, path, stats):
        out = ["# Migration report", "",
               "Generated by `tools/migrate.py`. Every entry below was reclassified, "
               "quarantined or dropped on the way from `domain/` + `keyword/` + "
               "`filter/` into `data/`. **Read this before trusting the result.**", ""]
        out += ["## Totals", ""]
        for k, v in stats.items():
            out.append("- **%s**: %s" % (k, v))
        out.append("")
        for name, lines in self.sections.items():
            out += ["## %s" % name, ""]
            out += lines
            out.append("")
        io.open(path, "w", encoding="utf-8", newline="\n").write("\n".join(out))


def norm(d):
    return d.lower().lstrip("*").lstrip(".").strip()


def build(report):
    # ---------------- collect from the filters (authoritative) -------------- #
    extracted = {}
    for path in sorted(glob.glob("filter/*.sieve")):
        d = extract(path)
        extracted[d["id"]] = d

    # ---------------- collect from the Markdown lists ----------------------- #
    md_domains = {}
    for cat, path in DOMAIN_MD.items():
        if os.path.exists(path):
            md_domains[cat] = parse_domain_file(path)

    md_keywords = {}
    for cat, path in KEYWORD_MD.items():
        if os.path.exists(path):
            md_keywords[cat] = parse_keyword_file(path)

    # ---------------- build the typed domain catalogue ---------------------- #
    catalogue = {}          # cat -> {domain -> record}
    for cat in CATEGORIES:
        catalogue[cat] = {}

    def put(cat, match, kind, scope, note, source):
        m = norm(match)
        if not m:
            return
        rec = catalogue[cat].setdefault(m, {
            "match": m, "kind": kind, "scope": scope, "note": note,
            "source": [],
        })
        if source not in rec["source"]:
            rec["source"].append(source)
        # block always wins over allow -- never silently allowlist a typosquat.
        if kind == "block":
            rec["kind"] = "block"
            rec["note"] = note or rec["note"]
        elif rec["kind"] == "allow" and kind in ("tld-example", "sender"):
            rec["kind"] = kind
        if note and not rec["note"]:
            rec["note"] = note

    # From the Markdown: carries the classification.
    for cat, entries in md_domains.items():
        for e in entries:
            put(cat, e["match"], e["kind"], e["scope"], e["note"], "md")

    # From the filters: everything here is an allow (it is matched against From).
    def gate_domains(rule):
        got = list(rule["match"]["domains"])
        for t in rule["tiers"]:
            got += gate_domains(t)
        return got

    for cat, d in extracted.items():
        doms = []
        if d["gate"]:
            doms += gate_domains(d["gate"])
        for b in d["extra_blocks"]:
            doms += gate_domains(b)
        for dom in doms:
            put(cat, dom, "allow", "subdomains", "", "sieve")

    # ---------------- corrections ------------------------------------------- #
    for cat, recs in catalogue.items():
        for m in list(recs):
            if m in DEFUNCT:
                del recs[m]
                report.add("Dropped: service no longer exists",
                           "- `%s` (%s) -- the source file's own comment said "
                           "\"(defunct)\"" % (m, cat))
            elif m in WRONG and WRONG[m][0] == cat:
                del recs[m]
                report.add("Dropped: wrong company",
                           "- `%s` (%s) -- %s" % (m, cat, WRONG[m][1]))
            elif m in MALFORMED:
                fixed = MALFORMED[m]
                rec = recs.pop(m)
                rec["match"] = fixed
                recs[fixed] = rec
                report.add("Corrected: malformed hostname",
                           "- `%s` -> `%s` (%s)" % (m, fixed, cat))
            elif m in RENAMED:
                recs[m]["note"] = (recs[m]["note"] or "") + \
                    (" " if recs[m]["note"] else "") + "Legacy domain; now %s." % RENAMED[m]
                report.add("Kept, but the service was renamed",
                           "- `%s` (%s) -- now `%s`; both are kept so old mail still "
                           "matches" % (m, cat, RENAMED[m]))
            elif m in ACADEMIC_SUFFIXES and ACADEMIC_SUFFIXES[m] == cat:
                recs[m]["scope"] = "subdomains-only"
                recs[m]["note"] = (recs[m]["note"] or "") +                     " Restricted academic namespace; emitted as *.%s so a label is "                     "required in front." % m
                report.add("Public suffix kept deliberately",
                           "- `%s` (%s) -- restricted academic namespace, emitted as "
                           "`*.%s` (dotted form requires a subdomain)" % (m, cat, m))
            elif m in GENERAL_SUFFIXES:
                recs[m]["kind"] = "tld-example"
                report.add("Quarantined: general-purpose public suffix",
                           "- `%s` (%s) -- anyone can register under this; it would "
                           "match unrelated senders, so it is never emitted" % (m, cat))
            elif m in MANUAL:
                recs[m].update(MANUAL[m])
                report.add("Manual triage",
                           "- `%s` (%s) -- %s" % (m, cat, MANUAL[m]["note"]))

    # ---------------- quarantine report ------------------------------------- #
    for cat, recs in catalogue.items():
        for m, r in sorted(recs.items()):
            if r["kind"] == "block":
                report.add("Quarantined: typosquat / phishing (kind: block)",
                           "- `%s` (%s) -- %s" % (m, cat, r["note"] or "no note"))
            elif r["kind"] == "tld-example":
                report.add("Quarantined: bare TLD, never emitted (kind: tld-example)",
                           "- `%s` (%s) -- %s" % (m, cat, r["note"] or "no note"))
            elif r["kind"] == "sender":
                report.add("Full sender addresses (kind: sender)",
                           "- `%s` (%s)" % (m, cat))

    # ---------------- resolve cross-category conflicts ---------------------- #
    owner = {}
    claims = collections.defaultdict(list)
    for cat, recs in catalogue.items():
        for m, r in recs.items():
            if r["kind"] == "allow":
                claims[m].append(cat)

    conflicts = {m: cats for m, cats in claims.items() if len(cats) > 1}
    for m, cats in sorted(conflicts.items(), key=lambda kv: (-len(kv[1]), kv[0])):
        mechanical = min(cats, key=lambda c: CATEGORIES[c]["order"])
        override = OWNER_OVERRIDE.get(m)
        winner = override if override in cats else mechanical
        owner[m] = winner
        losers = [c for c in cats if c != winner]
        for c in losers:
            catalogue[c][m]["kind"] = "ceded"
            catalogue[c][m]["ceded_to"] = winner

        if winner != mechanical:
            report.add("Resolved by explicit override",
                       "- `%s` -- claimed by %d (%s); install order would have given it "
                       "to **%s**, overridden to **%s** as the natural owner"
                       % (m, len(cats), ", ".join(sorted(cats)), mechanical, winner))
        else:
            report.add("Resolved by install order",
                       "- `%s` -- claimed by %d (%s); awarded to **%s** (install order "
                       "%d), ceded by %s"
                       % (m, len(cats), ", ".join(sorted(cats)), winner,
                          CATEGORIES[winner]["order"], ", ".join(sorted(losers))))

    # ---------------- keywords ---------------------------------------------- #
    keywords = {}
    for cat in CATEGORIES:
        groups = collections.OrderedDict()
        for e in md_keywords.get(cat, []):
            g = groups.setdefault(e["group"] or e["section"], {"en": [], "vi": [], "zh": [], "ja": []})
            lang = e["lang"] if e["lang"] in g else "en"
            if e["keyword"] not in g[lang]:
                g[lang].append(e["keyword"])
        keywords[cat] = groups

    return extracted, catalogue, keywords, conflicts


def emit(extracted, catalogue, keywords, report):
    written = []
    for cat, meta in sorted(CATEGORIES.items(), key=lambda kv: kv[1]["order"]):
        ex = extracted.get(cat)
        if ex is None:
            continue

        doc = collections.OrderedDict()
        doc["id"] = cat
        doc["title"] = meta["title"]
        doc["description"] = meta["description"]
        doc["install_order"] = meta["order"]
        doc["folder"] = ex["folder"]
        doc["shape"] = "flat" if not (ex["gate"] and ex["gate"]["tiers"]) else "nested"
        doc["whitelist"] = ex["preamble"]["whitelist"] or [":addrbook:personal"]
        doc["spam_discard"] = ex["preamble"]["spam_discard"]

        recs = catalogue[cat]
        doc["domains"] = [
            {k: v for k, v in (
                ("match", r["match"]),
                ("kind", r["kind"]),
                ("scope", r["scope"]),
                ("note", r["note"]),
                ("ceded_to", r.get("ceded_to")),
                ("source", "+".join(sorted(r["source"]))),
            ) if v}
            for _, r in sorted(recs.items())
        ]

        groups = []
        for name, langs in keywords.get(cat, {}).items():
            entry = collections.OrderedDict()
            entry["group"] = name
            for lang in ("en", "vi", "zh", "ja"):
                if langs[lang]:
                    entry[lang] = langs[lang]
            if len(entry) > 1:
                groups.append(entry)
        doc["keyword_groups"] = groups

        doc["rules"] = _rules_doc(ex)

        path = "data/categories/%s.yml" % cat
        with io.open(path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write("# %s -- generated by tools/migrate.py, then maintained by hand.\n"
                     "# This file is the source of truth; filter/%s.sieve is generated from it.\n\n"
                     % (meta["title"], cat))
            yaml.safe_dump(_plain(doc), fh, sort_keys=False, allow_unicode=True,
                           width=88, default_flow_style=False)
        written.append(path)
    return written


def _rules_doc(ex):
    def one(r):
        m, a = r["match"], r["actions"]
        d = collections.OrderedDict()
        if a["fileinto"]:
            d["folder"] = a["fileinto"]
        d["op"] = m["op"]
        for key in ("subjects", "from_contains", "from_patterns",
                    "exclude_subjects", "size_under", "size_over"):
            if m[key]:
                d[key] = m[key]
        if m["domains"]:
            d["domains"] = sorted({norm(x) for x in m["domains"]})
        if a["flags"]:
            d["flags"] = a["flags"]
        if a["unflags"]:
            d["unflags"] = a["unflags"]
        if a["expire"] is not None:
            d["expire_days"] = a["expire"]
        if a["stop"]:
            d["stop"] = True
        if r["tiers"]:
            d["tiers"] = [one(t) for t in r["tiers"]]
        return d

    out = []
    if ex["gate"]:
        g = one(ex["gate"])
        g["gate"] = True
        out.append(g)
    for b in ex["extra_blocks"]:
        out.append(one(b))
    return out


def _plain(o):
    if isinstance(o, collections.OrderedDict):
        return {k: _plain(v) for k, v in o.items()}
    if isinstance(o, dict):
        return {k: _plain(v) for k, v in o.items()}
    if isinstance(o, list):
        return [_plain(x) for x in o]
    return o


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--report", default="MIGRATION-REPORT.md")
    args = ap.parse_args(argv)

    # This is a ONE-OFF bootstrap. domain/ and keyword/ were removed once their
    # content reached data/, and running without them would quietly rebuild the
    # category files with no `kind` classification and no keywords at all --
    # silently discarding 22 typosquat records, 32 quarantined TLDs and 3,992
    # keywords. Refuse rather than destroy.
    missing = [d for d in ("domain", "keyword") if not os.path.isdir(d)]
    if missing:
        sys.stderr.write(
            "refusing to run: %s no longer exist(s).\n\n"
            "tools/migrate.py is a one-off bootstrap that read the legacy"
            " Markdown lists. They were removed in v0.2.1 once data/"
            " replaced them, so running it now would rebuild"
            " data/categories/*.yml from the filters alone and drop every"
            " kind classification and every keyword.\n\n"
            "data/ is the source of truth now -- edit it directly.\n"
            % ", ".join(missing))
        return 2

    report = Report()
    extracted, catalogue, keywords, conflicts = build(report)
    written = emit(extracted, catalogue, keywords, report)

    kinds = collections.Counter()
    for recs in catalogue.values():
        kinds.update(r["kind"] for r in recs.values())
    kw = collections.Counter()
    for groups in keywords.values():
        for langs in groups.values():
            for lang, vals in langs.items():
                kw[lang] += len(vals)

    stats = collections.OrderedDict([
        ("categories written", len(written)),
        ("domains: allow", kinds["allow"]),
        ("domains: ceded to another category", kinds["ceded"]),
        ("domains: block (typosquat)", kinds["block"]),
        ("domains: tld-example (never emitted)", kinds["tld-example"]),
        ("domains: sender address", kinds["sender"]),
        ("cross-category conflicts resolved", len(conflicts)),
        ("keywords: English", kw["en"]),
        ("keywords: Vietnamese", kw["vi"]),
        ("keywords: Chinese", kw["zh"]),
        ("keywords: Japanese", kw["ja"]),
    ])
    report.write(args.report, stats)

    for k, v in stats.items():
        print("%-42s %s" % (k, v))
    print("\nwrote %d file(s) to data/categories/ and %s" % (len(written), args.report))
    return 0


if __name__ == "__main__":
    sys.exit(main())
