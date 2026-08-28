# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and
this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.2.1] — 2026-08-28

Correctness release. **Everyone running v0.2.0 or earlier should read the advisory
below before updating**, because one of these defects silently scheduled mail for
deletion.

### ⚠️ Advisory — check `Legal/Suspicious` before it empties

`filter/EULAChange_filter.sieve` contained a logic error that made its final block
match **almost every message in the mailbox**, not just legal threats. The exclusion
list was written as a member of an `anyof(...)` rather than as a conjunct, so
`not anyof(...)` was true for any sender outside six government domains and your
personal address book:

```sieve
if anyof (
    header :contains "subject" ["Legal Action", "Lawsuit", ...],
    header :contains "subject" ["Immediate Legal Action", ...],
    not anyof (                      # <-- meant to narrow; actually widened
        address :domain :matches "from" ["*government.gov", "*gov.uk", ...],
        header :list "from" ":addrbook:personal"
    )
) {
    fileinto "Legal/Suspicious";
    addflag "\\Flagged";
    expire "day" "30";               # <-- 30-day delete timer on everything
    stop;
}
```

**If you installed this filter, open your `Legal/Suspicious` folder now.** Mail that
landed there was given a 30-day expiry and will be removed by Proton when it
elapses. Move anything you want to keep out of that folder before updating.

Two other filters mis-routed mail without deleting it: `SecurityAccount_filter.sieve`
filed any message from a `noreply@`-style sender into `Security` with a 14-day
expiry, and `social_media_filter.sieve` did the same into `Social Account`. Check
those folders too.

### Fixed

- **`EULAChange_filter.sieve`** — the catch-all above is now
  `allof(anyof(threat_a, threat_b), not anyof(legitimate))`.
- **`spam_filter.sieve` did not parse, so none of it ever ran.** Two `{ … }` blocks
  sat inside an `anyof(...)` test list, which the Sieve grammar does not allow.
  Brace counting balanced, so the fault was invisible to eyeballing. Both are now
  `allof(...)`. The same file's `require` named `"discard"` — a core command, not a
  capability, which makes a strict interpreter reject the whole script — and omitted
  `"vnd.proton.expire"` while calling `expire` twice.
- **36 `anyof` gates that should have been `allof`.** A `size` or `not` test placed
  as a bare `anyof` member satisfies the whole gate on its own, so the block swallowed
  every message and everything after it became unreachable. This affected
  `shopping.sieve` (11 sites), `proton_notifiaction.sieve` (11), `game_filter.sieve`
  (8), and one each in `work_filter.sieve`, `TravelFilters.sieve` and
  `EULAChange_filter.sieve`. Concretely, `work_filter.sieve` could never reach
  `Work/IT` or `Work/Finance`: everything over 100 KB stopped at `Work/Reports` and
  everything under 200 KB stopped at `Work/Reminders`.
- **23 missing `stop;` statements** in `game_filter.sieve`, `invoice_filter.sieve`,
  `social_media_filter.sieve` and `entertainment_filter.sieve`. Sibling retention
  tiers fell through each other, so the *last* match won and the shortest retention
  silently overrode the longest — a 365-day receipt that also mentioned "Payment
  Success" was cut to 7 days.
- **Eight domains that could never match**, because they were tested only inside a
  nested block while the top-level gate filtered them out first: `*paramount.com`
  (Entertainment), `*rollcall.com`, `*nationaljournal.com`, `*cookpolitical.com`,
  `*ballotpedia.org` (News), and `*pearson.com`, `*mcgraw-hill.com`, `*cengage.com`
  (Study). The whole `News/Weather` block was dead for the same reason and now works.
- **Four malformed patterns:** `"*plenty offish.com"` (a space in a hostname),
  `"*bbc.co.uk/sport"` (a URL path — `address :domain` never contains one),
  `"epic.com"` (missing the `*` every other entry uses), and the unreachable
  `News/Weather` domain set.
- **`shopping.sieve`'s 14-day default was dead code.** The 10-day promotional rule
  had no positive subject gate, so it matched everything under 500 KB and stopped.
- **`invoice_filter.sieve`** — the comment claimed 28-day retention for receipts
  while the code said 365. The code was correct and the comment now matches.

### Changed

- **Three unbounded catch-alls narrowed.** `SecurityAccount_filter.sieve` and
  `social_media_filter.sieve` no longer treat a bare `noreply@` sender as a match,
  and `shopping.sieve`'s gate no longer fires on bare subject words like `"Order"`,
  `"Payment"`, `"Receipt"` and `"Invoice"` with no sender constraint — that had been
  hijacking `invoice_filter.sieve` for mail from any sender at all.
- **`spam_filter.sieve` no longer treats a comma in `To:` as a bulk-recipient
  signal.** `header :contains "to" [","]` matched any quoted display name such as
  `"Doe, John" <john@example.com>`, which would have filed ordinary mail into Spam
  with a 7-day expiry.
- **`"reject"` removed from all 12 `require` lines that declared it.** It is invoked
  nowhere in the repository. All 15 filters now share one minimal, identical
  `require` line, which reduces the ways Proton can refuse a script at install time.

### Added

- `tools/validate_sieve.py` — parses every filter with a real Sieve parser
  (`sievelib`), taught Proton's `extlists` `:list` match-type and `vnd.proton.expire`.
- `tools/lint_proton.py` — checks `require` against Proton's supported extension
  list, rejects core commands named as capabilities, flags used-but-undeclared
  extensions, and detects each bug class fixed above so it cannot return.
- `tools/proton_dialect.py` — Proton's supported extensions, tests and plan limits
  in one place.
- `tools/sieve_eval.py` — a small evaluator for the Sieve subset these filters use,
  enough to answer "where does this message end up?".
- `tests/test_regressions.py` — 12 behavioural tests, one per defect above. They
  score 2/12 against v0.2.0 and 12/12 against this release.

### Known issues (not addressed in this release)

- **109 domains are claimed by more than one filter** (`*apple.com` by seven). Proton
  runs filters sequentially and the last conflicting action wins, so the outcome
  depends on your install order, which is not yet documented anywhere.
- **`domain/*.md` and `keyword/*.md` have drifted from the filters.** Over 700
  documented Vietnamese, Chinese and Japanese keywords are implemented in zero
  filters — every `.sieve` file is pure ASCII.
- `study_filter.sieve` documents 14 retention periods and implements none.
- `filter/proton_notifiaction.sieve` is still misspelled; `README.md` still lives in
  `README/`, so GitHub renders no landing page.

---

## [0.2.0] — 2025-08-17

- Added filters for AI (stub), entertainment, EULA/legal, gaming, health & fitness,
  invoices, newsletters, Proton notifications, security, shopping, social media,
  spam, study, travel and work.
- Added `domain/` and `keyword/` reference lists per category.
- Added `DISCLAIMER.md`, `ACKNOWLEDGE.md` and `REFERENCE.md`.
- Added Vietnamese, Japanese and Simplified Chinese READMEs.

## [0.1.0] — 2025-08-15

- Initial release.

[0.2.1]: https://github.com/poli0981/proton-sieve-filters/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/poli0981/proton-sieve-filters/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/poli0981/proton-sieve-filters/releases/tag/v0.1.0
