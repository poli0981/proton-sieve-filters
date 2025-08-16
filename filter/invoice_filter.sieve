# Sieve filter
# Invoice_filter.sieve
# Only for user use Proton Mail.
# Version: 0.1.0
# This Sieve script filters messages related to payment platforms, services, and invoices, moves them to "Payments" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to payments and invoices
if anyof (
    # Payment platforms and gateways domains
    address :domain :matches "from" "*paypal.com",
    address :domain :matches "from" "*stripe.com",
    address :domain :matches "from" "*squareup.com",
    address :domain :matches "from" "*adyen.com",
    address :domain :matches "from" "*authorize.net",
    address :domain :matches "from" "*worldpay.com",
    address :domain :matches "from" "*verifone.com",
    address :domain :matches "from" "*bluesnap.com",
    address :domain :matches "from" "*shopify.com",
    address :domain :matches "from" "*staxpayments.com",
    address :domain :matches "from" "*braintree.com",
    address :domain :matches "from" "*nuvei.com",
    address :domain :matches "from" "*rapyd.net",
    address :domain :matches "from" "*xsolla.com",
    address :domain :matches "from" "*zettle.com",
    address :domain :matches "from" "*venmo.com",
    address :domain :matches "from" "*hyperwallet.com",
    address :domain :matches "from" "*visa.com",
    address :domain :matches "from" "*mastercard.com",
    address :domain :matches "from" "*americanexpress.com",
    address :domain :matches "from" "*discover.com",
    address :domain :matches "from" "*apple.com",
    address :domain :matches "from" "*google.com",
    address :domain :matches "from" "*alipay.com",
    address :domain :matches "from" "*wechatpay.com",
    address :domain :matches "from" "*amazonpay.com",
    address :domain :matches "from" "*klarna.com",
    address :domain :matches "from" "*affirm.com",
    address :domain :matches "from" "*afterpay.com",
    address :domain :matches "from" "*sezzle.com",
    address :domain :matches "from" "*zip.co",
    address :domain :matches "from" "*payoneer.com",
    address :domain :matches "from" "*wise.com",
    address :domain :matches "from" "*revolut.com",
    address :domain :matches "from" "*skrill.com",
    address :domain :matches "from" "*neteller.com",
    address :domain :matches "from" "*paysafecard.com",
    address :domain :matches "from" "*bitcoin.com",
    address :domain :matches "from" "*coinbase.com",
    address :domain :matches "from" "*bitpay.com",
    address :domain :matches "from" "*paytm.com",
    address :domain :matches "from" "*razorpay.com",
    address :domain :matches "from" "*payu.com",
    address :domain :matches "from" "*finix.com",
    address :domain :matches "from" "*payrix.com",
    address :domain :matches "from" "*dyneti.com",
    address :domain :matches "from" "*almondfintech.com",
    address :domain :matches "from" "*checkout.com",
    address :domain :matches "from" "*mollie.com",
    address :domain :matches "from" "*sumup.com",
    address :domain :matches "from" "*tipalti.com",
    address :domain :matches "from" "*bill.com",
    address :domain :matches "from" "*intuit.com",
    address :domain :matches "from" "*jpmorgan.com",
    
    # E-commerce platforms with payment systems
    address :domain :matches "from" "*amazon.com",
    address :domain :matches "from" "*ebay.com",
    address :domain :matches "from" "*etsy.com",
    address :domain :matches "from" "*walmart.com",
    address :domain :matches "from" "*target.com",
    address :domain :matches "from" "*bestbuy.com",
    
    # Banking institutions
    address :domain :matches "from" "*chase.com",
    address :domain :matches "from" "*bankofamerica.com",
    address :domain :matches "from" "*wellsfargo.com",
    address :domain :matches "from" "*citi.com",
    address :domain :matches "from" "*usbank.com",
    
    # Regional payment providers
    address :domain :matches "from" "*mercadopago.com",
    address :domain :matches "from" "*pagseguro.com",
    address :domain :matches "from" "*dlocal.com",
    address :domain :matches "from" "*ebanx.com",
    address :domain :matches "from" "*flutterwave.com",
    address :domain :matches "from" "*paystack.com",
    
    # Subscription and billing services
    address :domain :matches "from" "*chargebee.com",
    address :domain :matches "from" "*recurly.com",
    address :domain :matches "from" "*zuora.com",
    address :domain :matches "from" "*paddle.com",
    address :domain :matches "from" "*fastspring.com"
) {
    # Move to "Payments" folder first
    fileinto "Payments";
    
    # Mark as read
    addflag "\\Seen";
    
    # Update EULA/ToS/Privacy: delete after 2 days
    if allof (
        header :contains "subject" ["EULA Update", "Terms Change", "Policy Revision", 
                                   "Updated Terms of Service", "License Agreement Change", "New EULA Version", 
                                   "Service Terms Update", "Agreement Modification", "Legal Update Alert", 
                                   "Policy Amendment", "Privacy Policy Update", "ToS Changes", "Data Policy Revision"],
        size :under 500K
    ) {
        expire "day" "2";
    }

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
        expire "day" "28";
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
        size :under 500K,
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

# Filter spam messages with payment-related fraud keywords
elsif anyof (
    header :contains "subject" ["Money Transfer", "Lottery Winner", "Inheritance Fund", 
                               "Bank Transfer", "Compensation Fund", "ATM Card", 
                               "Western Union", "MoneyGram", "Wire Transfer"],
    header :contains "subject" ["Nigerian Prince", "Government Compensation", "UN Fund", 
                               "IMF Payment", "World Bank", "Federal Reserve"],
    header :contains "subject" ["Cryptocurrency Investment", "Bitcoin Mining", "Forex Trading", 
                               "Binary Options", "Investment Opportunity"],
    header :contains "subject" ["100% free", "act now", "apply now", "avoid bankruptcy"],
    header :contains "subject" ["bargain", "best price", "big money", "beneficiary"],
    header :contains "subject" ["cash", "claims", "debt", "earn cash"],
    header :contains "subject" ["earn extra cash", "earn money", "free", "get rich quick"],
    header :contains "subject" ["make money", "make money fast", "money back", "quote"],
    header :contains "subject" ["refinance", "save big money", "winner", "bonus"],
    header :contains "subject" ["big bucks", "cash bonus", "cheap", "credit"],
    header :contains "subject" ["discount", "double your income", "earn $", "extra income"],
    header :contains "subject" ["fast cash", "financial freedom", "for just $", "hidden assets"],
    header :contains "subject" ["income from home", "increase sales", "increase traffic", "insurance"],
    header :contains "subject" ["investment", "lowest price", "luxury", "millionaire"],
    header :contains "subject" ["money making", "no cost", "no fees", "offer"],
    header :contains "subject" ["one time", "pennies a day", "potential earnings", "profit"],
    header :contains "subject" ["pure profit", "risk free", "save $", "serious cash"],
    header :contains "subject" ["unlimited", "buy now", "call now", "click here"],
    header :contains "subject" ["don't miss out", "exclusive deal", "expires", "for a limited time"],
    header :contains "subject" ["hurry", "immediate action", "last chance", "limited time"],
    header :contains "subject" ["limited time offer", "now only", "offer expires", "once in a lifetime"],
    header :contains "subject" ["only", "order now", "special promotion", "time limited"],
    header :contains "subject" ["today only", "urgent", "while supplies last", "24 hours"],
    header :contains "subject" ["don't delay", "get it now", "instant", "new"],
    header :contains "subject" ["required", "action", "request", "blank subject"],
    header :contains "subject" ["file", "message", "update", "100% satisfied"],
    header :contains "subject" ["all new", "as seen on", "best deal", "best offer"],
    header :contains "subject" ["buy direct", "cancel at any time", "check or money order", "congratulations"],
    header :contains "subject" ["deal", "direct email", "direct marketing", "ecommerce"],
    header :contains "subject" ["email marketing", "get started now", "gift certificate", "great offer"],
    header :contains "subject" ["guarantee", "information you requested", "internet marketing", "join millions"],
    header :contains "subject" ["marketing solutions", "mass email", "member", "no gimmick"],
    header :contains "subject" ["no obligation", "no questions asked", "no strings attached", "not spam"],
    header :contains "subject" ["online marketing", "opt in", "performance", "pre-approved"],
    header :contains "subject" ["promotion", "sale", "sales", "search engine"],
    header :contains "subject" ["shopping spree", "sign up free", "special offer", "supplies limited"],
    header :contains "subject" ["take action", "this won't last", "trial", "unsubscribe"],
    header :contains "subject" ["visit our website", "web traffic", "weekend getaway", "what are you waiting for"],
    header :contains "subject" ["while you sleep", "will not believe your eyes", "work from home", "all natural"],
    header :contains "subject" ["anti-aging", "cures", "lose weight", "medicine"],
    header :contains "subject" ["miracle cure", "no prescription needed", "online pharmacy", "pure and natural"],
    header :contains "subject" ["remove wrinkles", "reverses aging", "stop snoring", "viagra"],
    header :contains "subject" ["weight loss", "wonder drug", "youthful", "affordable healthcare"],
    header :contains "subject" ["diet", "enlarge", "hair loss", "human growth hormone"],
    header :contains "subject" ["life insurance", "lose weight fast", "medical", "meds"],
    header :contains "subject" ["pharmaceuticals", "prescription", "sample", "score with babes"],
    header :contains "subject" ["valium", "vicodin", "xanax", "acceptance"],
    header :contains "subject" ["accordingly", "avoid", "be your own boss", "believe me"],
    header :contains "subject" ["being a member", "bulk email", "chance", "confidentiality"],
    header :contains "subject" ["dormant", "freedom", "get out of debt", "here"],
    header :contains "subject" ["hidden", "if only", "important information", "info you requested"],
    header :contains "subject" ["information", "legal", "maintained", "meet singles"],
    header :contains "subject" ["message contains", "multi level marketing", "multi-level marketing", "no catch"],
    header :contains "subject" ["no credit check", "no hidden costs", "no investment", "no middleman"],
    header :contains "subject" ["no purchase necessary", "no refund", "no risk", "not intended"],
    header :contains "subject" ["obligation", "offshore", "one hundred percent guaranteed", "opportunity"],
    header :contains "subject" ["password", "passwords", "problem", "promise"],
    header :contains "subject" ["promises", "removal", "requires initial investment", "reserves the right"],
    header :contains "subject" ["risk-free", "satisfaction", "save big", "score"],
    header :contains "subject" ["search engines", "see for yourself", "sent in compliance", "serious only"],
    header :contains "subject" ["social security number", "stainless steel", "stock alert", "stock disclaimer statement"],
    header :contains "subject" ["stock pick", "stop", "strong buy", "stuff"],
    header :contains "subject" ["subject to", "terms", "they keep your", "this isn't junk"],
    header :contains "subject" ["this isn't spam", "undisclosed", "university diplomas", "us dollars"],
    header :contains "subject" ["warranty", "we hate spam", "why pay more", "will not"],
    header :contains "subject" ["winner", "winning", "winnings", "you are a winner"],
    header :contains "subject" ["you have been selected", "your chance", "zero chance", "adult"],
    header :contains "subject" ["casino", "cialis", "copy dvds", "form"],
    header :contains "subject" ["free hosting", "free website", "friend", "friendship"],
    header :contains "subject" ["get paid", "inc", "increase your chances", "internet"],
    header :contains "subject" ["investment decision", "junk", "levitra", "lotto"],
    header :contains "subject" ["mail in order form", "mlm", "nigerian", "no age restrictions"],
    header :contains "subject" ["no claim forms", "no disappointment", "no inventory", "no medical exams"],
    header :contains "subject" ["no selling", "not junk", "now", "number one"],
    header :contains "subject" ["oasis", "online biz opportunity", "online degree", "online income"],
    header :contains "subject" ["open", "opt-in", "order", "order shipped by"],
    header :contains "subject" ["order status", "orders shipped by", "per day", "per week"],
    header :contains "subject" ["print form signature", "print out and fax", "priority mail", "produced and sent out"],
    header :contains "subject" ["profits", "promise you", "removal instructions", "remove"],
    header :contains "subject" ["removes", "reply remove subject", "reverse", "rolex"],
    header :contains "subject" ["round the world", "s 1618", "safemail", "save up to"],
    header :contains "subject" ["search engine listings", "section 301", "shopping spree", "sign up free today"],
    header :contains "subject" ["subject to credit", "supplies", "take action now", "talks about prizes"],
    header :contains "subject" ["talks about search engine listings", "tells you it's an ad", "terms and conditions", "the best rates"],
    header :contains "subject" ["the following form", "they keep your money", "they're just giving it away", "this won't last"],
    header :contains "subject" ["thousands", "traffic", "vacation", "vacation offers"],
    header :contains "subject" ["we honor all", "weekend getaway", "what are you waiting for?"],
    header :contains "subject" ["while supplies last", "who really wins?", "why pay more?"],
    header :contains "subject" ["will not believe your eyes", "win", "work at home"],
    header :contains "subject" ["www", "you are a winner!", "your income"]
) {
    fileinto "Spam";
    stop;
}

# End of Invoice Filter