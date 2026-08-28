# Disclaimer

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

Read this before installing anything. It is short on purpose.

---

## 1. These filters delete mail

Every filter except a few uses Proton's `vnd.proton.expire` extension to set an
**auto-delete timer** on the messages it files. When the timer runs out, **Proton deletes
the message.** This is not a warning about a theoretical risk — it is what the software
does by design, on every message it matches.

Retention ranges from **1 day** (flash sales, daily digests) to **365 days** (receipts and
invoices). Four filters — `study`, `legal`, `government` and `recruiting` — set no timer at
all, because losing coursework, a policy change, a tax notice or an offer letter is worse
than clutter.

**Before installing, read [docs/Retention-and-Auto-Delete.md](docs/Retention-and-Auto-Delete.md)**,
which lists exactly which filter deletes what and after how long, and how to turn it off.

### If you installed v0.2.0 or earlier

`EULAChange_filter.sieve` contained a logic error that made it match **almost every
message in the mailbox**, file it into `Legal/Suspicious`, and set a **30-day delete
timer**. Two other filters mis-routed mail into `Security` and `Social Account` with
14-day timers.

**Check those three folders and move anything you want to keep out of them.** Details in
[CHANGELOG.md](CHANGELOG.md).

---

## 2. Not affiliated with Proton

This is an independent, unofficial project. It is **not affiliated with, endorsed by,
sponsored by, or connected to Proton AG** in any way. Proton has not reviewed it.

**Proton**, **Proton Mail**, **Proton VPN** and the Proton logo are trademarks of
Proton AG. They are used here only to describe what this project is compatible with —
nominative use — and no claim to them is made.

Do not report problems with these filters to Proton support. Report them
[here](https://github.com/poli0981/proton-sieve-filters/issues).

---

## 3. You need a paid Proton plan

Proton's **free plan allows exactly one active filter at a time**. This project ships 22.

A [bundle](README.md#-bundles--one-filter-instead-of-22) merges several categories into a
single script so free-plan users get something, but the full set requires a paid plan
(unlimited filters, up to 250 active).

---

## 4. The data is machine-generated and unverified

The domain and keyword lists were compiled with AI assistance and are **not individually
fact-checked**. This is not hypothetical: the audit that produced v0.2.1 found, in the
shipped data,

- **13 domains whose own comment said "(defunct)"** — services that no longer exist,
- **two domains attributed to the wrong company** — `frontier.com` listed as a game studio
  when it is a telecom, `steam.com` listed as Valve's when it is not,
- **one entry that was not a valid hostname** (`canal+.com`), and
- **127 patterns that matched more than intended** — `*ea.com` also matched `ikea.com`.

Those specific faults are fixed. Others like them are likely still present. Treat the
lists as a well-organised starting point, not as reference material.

The typosquat blocklist in `phishing.sieve` deserves particular scepticism: flagging a
domain as a phishing lookalike is a claim about a third party, and those entries came from
the same unverified source. `proton.com` is annotated in the data as the least clear-cut of
them.

---

## 5. Filters make mistakes, and you own the outcome

A filter that matches on sender domain and subject line will get things wrong in both
directions:

- **False positives.** Mail you wanted lands in a folder you do not check, and — if that
  category sets a timer — is eventually deleted.
- **False negatives.** Mail you expected to be sorted stays in the inbox.
- **Nothing is read.** Because of Proton's zero-access encryption, no filter here can see
  message *content* — only headers, the envelope, and the encrypted size. A filter cannot
  tell an important message from an unimportant one; it can only match a domain or a word
  in a subject line.

**You are responsible for what happens to your mail.** Install one filter at a time, check
the folders it fills for the first week, and keep your own backups of anything that
matters. Do not put these in front of mail you cannot afford to lose without reading
[docs/Retention-and-Auto-Delete.md](docs/Retention-and-Auto-Delete.md) first.

---

## 6. No warranty

This software is provided **"AS IS"**, without warranty of any kind, express or implied,
including but not limited to the warranties of merchantability, fitness for a particular
purpose and non-infringement.

**The entire risk as to quality and performance is with you.** In no event shall the
authors, contributors or copyright holders be liable for any claim, damages or other
liability — including lost, deleted or misfiled email — whether in contract, tort or
otherwise, arising from or in connection with this software or its use.

This restates the [MIT licence](LICENSE), which governs. Nothing in this file grants rights
beyond it or imposes obligations on you beyond it.

---

## 7. Governing law

The author is in Vietnam and this project is offered from there. Where a governing law must
be determined, the laws of the Socialist Republic of Vietnam apply, without regard to
conflict-of-law rules — except where mandatory consumer-protection law in your own
jurisdiction says otherwise, in which case that law applies.

Nothing here is legal advice. If a filter's behaviour matters to a legal or regulatory
obligation you have, consult a qualified professional in your jurisdiction.

---

## Related

- [PRIVACY.md](PRIVACY.md) — what this project can and cannot see (short answer: nothing)
- [SECURITY.md](SECURITY.md) — reporting a security problem
- [docs/Retention-and-Auto-Delete.md](docs/Retention-and-Auto-Delete.md) — the delete timers
- [CHANGELOG.md](CHANGELOG.md) — what changed and why
