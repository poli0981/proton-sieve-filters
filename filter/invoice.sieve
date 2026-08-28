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
# Install position 19 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

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

if anyof (
    address :domain :matches "from" ["adyen.com", "*.adyen.com", "affirm.com",
        "*.affirm.com", "afterpay.com", "*.afterpay.com", "alipay.com", "*.alipay.com",
        "almondfintech.com", "*.almondfintech.com", "amazonpay.com", "*.amazonpay.com",
        "americanexpress.com", "*.americanexpress.com", "apple.com", "*.apple.com",
        "authorize.net", "*.authorize.net", "bankofamerica.com", "*.bankofamerica.com",
        "barclays.co.uk", "*.barclays.co.uk", "bestbuy.com", "*.bestbuy.com",
        "bill.com", "*.bill.com", "bitcoin.com", "*.bitcoin.com", "bitfinex.com",
        "*.bitfinex.com", "bitpay.com", "*.bitpay.com", "bitstamp.net",
        "*.bitstamp.net", "bluesnap.com", "*.bluesnap.com", "bnpparibas.com",
        "*.bnpparibas.com", "braintree.com", "*.braintree.com", "bunq.com",
        "*.bunq.com", "bybit.com", "*.bybit.com", "chargebee.com", "*.chargebee.com",
        "chase.com", "*.chase.com", "checkout.com", "*.checkout.com", "citi.com",
        "*.citi.com", "coinbase.com", "*.coinbase.com", "dbs.com.sg", "*.dbs.com.sg",
        "discover.com", "*.discover.com", "dlocal.com", "*.dlocal.com", "dyneti.com",
        "*.dyneti.com", "ebanx.com", "*.ebanx.com", "ebay.com", "*.ebay.com",
        "etsy.com", "*.etsy.com", "fastspring.com", "*.fastspring.com", "finix.com",
        "*.finix.com", "flutterwave.com", "*.flutterwave.com", "hdfcbank.com",
        "*.hdfcbank.com", "hsbc.com", "*.hsbc.com", "hyperwallet.com",
        "*.hyperwallet.com", "icicibank.com", "*.icicibank.com", "ing.com", "*.ing.com",
        "intuit.com", "*.intuit.com", "jpmorgan.com", "*.jpmorgan.com", "klarna.com",
        "*.klarna.com", "kucoin.com", "*.kucoin.com", "ledger.com", "*.ledger.com",
        "lloydsbank.com", "*.lloydsbank.com", "mastercard.com", "*.mastercard.com",
        "mbbank.com.vn", "*.mbbank.com.vn", "mercadopago.com", "*.mercadopago.com",
        "metamask.io", "*.metamask.io", "mollie.com", "*.mollie.com", "monzo.com",
        "*.monzo.com", "n26.com", "*.n26.com", "natwest.com", "*.natwest.com",
        "neteller.com", "*.neteller.com", "nuvei.com", "*.nuvei.com", "ocbc.com",
        "*.ocbc.com", "okx.com", "*.okx.com", "paddle.com", "*.paddle.com",
        "pagseguro.com", "*.pagseguro.com", "payoneer.com", "*.payoneer.com",
        "paypal.com", "*.paypal.com", "payrix.com", "*.payrix.com", "paysafecard.com",
        "*.paysafecard.com", "paystack.com", "*.paystack.com", "paytm.com",
        "*.paytm.com", "payu.com", "*.payu.com", "rabobank.nl", "*.rabobank.nl",
        "rapyd.net", "*.rapyd.net", "razorpay.com", "*.razorpay.com", "recurly.com",
        "*.recurly.com", "revolut.com", "*.revolut.com", "santander.com",
        "*.santander.com", "sezzle.com", "*.sezzle.com", "shopify.com", "*.shopify.com",
        "skrill.com", "*.skrill.com", "societegenerale.com", "*.societegenerale.com",
        "squareup.com", "*.squareup.com", "starlingbank.com", "*.starlingbank.com",
        "staxpayments.com", "*.staxpayments.com", "stripe.com", "*.stripe.com",
        "sumup.com", "*.sumup.com", "target.com", "*.target.com", "techcombank.com.vn",
        "*.techcombank.com.vn", "tipalti.com", "*.tipalti.com", "trezor.io",
        "*.trezor.io", "uob.com.sg", "*.uob.com.sg", "usbank.com", "*.usbank.com",
        "venmo.com", "*.venmo.com", "verifone.com", "*.verifone.com",
        "vietcombank.com.vn", "*.vietcombank.com.vn", "visa.com", "*.visa.com",
        "vpbank.com.vn", "*.vpbank.com.vn", "walmart.com", "*.walmart.com",
        "wechatpay.com", "*.wechatpay.com", "wellsfargo.com", "*.wellsfargo.com",
        "wise.com", "*.wise.com", "worldpay.com", "*.worldpay.com", "xsolla.com",
        "*.xsolla.com", "zettle.com", "*.zettle.com", "zip.co", "*.zip.co", "zuora.com",
        "*.zuora.com"],
    header :contains "subject" ["Xác nhận mua hàng", "Hóa đơn thanh toán",
        "Biên lai giao dịch", "Thanh toán thành công", "Xác nhận đơn hàng",
        "Hóa đơn điện tử", "Chi tiết giao dịch", "Thông báo thanh toán", "Phí dịch vụ",
        "Hoàn tiền", "Mã kích hoạt", "Khóa sản phẩm", "Giấy phép phần mềm",
        "Đăng ký định kỳ", "Gia hạn dịch vụ", "Cảnh báo gian lận",
        "Hoạt động đáng nghi", "Ưu đãi thanh toán", "Mã giảm giá", "Hoàn tiền cashback",
        "购买确认", "付款收据", "订单发票", "交易摘要", "付款确认", "账单明细", "付款成功", "资金转账", "退款处理", "争议解决",
        "激活密钥", "产品密钥", "许可证密钥", "订阅确认", "续费通知", "自动续费", "欺诈警报", "可疑活动", "安全警告", "促销优惠",
        "现金回馈", "优惠码", "購入確認", "支払い領収書", "注文請求書", "取引概要", "支払い確認", "請求明細", "支払い成功",
        "資金移動", "返金処理", "紛争解決", "アクティベーションキー", "プロダクトキー", "ライセンスキー", "サブスクリプション確認",
        "更新通知", "自動更新", "詐欺警告", "不審な活動", "セキュリティ警告", "支払い特典", "キャッシュバック", "プロモコード"]
) {
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
