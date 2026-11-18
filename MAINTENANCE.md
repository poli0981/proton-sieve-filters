# Maintenance policy

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

> [!IMPORTANT]
> **Status: maintenance mode, since 2026-11-18.** v0.3.0 is the last feature release. The
> filters keep working and keep being corrected, but nothing new is being built.

This page says exactly what that means: what still gets fixed, what does not, and what
happens to an issue or pull request that falls outside it.

## Why

The project does what it set out to do: 22 filters generated from one typed dataset, checked
in CI against every defect class that has actually shipped. What decays from here is the
**data** — services rename, shut down and move domains — not the design. Maintenance mode
puts the remaining effort where the decay is.

## What is still done

Four kinds of change are accepted. Everything else is out of scope.

| # | Case | How it arrives |
| --- | --- | --- |
| 1 | **Scheduled dependency updates** — the Python tooling and the GitHub Actions used by CI | Dependabot, monthly |
| 2 | **Security** — a dependency or Actions runtime problem rated **High or Critical**, or any other serious security issue that needs an urgent fix. Also a change the maintainer judges genuinely necessary. | Dependabot alert, or a [private advisory](SECURITY.md) |
| 3 | **A major change to Proton's Sieve dialect** — Proton adds, removes or changes what its editor accepts, and the filters break or need to follow | [Proton Sieve change](https://github.com/poli0981/proton-sieve-filters/issues/new?template=proton-sieve-change.yml) issue |
| 4 | **Domains** — add, remove or correct one: wrong category, wrong owner, renamed, defunct, or the website returns **404 Not Found** | [Domain fix](https://github.com/poli0981/proton-sieve-filters/issues/new?template=domain-fix.yml) issue, or a pull request |

Fixes ship as **0.3.x** patch releases. Domain fixes are batched; security fixes are not.

## What is not accepted

- New filters or categories
- New features in the generator, the tooling, the bundles or CI
- New keywords, keyword groups, folders, or changes to retention periods
- Support for mail providers or Sieve servers other than Proton
- Documentation rewrites and translation updates

None of these are bad ideas. They are just not going to be built here. Everything you need to
build them yourself is in the repository, and the licences put nothing in the way: the
domain and keyword lists in [`data/`](data/) are **CC0** — public domain, no attribution
required — and the code is **MIT**. [Customisation](docs/Customization.md) explains how to
change your own copy.

## What happens to an out-of-scope issue or pull request

[`.github/workflows/maintenance-triage.yml`](.github/workflows/maintenance-triage.yml)
labels it **`out-of-scope`**, closes it, and leaves a comment linking here.

- **Pull requests** are closed if they change anything other than **existing** files in
  `data/categories/`, plus the files regenerated from them: `filter/*.sieve`,
  `bundles/*.sieve`, `docs/Filter-Reference.md` and `docs/Retention-and-Auto-Delete.md`.
  Adding or deleting a category file is a new feature.
- **Issues** opened through one of the issue forms are left for the maintainer. Issues
  opened any other way are closed if they read as a feature request — "feature request",
  "new filter", "new category", a `[Feature]` or `feat:` title, or the Vietnamese, Chinese
  and Japanese equivalents.
- **Anything else** the maintainer labels `out-of-scope` by hand is closed the same way.

The maintainer's own changes and Dependabot's are never touched.

**Closing is not a verdict on the idea.** If yours is one of the four cases above — a
security fix, say, or a change to keep up with Proton — reply on the closed item and say
so. The maintainer reopens what fits and removes the label; the workflow never re-closes a
reopened item.

## Labels

| Label | Meaning |
| --- | --- |
| `domain-fix` | Add, remove or correct a domain — case 4 |
| `sieve-dialect` | Proton changed its Sieve dialect — case 3 |
| `dependencies` | Scheduled dependency update — case 1 |
| `security` | Security fix, or a High/Critical vulnerability — case 2 |
| `out-of-scope` | Outside this policy; closed automatically |

## Dependencies

There is very little to update, and none of it reaches users — the filters are plain text
pasted into Proton's settings.

| What | Where | Used by |
| --- | --- | --- |
| `sievelib`, `PyYAML`, `jsonschema` | [`tools/requirements.txt`](tools/requirements.txt) | CI and contributors' machines |
| `actions/checkout`, `actions/setup-python`, `actions/github-script`, the wiki sync action | [`.github/workflows/`](.github/workflows/) | CI |

[Dependabot](.github/dependabot.yml) checks both monthly and opens one grouped pull request
per ecosystem. A **High or Critical** advisory is fixed out of cycle; anything lower waits
for the next scheduled update.

The realistic exposure is the tooling reading YAML from pull requests. Every load goes
through `yaml.safe_load`, and the triage workflow never checks out or runs pull-request
code — see the comment at the top of the workflow.

## Proton's Sieve dialect

[`tools/proton_dialect.py`](tools/proton_dialect.py) is the one place that records what
Proton's editor accepts: the extensions, the tests, the 730-day `expire` ceiling, the
active-filter limits. When Proton changes any of it, that file changes first, the linter
follows, the filters are regenerated, and a patch release goes out.
[Proton's Sieve dialect](docs/Proton-Sieve-Dialect.md) documents the current state.

If Proton's editor rejects an **unmodified** filter, that is the signal — report it with
the [Proton Sieve change](https://github.com/poli0981/proton-sieve-filters/issues/new?template=proton-sieve-change.yml)
form and paste the exact error.

## If the status changes

This page, the README badge and an announcement in
[Discussions](https://github.com/poli0981/proton-sieve-filters/discussions) will all say so.
