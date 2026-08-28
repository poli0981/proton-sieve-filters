# Security policy

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

## Reporting

Email **coding201913@hotmail.com**, or open a
[private security advisory](https://github.com/poli0981/proton-sieve-filters/security/advisories/new).

Please do not open a public issue for anything in the first table below. Expect a first
response within about a week — this is a single-maintainer project, not a funded one.

## What counts as a security issue here

This project ships text files that you paste into Proton's settings. It has no server, no
account, and nothing that runs on your machine. So the realistic threats are narrower than
for most software, and they are mostly about **mail going somewhere it should not**.

| Report privately | Why it matters |
| --- | --- |
| A filter that could send mail to `Spam`, `Trash`, or a `discard`, at scale | Silent mail loss |
| A `redirect` or any action that copies mail off the account | There is none today; one appearing would be serious |
| A retention timer far shorter than documented | Deletes mail the user expected to keep |
| A legitimate service in the `phishing` blocklist | Flags real mail as phishing, and publicly accuses a third party |
| A typosquat *missing* from the blocklist that impersonates a service covered here | Weakens the protection people installed it for |
| Anything in `tools/` that executes data as code | The generator reads untrusted YAML from pull requests |

Ordinary misrouting — "my Etsy mail goes to Shopping instead of Payments" — is a normal
[issue](https://github.com/poli0981/proton-sieve-filters/issues), not a security report.

## Out of scope

- **Proton Mail itself.** Report to [Proton](https://proton.me/security/report-vulnerability).
  This project is not affiliated with Proton AG.
- **The Sieve language.** Bugs in RFC 5228 or in Proton's implementation are not ours.
- **The unverified nature of the domain data.** It is documented in
  [DISCLAIMER.md](DISCLAIMER.md). A *specific* wrong entry is worth reporting; the general
  fact that the lists are machine-generated is already known.

## When you report

Include the filter, the data file, and — redacted — the sender domain and subject pattern
that triggers it. **Do not paste real message content**; see [PRIVACY.md](PRIVACY.md).

If you can, say what the check tooling does with it:

```bash
python tools/lint_proton.py
python tools/check_data.py
```

A case that the tooling *should* have caught but does not is especially useful — the point
of those checks is that a defect class cannot come back.

## Supported versions

| Version | Supported |
| --- | --- |
| 0.3.x | yes |
| 0.2.1 | security fixes only |
| ≤ 0.2.0 | **no — and you should update** |

v0.2.0 and earlier contain a defect that filed most of the mailbox into `Legal/Suspicious`
with a 30-day delete timer. If you are running one of those, read the advisory at the top
of [CHANGELOG.md](CHANGELOG.md) before doing anything else.

## Disclosure

Report privately, and give a reasonable window to fix before publishing — two weeks is
usually plenty for a text-file project. Fixes are announced in
[CHANGELOG.md](CHANGELOG.md), and you will be credited unless you ask not to be.
