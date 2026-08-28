"""Regression tests for the P0 defects fixed in v0.2.1.

Run against a directory of .sieve files:  python test_p0.py <dir>
"""
import sys, os

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), os.pardir, "tools"))

from sieve_eval import Message, deliver  # noqa: E402

D = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
    os.path.dirname(os.path.abspath(__file__)), os.pardir, "filter")
LISTS = {":addrbook:personal": set(), ":addrbook:myself": set(), ":incomingdefaults:spam": set()}


def msg(frm, subject, size=1000, to="me@example.com"):
    return Message({"from": frm, "subject": subject, "to": to}, size=size, lists=LISTS)


CASES = []


def case(name, filename, message, check, why):
    CASES.append((name, filename, message, check, why))


# 1. The mail-destroying catch-all.
case("legal: ordinary newsletter is NOT quarantined",
     "legal.sieve",
     msg("news@substack.com", "Your Tuesday briefing"),
     lambda r: r.folder != "Legal/Suspicious" and r.expire_days != 30,
     "every non-government sender was filed to Legal/Suspicious with a 30-day delete timer")

case("legal: a real legal threat IS still caught",
     "legal.sieve",
     msg("legal@random-firm.com", "Cease and Desist - immediate action"),
     lambda r: r.folder == "Legal/Suspicious",
     "the narrowed gate must not lose true positives")

# 2. spam_filter did not parse at all.
case("spam: script parses and files spam",
     "spam.sieve",
     msg("winner@lottery.tk", "Congratulations you have won"),
     lambda r: r is not None,
     "the whole script failed to parse, so none of it ever ran")

case("spam: display name with a comma is NOT spam-filed",
     "spam.sieve",
     msg("hr@company.com", "Update", to='"Doe, John" <john@example.com>'),
     lambda r: r.folder != "Spam",
     "header :contains \"to\" [\",\"] matched any quoted display name")

# 3. work_filter dead code.
case("work: 300K IT notice reaches Work/IT",
     "work.sieve",
     msg("it@microsoft.com", "IT Notice: VPN Access change", size=300 * 1024),
     lambda r: r.folder == "Work/IT",
     "size :over 100K in an anyof() sent every large message to Work/Reports")

case("work: small finance mail reaches Work/Finance",
     "work.sieve",
     msg("ap@microsoft.com", "Expense Report approval needed", size=50 * 1024),
     lambda r: r.folder != "Work/Reminders",
     "size :under 200K in an anyof() sent every small message to Work/Reminders")

# 4. Expiry overwritten by the shortest match.
case("invoice: receipt keeps 365 days, not 7",
     "invoice.sieve",
     msg("receipts@paypal.com", "Your Receipt - Payment Success"),
     lambda r: r.expire_days == 365,
     "no stop; meant a later 7-day tier overwrote the 365-day receipt tier")

# 5. shopping dead default.
case("shopping: non-promo mail reaches the 14-day default",
     "shopping.sieve",
     # Passes the outer gate on domain, but matches no subcategory subject.
     msg("hello@ikea.com", "A note about your account", size=20 * 1024),
     lambda r: r.expire_days == 14,
     "the 10-day promo rule had no subject gate, so it swallowed everything "
     "under 500K and made the 14-day default unreachable")

# 6. Catch-alls.
case("security: a plain noreply newsletter is NOT filed to Security",
     "security.sieve",
     msg("noreply@substack.com", "Weekly Update"),
     lambda r: r.folder is None,
     "any noreply@ sender was filed to Security, expired in 14 days, and stopped")

case("security: a real security alert IS still caught",
     "security.sieve",
     msg("noreply@bank.com", "Security Alert: new sign-in"),
     lambda r: r.folder is not None and str(r.folder).startswith("Security"),
     "narrowing must not lose true positives")

case("social: a noreply sender with unrelated subject is NOT filed",
     "social.sieve",
     msg("noreply@newsletter.example", "Monthly digest"),
     lambda r: r.folder != "Social Account",
     "a bare noreply sender test matched every automated message")

# 7. Unreachable weather block.
case("news: weather.com reaches News/Weather",
     "news.sieve",
     msg("alerts@weather.com", "Severe Weather warning for your area"),
     lambda r: r.folder == "News/Weather",
     "the weather domains were absent from the outer gate, so the block was dead")


def main():
    width = max(len(n) for n, *_ in CASES)
    fails = 0
    for name, fn, m, check, why in CASES:
        path = os.path.join(D, fn)
        try:
            r = deliver(path, m)
            ok = check(r)
            detail = f"folder={r.folder!r} expire={r.expire_days}"
        except SyntaxError as e:
            ok, detail = False, f"PARSE ERROR: {str(e)[:70]}"
        except Exception as e:
            ok, detail = False, f"{type(e).__name__}: {str(e)[:70]}"
        print(f"  {'PASS' if ok else 'FAIL'}  {name:<{width}}  {detail}")
        if not ok:
            fails += 1
            print(f"        why it matters: {why}")
    print(f"\n{len(CASES)-fails}/{len(CASES)} passed  (dir={D})")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
