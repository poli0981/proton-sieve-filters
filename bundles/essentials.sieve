# Essentials bundle -- bundles/essentials.sieve
#
# GENERATED FILE -- do not edit. Edit data/bundles.yml and run:
#     python tools/generate.py
#
# Phishing protection plus the categories where losing a message actually costs
# something. The recommended single filter for a free Proton plan.
#
# This is ONE filter containing 5 categories: phishing, security, invoice, government, shipping.
# Proton's free plan allows one active filter, so a bundle is the only way
# to use more than one category on it.
#
# Folders: Government, Payments, Phishing, Security, Security/Authentication,
#          Security/Billing, Security/Changes, Security/Compliance, Security/Critical,
#          Security/Education, Security/General, Security/Login, Security/Permissions,
#          Shipping, Spam
#
# WARNING: this bundle sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Drop what Proton already knows is spam.
if header :list "from" ":incomingdefaults:spam" {
    discard;
    stop;
}

# ====================================================================================
# Phishing & Typosquats  (install position 22 of 22)
# ====================================================================================

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

# ====================================================================================
# Security & Account  (install position 21 of 22)
# ====================================================================================

if header :contains "subject" ["Account Compromised", "Unauthorized Access Detected",
    "Security Breach Alert", "Account Hacked", "Suspicious Login Activity",
    "Unknown Device Login", "Login from New Location", "Unusual Account Activity",
    "Account Access from Unrecognized Device", "Multiple Failed Login Attempts",
    "Password Changed by Someone Else", "Account Takeover Detected",
    "Data Breach Alert", "Security Incident Report",
    "Your Data May Have Been Compromised", "Security Vulnerability Found",
    "Emergency Security Update", "Critical Security Patch",
    "Immediate Action Required", "Urgent Security Notice",
    "Personal Information Exposed", "Data Leak Alert", "Account Locked",
    "Account Suspended", "Account Frozen", "Account Temporarily Disabled",
    "Account Access Restricted", "Account Banned", "Service Suspended",
    "Account Under Review", "Access Revoked", "Account Deactivated",
    "Fraudulent Activity Detected", "Unauthorized Transaction",
    "Payment Method Compromised", "Card Used Unauthorized",
    "Suspicious Payment Alert", "Identity Theft Warning", "Fraud Alert",
    "Unauthorized Purchase", "Billing Alert", "Credit Card Security Alert",
    "Payment Fraud Detection", "Tài khoản bị xâm phạm",
    "Phát hiện truy cập trái phép", "Cảnh báo vi phạm bảo mật", "Tài khoản bị hack",
    "Hoạt động đăng nhập đáng ngờ", "Đăng nhập từ thiết bị lạ",
    "Đăng nhập từ vị trí mới", "Hoạt động tài khoản bất thường",
    "Nhiều lần đăng nhập thất bại", "Mật khẩu bị thay đổi",
    "Cảnh báo rò rỉ dữ liệu", "Báo cáo sự cố bảo mật", "Thông tin cá nhân bị lộ",
    "Cập nhật bảo mật khẩn cấp", "Yêu cầu hành động ngay lập tức",
    "Mật khẩu đã thay đổi thành công", "Yêu cầu đặt lại mật khẩu",
    "Xác nhận thay đổi mật khẩu", "Xác thực hai yếu tố", "Mã xác thực",
    "Mã bảo mật", "Mã đăng nhập", "Tài khoản bị khóa", "Tài khoản bị đình chỉ",
    "Tài khoản bị đóng băng", "Phát hiện hoạt động gian lận", "Giao dịch trái phép",
    "Phương thức thanh toán bị xâm phạm", "Cảnh báo gian lận", "Cập nhật hồ sơ",
    "Thay đổi thông tin cá nhân", "Địa chỉ email đã thay đổi", "Cấp quyền ứng dụng",
    "Truy cập của bên thứ ba", "Ủy quyền OAuth", "Tuân thủ GDPR",
    "Cập nhật chính sách bảo mật", "Thông báo pháp lý", "Mẹo bảo mật",
    "Cảnh báo lừa đảo", "Cảnh báo phần mềm độc hại", "账户被入侵", "检测到未授权访问", "安全漏洞警报",
    "账户被黑", "可疑登录活动", "来自未知设备的登录", "来自新位置的登录", "异常账户活动", "多次登录失败", "密码被他人更改",
    "数据泄露警报", "安全事件报告", "个人信息泄露", "紧急安全更新", "需要立即行动", "密码更改成功", "密码重置请求", "密码更改确认",
    "双重验证", "验证码", "安全码", "登录码", "账户被锁定", "账户被暂停", "账户被冻结", "检测到欺诈活动", "未授权交易",
    "支付方式被入侵", "欺诈警报", "个人资料更新", "个人信息更改", "电子邮件地址已更改", "应用程序权限授予", "第三方访问",
    "OAuth授权", "GDPR合规", "隐私政策更新", "法律通知", "安全提示", "网络钓鱼警报", "恶意软件警报",
    "アカウントが侵害されました", "不正アクセスを検出", "セキュリティ侵害アラート", "アカウントがハッキング", "疑わしいログイン活動",
    "不明なデバイスからのログイン", "新しい場所からのログイン", "異常なアカウント活動", "複数回のログイン失敗", "パスワードが他人により変更",
    "データ漏洩アラート", "セキュリティインシデントレポート", "個人情報の漏洩", "緊急セキュリティアップデート", "即座のアクション必要",
    "パスワード変更成功", "パスワードリセット要求", "パスワード変更確認", "二要素認証", "認証コード", "セキュリティコード",
    "ログインコード", "アカウントロック", "アカウント一時停止", "アカウント凍結", "不正行為を検出", "不正取引", "支払い方法が侵害",
    "詐欺アラート", "プロフィール更新", "個人情報変更", "メールアドレス変更", "アプリ権限付与", "サードパーティアクセス",
    "OAuth認証", "GDPR準拠", "プライバシーポリシー更新", "法的通知", "セキュリティヒント", "フィッシング警告", "マルウェア警告"] {
    removeflag "\\Seen";
    addflag "\\Flagged";
    fileinto "Security/Critical";
    expire "day" "90";

    stop;
}

if header :contains "subject" ["Password Changed Successfully",
    "Password Reset Request", "Password Change Confirmation", "Password Updated",
    "New Password Created", "Password Modification Alert", "Password Recovery",
    "Reset Password Link", "Password Reset Verification", "Temporary Password",
    "Password Expired", "Password Will Expire Soon", "Change Your Password",
    "Weak Password Alert", "Two-Factor Authentication", "2FA Setup", "2FA Enabled",
    "2FA Disabled", "Authentication Code", "Verification Code", "Security Code",
    "Login Code", "Access Code", "One-Time Password", "OTP Code",
    "Multi-Factor Authentication", "MFA Setup", "Authenticator App", "Backup Codes",
    "Recovery Codes", "Your one-time code", "Security Key Added",
    "Security Key Removed", "Biometric Authentication", "Fingerprint Added",
    "Face ID Setup", "New Account Confirmation", "Authentication Method Changed",
    "Login Method Updated", "Backup Authentication", "Disable two-step login",
    "Account Recovery", "Recovery Email Updated", "Recovery Phone Updated",
    "Security Questions", "Account Restoration", "Identity Verification Required",
    "Account Verification", "Verify Your Identity", "verify your email address"] {
    addflag "\\Seen";
    addflag "\\Flagged";
    fileinto "Security/Authentication";
    expire "day" "60";

    stop;
}

if header :contains "subject" ["New Device Login", "Login from New Location",
    "Unrecognized Device", "New Browser Login", "First Time Login", "Login Alert",
    "Access Notification", "Sign-in Alert", "Login Detected",
    "Device Authorization", "New IP Address Login", "Location Change Alert",
    "Session Expired", "Session Terminated", "Active Sessions", "Session Security",
    "Remote Logout", "All Sessions Ended", "Session Alert", "Login Session",
    "Device Sessions", "Session Management", "Multiple Login Attempts",
    "Repeated Login Failures", "Access Pattern Alert", "Login Frequency Alert",
    "Unusual Access Times", "Off-Hours Access", "Weekend Login Alert",
    "Holiday Access Alert"] {
    addflag "\\Seen";
    fileinto "Security/Login";
    expire "day" "30";

    stop;
}

if header :contains "subject" ["Profile Updated", "Personal Information Changed",
    "Email Address Changed", "Phone Number Updated", "Name Changed",
    "Address Updated", "Profile Picture Changed", "Account Details Modified",
    "Contact Information Updated", "Personal Data Changed",
    "Security Settings Updated", "Privacy Settings Changed",
    "Notification Preferences", "Security Preferences", "Account Preferences",
    "Security Configuration", "Privacy Configuration", "Settings Modified",
    "Account Permissions", "Access Level Changed", "Role Modified",
    "Permissions Updated", "Access Rights", "Authorization Level",
    "Account Privileges", "Admin Access", "User Role Changed"] {
    addflag "\\Seen";
    fileinto "Security/Changes";
    expire "day" "45";

    stop;
}

if header :contains "subject" ["Payment Method Added", "Credit Card Added",
    "Payment Method Removed", "Card Expired", "Payment Method Updated",
    "Billing Information Changed", "Payment Details Modified", "Card Declined",
    "Payment Failed", "Subscription Payment", "Auto-renewal Failed",
    "Billing Address Changed", "Tax Information Updated", "Invoice Generated",
    "Payment Confirmation", "Refund Processed", "Chargeback Alert",
    "Billing Dispute", "Payment Verification Required", "Subscription Cancelled",
    "Service Downgraded", "Service Upgraded", "Plan Changed",
    "Billing Cycle Modified", "Subscription Renewal",
    "Service Suspended for Payment", "Account Upgraded"] {
    addflag "\\Seen";
    fileinto "Security/Billing";
    expire "day" "365";

    stop;
}

if header :contains "subject" ["App Permission Granted", "Third-party Access",
    "OAuth Authorization", "API Access Granted", "Connected App", "App Connected",
    "Service Connected", "Integration Authorized", "Permission Revoked",
    "App Access Removed", "Connected Service", "External App Access",
    "Device Authorized", "Browser Authorized", "Device Permission",
    "Location Access", "Camera Permission", "Microphone Access",
    "Notification Permission", "Storage Permission", "Contact Permission",
    "Data Sharing Agreement", "Information Sharing", "Data Access Granted",
    "Privacy Consent", "Data Processing Consent", "Data Export Request",
    "Data Download", "Account Data", "Personal Data Export"] {
    addflag "\\Seen";
    fileinto "Security/Permissions";
    expire "day" "30";

    stop;
}

if header :contains "subject" ["GDPR Compliance", "CCPA Notice", "Privacy Law Update",
    "Data Protection Notice", "Regulatory Compliance", "Privacy Rights",
    "Data Subject Rights", "Right to Delete", "Data Portability", "Privacy Request",
    "Terms of Service Update", "Privacy Policy Update", "Legal Notice",
    "Regulatory Change", "Compliance Update", "Policy Amendment",
    "Legal Requirement", "Regulatory Filing", "Audit Notice", "Compliance Report",
    "Data Retention Policy", "Data Deletion Schedule", "Account Deletion",
    "Data Purge Notice", "Retention Period", "Data Cleanup", "Information Disposal",
    "Record Retention", "Data Archive"] {
    addflag "\\Seen";
    fileinto "Security/Compliance";
    expire "day" "90";

    stop;
}

if header :contains "subject" ["Security Tips", "Security Best Practices",
    "Security Awareness", "Phishing Alert", "Security Education",
    "Stay Safe Online", "Security Training", "Cybersecurity Tips", "Privacy Tips",
    "Safety Reminder", "Security Newsletter", "Threat Alert", "Security Warning",
    "Scam Alert", "Phishing Warning", "Malware Alert", "Virus Warning",
    "Security Threat", "Cyber Threat", "Security Advisory", "Safety Alert",
    "Fraud Warning"] {
    addflag "\\Seen";
    fileinto "Security/Education";
    expire "day" "14";

    stop;
}

if header :contains "subject" ["Security Update", "Security Patch", "Software Update",
    "System Update", "Security Fix", "Vulnerability Patch", "Security Enhancement",
    "Security Improvement", "Protection Update", "Safety Update",
    "Account Verified", "Email Verified", "Phone Verified", "Identity Confirmed",
    "Verification Complete", "Account Activated", "Registration Confirmed",
    "Account Setup Complete", "Welcome Security", "Please Confirm Your Account",
    "Please confirm your email address", "verify your email", "System Maintenance",
    "Security Maintenance", "Scheduled Maintenance", "Service Update",
    "Platform Update", "Infrastructure Update", "Server Maintenance",
    "Database Maintenance", "Network Maintenance"] {
    addflag "\\Seen";
    fileinto "Security/General";
    expire "day" "21";

    stop;
}

if anyof (
    header :contains "subject" ["Security Alert", "Password", "Login", "Sign-in",
        "Authentication", "Verification Code", "Two-Factor", "Unauthorized",
        "Suspicious Activity", "Account Recovery", "Data Breach", "Security", "Account",
        "Access", "Protect", "Privacy", "Confidential"],
    header :contains "from" ["security@", "account@", "admin@", "alerts@",
        "notification@"]
) {
    addflag "\\Seen";
    fileinto "Security";
    expire "day" "14";

    stop;
}

# ====================================================================================
# Invoices & Payments  (install position 19 of 22)
# ====================================================================================

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

# ====================================================================================
# Government & Tax  (install position 18 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["ato.gov.au", "*.ato.gov.au", "canada.ca",
        "*.canada.ca", "cra-arc.gc.ca", "*.cra-arc.gc.ca", "dol.gov", "*.dol.gov",
        "freetaxusa.com", "*.freetaxusa.com", "ftc.gov", "*.ftc.gov", "healthcare.gov",
        "*.healthcare.gov", "hrblock.com", "*.hrblock.com", "ird.govt.nz",
        "*.ird.govt.nz", "irs.gov", "*.irs.gov", "medicare.gov", "*.medicare.gov",
        "sec.gov", "*.sec.gov", "servicesaustralia.gov.au",
        "*.servicesaustralia.gov.au", "ssa.gov", "*.ssa.gov", "studentaid.gov",
        "*.studentaid.gov", "taxact.com", "*.taxact.com", "taxslayer.com",
        "*.taxslayer.com", "treasury.gov", "*.treasury.gov", "turbotax.com",
        "*.turbotax.com", "usa.gov", "*.usa.gov", "uscis.gov", "*.uscis.gov", "va.gov",
        "*.va.gov"],
    header :contains "subject" ["Tax Return", "Tax Refund", "Notice of Assessment",
        "Benefit Statement", "Government Notice", "Public Service", "Jury Summons",
        "Voter Registration", "Passport Application", "Visa Application",
        "Social Security"]
) {
    addflag "\\Seen";
    fileinto "Government";

    stop;
}

# ====================================================================================
# Shipping & Deliveries  (install position 13 of 22)
# ====================================================================================

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

# End of Essentials bundle
