# Food & Delivery filter -- filter/food.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/food.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Restaurant delivery and food ordering.
#
# Folders: Food
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 4 of 22. Filters run in the order you install them,
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
    address :domain :matches "from" ["burgerking.com", "*.burgerking.com",
        "chipotle.com", "*.chipotle.com", "chownow.com", "*.chownow.com",
        "deliveroo.co.uk", "*.deliveroo.co.uk", "deliveryhero.com",
        "*.deliveryhero.com", "dominos.com", "*.dominos.com", "doordash.com",
        "*.doordash.com", "dunkindonuts.com", "*.dunkindonuts.com", "foodpanda.com",
        "*.foodpanda.com", "glovoapp.com", "*.glovoapp.com", "gojek.com", "*.gojek.com",
        "grubhub.com", "*.grubhub.com", "ifood.com.br", "*.ifood.com.br",
        "just-eat.co.uk", "*.just-eat.co.uk", "kfc.com", "*.kfc.com", "mcdonalds.com",
        "*.mcdonalds.com", "menulog.com.au", "*.menulog.com.au", "panerabread.com",
        "*.panerabread.com", "papajohns.com", "*.papajohns.com", "pizzahut.com",
        "*.pizzahut.com", "rappi.com", "*.rappi.com", "seamless.com", "*.seamless.com",
        "slicelife.com", "*.slicelife.com", "starbucks.com", "*.starbucks.com",
        "subway.com", "*.subway.com", "swiggy.com", "*.swiggy.com", "tacobell.com",
        "*.tacobell.com", "takeaway.com", "*.takeaway.com", "toasttab.com",
        "*.toasttab.com", "ubereats.com", "*.ubereats.com", "wendys.com",
        "*.wendys.com", "wolt.com", "*.wolt.com"],
    header :contains "subject" ["Order Confirmed", "Order Delivered",
        "Driver on the way", "Your food is ready", "Rate your order", "Order Receipt",
        "Restaurant Offer"]
) {
    addflag "\\Seen";
    fileinto "Food";
    expire "day" "7";

    stop;
}

# End of Food & Delivery filter
