# Proton Sieve Filters

[![CI](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml/badge.svg)](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/Version-0.2.1-blue.svg)](CHANGELOG.md)
[![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/issues)

14 Sieve scripts that sort a Proton Mail inbox into folders — shopping, travel, work,
security, and ten more. Sieve is the server-side filtering language Proton exposes to
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

## 📂 Available filters (v0.2.1)

Install them in this order. Proton runs filters **sequentially**, and where two filters
want to act on the same message, **the last action wins** — so order is not cosmetic. The
order below runs specific filters before broad ones.

| # | Filter | Purpose | Top-level folder | Folders |
|---|--------|---------|------------------|---------|
| 1 | [`security.sieve`](filter/security.sieve) | Account alerts, 2FA, breaches | `Security` | 10 |
| 2 | [`proton.sieve`](filter/proton.sieve) | Proton service notifications | `Proton` | 1 |
| 3 | [`invoice.sieve`](filter/invoice.sieve) | Bills, payments, receipts | `Payments` | 1 |
| 4 | [`legal.sieve`](filter/legal.sieve) | Terms, policies, legal updates | `Legal` | 2 |
| 5 | [`health.sieve`](filter/health.sieve) | Medical, fitness, wellness | `Health` | 1 |
| 6 | [`travel.sieve`](filter/travel.sieve) | Bookings, flights, hotels | `Travel` | 9 |
| 7 | [`study.sieve`](filter/study.sieve) | Education, courses, learning | `Study` | 19 |
| 8 | [`gaming.sieve`](filter/gaming.sieve) | Games, platforms, gaming news | `Gaming` | 1 |
| 9 | [`entertainment.sieve`](filter/entertainment.sieve) | Streaming, media, events | `Entertainment` | 9 |
| 10 | [`news.sieve`](filter/news.sieve) | News and newsletters | `News` | 9 |
| 11 | [`social.sieve`](filter/social.sieve) | Social network notifications | `Social Account` | 1 |
| 12 | [`work.sieve`](filter/work.sieve) | Professional, business | `Work` | 10 |
| 13 | [`shopping.sieve`](filter/shopping.sieve) | E-commerce, deals, purchases | `Shopping` | 12 |
| 14 | [`spam.sieve`](filter/spam.sieve) | Additional spam heuristics | `Spam` | 1 |

`work.sieve`, `shopping.sieve` and `spam.sieve` are deliberately last: their gates are the
broadest, so running them early would let them claim mail the more specific filters
handle better.

> [!NOTE]
> **109 domains are currently claimed by more than one filter** — `*apple.com` by seven of
> them. The order above decides who wins. Consolidating this is tracked for a future
> release; see [CHANGELOG.md](CHANGELOG.md).

---

## 📥 Installation

### Step 1 — create the folders first

**The scripts silently fail to file mail into a folder that does not exist.** Create them
under **Settings → Folders and labels → Add folder**.

Start with the 14 top-level folders:

```
Entertainment    News             Shopping
Gaming           Payments         Social Account
Health           Proton           Spam
Legal            Security         Study
                                  Travel
                                  Work
```

Note the exact names: **`Payments`** (not "Invoices"), **`News`** (not "Newsletters"),
**`Social Account`** (with a space), **`Spam`**, and **`Legal`** (not "EULA").

Then create the subfolders for whichever filters you install. Every script lists its own
folders in its header comment — open the file and read the `# Folders:` block. In total
the 14 filters target **86 distinct folders**. For example, `work.sieve` needs:

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

Domains, keywords and retention periods are all plain text near the top of each script.
See [Advanced customisation](#-advanced-customisation) below.

---

## ⏰ Retention & auto-delete

Every filter except `study.sieve` sets an expiry on the mail it files, using Proton's
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

To keep a category forever, delete its `expire "day" "N";` line. To find every expiry in a
script:

```bash
grep -n 'expire "day"' filter/shopping.sieve
```

Mail from anyone in your Proton address book is skipped by every filter before any of this
applies.

---

## 🗂️ Project structure

```
proton-sieve-filters/
├── filter/            # The 14 Sieve scripts
├── domain/            # Per-category domain reference lists (see note)
├── keyword/           # Per-category keyword reference lists (see note)
├── tools/             # Validation and linting
│   ├── validate_sieve.py    # parses every filter with a real Sieve parser
│   ├── lint_proton.py       # checks against Proton's dialect and known bug classes
│   ├── proton_dialect.py    # Proton's supported extensions, tests and limits
│   └── sieve_eval.py        # evaluator for the Sieve subset used here
├── tests/
│   └── test_regressions.py  # one behavioural test per defect fixed in v0.2.1
├── README/            # Translations
├── CHANGELOG.md
├── DISCLAIMER.md
└── LICENSE
```

> [!NOTE]
> `domain/` and `keyword/` are **reference documentation that has drifted from the
> scripts** — they are not the source the filters are built from. Over 700 Vietnamese,
> Chinese and Japanese keywords are documented there and implemented in **zero** filters.
> Making these lists the single source of truth is the next planned change.

---

## 🛠️ Advanced customisation

### Adding a domain

Add it to the `address :domain :matches "from" [...]` list in the **top-level gate** of the
script, not only to a subcategory block. A domain that appears only in a nested block can
never be reached, because the top-level gate filters the message out first:

```sieve
address :domain :matches "from" ["*yourshop.com", "*anothershop.com"],
```

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
python tools/validate_sieve.py    # does every filter parse?
python tools/lint_proton.py       # Proton dialect + known bug classes
python tests/test_regressions.py  # behavioural tests
```

All three run in CI on every push and pull request. `validate_sieve.py` uses a real Sieve
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
**Version**: 0.2.1 · **Last updated**: 2026-08-28

*This project is not affiliated with, endorsed by, or sponsored by Proton AG. Proton and
Proton Mail are trademarks of Proton AG.*
