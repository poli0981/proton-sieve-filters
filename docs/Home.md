# Proton Sieve Filters

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

22 Sieve scripts that sort a Proton Mail inbox into folders, generated from a typed dataset
of sender domains and subject keywords.

> [!WARNING]
> **These filters delete mail.** They set auto-delete timers on the messages they match.
> Read [Retention & auto-delete](Retention-and-Auto-Delete.md) before installing anything.

> [!IMPORTANT]
> Proton's **free plan allows one active filter**. Use a
> [bundle](Installation.md#bundles) if you are on it.

## Start here

| If you want to… | Go to |
| --- | --- |
| Install the filters | [Installation](Installation.md) |
| Know what each filter does | [Filter reference](Filter-Reference.md) |
| Know what gets deleted, and when | [Retention & auto-delete](Retention-and-Auto-Delete.md) |
| Change a domain, keyword or folder | [Customisation](Customization.md) |
| Fix something that is not working | [Troubleshooting](Troubleshooting.md) |
| Understand what Proton's Sieve supports | [Proton's Sieve dialect](Proton-Sieve-Dialect.md) |
| Know how much of this an AI wrote | [AI disclosure](AI-Disclosure.md) |
| Ask something else | [FAQ](FAQ.md) |

## How it fits together

```
data/categories/*.yml     the source of truth -- domains, keywords, rules
        |
        |  python tools/generate.py
        v
filter/*.sieve            22 filters, one per category   -> paste into Proton
bundles/*.sieve           merged, for one-filter installs
```

Edit the YAML, never the `.sieve`. CI fails if they drift apart.

## The short version of what this does

Each filter matches a message on **who sent it** (domain) and **what the subject says**,
then files it into a folder, marks it read, and sets a delete timer. It cannot do more than
that: Proton's zero-access encryption means the server never sees message content, so there
is no `body` test and no filter here can act on what an email actually says.

## Honest limitations

- The domain and keyword lists were compiled with AI assistance and are **not individually
  verified**. See [AI disclosure](AI-Disclosure.md) and [DISCLAIMER](../DISCLAIMER.md).
- Filters get things wrong in both directions. Install one at a time and check the folder it
  fills for the first week.
- This project is **not affiliated with Proton AG**. Do not send it their support tickets.

## Project links

[Repository](https://github.com/poli0981/proton-sieve-filters) ·
[Changelog](../CHANGELOG.md) ·
[Disclaimer](../DISCLAIMER.md) ·
[Privacy](../PRIVACY.md) ·
[Security](../SECURITY.md) ·
[Contributing](../CONTRIBUTING.md) ·
[Licences](../LICENSES/README.md)
