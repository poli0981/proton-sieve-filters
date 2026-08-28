# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and
this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.3.0] — 2026-08-28

### Changed — documentation rewritten

`DISCLAIMER.md` went from 272 lines to a focused document. The old one warned at length
about court summons, day trading and academic dismissal, repeated three of its own sections
verbatim, and **omitted the three things that actually mattered**: it never said the project
is unaffiliated with Proton AG, never carried a trademark notice, and never mentioned that a
paid plan is required. The string "Proton AG" appeared **nowhere in the repository**. Nor
did it mention that the filters set delete timers — the single most consequential thing they
do. All four are now in the first three sections.

`REFERENCE.md` is deleted. 500 lines of which roughly 85% was filler — Kaggle, pandas,
Tableau, AWS Training, CompTIA, Khan Academy — claiming "100+ verified sources" and a review
date that had passed nine months earlier. Its one useful section became
[`docs/Proton-Sieve-Dialect.md`](docs/Proton-Sieve-Dialect.md), which is now a real
reference: the supported extension list, the absent `body` test, the 730-day expire ceiling,
and the four matching gotchas that cost this project real bugs.

### Added — documentation

- **[`PRIVACY.md`](PRIVACY.md)** — this project collects nothing, and explains why that is
  structural rather than a promise: the deliverable is text you paste into Proton's own
  settings, and Proton's zero-access encryption means a filter can only ever see headers,
  the envelope and the encrypted size.
- **[`CONTRIBUTING.md`](CONTRIBUTING.md)** — where the one line goes, and a table of the
  eight defect classes the build will stop you reintroducing.
- **[`SECURITY.md`](SECURITY.md)** — what counts as a security issue for a project that
  ships text files, and what does not.
- **[`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md)** — Contributor Covenant 2.1, vendored with a
  real reporting contact. The README previously linked the hosted version, which GitHub does
  not recognise and which named nobody to report to.
- **Issue and PR templates**, including one for data corrections — the lists are
  machine-generated, so corrections are the most useful kind of report.

### Added — `docs/`, mirrored to the Wiki

Eight pages. Two of them — [Filter reference](docs/Filter-Reference.md) and
[Retention & auto-delete](docs/Retention-and-Auto-Delete.md) — are **generated from
`data/`** by `tools/gen_docs.py`, with `--check` in CI. v0.2.0's README invented its filter
counts and documented 14 folders when the filters used 86; anything derived from the data is
generated now so it cannot say something the filters do not do.

`.github/workflows/wiki.yml` mirrors `docs/` to the repository Wiki on merge to `main`, so
pages go through review like everything else.

### Added — [AI disclosure](docs/AI-Disclosure.md)

A page naming which model wrote which part — GitHub Copilot (Claude Sonnet 4) and Grok 4 for
v0.1.0–v0.2.0, **Claude Opus 5** for the v0.2.1–v0.3.0 audit, rebuild and tooling — and what
that means for data nobody has fact-checked.

The old **"35% human / 65% AI"** figure is removed rather than updated. It was never
measured, and after this rework it would be wrong anyway.

### Changed — licensing

- **Three licences, split by content type**, replacing a single MIT that sat awkwardly
  across software, a dataset and prose:

  | Path | Licence |
  | --- | --- |
  | `filter/`, `bundles/`, `tools/`, `tests/`, `data/schema/`, `data/bundles.yml` | MIT |
  | `data/categories/`, `data/shared/` | CC0-1.0 |
  | Documentation | CC-BY-4.0 |

  The domain and keyword lists are collections of facts — which company sends from which
  domain, which words appear in which subject. CC0 puts them in the public domain with no
  attribution required and removes any residual database-right ambiguity. The generated
  `.sieve` files stay MIT: CC0 imposes no conditions, so nothing is inherited.

- **Copyright updated to `2025-2026`**; it had said `2025` while the newest commits were
  from 2026.
- `LICENSES/` holds the three canonical SPDX texts, unmodified, plus a
  [matrix](LICENSES/README.md) of which covers what. `data/LICENSE` states the CC0
  dedication in place.
- SPDX identifiers added to every Python file (MIT) and every category and shared data
  file (CC0).
- **`CITATION.cff`** added, replacing the citation block `REFERENCE.md` had hand-rolled.

### Changed — `ACKNOWLEDGE.md` → `ACKNOWLEDGMENTS.md`, rewritten

The old file thanked "Static Analysis and Linting Tools" that did not exist in the
repository, "Beta Testers and Early Adopters" for a project that had never had an external
contributor, and roughly thirty standards bodies and universities with no connection to
it. It also asked redistributors for more attribution than MIT requires.

The replacement credits what is actually used — the RFCs, Proton, and the three PyPI
packages the tooling depends on — states the AI authorship and what it means for the data,
and says plainly that MIT's notice requirement is the whole obligation.

### Fixed

- **The Vietnamese README had drifted to 14 filters** while the English one documented 22.
  It is back at full parity, and `tools/check_folders.py` now validates **both** maintained
  READMEs — every top-level folder and every filter filename must appear in each.


### Added — eight new filters

22 categories now, up from 14.

| Filter | Why |
| --- | --- |
| `phishing.sieve` | The 22 typosquats the reference lists had documented were **prose warnings only** — no filter acted on them. They are now one filter that flags `payp4l.com`, `pr0ton.me`, `faceb00k.com` and the rest, and it covers their subdomains too. |
| `shipping.sieve` | `Shopping/Shipping` fired on subject strings alone; **not one carrier domain existed anywhere in the repo**. 37 carriers now. |
| `bills.sieve` | Telecoms, energy and insurance were entirely absent. 50 domains. |
| `government.sieve` | Tax and government mail was absent apart from two domains hard-coded inside the legal filter. 22 domains, and **no expiry** — losing a tax notice is worse than clutter. |
| `recruiting.sieve` | Only job *boards* were covered; application status mail comes from the ATS. 16 domains, no expiry. |
| `ai.sieve` | Replaces the `AI_filter.sieve` stub that was 121 bytes of comments. 28 domains. |
| `devtools.sieve` | Package registries were absent. 31 domains. |
| `food.sieve` | Meal kits were covered, restaurant delivery was not. 32 domains. |

Also extended: **password managers and 2FA** added to security (9 domains), and
**non-US retail banking plus crypto exchanges** to invoice (30 domains) — the reference
lists documented eight exchanges and only three had ever reached a filter.

### Added — multi-language keywords actually work

989 Vietnamese, Chinese and Japanese keywords were documented in the old lists and
implemented in **zero** filters: every `.sieve` file was pure ASCII while the README
advertised multi-language support. 13 of the 22 filters now match on them, controlled by a
`languages:` key per category.

Verified not to disturb anything: **23,027 test messages route identically** before and
after, while multilingual messages that get filed at all went from **2 to 496**.

### Added — bundles

Proton's free plan allows one active filter, so 22 separate filters are unusable on it.
`bundles/essentials.sieve` (~26 KB) merges phishing, security, invoice, government and
shipping. `bundles/everything.sieve` (~190 KB) merges all 22 and may be too large to save.
Both are generated from `data/bundles.yml`.

### Fixed — the documented install order was backwards

Proton applies **every** matching filter and, on conflicting actions, **the last one
wins**. v0.2.1 documented the opposite, putting specific filters first and broad ones last
— which under real semantics let `work`, `shopping` and `spam` override the precise
filters. The order is reversed: broad first, specific last, `phishing` last of all.

Inside a bundle this inverts again — one script, so `stop;` makes the *first* match win —
so bundles are emitted in reverse install order.

### Fixed

- **The generator would have emitted a filter that swallowed the whole mailbox.** A
  top-level rule with no test at all compiles to unconditional `fileinto`, which is the
  catch-all class of defect v0.2.1 spent its time removing. The first draft of
  `phishing.yml` produced exactly that. `generate.py` now refuses to emit it.
- `expire` values above Proton's documented maximum of **730 days** are now a lint error.

### Notes

- **`study.sieve` still sets no retention**, deviating from the original plan to give it
  the 14 periods its keyword file documented. `data/shared/retention.yml` lists Study
  under `never_expire`, and adding delete timers to coursework in a release that exists to
  stop this project deleting mail was the wrong trade.
- `proton.com` is in the phishing blocklist because it is not one of Proton's sending
  domains (`proton.me`, `protonmail.com`, `pm.me`, `protonmail.ch`). It is the least
  clear-cut entry in that list and is annotated as such.

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
