<!-- GENERATED FILE -- do not edit. Run `python tools/gen_docs.py`.
     Source: data/categories/*.yml -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Retention & auto-delete

> [!WARNING]
> `expire_days` is a **delete timer**. When it runs out Proton removes the message. This is the single most consequential thing these filters do.

Proton's maximum is **730 days**; `tools/lint_proton.py` fails the build above that.

## Which filters delete mail

| Filter | Deletes? | Range |
| --- | --- | --- |
| `spam.sieve` | yes | 7 days |
| `shopping.sieve` | yes | 1–365 days |
| `work.sieve` | yes | 1–365 days |
| `food.sieve` | yes | 7 days |
| `devtools.sieve` | yes | 30 days |
| `ai.sieve` | yes | 30 days |
| `social.sieve` | yes | 1–28 days |
| `news.sieve` | yes | 1–14 days |
| `entertainment.sieve` | yes | 1–28 days |
| `gaming.sieve` | yes | 2–21 days |
| `recruiting.sieve` | **no** | keeps everything |
| `study.sieve` | **no** | keeps everything |
| `shipping.sieve` | yes | 60 days |
| `travel.sieve` | yes | 1–90 days |
| `health.sieve` | yes | 1–365 days |
| `legal.sieve` | yes | 7–30 days |
| `bills.sieve` | yes | 365 days |
| `government.sieve` | **no** | keeps everything |
| `invoice.sieve` | yes | 3–365 days |
| `proton.sieve` | yes | 1–365 days |
| `security.sieve` | yes | 14–365 days |
| `phishing.sieve` | **no** | keeps everything |

## The canonical ladder

Reuse one of these when a category needs a retention period, rather than inventing a value. v0.2.0 reimplemented the ladder in every filter and ended up with fifteen different numbers for the same handful of concepts.

| Tier | Days | Use for |
| --- | --- | --- |
| `permanent` | keep forever | Tax documents, government correspondence; Software licence keys and activation codes; Anything the user may need to prove later |
| `records` | 365 | Receipts, invoices, order confirmations; Subscription and renewal notices; Warranty and purchase records |
| `reference` | 90 | Completed bookings and itineraries after travel; HR and payroll notifications; Medical appointment records |
| `tracking` | 60 | Shipping and delivery updates; Returns and refunds in progress |
| `transactional` | 30 | Policy and terms-of-service changes; Account changes worth being able to look back at |
| `notification` | 14 | Security and sign-in alerts; Service status and maintenance notices |
| `ephemeral` | 7 | Newsletters and editorial mail; Social network notifications; Spam heuristic matches |
| `promotional` | 3 | Marketing, deals and discount codes; Recommendations and "you might also like" |
| `expiring` | 1 | Flash sales and same-day offers; Daily digests and standup reminders |

## Never expire

These are listed in `data/shared/retention.yml` as categories where losing a message is worse than keeping clutter:

- `Study`
- `Legal`
- `Security/Critical`

## Turning it off

Remove the `expire_days` key from the rule in [`data/categories/`](../data/categories/) and regenerate:

```bash
python tools/generate.py
```

To see every retention value a filter currently sets:

```bash
grep -n 'expire "day"' filter/shopping.sieve
```

