# Sieve filter
# Invoice_filter.sieve
# Only for user use Proton Mail.
# Version: 0.1.0 -> 0.2.0
# This Sieve script filters messages related to payment platforms, services, and invoices, moves them to "Payments" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to payments and invoices
if anyof (
    # Payment platforms and gateways domains
    address :domain :matches "from" ["*paypal.com", "*stripe.com", "*squareup.com",
    "*adyen.com", "*authorize.net", "*worldpay.com", "*verifone.com", "*bluesnap.com",
    "*shopify.com", "*staxpayments.com", "*braintree.com", "*nuvei.com", "*rapyd.net",
    "*xsolla.com", "*zettle.com", "*venmo.com", "*hyperwallet.com", "*visa.com",
    "*mastercard.com", "*americanexpress.com", "*discover.com", "*apple.com", "*google.com",
    "*alipay.com", "*wechatpay.com", "*amazonpay.com", "*klarna.com", "*affirm.com",
    "*afterpay.com", "*sezzle.com", "*zip.co", "*payoneer.com", "*wise.com", "*revolut.com",
    "*skrill.com", "*neteller.com", "*paysafecard.com", "*bitcoin.com", "*coinbase.com",
    "*bitpay.com", "*paytm.com", "*razorpay.com", "*payu.com", "*finix.com", "*payrix.com",
    "*dyneti.com", "*almondfintech.com", "*checkout.com", "*mollie.com", "*sumup.com",
    "*tipalti.com", "*bill.com", "*intuit.com", "*jpmorgan.com"],
    
    # E-commerce platforms with payment systems
    address :domain :matches "from" ["*amazon.com", "*ebay.com", "*etsy.com",
    "*walmart.com", "*target.com", "*bestbuy.com"],
    
    # Banking institutions
    address :domain :matches "from" ["*chase.com", "*bankofamerica.com", "*wellsfargo.com",
    "*citi.com", "*usbank.com"],
    
    # Regional payment providers
    address :domain :matches "from" ["*mercadopago.com", "*pagseguro.com", "*dlocal.com",
    "*ebanx.com", "*flutterwave.com", "*paystack.com"],
    
    # Subscription and billing services
    address :domain :matches "from" ["*chargebee.com", "*recurly.com", "*zuora.com",
    "*paddle.com", "*fastspring.com"]
) {

    # Move to "Payments" folder first
    fileinto "Payments";
    
    # Mark as read
    addflag "\\Seen";

    # Receipts/Invoices: delete after 28 days (but preserve subscriptions and keys)
    if allof (
        header :contains "subject" ["Purchase Confirmation", "Your Receipt", "Order Invoice",
        "Digital Purchase Details", "Transaction Summary", "Payment Confirmation", 
        "Receipt for Purchase", "Invoice Attached", "Invoice no.", "Your Invoice", 
        "Billing Statement", "Payment Received", "Thank You for Your Payment"],
        size :under 500K,
        not anyof (
            # Check subscription (keep forever)
            header :contains "subject" ["Subscription Confirmation", "Monthly Billing", "Renewal Notice", 
            "Subscription Renewed", "Auto-Renewal", "Subscription Invoice", 
            "Recurring Payment", "Membership Renewal", "Annual Subscription"],
            # Check key activation (keep forever)
            header :contains "subject" ["Activation Key", "Product Key Inside", "License Key", 
            "Download Key", "Serial Key Included", "Activation Code",
            "License Activation", "Key for Your Purchase", "Your License Key",
            "Product Activation", "Key for Software", "Your Activation Code",
            "Software License Key", "Your Product Key", "Key for Digital Product",
            "Your Activation Key", "License Code", "Activation Information",
            "Your Software Key", "License Information", "Key for Your Software"]
        )
    ) {
        expire "day" "365";
    }

    # Transaction confirmations (expire 7 days)
    if allof (
        header :contains "subject" ["Transaction Confirmation", "Payment Processed", "Order Shipped", 
        "Transaction Details", "Payment Success", "Funds Transferred", 
        "Payout Sent", "Deposit Received"],
        size :under 500K
    ) {
        expire "day" "7";
    }

    # Refund/chargeback notifications (expire 28 days for tracking)
    if allof (
        header :contains "subject" ["Refund Processed", "Chargeback Notification", "Refund Confirmation", 
        "Reversal Alert", "Money Back", "Refund Issued", "Dispute Resolved"],
        size :under 500K
    ) {
        expire "day" "28";
    }

    # Fraud/security warnings (expire 28 days)
    if allof (
        header :contains "subject" ["Fraud Alert", "Suspicious Activity", "Security Warning", 
        "Unauthorized Transaction", "Account Compromised", "Fraud Detection", 
        "Potential Scam"],
        size :under 500K
    ) {
        expire "day" "28";
    }

    # Promotions/deals from payment platforms (expire 3 days)
    if allof (
        header :contains "subject" ["Payment Deal", "Cashback Offer", "Promo Code", 
        "Discount on Fees", "Special Payment Offer", "Limited Time Deal", 
        "Rewards Alert"],
        size :under 500K
    ) {
        expire "day" "3";
    }

    stop;
}

# End of Invoice Filter