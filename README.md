# Proton Sieve Filters

[![CI](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml/badge.svg)](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-0.3.0-blue.svg)](CHANGELOG.md)
[![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/issues)

22 Sieve scripts that sort a Proton Mail inbox into folders — shopping, travel, work,
security, phishing protection, and seventeen more. Sieve is the server-side filtering language Proton exposes to
paid accounts.

**Languages:** English · [Tiếng Việt](README/README.vi.md) — both maintained.
Community translations, currently out of date:
[日本語](README/community/README.ja.md) ·
[简体中文](README/community/README.zh.md)

> [!WARNING]
> **These filters delete mail.** They use Proton's `expire` extension to set
> auto-delete timers on messages they match — a newsletter filed by `news.sieve` is
> gone in 1–14 days, a receipt filed by `invoice.sieve` in 365. Read
> [Retention & auto-delete](#-retention--auto-delete) before installing anything, and
> read [CHANGELOG.md](CHANGELOG.md) if you installed **v0.2.0 or earlier** — it
> contains an advisory about a defect that scheduled most of the mailbox for deletion.

> [!IMPORTANT]
> **A paid Proton plan is required to use more than one of these.** Proton's free plan
> allows exactly **one active filter** at a time. Paid plans allow unlimited filters
> with up to **250 active**.

---

## 📧 What this is

Each script matches on the sender domain and the subject line, files the message into a
folder, marks it read, and sets a retention period. They are copy-pasted into Proton's
Sieve editor; nothing is installed on your machine and nothing phones home.

**What Sieve can and cannot see on Proton.** Because of zero-access encryption, Proton's
servers never see your message *content*. Filters can test headers, the envelope, and the
*encrypted* size — that is all. There is no `body` test, so no filter here can match on
what an email actually says.

**🤖 AI-assisted development.** This project was developed with AI assistance for
research, script writing, and translation, then reviewed by
[@poli0981](https://github.com/poli0981).

- **👨‍💻 Human (@poli0981): 35%** — concept, architecture, prompt engineering, bug fixes,
  Vietnamese content, QA
- **🤖 AI (GitHub Copilot/Claude Sonnet 4 & Grok 4): 65%** — implementation, translations,
  research, documentation, domain/keyword compilation

The domain and keyword lists were compiled this way and are **not individually verified**.
They contain defunct services and at least two domains attributed to the wrong company.
See [DISCLAIMER.md](DISCLAIMER.md).

---

## 📂 Available filters (v0.3.0)

**Install them in this order.** Proton applies **every** matching filter to a message and,
where two conflict, **the last one applied wins**. So the sequence runs broad categories
first and specific ones last, giving the most specific filter the final say.

| # | Filter | Purpose | Top-level folder | Folders |
|---|--------|---------|------------------|---------|
| 1 | [`spam.sieve`](filter/spam.sieve) | Additional spam heuristics beyond Proton's own | `Spam` | 1 |
| 2 | [`shopping.sieve`](filter/shopping.sieve) | E-commerce, orders, shipping and deals | `Shopping` | 13 |
| 3 | [`work.sieve`](filter/work.sieve) | Professional and business correspondence | `Work` | 10 |
| 4 | [`food.sieve`](filter/food.sieve) | Restaurant delivery and food ordering | `Food` | 1 |
| 5 | [`devtools.sieve`](filter/devtools.sieve) | Package registries, CI, hosting and observability | `Dev` | 1 |
| 6 | [`ai.sieve`](filter/ai.sieve) | AI assistants, model providers and generative tools | `AI` | 1 |
| 7 | [`social.sieve`](filter/social.sieve) | Social network notifications | `Social Account` | 2 |
| 8 | [`news.sieve`](filter/news.sieve) | News outlets and newsletter platforms | `News` | 9 |
| 9 | [`entertainment.sieve`](filter/entertainment.sieve) | Streaming, music, podcasts, books and events | `Entertainment` | 9 |
| 10 | [`gaming.sieve`](filter/gaming.sieve) | Game stores, publishers, esports and gaming news | `Gaming` | 1 |
| 11 | [`recruiting.sieve`](filter/recruiting.sieve) | Applicant tracking systems and recruiter correspondence | `Recruiting` | 1 |
| 12 | [`study.sieve`](filter/study.sieve) | Courses, universities, research and learning platforms | `Study` | 19 |
| 13 | [`shipping.sieve`](filter/shipping.sieve) | Carrier tracking and delivery notifications | `Shipping` | 1 |
| 14 | [`travel.sieve`](filter/travel.sieve) | Flights, hotels, car hire and trip planning | `Travel` | 10 |
| 15 | [`health.sieve`](filter/health.sieve) | Medical, fitness and wellness services | `Health` | 1 |
| 16 | [`legal.sieve`](filter/legal.sieve) | Terms of service, privacy policy and EULA changes | `Legal` | 2 |
| 17 | [`bills.sieve`](filter/bills.sieve) | Telecoms, energy, water and insurance billing | `Bills` | 1 |
| 18 | [`government.sieve`](filter/government.sieve) | Tax authorities, government agencies and public services | `Government` | 1 |
| 19 | [`invoice.sieve`](filter/invoice.sieve) | Receipts, invoices, payment processors and billing | `Payments` | 2 |
| 20 | [`proton.sieve`](filter/proton.sieve) | Mail from Proton's own services | `Proton` | 2 |
| 21 | [`security.sieve`](filter/security.sieve) | Account alerts, sign-in notifications, 2FA and breach warnings | `Security` | 10 |
| 22 | [`phishing.sieve`](filter/phishing.sieve) | Lookalike domains impersonating the services above | `Phishing` | 1 |

`phishing.sieve` is last on purpose: a message from a domain pretending to be PayPal should
end up flagged as phishing whatever else claimed it.

> [!NOTE]
> 109 domains used to be claimed by more than one filter — `apple.com` by seven of them —
> so the destination depended on the order you happened to install in. Each domain now has
> exactly one owning category, recorded in [`data/`](data/) and enforced in CI.

---

## 📦 Bundles — one filter instead of 22

Proton's free plan allows **one active filter**, which makes 22 separate filters unusable
on it. A bundle merges several categories into a single script.

| Bundle | Contains | Size |
|--------|----------|------|
| [`bundles/essentials.sieve`](bundles/essentials.sieve) | phishing, security, invoice, government, shipping | ~26 KB |
| [`bundles/everything.sieve`](bundles/everything.sieve) | all 22 categories | ~190 KB |

**`essentials` is the one to use.** It covers phishing protection plus the categories where
losing a message actually costs something. `everything` is provided for completeness, but
Proton publishes no maximum filter size and 190 KB is a lot to paste into a web editor —
check that it saves before relying on it.

Inside a bundle the ordering inverts: it is one script, so `stop;` means the **first**
match wins. The generator emits bundles in reverse install order so a bundle routes mail
the same way the separate filters would. Edit
[`data/bundles.yml`](data/bundles.yml) to build your own.

---

## 🌍 Multi-language keywords

Filters match subjects in **English, Vietnamese, Chinese and Japanese**. 989 non-English
keywords were documented in the old reference lists and implemented in **zero** filters —
every `.sieve` file was pure ASCII while the README advertised multi-language support.
They are emitted now.

Adding them changed nothing for existing mail: 23,027 test messages route identically
before and after, while the number of multilingual messages that get filed at all went
from 2 to 496.

To build an English-only set, set `languages: [en]` in the category files and regenerate.

---

## 📥 Installation

### Step 1 — create the folders first

**The scripts silently fail to file mail into a folder that does not exist.** Create them
under **Settings → Folders and labels → Add folder**.

Start with the 22 top-level folders:

```
AI          Entertainment   Government   Phishing     Shipping         Study
Bills       Food            Health       Proton       Shopping         Travel
Dev         Gaming          Legal        Recruiting   Social Account   Work
                            News         Security     Spam
                            Payments
```

Note the exact names: **`Payments`** (not "Invoices"), **`News`** (not "Newsletters"),
**`Social Account`** (with a space), **`Spam`**, **`Legal`** (not "EULA") and **`Dev`**.

Then create the subfolders for whichever filters you install. Every script lists its own
folders in its header comment — open the file and read the `# Folders:` block. In total
the 22 filters target **94 distinct folders**. For example, `work.sieve` needs:

```
Work/Career    Work/HR         Work/Meetings   Work/Reminders   Work/Sales
Work/Finance   Work/IT         Work/Projects   Work/Reports
```

### Step 2 — install the filters

1. **Settings → Filters → Add Sieve filter**
2. Open a `.sieve` file from [`filter/`](filter/) and copy the whole script
3. Paste it in, and name it something you will recognise (e.g. `01 — Security`)
4. Save, then **install the next one in the order given above**

Prefix the filter names with a number. Proton lists filters in the order you create them,
and that order is what decides conflicts.

### Step 3 — customise (optional)

Domains, keywords and retention periods live in [`data/categories/`](data/categories/), not
in the `.sieve` files. See [Advanced customisation](#-advanced-customisation) below.

---

## ⏰ Retention & auto-delete

Most filters set an expiry on the mail it files, using Proton's
`vnd.proton.expire` extension. **Proton deletes the message when the timer runs out.**

Typical values as shipped:

| Category | Retention |
|----------|-----------|
| Receipts, invoices, order confirmations | 365 days |
| Shipping and delivery updates | 60 days |
| Security and account notifications | 14–30 days |
| Proton service mail | 10–90 days |
| Newsletters, promotions, social notifications | 1–14 days |
| Spam heuristic matches | 7 days |

To keep a category forever, remove its `expire_days` in
[`data/categories/`](data/categories/) and regenerate. To see every retention value a
filter sets:

```bash
grep -n 'expire "day"' filter/shopping.sieve
```

The tiers themselves are documented in
[`data/shared/retention.yml`](data/shared/retention.yml).

Mail from anyone in your Proton address book is skipped by every filter before any of this
applies.

---

## 🗂️ Project structure

```
proton-sieve-filters/
├── data/              # SOURCE OF TRUTH -- every domain and keyword lives here
│   ├── categories/    #   one .yml per filter
│   ├── shared/        #   the canonical retention ladder
│   └── schema/        #   JSON Schema for a category file
├── filter/            # The 14 Sieve scripts
├── tools/             # Generation, validation and linting
│   ├── generate.py          # data/ -> filter/*.sieve  (--check for no drift)
│   ├── check_roundtrip.py   # do two filter sets route mail the same way?
│   ├── validate_sieve.py    # parses every filter with a real Sieve parser
│   ├── lint_proton.py       # checks against Proton's dialect and known bug classes
│   ├── check_data.py        # enforces the data model in data/
│   ├── check_folders.py     # documented folders must match the filters
│   ├── check_links.py       # relative Markdown links must resolve
│   ├── migrate.py           # one-off: the legacy Markdown lists -> data/
│   ├── proton_dialect.py    # Proton's supported extensions, tests and limits
│   └── sieve_eval.py        # evaluator for the Sieve subset used here
├── tests/
│   └── test_regressions.py  # one behavioural test per defect fixed in v0.2.1
├── README/            # Translations
├── CHANGELOG.md
├── DISCLAIMER.md
├── MIGRATION-REPORT.md
└── LICENSE
```

> [!NOTE]
> **`filter/*.sieve` is generated. Edit [`data/`](data/) instead.** The 1,826 domain
> records and 3,992 keywords live in `data/categories/*.yml`; run
> `python tools/generate.py` to rebuild the filters, and CI fails if a `.sieve` no longer
> matches its data. See [data/README.md](data/README.md) for the model.

---

## 🛠️ Advanced customisation

### Adding a domain

Add it to the owning category in [`data/`](data/), not to a `.sieve` file:

```yaml
domains:
  - match: yourshop.com
    kind: allow
    scope: subdomains
    note: What this service is
```

A domain may be `allow` in exactly **one** category — `tools/check_data.py` fails the
build otherwise. See [data/README.md](data/README.md).

### Adjusting retention

```sieve
expire "day" "30";   # 30 days
expire "day" "365";  # 1 year
```

Delete the line entirely to keep matching mail indefinitely.

### Whitelisting contacts

Every filter already starts with this, so mail from your address book is never touched:

```sieve
if header :list "from" ":addrbook:personal" {
    stop;
}
```

### A caution on domain patterns

`*example.com` is a **suffix** match, not a subdomain match. v0.2.0 used that shorthand
everywhere, so `*ea.com` (EA) also matched `ikea.com` and `silversea.com`, and `*box.com`
(Box) also matched `xbox.com` — 127 such collisions were shipping. The generator now emits
the pair `"example.com", "*.example.com"`, which matches the domain and its subdomains and
nothing else.

### A caution on `anyof`

`anyof` is OR. A `size` test placed inside one satisfies the whole gate by itself, which
makes every message under (or over) that size match and turns the blocks below it into
dead code. This shipped 36 times in v0.2.0. Use `allof` when you mean AND:

```sieve
if allof (
    header :contains "subject" ["Invoice"],
    size :under 500K
) { ... }
```

`tools/lint_proton.py` fails the build on this pattern.

---

## 🧪 Validating your changes

```bash
python -m pip install -r tools/requirements.txt
python tools/generate.py          # rebuild filter/*.sieve from data/
python tools/generate.py --check  # ...or just assert they are up to date
python tools/validate_sieve.py    # does every filter parse?
python tools/lint_proton.py       # Proton dialect + known bug classes
python tools/check_data.py        # the data model in data/
python tools/check_folders.py     # documented folders match the filters
python tools/check_links.py       # relative links resolve
python tests/test_regressions.py  # behavioural tests
```

To prove a change routes mail the way you expect, keep a copy of the old filters and
compare. This builds a corpus from the data itself — one message per domain and per
subject keyword, at five size bands — and reports every message whose destination,
retention or flags changed:

```bash
python tools/check_roundtrip.py OLD_DIR filter
```

All of these run in CI on every push and pull request. `validate_sieve.py` uses a real Sieve
parser, taught Proton's `extlists` `:list` match-type and the `vnd.proton.expire` command.

Passing locally is not the last word — **Proton's own editor is the only authority on its
dialect.** Paste the script in and confirm it saves.

---

## 🚨 Troubleshooting

**Proton refuses to save the filter.** Check the `require` line. Proton accepts only
`fileinto`, `imap4flags`, `reject`, `vacation`, `date`, `envelope`, `variables`,
`relational`, `regex`, `comparator-i;ascii-numeric`, `extlists`, `include`,
`vnd.proton.eval` and `vnd.proton.expire`. Anything else — including core commands such as
`discard`, which needs no `require` — makes Proton reject the whole script.

**The filter saves but nothing happens.** The target folder probably does not exist, or
its name does not match the script exactly (`Social Account`, not `Social`).

**Mail lands in the wrong folder.** Two filters are competing. Check your install order —
the last matching filter wins.

**Important mail is being filtered.** Add the sender to your Proton address book; every
filter skips address-book senders before doing anything else.

**Mail disappeared.** Check the retention table above. Filters set delete timers.

---

## 🤝 Contributing

1. Fork and branch: `git checkout -b feature/amazing-feature`
2. Make the change, then run the three commands under
   [Validating your changes](#-validating-your-changes)
3. Add a test to `tests/test_regressions.py` if you fixed a bug
4. Open a pull request describing what changed and why

Follow the existing style, and respect the
[Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html).

---

## ⚠️ Limitations

- **Proton-specific.** Uses `vnd.proton.expire` and `extlists`; these scripts will not run
  unmodified on another Sieve server.
- **Paid plan.** The free plan allows one active filter.
- **New mail only.** Filters do not reorganise mail already in your mailbox.
- **Headers only.** No content matching is possible — see
  [What this is](#-what-this-is).
- **No warranty.** Read [DISCLAIMER.md](DISCLAIMER.md) before installing.

---

## 📄 License

MIT — see [LICENSE](LICENSE).

## 👨‍💻 Contact

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Email**: coding201913@hotmail.com

Before opening an issue, check the [existing issues](https://github.com/poli0981/proton-sieve-filters/issues)
and [Proton's Sieve documentation](https://proton.me/support/sieve-advanced-custom-filters).

## 🔗 Resources

- [Proton — Sieve advanced custom filters](https://proton.me/support/sieve-advanced-custom-filters)
- [Proton — How to use email filters](https://proton.me/support/email-inbox-filters)
- [RFC 5228 — Sieve](https://datatracker.ietf.org/doc/html/rfc5228)
- [RFC 5232 — Imap4flags](https://datatracker.ietf.org/doc/html/rfc5232)
- [RFC 6134 — Extlists](https://datatracker.ietf.org/doc/html/rfc6134)

---

**Repository**: https://github.com/poli0981/proton-sieve-filters
**Version**: 0.3.0 · **Last updated**: 2026-08-28

*This project is not affiliated with, endorsed by, or sponsored by Proton AG. Proton and
Proton Mail are trademarks of Proton AG.*
