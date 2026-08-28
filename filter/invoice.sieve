# Invoices & Payments filter -- filter/invoice.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/invoice.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Receipts, invoices, payment processors and billing.
#
# Folders: Payments, Spam
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 3 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Known typosquats of the services this filter handles. These are lookalike
# domains, not the real senders -- flag them instead of filing them away.
if address :domain :matches "from" ["payp4l.com", "*.payp4l.com", "paypa1.com",
    "*.paypa1.com", "paypal-verification.com", "*.paypal-verification.com",
    "stripe-inc.com", "*.stripe-inc.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if address :domain :matches "from" ["adyen.com", "*.adyen.com", "affirm.com",
    "*.affirm.com", "afterpay.com", "*.afterpay.com", "alipay.com", "*.alipay.com",
    "almondfintech.com", "*.almondfintech.com", "amazonpay.com", "*.amazonpay.com",
    "americanexpress.com", "*.americanexpress.com", "apple.com", "*.apple.com",
    "authorize.net", "*.authorize.net", "bankofamerica.com", "*.bankofamerica.com",
    "bestbuy.com", "*.bestbuy.com", "bill.com", "*.bill.com", "bitcoin.com",
    "*.bitcoin.com", "bitpay.com", "*.bitpay.com", "bluesnap.com", "*.bluesnap.com",
    "braintree.com", "*.braintree.com", "chargebee.com", "*.chargebee.com",
    "chase.com", "*.chase.com", "checkout.com", "*.checkout.com", "citi.com",
    "*.citi.com", "coinbase.com", "*.coinbase.com", "discover.com",
    "*.discover.com", "dlocal.com", "*.dlocal.com", "dyneti.com", "*.dyneti.com",
    "ebanx.com", "*.ebanx.com", "ebay.com", "*.ebay.com", "etsy.com", "*.etsy.com",
    "fastspring.com", "*.fastspring.com", "finix.com", "*.finix.com",
    "flutterwave.com", "*.flutterwave.com", "hyperwallet.com", "*.hyperwallet.com",
    "intuit.com", "*.intuit.com", "jpmorgan.com", "*.jpmorgan.com", "klarna.com",
    "*.klarna.com", "mastercard.com", "*.mastercard.com", "mercadopago.com",
    "*.mercadopago.com", "mollie.com", "*.mollie.com", "neteller.com",
    "*.neteller.com", "nuvei.com", "*.nuvei.com", "paddle.com", "*.paddle.com",
    "pagseguro.com", "*.pagseguro.com", "payoneer.com", "*.payoneer.com",
    "paypal.com", "*.paypal.com", "payrix.com", "*.payrix.com", "paysafecard.com",
    "*.paysafecard.com", "paystack.com", "*.paystack.com", "paytm.com",
    "*.paytm.com", "payu.com", "*.payu.com", "rapyd.net", "*.rapyd.net",
    "razorpay.com", "*.razorpay.com", "recurly.com", "*.recurly.com", "revolut.com",
    "*.revolut.com", "sezzle.com", "*.sezzle.com", "shopify.com", "*.shopify.com",
    "skrill.com", "*.skrill.com", "squareup.com", "*.squareup.com",
    "staxpayments.com", "*.staxpayments.com", "stripe.com", "*.stripe.com",
    "sumup.com", "*.sumup.com", "target.com", "*.target.com", "tipalti.com",
    "*.tipalti.com", "usbank.com", "*.usbank.com", "venmo.com", "*.venmo.com",
    "verifone.com", "*.verifone.com", "visa.com", "*.visa.com", "walmart.com",
    "*.walmart.com", "wechatpay.com", "*.wechatpay.com", "wellsfargo.com",
    "*.wellsfargo.com", "wise.com", "*.wise.com", "worldpay.com", "*.worldpay.com",
    "xsolla.com", "*.xsolla.com", "zettle.com", "*.zettle.com", "zip.co",
    "*.zip.co", "zuora.com", "*.zuora.com"] {
    addflag "\\Seen";
    fileinto "Payments";

    if allof (
        header :contains "subject" ["Purchase Confirmation", "Your Receipt",
            "Order Invoice", "Digital Purchase Details", "Transaction Summary",
            "Payment Confirmation", "Receipt for Purchase", "Invoice Attached",
            "Invoice no.", "Your Invoice", "Billing Statement", "Payment Received",
            "Thank You for Your Payment"],
        size :under 500K,
        not header :contains "subject" ["Subscription Confirmation", "Monthly Billing",
            "Renewal Notice", "Subscription Renewed", "Auto-Renewal",
            "Subscription Invoice", "Recurring Payment", "Membership Renewal",
            "Annual Subscription", "Activation Key", "Product Key Inside",
            "License Key", "Download Key", "Serial Key Included", "Activation Code",
            "License Activation", "Key for Your Purchase", "Your License Key",
            "Product Activation", "Key for Software", "Your Activation Code",
            "Software License Key", "Your Product Key", "Key for Digital Product",
            "Your Activation Key", "License Code", "Activation Information",
            "Your Software Key", "License Information", "Key for Your Software"]
    ) {
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Transaction Confirmation", "Payment Processed",
            "Order Shipped", "Transaction Details", "Payment Success",
            "Funds Transferred", "Payout Sent", "Deposit Received"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Refund Processed", "Chargeback Notification",
            "Refund Confirmation", "Reversal Alert", "Money Back", "Refund Issued",
            "Dispute Resolved"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Fraud Alert", "Suspicious Activity",
            "Security Warning", "Unauthorized Transaction", "Account Compromised",
            "Fraud Detection", "Potential Scam"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Payment Deal", "Cashback Offer", "Promo Code",
            "Discount on Fees", "Special Payment Offer", "Limited Time Deal",
            "Rewards Alert"],
        size :under 500K
    ) {
        expire "day" "3";

        stop;
    }

    stop;
}

# End of Invoices & Payments filter
