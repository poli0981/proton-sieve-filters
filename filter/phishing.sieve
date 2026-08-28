# Phishing & Typosquats filter -- filter/phishing.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/phishing.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Lookalike domains that impersonate services the other filters handle.
#
# Folders: Phishing
#
# Install position 22 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Known typosquats of the services this filter handles. These are lookalike
# domains, not the real senders -- flag them instead of filing them away.
if address :domain :matches "from" ["airbnbb.com", "*.airbnbb.com", "amazcn.com",
    "*.amazcn.com", "bookng.com", "*.bookng.com", "delta-airlines.com",
    "*.delta-airlines.com", "ebay-inc.com", "*.ebay-inc.com", "expedia-deals.com",
    "*.expedia-deals.com", "faceb00k.com", "*.faceb00k.com", "lnkedin.com",
    "*.lnkedin.com", "marriot.com", "*.marriot.com", "payp4l.com", "*.payp4l.com",
    "paypa1.com", "*.paypa1.com", "paypai.com", "*.paypai.com",
    "paypal-verification.com", "*.paypal-verification.com", "pr0ton.me", "*.pr0ton.me",
    "proton-mail.com", "*.proton-mail.com", "proton.com", "*.proton.com",
    "protonmai1.com", "*.protonmai1.com", "stripe-inc.com", "*.stripe-inc.com",
    "target-store.com", "*.target-store.com", "twiter.com", "*.twiter.com",
    "wallmart.com", "*.wallmart.com", "youutube.com", "*.youutube.com"] {
    addflag "\\Flagged";
    fileinto "Phishing";

    stop;
}

# End of Phishing & Typosquats filter
