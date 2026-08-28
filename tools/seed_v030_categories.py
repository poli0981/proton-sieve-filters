"""Author the new categories for v0.3.0 and renumber install_order.

Domain lists here are deliberately conservative: well-known senders only. The
data model makes them easy to extend, and check_data.py enforces that no domain
is claimed twice.
"""
import collections
import glob
import io
import os
import sys

sys.path.insert(0, "tools")
import yaml

# --------------------------------------------------------------------------- #
NEW = {}

NEW["shipping"] = dict(
    title="Shipping & Deliveries",
    description="Carrier tracking and delivery notifications.",
    folder="Shipping",
    domains="""
ups.com fedex.com usps.com dhl.com royalmail.com parcelforce.com evri.com
canadapost-postescanada.ca purolator.com auspost.com.au nzpost.co.nz postnl.nl
dpd.com gls-group.eu tnt.com aramex.com sf-express.com japanpost.jp
correos.es poste.it laposte.fr deutschepost.de ontrac.com lasership.com
aftership.com goshippo.com easyship.com sendcloud.com 17track.net
bluedart.com delhivery.com ninjavan.co jtexpress.com vnpost.vn ghn.vn
giaohangtietkiem.vn viettelpost.vn
""",
    subjects=["Shipped", "Out for Delivery", "Delivery Update", "Tracking Number",
              "Package Delivered", "Shipment Notification", "In Transit",
              "Delivery Attempt", "Ready for Pickup", "Package Delayed",
              "Your parcel", "Proof of Delivery"],
    expire_days=60,
)

NEW["government"] = dict(
    title="Government & Tax",
    description="Tax authorities, government agencies and public services.",
    folder="Government",
    domains="""
irs.gov ssa.gov usa.gov medicare.gov healthcare.gov uscis.gov va.gov
studentaid.gov sec.gov ftc.gov treasury.gov dol.gov canada.ca cra-arc.gc.ca
ato.gov.au servicesaustralia.gov.au ird.govt.nz turbotax.com hrblock.com
taxact.com freetaxusa.com taxslayer.com
""",
    subjects=["Tax Return", "Tax Refund", "Notice of Assessment", "Benefit Statement",
              "Government Notice", "Public Service", "Jury Summons", "Voter Registration",
              "Passport Application", "Visa Application", "Social Security"],
    expire_days=None,   # never expire -- losing a tax notice is worse than clutter
    note="Retention is deliberately unset: government correspondence may be needed "
         "years later.",
)

NEW["bills"] = dict(
    title="Bills & Utilities",
    description="Telecoms, energy, water and insurance billing.",
    folder="Bills",
    domains="""
verizon.com att.com t-mobile.com xfinity.com comcast.com spectrum.com cox.com
centurylink.com frontier.com vodafone.com o2.co.uk ee.co.uk three.co.uk
orange.com telekom.de movistar.es rogers.com bell.ca telus.com telstra.com.au
optus.com.au docomo.ne.jp softbank.jp kddi.com viettel.vn vnpt.com.vn
mobifone.vn pge.com duke-energy.com nationalgrid.com coned.com octopus.energy
ovoenergy.com britishgas.co.uk eon.com engie.com evn.com.vn geico.com
progressive.com statefarm.com allstate.com libertymutual.com nationwide.com
farmers.com usaa.com lemonade.com aetna.com cigna.com humana.com axa.com
allianz.com aviva.co.uk directline.com
""",
    subjects=["Your Bill", "Bill Ready", "Statement Available", "Payment Due",
              "Autopay Confirmation", "Meter Reading", "Policy Renewal",
              "Premium Due", "Insurance Claim", "Service Charge", "Usage Summary"],
    expire_days=365,
)

NEW["recruiting"] = dict(
    title="Recruiting & Applications",
    description="Applicant tracking systems and recruiter correspondence.",
    folder="Recruiting",
    domains="""
greenhouse.io lever.co workable.com smartrecruiters.com jobvite.com ashbyhq.com
breezy.hr recruitee.com teamtailor.com icims.com taleo.net successfactors.com
myworkdayjobs.com jazzhr.com applytojob.com hired.com otta.com
""",
    subjects=["Application Received", "Application Update", "Interview Invitation",
              "Interview Scheduled", "Offer Letter", "Candidate Assessment",
              "Take-home Assignment", "Reference Request", "Application Status",
              "Thank You for Applying", "Next Steps"],
    expire_days=None,   # an offer or rejection is worth keeping
    note="Retention is deliberately unset: offers, rejections and assessments are "
         "worth keeping.",
)

NEW["ai"] = dict(
    title="AI Services",
    description="AI assistants, model providers and generative tools.",
    folder="AI",
    domains="""
openai.com anthropic.com claude.ai huggingface.co midjourney.com stability.ai
runwayml.com perplexity.ai cohere.com mistral.ai replicate.com elevenlabs.io
deepmind.com character.ai jasper.ai copy.ai writesonic.com poe.com together.ai
groq.com fireworks.ai langchain.com civitai.com leonardo.ai ideogram.ai
suno.com synthesia.io descript.com
""",
    subjects=["Usage Summary", "Credit Balance", "Model Update", "API Key",
              "Rate Limit", "New Model Available", "Beta Access", "Waitlist"],
    expire_days=30,
)

NEW["devtools"] = dict(
    title="Developer Tools",
    description="Package registries, CI, hosting and observability.",
    folder="Dev",
    domains="""
npmjs.com pypi.org rubygems.org crates.io packagist.org nuget.org docker.com
quay.io jfrog.com snyk.io circleci.com travis-ci.com jenkins.io netlify.com
vercel.com heroku.com render.com fly.io railway.app digitalocean.com
linode.com vultr.com cloudflare.com fastly.com sentry.io datadoghq.com
newrelic.com pagerduty.com statuspage.io sourcegraph.com jetbrains.com
hashicorp.com pulumi.com supabase.com planetscale.com neon.tech mongodb.com
elastic.co
""",
    subjects=["Build Failed", "Build Succeeded", "Deployment", "Security Advisory",
              "Vulnerability Alert", "Dependency Update", "Incident", "Downtime",
              "Usage Report", "Quota Exceeded", "New Release", "Package Published"],
    expire_days=30,
)

NEW["food"] = dict(
    title="Food & Delivery",
    description="Restaurant delivery and food ordering.",
    folder="Food",
    domains="""
doordash.com ubereats.com grubhub.com seamless.com deliveroo.co.uk
just-eat.co.uk takeaway.com foodpanda.com swiggy.com zomato.com gojek.com
wolt.com glovoapp.com deliveryhero.com ifood.com.br rappi.com menulog.com.au
chownow.com slicelife.com toasttab.com dominos.com pizzahut.com papajohns.com
mcdonalds.com starbucks.com chipotle.com subway.com kfc.com burgerking.com
tacobell.com wendys.com dunkindonuts.com panerabread.com
""",
    subjects=["Order Confirmed", "Order Delivered", "Driver on the way",
              "Your food is ready", "Rate your order", "Order Receipt",
              "Restaurant Offer"],
    expire_days=7,
)

# --------------------------------------------------------------------------- #
# Additions to existing categories.
EXTEND = {
    "security": """
1password.com bitwarden.com lastpass.com dashlane.com keepersecurity.com
nordpass.com authy.com yubico.com duo.com
""",
    "invoice": """
hsbc.com barclays.co.uk lloydsbank.com natwest.com santander.com
bnpparibas.com societegenerale.com ing.com rabobank.nl monzo.com
starlingbank.com n26.com bunq.com dbs.com.sg ocbc.com uob.com.sg
icicibank.com hdfcbank.com vietcombank.com.vn techcombank.com.vn
vpbank.com.vn mbbank.com.vn binance.com kraken.com gemini.com crypto.com
blockchain.com kucoin.com okx.com bybit.com bitfinex.com bitstamp.net
metamask.io ledger.com trezor.io
""",
}

ORDER = ["phishing", "security", "proton", "invoice", "government", "bills",
         "legal", "health", "travel", "shipping", "study", "recruiting",
         "gaming", "entertainment", "news", "social", "ai", "devtools",
         "food", "work", "shopping", "spam"]


def words(s):
    return [w for w in s.split() if w]


def load(path):
    with io.open(path, encoding="utf-8") as fh:
        return yaml.safe_load(fh)


def plain(o):
    """PyYAML's safe_dump cannot represent OrderedDict; plain dicts keep order."""
    if isinstance(o, dict):
        return {k: plain(v) for k, v in o.items()}
    if isinstance(o, list):
        return [plain(x) for x in o]
    return o


def dump(path, doc, banner):
    with io.open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(banner.rstrip("\n") + "\n\n")
        yaml.safe_dump(plain(doc), fh, sort_keys=False, allow_unicode=True,
                       width=88, default_flow_style=False)


BANNER = ("# %s -- the source of truth for filter/%s.sieve.\n"
          "# Run `python tools/generate.py` after editing.")


def main():
    existing = {}
    for p in sorted(glob.glob("data/categories/*.yml")):
        d = load(p)
        existing[d["id"]] = (p, d)

    # Everything already claimed, so new categories never collide.
    claimed = {}
    for cid, (_p, d) in existing.items():
        for r in d["domains"]:
            if r["kind"] == "allow":
                claimed[r["match"]] = cid

    report = []

    # ---- 1. phishing: aggregate every kind: block record --------------------
    blocks = []
    for cid, (_p, d) in sorted(existing.items()):
        for r in d["domains"]:
            if r["kind"] == "block":
                rec = dict(r)
                rec["note"] = "%s (from %s)" % (rec.get("note", "typosquat"), cid)
                blocks.append(rec)
    blocks.sort(key=lambda r: r["match"])

    phishing = collections.OrderedDict([
        ("id", "phishing"),
        ("title", "Phishing & Typosquats"),
        ("description",
         "Lookalike domains that impersonate services the other filters handle."),
        ("install_order", 1),
        ("folder", "Phishing"),
        ("shape", "flat"),
        ("whitelist", [":addrbook:personal"]),
        ("spam_discard", False),
        ("domains", blocks),
        ("keyword_groups", []),
        ("rules", [collections.OrderedDict([
            ("folder", "Phishing"),
            ("op", "anyof"),
            ("flags", ["\\Flagged"]),
            ("stop", True),
        ])]),
    ])
    dump("data/categories/phishing.yml", dict(phishing),
         BANNER % ("Phishing & Typosquats", "phishing") +
         "\n#\n# Every entry here is a lookalike domain, not a real sender. They are\n"
         "# aggregated from the `kind: block` records of the other categories, so a\n"
         "# free-plan user (one active filter) can install this one on its own.\n"
         "#\n# Entries came from the project's original reference lists and are NOT\n"
         "# individually verified -- check one before trusting it.")
    report.append("phishing: %d typosquat record(s)" % len(blocks))

    # ---- 2. the authored categories ----------------------------------------
    for cid, spec in NEW.items():
        doms, skipped = [], []
        for w in words(spec["domains"]):
            if w in claimed:
                skipped.append("%s (owned by %s)" % (w, claimed[w]))
                continue
            claimed[w] = cid
            doms.append({"match": w, "kind": "allow", "scope": "subdomains",
                         "source": "authored"})
        doms.sort(key=lambda r: r["match"])

        rule = collections.OrderedDict([
            ("gate", True),
            ("folder", spec["folder"]),
            ("op", "anyof"),
            ("domains", [r["match"] for r in doms]),
            ("subjects", spec["subjects"]),
            ("flags", ["\\Seen"]),
        ])
        if spec.get("expire_days") is not None:
            rule["expire_days"] = spec["expire_days"]
        rule["stop"] = True

        doc = collections.OrderedDict([
            ("id", cid),
            ("title", spec["title"]),
            ("description", spec["description"]),
            ("install_order", ORDER.index(cid) + 1),
            ("folder", spec["folder"]),
            ("shape", "nested"),
            ("whitelist", [":addrbook:personal"]),
            ("spam_discard", False),
            ("domains", doms),
            ("keyword_groups", []),
            ("rules", [rule]),
        ])
        banner = BANNER % (spec["title"], cid)
        if spec.get("note"):
            banner += "\n#\n# " + spec["note"]
        dump("data/categories/%s.yml" % cid, dict(doc), banner)
        report.append("%s: %d domain(s), %d skipped as already owned"
                      % (cid, len(doms), len(skipped)))
        for s in skipped:
            report.append("    skipped %s" % s)

    # ---- 3. extend existing categories --------------------------------------
    for cid, extra in EXTEND.items():
        path, doc = existing[cid]
        added = []
        for w in words(extra):
            if w in claimed:
                continue
            claimed[w] = cid
            doc["domains"].append({"match": w, "kind": "allow",
                                   "scope": "subdomains", "source": "authored"})
            added.append(w)
        doc["domains"].sort(key=lambda r: r["match"])
        # New domains must also reach the gate, or they are unreachable.
        for r in doc["rules"]:
            if r.get("gate") or r is doc["rules"][0]:
                if r.get("domains") is not None:
                    r["domains"] = sorted(set(r["domains"]) | set(added))
                break
        head = io.open(path, encoding="utf-8").read()
        head = head[:head.index("\nid:")]
        dump(path, doc, head)
        report.append("%s: +%d domain(s)" % (cid, len(added)))

    # ---- 4. renumber install_order -----------------------------------------
    for p in sorted(glob.glob("data/categories/*.yml")):
        doc = load(p)
        want = ORDER.index(doc["id"]) + 1
        if doc["install_order"] != want:
            doc["install_order"] = want
            head = io.open(p, encoding="utf-8").read()
            head = head[:head.index("\nid:")]
            dump(p, doc, head)
    report.append("renumbered install_order across %d categories" % len(ORDER))

    print("\n".join(report))


if __name__ == "__main__":
    main()
