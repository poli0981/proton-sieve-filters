# Troubleshooting

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

## Proton refuses to save the filter

**Check the `require` line first.** Proton rejects the *whole script* if it names anything
outside its supported set:

```
fileinto  imap4flags  reject  vacation  date  envelope  variables  relational
regex  extlists  include  comparator-i;ascii-numeric
vnd.proton.eval  vnd.proton.expire
```

`discard`, `keep`, `stop` and `redirect` are **core commands, not extensions** — naming one
in `require` is an error. See [Proton's Sieve dialect](Proton-Sieve-Dialect.md).

If you edited the file, run the checks:

```bash
python tools/validate_sieve.py
python tools/lint_proton.py
```

If you did **not** edit it and Proton still refuses, that is a bug — please
[report it](https://github.com/poli0981/proton-sieve-filters/issues) with the exact error.

## The filter saves, but nothing happens

In order of likelihood:

1. **The folder does not exist.** This is the usual cause and it fails *silently*. Check the
   `# Folders:` block at the top of the script and create every one.
2. **The name does not match exactly.** `Social Account` has a space. `Payments`, not
   "Invoices". `News`, not "Newsletters". `Legal`, not "EULA".
3. **The filter is not enabled.** Check the toggle in Settings → Filters.
4. **You are on the free plan with another filter active.** Free allows exactly one.
5. **You are testing with old mail.** Filters run at delivery. They never touch mail already
   in the mailbox.

## Mail goes to the wrong folder

Two filters are competing. Proton applies **every** matching filter, and where they
conflict **the last one applied wins** — so the filter you installed *later* is winning.

Check your install order against the `#` column in the
[filter reference](Filter-Reference.md). The order runs broad categories first and specific
ones last on purpose. If you installed `shopping` after `invoice`, shopping wins; reversing
them fixes it.

To change it, delete both filters and re-add them in the right order — Proton runs them in
creation order.

## Mail I wanted is being filtered

Add the sender to your **Proton address book**. Every filter checks
`:addrbook:personal` first and stops, so address-book senders are never touched. This is the
fix for almost every false positive and needs no editing.

If it is a whole category misbehaving, narrow it in
[`data/`](../data/) — see [Customisation](Customization.md).

## Mail disappeared

**Check the retention table.** These filters set auto-delete timers, and Proton removes the
message when one runs out. [Retention & auto-delete](Retention-and-Auto-Delete.md) lists
exactly which filter deletes what and after how long.

If you installed **v0.2.0 or earlier**, look in `Legal/Suspicious`, `Security` and
`Social Account` — a defect in that version filed most of the mailbox into them with
delete timers. The advisory is at the top of [CHANGELOG.md](../CHANGELOG.md).

Deleted mail may still be in **Trash** for a while. Proton's own retention there is not
something this project controls.

## A legitimate sender is flagged as phishing

`phishing.sieve` flags lookalike domains. Its entries came from the project's original
unverified lists, so a false accusation is possible — `proton.com` is annotated in the data
as the least clear-cut of them.

Remove the entry from `data/categories/phishing.yml`, regenerate, and
[tell us](https://github.com/poli0981/proton-sieve-filters/issues) so it is fixed for
everyone. See [SECURITY.md](../SECURITY.md) — this counts as a security report.

## Everything lands in one folder

That is the signature of a **catch-all defect**: a gate that matches every message. It
should be impossible now — the generator refuses to emit a top-level rule with no test, and
the linter rejects a `size` or `not` sitting alone in an `anyof`.

If you see it, you are either on an old version or on a hand-edited filter. Run:

```bash
python tools/lint_proton.py
```

and [report it](https://github.com/poli0981/proton-sieve-filters/issues) if the file is
unmodified.

## The build fails after I edited something

| Message | Meaning |
| --- | --- |
| `DRIFT ... differs from what data/... generates` | You edited a `.sieve` by hand. Move the change into `data/` and run `python tools/generate.py`. |
| `is owned by 2 categories` | Two categories both claim a domain. One needs `kind: ceded`. |
| `is a general-purpose public suffix but classified allow` | You added a bare TLD such as `com`. It would match everything. |
| `has no test, so it would match every message` | A top-level rule with no domains or subjects. |
| `satisfies the gate alone` | A `size` or `not` inside an `anyof`. Use `allof`. |
| `is absent from the top-level gate` | A domain in a nested rule that the gate filters out first. |
| `does not mention <folder>` | A new folder needs adding to `README.md` **and** `README/README.vi.md`. |

## Getting help

[Search the issues](https://github.com/poli0981/proton-sieve-filters/issues) first, then
open one. Useful details: which filter, which version, the sender **domain** and the subject
**pattern**.

**Do not paste real message content into a public issue** — see [PRIVACY.md](../PRIVACY.md).

For problems with Proton Mail itself rather than these filters, contact
[Proton support](https://proton.me/support). This project is not affiliated with Proton AG.
