# Privacy

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

**This project collects nothing.** There is no telemetry, no analytics, no network call, no
account, and no server belonging to it. Nothing to opt out of.

That is the whole answer. The rest of this page explains why it is structurally true rather
than just a promise.

---

## There is nothing here that runs on your machine

The deliverable is text. A `.sieve` file is a filter script that you copy and paste into
Proton's own settings page. Nothing is installed, nothing starts at boot, nothing has
network access.

The Python under [`tools/`](tools/) is for *building and checking the filters* — it reads
YAML from `data/` and writes Sieve into `filter/`. It never touches mail, and you do not
need to run it to use the filters. It makes no network requests either.

---

## Where the filters actually run

On **Proton's servers**, as part of delivering a message to your mailbox. Your relationship
there is with Proton, under
[Proton's privacy policy](https://proton.me/legal/privacy) — not with this project. This
project has no visibility into anything that happens at that point.

---

## What a filter can see

Very little, and this is a property of Proton's design rather than a choice made here.
Proton uses zero-access encryption, so its servers cannot read your message bodies. A Sieve
filter running there can therefore test only:

| Can see | Cannot see |
| --- | --- |
| Headers — `From`, `To`, `Subject`, `Date` | **Message body.** There is no `body` test; Proton does not support one |
| The envelope | Attachments, or their names |
| The **encrypted** size of the message | Anything the encryption covers |
| Whether the sender is in your Proton address book | |

So a filter can act on *who wrote to you and what the subject line says*. It cannot act on
what the message says, and no filter in this repository claims to.

---

## What the filters do with it

Three things, all local to your mailbox: move the message to a folder, set a flag (read, or
flagged), and set a delete timer. Nothing is copied, forwarded, redirected or reported
anywhere. There is no `redirect` command in any filter in this repository — you can check:

```bash
grep -rn 'redirect' filter/ bundles/
```

The one action worth understanding properly is the delete timer. See
[docs/Retention-and-Auto-Delete.md](docs/Retention-and-Auto-Delete.md) and
[DISCLAIMER.md](DISCLAIMER.md).

---

## The data in this repository

[`data/`](data/) contains domain names of companies (`paypal.com`, `ups.com`) and generic
subject-line phrases (`"Order Confirmation"`, `"Security Alert"`). It contains **no personal
data**: no addresses, no names, no message content, nothing derived from anyone's mailbox.

It was compiled from public knowledge of which companies send mail from which domains — not
by scraping anyone's email.

---

## If you contribute

Git records the name and email address in your commits, and GitHub records your account
against issues and pull requests. That is ordinary for any public repository, and it is
governed by [GitHub's privacy statement](https://docs.github.com/site-policy/privacy-policies/github-privacy-statement).

**Do not paste real email content into an issue.** If you are reporting a misrouted
message, the sender's domain and the subject pattern are enough — and both can be redacted
to the shape of the problem (`something@example-shop.com`, subject contains "Order").
See [SECURITY.md](SECURITY.md) for anything sensitive.

---

## Changes

Any change to this page is a commit in [the history](https://github.com/poli0981/proton-sieve-filters/commits/main/PRIVACY.md).
Since the answer is "nothing is collected", there is not much scope for it to change without
that being obvious in the diff.
