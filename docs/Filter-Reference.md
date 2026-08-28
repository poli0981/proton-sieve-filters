<!-- GENERATED FILE -- do not edit. Run `python tools/gen_docs.py`.
     Source: data/categories/*.yml -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->

# Filter reference

One section per filter, in install order. **Install them in this order** — Proton applies every matching filter and, where two conflict, the last one applied wins, so the sequence runs broad categories first and specific ones last.

Generated from `data/categories/`. Counts here are what the filters actually contain.

| # | Filter | Folder | Domains | Keywords | Retention |
|---|--------|--------|---------|----------|-----------|
| 1 | [`spam.sieve`](../filter/spam.sieve) | `Spam` | 0 | 299 | 7 d |
| 2 | [`shopping.sieve`](../filter/shopping.sieve) | `Shopping` | 178 | 349 | 1–365 d |
| 3 | [`work.sieve`](../filter/work.sieve) | `Work` | 184 | 368 | 1–365 d |
| 4 | [`food.sieve`](../filter/food.sieve) | `Food` | 32 | 0 | 7 d |
| 5 | [`devtools.sieve`](../filter/devtools.sieve) | `Dev` | 31 | 0 | 30 d |
| 6 | [`ai.sieve`](../filter/ai.sieve) | `AI` | 28 | 0 | 30 d |
| 7 | [`social.sieve`](../filter/social.sieve) | `Social Account` | 121 | 259 | 1–28 d |
| 8 | [`news.sieve`](../filter/news.sieve) | `News` | 150 | 268 | 1–14 d |
| 9 | [`entertainment.sieve`](../filter/entertainment.sieve) | `Entertainment/General` | 145 | 257 | 1–28 d |
| 10 | [`gaming.sieve`](../filter/gaming.sieve) | `Gaming` | 218 | 205 | 2–21 d |
| 11 | [`recruiting.sieve`](../filter/recruiting.sieve) | `Recruiting` | 16 | 0 | none |
| 12 | [`study.sieve`](../filter/study.sieve) | `Study` | 144 | 374 | none |
| 13 | [`shipping.sieve`](../filter/shipping.sieve) | `Shipping` | 37 | 0 | 60 d |
| 14 | [`travel.sieve`](../filter/travel.sieve) | `Travel` | 217 | 362 | 1–90 d |
| 15 | [`health.sieve`](../filter/health.sieve) | `Health` | 186 | 299 | 1–365 d |
| 16 | [`legal.sieve`](../filter/legal.sieve) | `Legal` | 0 | 138 | 7–30 d |
| 17 | [`bills.sieve`](../filter/bills.sieve) | `Bills` | 50 | 0 | 365 d |
| 18 | [`government.sieve`](../filter/government.sieve) | `Government` | 22 | 0 | none |
| 19 | [`invoice.sieve`](../filter/invoice.sieve) | `Payments` | 111 | 204 | 3–365 d |
| 20 | [`proton.sieve`](../filter/proton.sieve) | `Proton` | 9 | 191 | 1–365 d |
| 21 | [`security.sieve`](../filter/security.sieve) | `Security/Critical` | 9 | 419 | 14–365 d |
| 22 | [`phishing.sieve`](../filter/phishing.sieve) | `Phishing` | 0 | 0 | none |

---

## 1. Spam

Additional spam heuristics beyond Proton's own.

- **File:** [`filter/spam.sieve`](../filter/spam.sieve)
- **Data:** [`data/categories/spam.yml`](../data/categories/spam.yml)
- **Domains:** 0 matched
- **Keywords:** 299 (30 non-English)
- **Folders (1):** `Spam`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Spam` | 7 days |

## 2. Shopping

E-commerce, orders, shipping and deals.

- **File:** [`filter/shopping.sieve`](../filter/shopping.sieve)
- **Data:** [`data/categories/shopping.yml`](../data/categories/shopping.yml)
- **Domains:** 178 matched, 39 ceded to another category, 5 blocked as typosquats
- **Keywords:** 349 (91 non-English)
- **Folders (13):** `Shopping`, `Shopping/Account`, `Shopping/Cart`, `Shopping/Deals`, `Shopping/Orders`, `Shopping/Recommendations`, `Shopping/Returns`, `Shopping/Reviews`, `Shopping/Rewards`, `Shopping/Shipping`, `Shopping/Subscriptions`, `Shopping/Wishlist`, `Spam`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Shopping` | 14 days |
  | `Shopping/Orders` | 365 days |
  | `Shopping/Shipping` | 60 days |
  | `Shopping` | 1 days |
  | `Shopping/Cart` | 2 days |
  | `Shopping/Recommendations` | 7 days |
  | `Shopping/Returns` | 90 days |
  | `Shopping/Rewards` | 30 days |
  | `Shopping/Reviews` | 14 days |
  | `Shopping/Subscriptions` | 90 days |
  | `Shopping/Wishlist` | 21 days |
  | `Shopping/Account` | 60 days |
  | `Shopping` | 7 days |
  | `Shopping` | 10 days |

## 3. Work

Professional and business correspondence.

- **File:** [`filter/work.sieve`](../filter/work.sieve)
- **Data:** [`data/categories/work.yml`](../data/categories/work.yml)
- **Domains:** 184 matched, 22 ceded to another category
- **Keywords:** 368 (159 non-English)
- **Folders (10):** `Work`, `Work/Career`, `Work/Finance`, `Work/HR`, `Work/IT`, `Work/Meetings`, `Work/Projects`, `Work/Reminders`, `Work/Reports`, `Work/Sales`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Work` | 14 days |
  | `Work` | 3 days |
  | `Work` | 7 days |
  | `Work` | 90 days |
  | `Work` | 60 days |
  | `Work` | 180 days |
  | `Work` | 1 days |
  | `Work` | 30 days |
  | `Work/Finance` | 365 days |

## 4. Food & Delivery

Restaurant delivery and food ordering.

- **File:** [`filter/food.sieve`](../filter/food.sieve)
- **Data:** [`data/categories/food.yml`](../data/categories/food.yml)
- **Domains:** 32 matched
- **Keywords:** 0
- **Folders (1):** `Food`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Food` | 7 days |

## 5. Developer Tools

Package registries, CI, hosting and observability.

- **File:** [`filter/devtools.sieve`](../filter/devtools.sieve)
- **Data:** [`data/categories/devtools.yml`](../data/categories/devtools.yml)
- **Domains:** 31 matched
- **Keywords:** 0
- **Folders (1):** `Dev`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Dev` | 30 days |

## 6. AI Services

AI assistants, model providers and generative tools.

- **File:** [`filter/ai.sieve`](../filter/ai.sieve)
- **Data:** [`data/categories/ai.yml`](../data/categories/ai.yml)
- **Domains:** 28 matched
- **Keywords:** 0
- **Folders (1):** `AI`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `AI` | 30 days |

## 7. Social Media

Social network notifications.

- **File:** [`filter/social.sieve`](../filter/social.sieve)
- **Data:** [`data/categories/social.yml`](../data/categories/social.yml)
- **Domains:** 121 matched, 25 ceded to another category, 4 blocked as typosquats
- **Keywords:** 259 (57 non-English)
- **Folders (2):** `Social Account`, `Spam`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Social Account` | 1 days |
  | `Social Account` | 28 days |
  | `Social Account` | 7 days |
  | `Social Account` | 5 days |
  | `Social Account` | 3 days |
  | `Social Account` | 10 days |

## 8. News & Newsletters

News outlets and newsletter platforms.

- **File:** [`filter/news.sieve`](../filter/news.sieve)
- **Data:** [`data/categories/news.yml`](../data/categories/news.yml)
- **Domains:** 150 matched, 19 ceded to another category
- **Keywords:** 268 (60 non-English)
- **Folders (9):** `News`, `News/Business`, `News/Entertainment`, `News/Politics`, `News/Science`, `News/Sports`, `News/Tech`, `News/Weather`, `News/World`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `News` | 3 days |
  | `News` | 2 days |
  | `News` | 7 days |
  | `News` | 1 days |
  | `News` | 14 days |

## 9. Entertainment

Streaming, music, podcasts, books and events.

- **File:** [`filter/entertainment.sieve`](../filter/entertainment.sieve)
- **Data:** [`data/categories/entertainment.yml`](../data/categories/entertainment.yml)
- **Domains:** 145 matched, 8 ceded to another category
- **Keywords:** 257 (60 non-English)
- **Folders (9):** `Entertainment/Books`, `Entertainment/Comics`, `Entertainment/Events`, `Entertainment/General`, `Entertainment/Movies-TV`, `Entertainment/Music`, `Entertainment/News`, `Entertainment/Podcasts`, `Entertainment/Reviews`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Entertainment/General` | 7 days |
  | `Entertainment/General` | 14 days |
  | `Entertainment/General` | 10 days |
  | `Entertainment/General` | 1 days |
  | `Entertainment/General` | 3 days |
  | `Entertainment/General` | 28 days |
  | `Entertainment/General` | 5 days |

## 10. Gaming

Game stores, publishers, esports and gaming news.

- **File:** [`filter/gaming.sieve`](../filter/gaming.sieve)
- **Data:** [`data/categories/gaming.yml`](../data/categories/gaming.yml)
- **Domains:** 218 matched
- **Keywords:** 205 (36 non-English)
- **Folders (1):** `Gaming`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Gaming` | 21 days |
  | `Gaming` | 5 days |
  | `Gaming` | 2 days |
  | `Gaming` | 14 days |
  | `Gaming` | 7 days |
  | `Gaming` | 10 days |
  | `Gaming` | 3 days |

## 11. Recruiting & Applications

Applicant tracking systems and recruiter correspondence.

- **File:** [`filter/recruiting.sieve`](../filter/recruiting.sieve)
- **Data:** [`data/categories/recruiting.yml`](../data/categories/recruiting.yml)
- **Domains:** 16 matched
- **Keywords:** 0
- **Folders (1):** `Recruiting`
- **Sets delete timers:** no — this filter never expires mail

## 12. Study & Education

Courses, universities, research and learning platforms.

- **File:** [`filter/study.sieve`](../filter/study.sieve)
- **Data:** [`data/categories/study.yml`](../data/categories/study.yml)
- **Domains:** 144 matched, 7 ceded to another category
- **Keywords:** 374 (60 non-English)
- **Folders (19):** `Study`, `Study/Algorithms`, `Study/Art`, `Study/Biology`, `Study/Business`, `Study/Certification`, `Study/Chemistry`, `Study/Engineering`, `Study/General`, `Study/History`, `Study/Languages`, `Study/Mathematics`, `Study/Medicine`, `Study/Music`, `Study/Physics`, `Study/Programming`, `Study/Research`, `Study/TestPrep`, `Study/Textbooks`
- **Sets delete timers:** no — this filter never expires mail

## 13. Shipping & Deliveries

Carrier tracking and delivery notifications.

- **File:** [`filter/shipping.sieve`](../filter/shipping.sieve)
- **Data:** [`data/categories/shipping.yml`](../data/categories/shipping.yml)
- **Domains:** 37 matched
- **Keywords:** 0
- **Folders (1):** `Shipping`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Shipping` | 60 days |

## 14. Travel

Flights, hotels, car hire and trip planning.

- **File:** [`filter/travel.sieve`](../filter/travel.sieve)
- **Data:** [`data/categories/travel.yml`](../data/categories/travel.yml)
- **Domains:** 217 matched, 3 ceded to another category, 5 blocked as typosquats
- **Keywords:** 362 (126 non-English)
- **Folders (10):** `Spam`, `Travel`, `Travel/Activities`, `Travel/Alerts`, `Travel/Deals`, `Travel/Flights`, `Travel/Hotels`, `Travel/Planning`, `Travel/Reviews`, `Travel/Transport`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Travel` | 10 days |
  | `Travel` | 90 days |
  | `Travel` | 60 days |
  | `Travel` | 5 days |
  | `Travel` | 1 days |
  | `Travel` | 7 days |
  | `Travel` | 14 days |
  | `Travel` | 30 days |

## 15. Health & Fitness

Medical, fitness and wellness services.

- **File:** [`filter/health.sieve`](../filter/health.sieve)
- **Data:** [`data/categories/health.yml`](../data/categories/health.yml)
- **Domains:** 186 matched, 1 ceded to another category
- **Keywords:** 299 (93 non-English)
- **Folders (1):** `Health`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Health` | 5 days |
  | `Health` | 1 days |
  | `Health` | 3 days |
  | `Health` | 7 days |
  | `Health` | 14 days |
  | `Health` | 21 days |
  | `Health` | 28 days |
  | `Health` | 10 days |
  | `Health` | 90 days |
  | `Health` | 365 days |

## 16. Legal & Policy Notifications

Terms of service, privacy policy and EULA changes.

- **File:** [`filter/legal.sieve`](../filter/legal.sieve)
- **Data:** [`data/categories/legal.yml`](../data/categories/legal.yml)
- **Domains:** 0 matched
- **Keywords:** 138
- **Folders (2):** `Legal`, `Legal/Suspicious`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Legal` | 10 days |
  | `Legal` | 30 days |
  | `Legal` | 21 days |
  | `Legal` | 14 days |
  | `Legal` | 7 days |
  | `Legal/Suspicious` | 30 days |

## 17. Bills & Utilities

Telecoms, energy, water and insurance billing.

- **File:** [`filter/bills.sieve`](../filter/bills.sieve)
- **Data:** [`data/categories/bills.yml`](../data/categories/bills.yml)
- **Domains:** 50 matched
- **Keywords:** 0
- **Folders (1):** `Bills`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Bills` | 365 days |

## 18. Government & Tax

Tax authorities, government agencies and public services.

- **File:** [`filter/government.sieve`](../filter/government.sieve)
- **Data:** [`data/categories/government.yml`](../data/categories/government.yml)
- **Domains:** 22 matched
- **Keywords:** 0
- **Folders (1):** `Government`
- **Sets delete timers:** no — this filter never expires mail

## 19. Invoices & Payments

Receipts, invoices, payment processors and billing.

- **File:** [`filter/invoice.sieve`](../filter/invoice.sieve)
- **Data:** [`data/categories/invoice.yml`](../data/categories/invoice.yml)
- **Domains:** 111 matched, 2 ceded to another category, 4 blocked as typosquats
- **Keywords:** 204 (64 non-English)
- **Folders (2):** `Payments`, `Spam`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Payments` | 365 days |
  | `Payments` | 7 days |
  | `Payments` | 28 days |
  | `Payments` | 3 days |

## 20. Proton Service Notifications

Mail from Proton's own services.

- **File:** [`filter/proton.sieve`](../filter/proton.sieve)
- **Data:** [`data/categories/proton.yml`](../data/categories/proton.yml)
- **Domains:** 9 matched, 4 blocked as typosquats
- **Keywords:** 191 (30 non-English)
- **Folders (2):** `Proton`, `Spam`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Proton` | 10 days |
  | `Proton` | 90 days |
  | `Proton` | 365 days |
  | `Proton` | 30 days |
  | `Proton` | 1 days |
  | `Proton` | 14 days |
  | `Proton` | 7 days |

## 21. Security & Account

Account alerts, sign-in notifications, 2FA and breach warnings.

- **File:** [`filter/security.sieve`](../filter/security.sieve)
- **Data:** [`data/categories/security.yml`](../data/categories/security.yml)
- **Domains:** 9 matched
- **Keywords:** 419 (123 non-English)
- **Folders (10):** `Security`, `Security/Authentication`, `Security/Billing`, `Security/Changes`, `Security/Compliance`, `Security/Critical`, `Security/Education`, `Security/General`, `Security/Login`, `Security/Permissions`
- **Sets delete timers:** yes — see [Retention & auto-delete](Retention-and-Auto-Delete.md)

  | Folder | Deleted after |
  | --- | --- |
  | `Security/Critical` | 90 days |
  | `Security/Authentication` | 60 days |
  | `Security/Login` | 30 days |
  | `Security/Changes` | 45 days |
  | `Security/Billing` | 365 days |
  | `Security/Permissions` | 30 days |
  | `Security/Compliance` | 90 days |
  | `Security/Education` | 14 days |
  | `Security/General` | 21 days |
  | `Security` | 14 days |

## 22. Phishing & Typosquats

Lookalike domains that impersonate services the other filters handle.

- **File:** [`filter/phishing.sieve`](../filter/phishing.sieve)
- **Data:** [`data/categories/phishing.yml`](../data/categories/phishing.yml)
- **Domains:** 0 matched, 22 blocked as typosquats
- **Keywords:** 0
- **Folders (1):** `Phishing`
- **Sets delete timers:** no — this filter never expires mail

