# Installation

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

Three steps: create the folders, paste the filters in order, then watch them for a week.

> [!WARNING]
> Filters set **auto-delete timers**. Read [Retention & auto-delete](Retention-and-Auto-Delete.md)
> first and decide whether you want them.

## Before you start

**A paid Proton plan is required for more than one filter.** Free allows exactly one active
filter; paid allows unlimited with up to 250 active. If you are on free, skip to
[Bundles](#bundles).

## Step 1 — create the folders

**A filter cannot file mail into a folder that does not exist. It fails silently.**

Go to **Settings → Folders and labels → Add folder** and create the 22 top-level folders:

```
AI          Entertainment   Government   Phishing     Shipping         Study
Bills       Food            Health       Proton       Shopping         Travel
Dev         Gaming          Legal        Recruiting   Social Account   Work
                            News         Security     Spam
                            Payments
```

Get these exactly right — they are the ones people most often assume:

| Folder | Not |
| --- | --- |
| `Payments` | "Invoices" |
| `News` | "Newsletters" |
| `Social Account` | "Social" — and it has a space |
| `Legal` | "EULA" |
| `Dev` | "Devtools" |

Then create the **subfolders** for whichever filters you install. Every script lists its own
at the top — open it and read the `# Folders:` block. The full set is in the
[filter reference](Filter-Reference.md); across all 22 filters it comes to **94 folders**.

You do not need all of them. Create the folders for the filters you actually install.

## Step 2 — install in order

**Order matters, and not in the way you might expect.** Proton applies **every** matching
filter to a message and, where two conflict, **the last one applied wins**. So the sequence
runs broad categories first and specific ones last, giving the specific filter the final
say. `phishing` is last of all: a domain pretending to be PayPal should be flagged whatever
else claimed it.

1. **Settings → Filters → Add Sieve filter**
2. Open a `.sieve` file from [`filter/`](../filter/) and copy the **whole** script
3. Paste it in and name it with its number — `01 — Spam`, `02 — Shopping`, …
4. Save, then do the next one

The numbering matters for you, not for Proton: Proton lists filters in creation order, and
that is the order they run. Numbering the names keeps it legible later.

The order is the `#` column in the [filter reference](Filter-Reference.md).

### You do not have to install all 22

Pick the categories you care about and install those, keeping their **relative** order.
Skipping numbers is fine.

## Step 3 — watch it for a week

Install **one filter at a time** and check the folder it fills before adding the next. What
to look for:

- Mail landing in a folder you did not expect
- Mail you wanted in the inbox getting filed away
- Anything in a folder with a short delete timer that you would rather keep

Add senders you always want to see to your **Proton address book** — every filter skips
address-book senders before doing anything else.

---

## Bundles

Proton's free plan allows one active filter, so 22 separate ones are unusable on it. A
bundle merges categories into a single script.

| Bundle | Contains | Size |
| --- | --- | --- |
| [`bundles/essentials.sieve`](../bundles/essentials.sieve) | phishing, security, invoice, government, shipping | ~26 KB |
| [`bundles/everything.sieve`](../bundles/everything.sieve) | all 22 categories | ~190 KB |

**Use `essentials`.** It is phishing protection plus the categories where losing a message
actually costs something. `everything` exists for completeness, but Proton publishes no
maximum filter size and 190 KB is a lot to paste into a web editor — confirm it saves before
relying on it.

Install a bundle exactly like a single filter, and create the folders it lists in its
header first.

Inside a bundle the ordering inverts — it is one script, so `stop;` means the **first**
match wins. The generator emits bundles in reverse install order so a bundle routes mail the
same way the separate filters would. To build your own, edit
[`data/bundles.yml`](../data/bundles.yml) and run `python tools/generate.py`.

## Uninstalling

Delete the filter in **Settings → Filters**. That stops any further sorting, but it does
**not** undo anything already done — mail already filed stays filed, and **delete timers
already set stay set**. To cancel a timer on a message, move it out of the folder and check
its expiration in Proton's own message view.

## Next

- [Customisation](Customization.md) — change domains, keywords, folders and timers
- [Troubleshooting](Troubleshooting.md) — when something does not work
