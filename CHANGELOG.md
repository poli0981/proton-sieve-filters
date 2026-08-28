# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and
this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added — filters are generated

- **`tools/generate.py` renders `filter/*.sieve` from `data/categories/*.yml`**, and
  `--check` fails the build when a `.sieve` no longer matches its data. The `.sieve`
  files in this repository are now generated output; edits go to `data/`.

- **Domain patterns are precise.** v0.2.0 wrote `*example.com`, which is a *suffix*
  match, not a subdomain match — so `*ea.com` (EA) also matched `ikea.com` and
  `silversea.com`, `*box.com` (Box) also matched `xbox.com`, and `*ew.com` (Entertainment
  Weekly) also matched `nationalreview.com`, filing a political magazine into
  `News/Entertainment`. **127 such collisions were shipping.** The generator now emits the
  pair `"example.com", "*.example.com"`.

- **Typosquat entries cover subdomains.** `login.payp4l.com` is as malicious as
  `payp4l.com`, so a `kind: block` record always emits both forms.

- **Retention defaults moved after their subrules.** A category's default `expire` is
  emitted after the rules nested inside it, so it applies only to mail that reached none
  of them — matching how the hand-written filters were laid out. Emitting it first would
  have put a delete timer on every message the filter touched.

- **`tools/check_roundtrip.py`** — builds a corpus from the data (one message per domain
  and per subject keyword, at five size bands) and reports every message whose folder,
  retention or flags differ between two sets of filters.

  The migration was verified with it: **20,568 messages route identically**, 96 differ,
  and every difference is accounted for — a domain ceded to another category, a typosquat
  now sent to Spam, or the `nationalreview.com` correction above. Three domains the old
  suffix shorthand had caught usefully (`choicehotels.com`, `wyndhamhotels.com`,
  `classroom.google.com`) were added to their subrules explicitly so no coverage was lost.

- **`tools/migrate.py` now refuses to run** once `domain/` and `keyword/` are gone.
  Re-running it against the filters alone silently rebuilt the category files with no
  `kind` classification and no keywords at all — 22 typosquat records, 32 quarantined
  TLDs and 3,992 keywords discarded without a word.

- Filter parsing is memoised in `tools/sieve_eval.py`, taking the round-trip check from
  over two minutes to ten seconds.

### Fixed

- `tools/sieve_extract.py` dropped every `addflag`/`removeflag`, because sievelib exposes
  the flag list as `variable-name` rather than `flags`. 48 flag operations were missing
  from the extracted data.

### Added — `data/` is now the source of truth

- **`data/categories/*.yml` replaces `domain/*.md` and `keyword/*.md`.** The Markdown
  lists were reference documentation that had drifted away from the filters: a domain
  added to a `.sieve` was never added to the list, and over 700 Vietnamese, Chinese and
  Japanese keywords were documented and implemented in **zero** filters. `filter/*.sieve`
  will be generated from `data/` from the next release onward.

  Migrated: **1,826 domain records** and **3,992 keywords** (3,003 English, 323
  Vietnamese, 332 Chinese, 334 Japanese) across 14 categories.

- **Every domain now carries an explicit `kind`.** The legacy lists encoded
  allow-versus-block *only* in a missing `*.` prefix, with a "Watch for Typosquatting"
  heading somewhere above — so any generator that read them naively would have
  **allowlisted `payp4l.com`, `pr0ton.me` and `faceb00k.com`**. The four kinds are
  `allow`, `block` (22 typosquats), `tld-example` (32 bare public suffixes, never
  emitted) and `sender` (11 full addresses such as `noreply@proton.me`).

- **A `scope` field distinguishes `*example.com` from `*.example.com`.** Public suffixes
  such as `ac.uk` must use `subdomains-only`, so the generated pattern requires a label in
  front. Matching a restricted academic namespace is deliberate; matching `hackac.uk` is
  not.

- **109 cross-category domain conflicts resolved.** `*apple.com` was claimed by seven
  filters, `*google.com` by five. Each domain now has exactly one owner; the rest carry
  `kind: ceded` naming the winner. Ownership follows install order — which reproduces what
  Proton would do at runtime — except for ten high-traffic domains where the mechanical
  answer was plainly wrong (`amazon.com` went to `shopping`, not `invoice`;
  `linkedin.com` and `microsoft.com` to `work`, not `study`).

- **Data corrections applied during migration**, each listed in `MIGRATION-REPORT.md`:
  13 domains dropped whose own comment said "(defunct)"; `frontier.com` dropped from
  gaming (Frontier Developments is `frontier.co.uk`; `frontier.com` is Frontier
  Airlines); `steam.com` dropped (not Valve's domain); `canal+.com` corrected to
  `canalplus.com`; 7 renamed services annotated.

- **`data/shared/retention.yml`** — one canonical retention ladder. v0.2.0 reinvented it
  per filter and ended up with fifteen different values for the same handful of concepts,
  so a billing email expired after 365 days in five filters and 90, 60, 28 or 14 in
  others.

- **`data/schema/category.schema.json`** — JSON Schema for a category file, enforced in CI.

- **`tools/check_data.py`** — validates the schema and the guard rails: a bare TLD
  classified `allow`, a typosquat allowed anywhere, a domain owned by two categories, an
  invalid hostname, a duplicate `install_order`. All six were verified to fail the build
  when deliberately introduced.

- **`tools/migrate.py`** and **`MIGRATION-REPORT.md`** — the migration is reproducible and
  every quarantined, reclassified or dropped entry is listed for review.

- **`tools/md_parse.py`** and **`tools/sieve_extract.py`** — the parsers behind it.
  `sieve_extract` reads the full structure of all 14 filters with no unhandled constructs.

### Removed

- **`domain/` and `keyword/`.** Superseded by `data/`; the git history keeps them and
  `MIGRATION-REPORT.md` records where every entry went. This also retires
  `keyword/sp@m_keyword.md`, whose `@` broke shell globs and rsync-style tooling.

### Changed — breaking

- **Every filter was renamed** to one convention: lowercase, no `_filter` suffix,
  named after its category. `README.md` documents the new names.

  | Old | New |
  | --- | --- |
  | `EULAChange_filter.sieve` | `legal.sieve` |
  | `SecurityAccount_filter.sieve` | `security.sieve` |
  | `TravelFilters.sieve` | `travel.sieve` |
  | `entertainment_filter.sieve` | `entertainment.sieve` |
  | `game_filter.sieve` | `gaming.sieve` |
  | `healthAndFitness.sieve` | `health.sieve` |
  | `invoice_filter.sieve` | `invoice.sieve` |
  | `newsletter.sieve` | `news.sieve` |
  | `proton_notifiaction.sieve` | `proton.sieve` |
  | `social_media_filter.sieve` | `social.sieve` |
  | `spam_filter.sieve` | `spam.sieve` |
  | `study_filter.sieve` | `study.sieve` |
  | `work_filter.sieve` | `work.sieve` |

  This also fixes the misspelled `proton_notifiaction.sieve`, which `README.md` had
  always referred to by its correct spelling — so the documented path never existed.

- **`README.md` moved from `README/` to the repository root.** GitHub only renders a
  readme found in the root, `.github/` or `docs/`, so the project landing page showed
  no readme at all.
- **Removed `filter/test.sieve`** (scratch: it filed into an undocumented `Test`
  folder, still carried a comment copied from `invoice_filter.sieve`, and was the only
  script that never called `stop;`) **and `filter/AI_filter.sieve`** (121 bytes of
  comments, no code). 14 filters remain.
- **`README.ja.md` and `README.zh.md` moved to `README/community/`** with a banner
  saying they are out of date. They were ~52% translations of v0.2.0 and omitted the
  entire Limitations & Disclaimers section, so non-English readers got no risk warning.

### Fixed

- **`[LICENSE](LICENSE)` was broken in all four READMEs.** Because they lived in
  `README/`, the link resolved to `README/LICENSE`, which does not exist.
- **`README.md`'s "Required Folders" instruction was wrong.** It told users to create
  14 folders — five of which no script ever used (`Invoices` vs `Payments`,
  `Newsletters` vs `News`, `Social` vs `Social Account`, `Spam_Filter` vs `Spam`,
  `EULA` vs `Legal`) — while omitting the ~70 subfolders every script depends on. The
  filters target **86 distinct folders**; each script now lists its own in its header.
- Header banners: line 2 named a file that did not exist in every filter
  (`Filter_News.sieve` inside `newsletter.sieve`), and line 3 read
  `# Only for user use Proton Mail.` in all 15. Headers are now generated to one
  format and state the paid-plan requirement, the folders used, and — where the filter
  sets `expire` — an auto-delete warning.
- Stripped trailing whitespace from **397 lines** and added a final newline to all 15
  files; normalised CRLF to LF.

### Added

- `.gitattributes` and `.editorconfig` to keep line endings and whitespace consistent.
- `tools/check_folders.py` — fails the build when a filter's documented folder list
  drifts from the folders it actually uses, or when `README.md` omits a top-level one.
- `tools/check_links.py` — resolves every relative Markdown link.
- Both are wired into a new `docs` job in CI.
- `README.md` now documents the **recommended install order**. Proton applies filters
  sequentially and the last conflicting action wins, so with 109 domains claimed by
  more than one filter, order determines the outcome. This was previously undocumented.

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
