# `data/` — the source of truth

Every domain and keyword lives here. **`filter/*.sieve` is generated from these
files**, so a change made directly to a `.sieve` will be overwritten.

Until v0.2.1 the situation was reversed: `domain/*.md` and `keyword/*.md` were
prose documents that had drifted away from the filters. A domain added to a
filter was never added to the list, and over 700 Vietnamese, Chinese and Japanese
keywords were documented and implemented in exactly zero filters. Those
directories are gone; `MIGRATION-REPORT.md` records what happened to every entry.

## Layout

```
data/
  categories/<id>.yml    # one per filter — filter/<id>.sieve is generated from it
  shared/retention.yml   # the canonical retention ladder
  schema/category.schema.json
```

## Adding a domain

Add a record to the category that should own it:

```yaml
domains:
  - match: example.com
    kind: allow
    scope: subdomains
    note: What this service is
```

`match` is the registrable domain with **no leading wildcard** — the generator
adds it according to `scope`.

## `kind` — this is the part that matters

| kind | meaning | emitted? |
| --- | --- | --- |
| `allow` | mail from here belongs to this category | yes |
| `block` | a typosquat or phishing lookalike | yes, as a *block* rule — never as an allow |
| `tld-example` | a bare public suffix such as `com` or `co.uk` | **never** |
| `sender` | a full address such as `noreply@proton.me` | yes, matched against `From` |
| `ceded` | another category owns it; see `ceded_to` | no |

The legacy lists encoded allow-versus-block **only** in a missing `*.` prefix,
with a "Watch for Typosquatting" heading somewhere above. A generator that
ignored that would have allowlisted `payp4l.com` and `pr0ton.me`. Making the
distinction an explicit field is the whole point of this directory.

`tld-example` entries are kept rather than deleted so nobody re-adds them. A bare
`com` classified `allow` would match every message on the internet;
`tools/check_data.py` fails the build if one appears.

## `scope`

| scope | emitted as | matches |
| --- | --- | --- |
| `subdomains` | `*example.com` | `example.com`, `mail.example.com` — and `notexample.com` |
| `subdomains-only` | `*.example.com` | `mail.example.com` only — a label is required in front |
| `exact` | `example.com` | that domain and nothing else |

Public suffixes such as `ac.uk` **must** use `subdomains-only`. Matching a whole
restricted academic namespace is deliberate; matching `hackac.uk` is not.

## One owner per domain

A domain may be `allow` in exactly one category. Proton runs filters
sequentially and the last conflicting action wins, so a domain claimed by several
filters resolved by install order — accidentally. 109 domains were in that state,
`apple.com` in seven filters at once.

Conflicts are now resolved in the data: one category owns it, the rest carry
`kind: ceded` with `ceded_to`. `tools/check_data.py` fails the build if two
categories both claim one.

## `install_order`

The position in the documented install sequence, and the tie-breaker for
ownership. Lower runs first. Specific categories go before broad ones — `work`,
`shopping` and `spam` are last because their gates are the widest.

## Retention

`expire_days` is a **delete timer**: Proton removes the message when it runs out.
`null` keeps it. Reuse a tier from [`shared/retention.yml`](shared/retention.yml)
where one fits — v0.2.0 reinvented the ladder in every filter and ended up with
fifteen different values for the same handful of concepts.

## Checking your change

```bash
python tools/check_data.py
```

Validates against [`schema/category.schema.json`](schema/category.schema.json)
and enforces everything above. It runs in CI.
