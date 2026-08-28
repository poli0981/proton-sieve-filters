#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Parse the legacy `domain/*.md` and `keyword/*.md` reference files.

These files are prose documents, not data files: every payload block is an
untagged ``` fence, and ~120 lines inside those fences are not domains at all.
Two traps matter for anything that generates Sieve from them.

1. Bare-TLD pseudo-entries. `*.com (US-based)` looks like a domain and would
   match every message on the internet.

2. Allow-versus-block is encoded only in a missing `*.` prefix, and only a
   nearby "Watch for Typosquatting" heading says so. A parser that ignores it
   allowlists `payp4l.com` and `pr0ton.me`.

So entries are classified by the *section* they appear under, and the prefix
heuristic is used only as a cross-check that gets reported, never as the answer.
"""
import io
import re

# A domain entry: optional leading *. / *, then a hostname, then an optional
# "# comment" or "(parenthetical)".
ENTRY = re.compile(r"^(?P<match>[*.]*[A-Za-z0-9][A-Za-z0-9.\-+@]*)"
                   r"(?P<paren>\s*\([^)]*\))?"
                   r"(?:\s*#\s*(?P<note>.*))?$")

BLOCK_MARKERS = (
    "typosquat", "watch for", "suspicious domain", "avoid these",
    "fake domain", "verified vs suspicious", "red flag", "suspicious domain examples",
)

ALLOW, BLOCK, TLD, SENDER = "allow", "block", "tld-example", "sender"


def _is_tld_example(match, paren):
    """`*.com (US-based)` / `*.co.uk (United Kingdom)` -- a TLD, not a domain."""
    if not paren:
        return False
    stem = match.lstrip("*").lstrip(".")
    # One or two labels and no registrable name in front of them.
    return stem.count(".") <= 1 and len(stem) <= 6


def parse_domain_file(path):
    """Yield dicts: {match, kind, scope, note, section, bare, line}."""
    lines = io.open(path, encoding="utf-8").read().split("\n")
    out = []
    section = ""
    marker = ""
    in_fence = False

    for i, raw in enumerate(lines, 1):
        line = raw.rstrip()

        if line.startswith("```"):
            in_fence = not in_fence
            if not in_fence:
                marker = ""          # a marker only applies to the next fence
            continue

        if not in_fence:
            if line.startswith("#"):
                section = line.lstrip("#").strip()
                marker = ""
            elif line.lstrip().startswith(("⚠️", "**⚠️")) or "**" in line:
                low = line.lower()
                if any(m in low for m in BLOCK_MARKERS):
                    marker = line.strip()
            continue

        if not line.strip() or line.lstrip().startswith(("-", "#", "|")):
            continue

        m = ENTRY.match(line.strip())
        if not m:
            continue

        match = m.group("match")
        paren = m.group("paren")
        note = (m.group("note") or "").strip()

        context = (marker + " " + section).lower()
        if any(k in context for k in BLOCK_MARKERS):
            kind = BLOCK
        elif _is_tld_example(match, paren):
            kind = TLD
        elif "@" in match:
            # A full address such as noreply@proton.me. These are matched with
            # `header :contains "from"`, not `address :domain`.
            kind = SENDER
        else:
            kind = ALLOW

        stem = match.lstrip("*").lstrip(".")
        if "." not in stem and kind not in (TLD, SENDER):
            continue

        out.append({
            "match": stem,
            "kind": kind,
            "scope": "subdomains" if match.startswith("*") else "exact",
            "note": note,
            "section": section,
            "bare": not match.startswith("*"),
            "line": i,
        })
    return out


# --------------------------------------------------------------------------- #
# Keywords
# --------------------------------------------------------------------------- #
LANG_HEADINGS = {
    "vietnamese": "vi", "tiếng việt": "vi",
    "chinese": "zh", "中文": "zh", "simplified chinese": "zh",
    "japanese": "ja", "日本語": "ja",
    "english": "en",
}


def _lang_for(section, multilingual):
    low = section.lower().strip()
    for name, code in LANG_HEADINGS.items():
        if low == name or low.startswith(name):
            return code
    return None if not multilingual else None


def parse_keyword_file(path):
    """Yield dicts: {keyword, lang, section, group, line}."""
    lines = io.open(path, encoding="utf-8").read().split("\n")
    out = []
    section = ""
    group = ""
    lang = "en"
    multilingual = False
    in_fence = False

    for i, raw in enumerate(lines, 1):
        line = raw.rstrip()

        if line.startswith("```"):
            in_fence = not in_fence
            continue

        if not in_fence:
            if line.startswith("#"):
                title = line.lstrip("#").strip()
                level = len(line) - len(line.lstrip("#"))
                if level <= 2:
                    section = title
                    multilingual = "multi-language" in title.lower() or \
                                   "multilingual" in title.lower()
                    lang = "en"
                    group = title
                else:
                    group = title
                    code = _lang_for(title, multilingual)
                    lang = code if (multilingual and code) else ("en" if not multilingual else lang)
                    if multilingual and code:
                        lang = code
            continue

        kw = line.strip()
        if not kw or kw.startswith(("-", "#", "|", "*")):
            continue

        out.append({
            "keyword": kw,
            "lang": lang,
            "section": section,
            "group": group,
            "line": i,
        })
    return out
