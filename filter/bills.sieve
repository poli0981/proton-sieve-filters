# Bills & Utilities filter -- filter/bills.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/bills.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Telecoms, energy, water and insurance billing.
#
# Folders: Bills
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 17 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["aetna.com", "*.aetna.com", "allstate.com",
        "*.allstate.com", "att.com", "*.att.com", "aviva.co.uk", "*.aviva.co.uk",
        "bell.ca", "*.bell.ca", "britishgas.co.uk", "*.britishgas.co.uk",
        "centurylink.com", "*.centurylink.com", "cigna.com", "*.cigna.com",
        "comcast.com", "*.comcast.com", "coned.com", "*.coned.com", "cox.com",
        "*.cox.com", "directline.com", "*.directline.com", "docomo.ne.jp",
        "*.docomo.ne.jp", "duke-energy.com", "*.duke-energy.com", "ee.co.uk",
        "*.ee.co.uk", "engie.com", "*.engie.com", "eon.com", "*.eon.com", "evn.com.vn",
        "*.evn.com.vn", "farmers.com", "*.farmers.com", "geico.com", "*.geico.com",
        "humana.com", "*.humana.com", "kddi.com", "*.kddi.com", "lemonade.com",
        "*.lemonade.com", "libertymutual.com", "*.libertymutual.com", "mobifone.vn",
        "*.mobifone.vn", "movistar.es", "*.movistar.es", "nationalgrid.com",
        "*.nationalgrid.com", "nationwide.com", "*.nationwide.com", "o2.co.uk",
        "*.o2.co.uk", "octopus.energy", "*.octopus.energy", "optus.com.au",
        "*.optus.com.au", "orange.com", "*.orange.com", "ovoenergy.com",
        "*.ovoenergy.com", "pge.com", "*.pge.com", "progressive.com",
        "*.progressive.com", "rogers.com", "*.rogers.com", "softbank.jp",
        "*.softbank.jp", "spectrum.com", "*.spectrum.com", "statefarm.com",
        "*.statefarm.com", "t-mobile.com", "*.t-mobile.com", "telekom.de",
        "*.telekom.de", "telstra.com.au", "*.telstra.com.au", "telus.com",
        "*.telus.com", "three.co.uk", "*.three.co.uk", "usaa.com", "*.usaa.com",
        "verizon.com", "*.verizon.com", "viettel.vn", "*.viettel.vn", "vnpt.com.vn",
        "*.vnpt.com.vn", "vodafone.com", "*.vodafone.com", "xfinity.com",
        "*.xfinity.com"],
    header :contains "subject" ["Your Bill", "Bill Ready", "Statement Available",
        "Payment Due", "Autopay Confirmation", "Meter Reading", "Policy Renewal",
        "Premium Due", "Insurance Claim", "Service Charge", "Usage Summary"]
) {
    addflag "\\Seen";
    fileinto "Bills";
    expire "day" "365";

    stop;
}

# End of Bills & Utilities filter
