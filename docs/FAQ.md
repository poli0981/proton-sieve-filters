# FAQ

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

## Do these really delete my mail?

Yes. Most filters set an auto-delete timer via Proton's `expire` extension, and Proton
removes the message when it runs out — 1 day for flash sales, 365 for receipts. Four filters
(`study`, `legal`, `government`, `recruiting`) set none at all.

[Retention & auto-delete](Retention-and-Auto-Delete.md) lists exactly what and when, and how
to switch it off.

## Can I use these on the free plan?

One of them, or a [bundle](Installation.md#bundles). Proton's free plan allows exactly one
active filter. `bundles/essentials.sieve` merges five categories into a single script for
this reason.

## Will they read my email?

They cannot. Proton uses zero-access encryption, so its servers never see message content
and Sieve has no `body` test there. A filter can test the sender, the subject line, the
envelope and the *encrypted* size — nothing else. See [PRIVACY.md](../PRIVACY.md).

## Does this project collect anything about me?

No. There is no telemetry, no server, no account, and nothing that runs on your machine —
the deliverable is text you paste into Proton's own settings.

## Will it sort mail already in my inbox?

No. Sieve runs at delivery, so filters only affect mail that arrives after you install them.

## Why 22 filters instead of one?

So you can install only what you want, and so a mistake in one category cannot affect the
others. If you want one, use a [bundle](Installation.md#bundles).

## Does the install order really matter?

Yes, and it is counter-intuitive. Proton applies **every** matching filter, and where two
conflict **the last one applied wins**. So broad categories go first and specific ones last,
and `phishing` goes last of all.

Inside a bundle it inverts — one script, so `stop;` makes the *first* match win. Bundles are
generated in reverse order to compensate.

## Why is my mail from Apple in Payments and not Shopping?

Because `apple.com` is owned by exactly one category, and that is `invoice`. 109 domains
used to be claimed by several filters at once — `apple.com` by seven — so where a message
landed depended on the order you happened to install in. Each domain now has one owner,
recorded in [`data/`](../data/) and enforced in CI.

To move it, see [Customisation](Customization.md).

## Can I edit the .sieve files directly?

You can, but they are **generated** — the next `python tools/generate.py` overwrites your
edit, and CI rejects a hand-edited filter. Edit [`data/`](../data/) instead.

If you only want one filter and no toolchain, copying the `.sieve` and editing your copy is
fine. You are then maintaining a fork of one file.

## Do I need Python?

Only to change something. To *use* the filters, copy and paste — nothing to install.

## How accurate are the domain lists?

Less than you would like. They were compiled by AI models and never individually
fact-checked; the v0.2.1 audit found defunct services, two domains attributed to the wrong
company, and entries that were not valid hostnames. See [AI disclosure](AI-Disclosure.md).

## Is this made by Proton?

No. It is an independent, unofficial project with **no affiliation to Proton AG**. Send
Proton problems to [Proton support](https://proton.me/support) and filter problems
[here](https://github.com/poli0981/proton-sieve-filters/issues).

## Can I use the domain lists in my own project?

Yes, freely. [`data/`](../data/) is **CC0** — public domain, no attribution required. The
code is MIT and the documentation CC-BY-4.0; see [LICENSES/README.md](../LICENSES/README.md).

## Why is a legitimate company in the phishing list?

It should not be. Those entries came from the same unverified source as everything else, and
`proton.com` is annotated in the data as the least clear-cut. Remove it from
`data/categories/phishing.yml`, regenerate, and please
[report it](https://github.com/poli0981/proton-sieve-filters/issues) — see
[SECURITY.md](../SECURITY.md).

## Can it filter calendar invites?

No, and it cannot be made to. Invites are identified by a MIME part (`text/calendar`), and
Proton's Sieve has no `body` test. Structurally out of reach.

## Do these work on Gmail, Fastmail, or my own server?

Not unmodified. They use `vnd.proton.expire`, which is Proton-only, and `extlists` names
specific to Proton's address book. The [`data/`](../data/) lists are portable; the generated
Sieve is not.

## Something else

[Troubleshooting](Troubleshooting.md), then
[open an issue](https://github.com/poli0981/proton-sieve-filters/issues). Do not paste real
message content into a public issue.
