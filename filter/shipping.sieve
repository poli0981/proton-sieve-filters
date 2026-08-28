# Shipping & Deliveries filter -- filter/shipping.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/shipping.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Carrier tracking and delivery notifications.
#
# Folders: Shipping
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 13 of 22. Filters run in the order you install them,
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
    address :domain :matches "from" ["17track.net", "*.17track.net", "aftership.com",
        "*.aftership.com", "aramex.com", "*.aramex.com", "auspost.com.au",
        "*.auspost.com.au", "bluedart.com", "*.bluedart.com",
        "canadapost-postescanada.ca", "*.canadapost-postescanada.ca", "correos.es",
        "*.correos.es", "delhivery.com", "*.delhivery.com", "deutschepost.de",
        "*.deutschepost.de", "dhl.com", "*.dhl.com", "dpd.com", "*.dpd.com",
        "easyship.com", "*.easyship.com", "evri.com", "*.evri.com", "fedex.com",
        "*.fedex.com", "ghn.vn", "*.ghn.vn", "giaohangtietkiem.vn",
        "*.giaohangtietkiem.vn", "gls-group.eu", "*.gls-group.eu", "goshippo.com",
        "*.goshippo.com", "japanpost.jp", "*.japanpost.jp", "jtexpress.com",
        "*.jtexpress.com", "laposte.fr", "*.laposte.fr", "lasership.com",
        "*.lasership.com", "ninjavan.co", "*.ninjavan.co", "nzpost.co.nz",
        "*.nzpost.co.nz", "ontrac.com", "*.ontrac.com", "parcelforce.com",
        "*.parcelforce.com", "poste.it", "*.poste.it", "postnl.nl", "*.postnl.nl",
        "purolator.com", "*.purolator.com", "royalmail.com", "*.royalmail.com",
        "sendcloud.com", "*.sendcloud.com", "sf-express.com", "*.sf-express.com",
        "tnt.com", "*.tnt.com", "ups.com", "*.ups.com", "usps.com", "*.usps.com",
        "viettelpost.vn", "*.viettelpost.vn", "vnpost.vn", "*.vnpost.vn"],
    header :contains "subject" ["Shipped", "Out for Delivery", "Delivery Update",
        "Tracking Number", "Package Delivered", "Shipment Notification", "In Transit",
        "Delivery Attempt", "Ready for Pickup", "Package Delayed", "Your parcel",
        "Proof of Delivery"]
) {
    addflag "\\Seen";
    fileinto "Shipping";
    expire "day" "60";

    stop;
}

# End of Shipping & Deliveries filter
