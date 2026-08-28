# Customisation

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

> [!IMPORTANT]
> **`filter/*.sieve` is generated. Edit [`data/`](../data/) and regenerate.** A hand edit is
> overwritten the next time anyone runs the generator, and CI rejects it.

```bash
python -m pip install -r tools/requirements.txt
# edit data/categories/<category>.yml
python tools/generate.py
```

Then re-paste the changed filter into Proton.

## Editing without the toolchain

If you just want one filter and would rather not install Python: copy the `.sieve`, edit
your copy, and paste that into Proton. It will work. You are then maintaining a fork of one
file, and it will not pick up upstream fixes — fine for a one-off, awkward long-term.

Everything below assumes the supported path.

---

## Add a domain

```yaml
domains:
  - match: yourshop.com
    kind: allow
    scope: subdomains
    note: Where you buy things
```

`match` takes the registrable domain with **no wildcard** — the generator emits
`"yourshop.com", "*.yourshop.com"`, which matches the domain and its subdomains and nothing
else.

A domain may be `allow` in **exactly one** category; `tools/check_data.py` fails otherwise.
To move one, set the current owner's record to `kind: ceded` with `ceded_to:` naming the new
owner.

To make it reach a **subfolder**, add it to that rule's `domains:` list as well. A domain
listed only in a nested rule is unreachable — the top-level gate filters the message out
first, which is a real bug the linter now catches.

## Add a keyword

```yaml
keyword_groups:
  - group: Order Notifications
    en: ["Order Confirmation", "Your Receipt"]
    vi: ["Xác nhận đơn hàng"]
```

Non-English keywords are emitted for any category whose `languages:` includes that code.
For an English-only build:

```yaml
languages: [en]
```

**Prefer specific phrases.** `"Order Confirmation"` is safe; a bare `"Order"` in a gate with
no sender constraint pulls in mail from anyone. That is how v0.2.0 ended up with a shopping
filter that hijacked the invoice filter.

## Change what gets deleted

Find the rule and edit `expire_days`:

```yaml
- folder: Shopping/Orders
  expire_days: 365      # delete after a year
```

**Remove the key entirely to keep mail indefinitely.** Maximum is 730 days — Proton's limit,
and a lint error above it. See [Retention & auto-delete](Retention-and-Auto-Delete.md).

## Rename a folder

Change `folder:` on the rule (and `folder:` at the top of the file if it is the category's
main one), regenerate, and **create the new folder in Proton before re-pasting**. Mail
already in the old folder stays there.

`tools/check_folders.py` will tell you to add a new top-level folder to `README.md` and
`README/README.vi.md`.

## Whitelist more senders

The simplest way needs no editing at all: **add them to your Proton address book.** Every
filter skips `:addrbook:personal` before anything else.

For a category-level exception, use `exclude_subjects` on a rule, or a `not` test — but the
address book is almost always the better answer.

## Turn a category off

Do not install its filter. If you want it gone from the generated output entirely, delete
its `data/categories/<id>.yml`, regenerate, and remove its row from both READMEs.

## Build your own bundle

```yaml
# data/bundles.yml
bundles:
  - id: mine
    title: My bundle
    description: Just the ones I use.
    categories: [phishing, security, invoice, shopping]
```

`python tools/generate.py` writes `bundles/mine.sieve`. Categories are emitted in reverse
install order, because a bundle is one script and `stop;` makes the first match win.

## Check your changes

```bash
python tools/generate.py --check     # committed filters match the data
python tools/validate_sieve.py       # everything parses
python tools/lint_proton.py          # Proton dialect + known bug classes
python tools/check_data.py           # the data model
```

To see what your change did to routing rather than guessing:

```bash
cp -r filter /tmp/before
# ...make your change, then:
python tools/generate.py
python tools/check_roundtrip.py /tmp/before filter
```

That builds a corpus from the data — one message per domain and per subject keyword, at five
size bands — and reports every message whose folder, retention or flags changed. If it
reports more than you intended, your change is wider than you thought.

## See also

- [`data/README.md`](../data/README.md) — the data model in full
- [Proton's Sieve dialect](Proton-Sieve-Dialect.md) — what the language allows
- [`CONTRIBUTING.md`](../CONTRIBUTING.md) — sending a change back
