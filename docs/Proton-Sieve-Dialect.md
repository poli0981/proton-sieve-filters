# Proton's Sieve dialect

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

What Proton's Sieve implementation supports, what it does not, and where it differs from
the base standard. Everything here is enforced by
[`tools/lint_proton.py`](../tools/lint_proton.py) against
[`tools/proton_dialect.py`](../tools/proton_dialect.py).

Source: [Proton — Sieve advanced custom filters](https://proton.me/support/sieve-advanced-custom-filters)
and [Proton — How to use email filters](https://proton.me/support/email-inbox-filters).

## Extensions you may `require`

```
fileinto            imap4flags          reject              vacation
date                envelope            variables           relational
regex               extlists            include
comparator-i;ascii-numeric
vnd.proton.eval     vnd.proton.expire
```

Anything else makes Proton **reject the whole script**, not just that line.

> [!CAUTION]
> `discard`, `keep`, `stop` and `redirect` are **core RFC 5228 commands**, not extensions.
> They need no `require`, and naming one there is an error. `spam_filter.sieve` shipped
> with `require [... "discard" ...]` in v0.2.0 and would not load at all.

## Tests

Supported: `address`, `header`, `envelope`, `exists`, `size`, `string`, `date`,
`currentdate`, `hasflag`, `hasexpiration`, `expiration`, `anyof`, `allof`, `not`, `true`,
`false`, `valid_ext_list`.

**There is no `body` test.** Proton uses zero-access encryption, so its servers cannot read
message content. A filter can test headers, the envelope, and the *encrypted* size — that
is all. Any filter that claims to match on what an email says is wrong by construction.

## Proton-specific extensions

### `vnd.proton.expire`

```sieve
expire "day" "30";
```

Sets an auto-delete timer. **Proton removes the message when it runs out.** Maximum is
**730 days**. This is the most consequential thing in the dialect — see
[Retention & auto-delete](Retention-and-Auto-Delete.md).

### `vnd.proton.eval`

Evaluates a simple arithmetic function given as a string. Not used in this project.

## `extlists` — the address book

```sieve
if header :list "from" ":addrbook:personal" { stop; }
if header :list "from" ":incomingdefaults:spam" { discard; stop; }
```

| List | Contents |
| --- | --- |
| `:addrbook:personal` | Your Proton contacts |
| `:addrbook:myself` | Your own addresses |
| `:incomingdefaults:spam` | Senders Proton already treats as spam |

Every filter here opens with the `:addrbook:personal` check, so mail from people you know is
never touched.

## How filters interact

Proton applies **every** matching filter to a message. Non-conflicting actions all apply;
where two conflict, **the last one applied wins**.

A Sieve `stop;` ends *that script*, not the chain — the next filter still runs. That has two
consequences worth internalising:

- **Separate filters:** install broad ones first, specific ones last, so the specific one
  has the final say.
- **Inside one script (a bundle):** `stop;` does end processing, so the **first** match
  wins — the opposite. Bundles here are generated in reverse install order to compensate.

## Limits

| | |
| --- | --- |
| Active filters, free plan | **1** |
| Active filters, paid plan | 250 (unlimited created) |
| Maximum `expire` | 730 days |
| Maximum script size | not documented by Proton |

## Regular expressions

`:regex` is available with the `regex` extension, but **shorthand classes are not
supported**: `\b`, `\w`, `\W`, `\d`, `\D`, `\s`, `\S` do not work. Use POSIX classes
(`[[:alpha:]]`, `[[:digit:]]`) instead. No filter in this project uses `:regex`.

## Matching gotchas that cost this project real bugs

### `*example.com` is a suffix match

`address :domain :matches "from" ["*ea.com"]` matches anything **ending** in `ea.com` —
including `ikea.com` and `silversea.com`. `*box.com` matches `xbox.com`. **127 such
collisions were shipping in v0.2.0.**

Write the pair instead, which is what the generator emits:

```sieve
address :domain :matches "from" ["example.com", "*.example.com"]
```

### `anyof` is OR, and a `size` test inside one satisfies it alone

```sieve
if anyof (
    header :contains "subject" ["Report"],
    size :over 100K              # <-- every message over 100K matches, alone
) { fileinto "Work/Reports"; stop; }
```

This shipped **36 times**. Everything over 100 KB stopped at `Work/Reports`, making the
blocks after it unreachable. Use `allof` when a size test is meant to narrow.

### A `{ ... }` block is not a test

```sieve
if anyof (
    header :contains "from" ["noreply@"] {   # <-- not valid Sieve
        not anyof ( ... )
    }
) { ... }
```

Brace counting balances, so this survives review — but the script does not parse and
**nothing in it ever runs**. `spam_filter.sieve` shipped this way. Use `allof(...)`.

### `header :contains "to" [","]` is not "multiple recipients"

A comma appears in any quoted display name — `"Doe, John" <john@example.com>`. Using it as
a bulk-mail signal files ordinary correspondence as spam.

## Checking a script

```bash
python -m pip install -r ../tools/requirements.txt
python tools/validate_sieve.py    # parses with a real Sieve parser
python tools/lint_proton.py       # dialect + the gotchas above
```

`validate_sieve.py` uses [sievelib](https://github.com/tonioo/sievelib), taught Proton's
`extlists` `:list` match-type and the `expire` command at runtime.

**Neither is the last word.** Proton's own editor is the only authority on its dialect —
paste the script in and confirm it saves.

## Specifications

| | |
| --- | --- |
| [RFC 5228](https://datatracker.ietf.org/doc/html/rfc5228) | Sieve — the base language |
| [RFC 5229](https://datatracker.ietf.org/doc/html/rfc5229) | Variables |
| [RFC 5230](https://datatracker.ietf.org/doc/html/rfc5230) | Vacation |
| [RFC 5231](https://datatracker.ietf.org/doc/html/rfc5231) | Relational |
| [RFC 5232](https://datatracker.ietf.org/doc/html/rfc5232) | Imap4flags |
| [RFC 5173](https://datatracker.ietf.org/doc/html/rfc5173) | Body — *not supported by Proton* |
| [RFC 6134](https://datatracker.ietf.org/doc/html/rfc6134) | Extlists |
