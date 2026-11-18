# Contributing

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

> [!IMPORTANT]
> **The project is in maintenance mode.** Pull requests are accepted for **domain fixes
> only** — adding, removing or correcting a domain in an existing category. Anything else
> (new categories, keywords, tooling, docs) is labelled `out-of-scope` and closed
> automatically. [MAINTENANCE.md](MAINTENANCE.md) has the full policy.

A domain fix is one line in a YAML file. Here is where that line goes.

## The one rule

**`filter/*.sieve` and `bundles/*.sieve` are generated. Do not edit them.** They are built
from [`data/`](data/), and CI fails if they no longer match. A pull request that edits a
`.sieve` by hand will be rejected by the build before a human sees it.

```
data/categories/shopping.yml   ->   filter/shopping.sieve
                               ->   bundles/*.sieve
```

## Setup

```bash
python -m pip install -r tools/requirements.txt
```

That is the whole toolchain: `sievelib`, `PyYAML`, `jsonschema`.

## Adding a domain

Find the category that should own it in [`data/categories/`](data/categories/) and add a
record:

```yaml
domains:
  - match: example.com
    kind: allow
    scope: subdomains
    note: What this service is
```

- `match` — the registrable domain, **no leading wildcard**. The generator adds it.
- `kind` — `allow`, or `block` for a typosquat. See [data/README.md](data/README.md).
- `scope` — `subdomains` for almost everything.
- `note` — required for `block`, and useful everywhere else.

A domain may be `allow` in **exactly one** category. If it is already owned elsewhere and
you think the other category is wrong, say so in the pull request rather than adding it
twice — the build will reject a duplicate.

Then regenerate and check:

```bash
python tools/generate.py
python tools/check_data.py
```

Commit the regenerated `.sieve` files along with the data change.

## Removing or correcting a domain

- **Defunct, or the site returns 404** — delete the record.
- **Renamed or moved** — change `match` to the new domain, and say in `note` what it was.
- **Wrong category** — make it `kind: allow` in the category that should own it, and in
  the old one either delete the record or change it to `kind: ceded` with `ceded_to`
  naming the new owner. See [data/README.md](data/README.md).
- **Wrong owner in the note** — fix the `note`.

Then regenerate and run the checks below. `docs/Filter-Reference.md` carries per-filter
domain counts, so run `python tools/gen_docs.py` too and commit what it changes.

## For your own copy: keywords and categories

Pull requests that add keywords or categories are **not accepted** during maintenance mode
and are closed automatically. The rest of this section is for people changing their own
fork — the data is CC0 and the code MIT, so nothing stops you.

### Adding a keyword

Same file, under `keyword_groups`. Non-English keywords go under the language code and are
emitted for any category whose `languages:` list includes it:

```yaml
keyword_groups:
  - group: Order Notifications
    en: ["Order Confirmation"]
    vi: ["Xác nhận đơn hàng"]
```

Prefer specific multi-word phrases. A bare common word in a gate with no sender constraint
is how v0.2.0 ended up with filters that swallowed the whole mailbox.

### Adding a category

Copy the shape of an existing small one — `data/categories/ai.yml` is a good model — and:

1. Give it an unused `install_order`. **Broad categories go first, specific ones last**:
   Proton applies every matching filter and the last conflicting action wins, so the
   specific filter needs to run later to have the final say.
2. Add it to `README.md` and `README/README.vi.md`. CI checks both.
3. Regenerate and run everything below.

## Before you open a pull request

A pull request may change only **existing** files in `data/categories/`, plus what is
regenerated from them: `filter/*.sieve`, `bundles/*.sieve`, `docs/Filter-Reference.md` and
`docs/Retention-and-Auto-Delete.md`. One that touches anything else is closed by
[`maintenance-triage.yml`](.github/workflows/maintenance-triage.yml) before review.

```bash
python tools/generate.py --check     # filters match the data
python tools/gen_docs.py --check     # generated docs match the data
python tools/validate_sieve.py       # every filter parses
python tools/lint_proton.py          # Proton dialect + known bug classes
python tools/check_data.py           # the data model
python tools/check_folders.py        # docs list the folders the filters use
python tools/check_links.py          # relative links resolve
python tests/test_regressions.py     # behavioural tests
```

All of these run in CI. If you changed filter behaviour, also show what it did to routing:

```bash
git stash && cp -r filter /tmp/old && git stash pop
python tools/check_roundtrip.py /tmp/old filter
```

That builds a corpus from the data — one message per domain and per subject keyword, at
five size bands — and reports every message whose folder, retention or flags changed. Say
in the pull request what changed and why it should.

## Things the build will stop you doing

These are all defects that actually shipped in v0.2.0, so they are checked now:

| Check | Why |
| --- | --- |
| `size` or `not` as a bare `anyof` member | Satisfies the gate alone, so the block swallows every message and everything after it is dead code. Shipped 36 times. |
| A top-level rule with no test | Compiles to an unconditional `fileinto` — the entire mailbox into one folder. |
| A domain in a nested block but not the top-level gate | Unreachable; the gate filters the message out first. |
| A bare TLD (`com`, `co.uk`) as `kind: allow` | Matches every message on the internet. |
| A typosquat allowed anywhere | Allowlists a phishing domain. |
| Sibling `expire` tiers with no `stop;` between them | The *last* match wins, so the shortest retention silently overrides the longest. |
| `expire` above 730 days | Proton's maximum. |
| `discard` in a `require` | It is a core command, not a capability; naming it makes Proton reject the whole script. |

## Reporting a problem instead

An issue does not need any of the above. Issues go through two forms:

- [**Domain fix**](https://github.com/poli0981/proton-sieve-filters/issues/new?template=domain-fix.yml)
  — a domain to add, remove or correct. A message that went to the wrong folder belongs
  here too: the **sender's domain** and the **subject pattern** are what is needed, and
  redacted is fine (`something@example-shop.com`, subject contains "Order").
- [**Proton Sieve change**](https://github.com/poli0981/proton-sieve-filters/issues/new?template=proton-sieve-change.yml)
  — Proton's editor rejects a filter you have not edited.

Do not paste real mail into a public issue; see [PRIVACY.md](PRIVACY.md). For anything
security-sensitive, see [SECURITY.md](SECURITY.md).

## Licensing your contribution

By contributing you agree your work is released under the licence covering the path you
changed — MIT for code, CC0 for `data/`, CC-BY-4.0 for documentation. See
[LICENSES/README.md](LICENSES/README.md).

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
