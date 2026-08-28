# AI disclosure

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

Most of this project was written by AI models. That is disclosed here in detail because it
has consequences for how much you should trust the parts you are about to install.

## Who wrote what

| Model | Period | What it produced |
| --- | --- | --- |
| **GitHub Copilot (Claude Sonnet 4)** | Aug 2025, v0.1.0–v0.2.0 | Most of the original Sieve scripts, the domain and keyword reference lists, the first documentation |
| **Grok 4** | Aug 2025, v0.1.0–v0.2.0 | Research, further domain and keyword compilation, translations |
| **Claude Opus 5** | Aug 2026, v0.2.1–v0.3.0 | The audit and defect fixes, the `data/` model and migration, the generator, all validation tooling and tests, the current documentation |
| **[@poli0981](https://github.com/poli0981)** *(human)* | throughout | The project itself: concept, direction, review, and every decision about what it should do |

## What that means for the data

**The domain and keyword lists are machine-compiled and were never individually
fact-checked.** This is not a theoretical caveat. The v0.2.1 audit found, in data that had
been shipping for a year:

- **13 domains whose own comment said "(defunct)"** — the list documented that the service
  no longer existed and shipped it anyway
- **`frontier.com` filed under gaming** as Frontier Developments, which is `frontier.co.uk`.
  `frontier.com` is a telecom.
- **`steam.com` filed as Valve's domain.** It is not; Valve uses `steampowered.com`.
- **`canal+.com`**, which is not a valid hostname
- **`*.bbc.co.uk/sport`** — a URL path in a field that only ever holds a domain
- **`*plenty offish.com`** — a space inside a domain, so it could never match anything

Those are fixed. **Others like them are almost certainly still there**, because 2,103 domain
records were compiled the same way and nobody has checked them one by one.

Treat the lists as a well-organised starting point. If a filter's behaviour on a particular
sender matters to you, verify that entry yourself.

## What that meant for the code

The AI-written filters shipped with defects that a review pass did not catch, including one
that **filed most of the mailbox into a folder with a 30-day delete timer** and one that
**did not parse at all**, so it never ran. The full list is in
[CHANGELOG.md](../CHANGELOG.md) under v0.2.1.

The lesson taken from that is the reason [`tools/`](../tools/) exists. Rather than reviewing
harder, each defect class was turned into a check that fails the build:

| Defect | Now caught by |
| --- | --- |
| A script that does not parse | `validate_sieve.py`, using a real Sieve parser |
| A gate that matches every message | `lint_proton.py`, and the generator refuses to emit one |
| A domain that can never be reached | `lint_proton.py` |
| A typosquat allowlisted, or a bare TLD allowed | `check_data.py` |
| Documentation drifting from the filters | `check_folders.py`, `gen_docs.py --check` |
| Routing changing when it should not | `check_roundtrip.py`, over ~23,000 synthetic messages |

The v0.2.1 fixes were verified by running the same behavioural tests against the old and new
trees: **2 of 12 passed before, 12 of 12 after**. The v0.3.0 migration was verified by
routing 20,568 messages through both and accounting for every difference.

That is the standard this project now holds itself to, and it is a better answer to "an AI
wrote it" than any amount of assurance.

## Why say all this

Because you are being asked to install software that **deletes email**, and the honest
description of its provenance is "largely machine-written, with a documented history of
defects that machine-written review did not catch."

You should weigh that. [DISCLAIMER.md](../DISCLAIMER.md) is the short version;
[Retention & auto-delete](Retention-and-Auto-Delete.md) is the page that matters most before
installing.

## On the old "35% / 65%" figure

Earlier versions of the README claimed a precise human/AI contribution split. It was a
guess, it was never measured, and after the v0.2.1–v0.3.0 rework it would be wrong anyway.
It has been removed rather than updated. The table at the top of this page says who did what
without pretending to a precision nobody has.
