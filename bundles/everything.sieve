# Everything bundle -- bundles/everything.sieve
#
# GENERATED FILE -- do not edit. Edit data/bundles.yml and run:
#     python tools/generate.py
#
# All 22 categories in one script. Large -- check that Proton accepts it before relying
# on it.
#
# This is ONE filter containing 22 categories: phishing, security, proton, invoice, government, bills, legal, health, travel, shipping, study, recruiting, gaming, entertainment, news, social, ai, devtools, food, work, shopping, spam.
# Proton's free plan allows one active filter, so a bundle is the only way
# to use more than one category on it.
#
# Folders: AI, Bills, Dev, Entertainment/Books, Entertainment/Comics,
#          Entertainment/Events, Entertainment/General, Entertainment/Movies-TV,
#          Entertainment/Music, Entertainment/News, Entertainment/Podcasts,
#          Entertainment/Reviews, Food, Gaming, Government, Health, Legal,
#          Legal/Suspicious, News, News/Business, News/Entertainment, News/Politics,
#          News/Science, News/Sports, News/Tech, News/Weather, News/World, Payments,
#          Phishing, Proton, Recruiting, Security, Security/Authentication,
#          Security/Billing, Security/Changes, Security/Compliance, Security/Critical,
#          Security/Education, Security/General, Security/Login, Security/Permissions,
#          Shipping, Shopping, Shopping/Account, Shopping/Cart, Shopping/Deals,
#          Shopping/Orders, Shopping/Recommendations, Shopping/Returns,
#          Shopping/Reviews, Shopping/Rewards, Shopping/Shipping,
#          Shopping/Subscriptions, Shopping/Wishlist, Social Account, Spam, Study,
#          Study/Algorithms, Study/Art, Study/Biology, Study/Business,
#          Study/Certification, Study/Chemistry, Study/Engineering, Study/General,
#          Study/History, Study/Languages, Study/Mathematics, Study/Medicine,
#          Study/Music, Study/Physics, Study/Programming, Study/Research,
#          Study/TestPrep, Study/Textbooks, Travel, Travel/Activities, Travel/Alerts,
#          Travel/Deals, Travel/Flights, Travel/Hotels, Travel/Planning,
#          Travel/Reviews, Travel/Transport, Work, Work/Career, Work/Finance, Work/HR,
#          Work/IT, Work/Meetings, Work/Projects, Work/Reminders, Work/Reports,
#          Work/Sales
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
# Proton Service Notifications  (install position 20 of 22)
# ====================================================================================

if address :domain :matches "from" ["pr0ton.me", "*.pr0ton.me", "proton-mail.com",
    "*.proton-mail.com", "proton.com", "*.proton.com", "protonmai1.com",
    "*.protonmai1.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if anyof (
    address :domain :matches "from" ["pm.me", "*.pm.me", "proton.ch", "*.proton.ch",
        "proton.me", "*.proton.me", "protoncalendar.com", "*.protoncalendar.com",
        "protondrive.com", "*.protondrive.com", "protonmail.ch", "*.protonmail.ch",
        "protonmail.com", "*.protonmail.com", "protonstatus.com", "*.protonstatus.com",
        "protonvpn.com", "*.protonvpn.com"],
    header :contains "subject" ["Proton Mail", "Proton VPN", "Proton Drive",
        "Proton Calendar", "Proton Pass", "Proton Account", "ProtonMail",
        "Cảnh báo bảo mật", "Tài khoản bị xâm phạm", "Truy cập trái phép",
        "Cảnh báo đăng nhập", "Vi phạm bảo mật", "Tài khoản bị khóa",
        "Hoạt động đáng nghi", "Mật khẩu đã thay đổi", "Xác thực hai yếu tố",
        "Ủy quyền thiết bị", "安全警报", "账户被盗用", "未授权访问", "登录警报", "安全漏洞", "账户被锁定", "可疑活动",
        "密码已更改", "双重认证", "设备授权", "セキュリティアラート", "アカウントが侵害されました", "不正アクセス", "ログインアラート",
        "セキュリティ違反", "アカウントがロックされました", "疑わしい活動", "パスワードが変更されました", "二要素認証", "デバイス認証"],
    header :contains "from" ["noreply@proton.me", "no-reply@proton.me",
        "notifications@proton.me", "support@proton.me", "security@proton.me",
        "billing@proton.me", "newsletter@proton.me", "updates@proton.me",
        "community@proton.me", "feedback@proton.me", "survey@proton.me"]
) {
    addflag "\\Seen";
    fileinto "Proton";

    if header :contains "subject" ["Security Alert", "Account Compromised",
        "Unauthorized Access", "Login Alert", "Security Breach", "Account Locked",
        "Suspicious Activity", "Password Changed", "Two-Factor Authentication",
        "Device Authorization", "Login from New Location", "Security Warning"] {
        removeflag "\\Seen";
        addflag "\\Flagged";
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Subscription Confirmation", "Billing Update",
            "Payment Received", "Renewal Notice", "Invoice Attached", "Account Charged",
            "Plan Upgrade", "Plan Downgrade", "Subscription Details",
            "Billing Statement", "Payment Reminder", "Payment Failed", "Card Expired",
            "Subscription Cancelled", "Refund Processed", "Credit Applied",
            "Proton Plus", "Proton Unlimited"],
        size :under 1M
    ) {
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Verification", "Email Verified",
            "Profile Update", "Settings Changed", "Account Activity",
            "Login Confirmation", "Device Added", "Device Removed", "Account Recovery",
            "Email Preferences Update", "Proton Account Alert",
            "User Settings Notification", "Recovery Email", "Account Activated",
            "Welcome to Proton", "Account Setup Complete"],
        size :under 500K
    ) {
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["New Message in Inbox", "Unread Email Notification",
            "Inbox Update", "Message Received", "Email Alert",
            "Proton Mail Notification", "New Email Arrived", "Inbox Activity",
            "Message Waiting", "Check Your Inbox", "Daily Summary", "Inbox Digest",
            "Message Count", "Unread Messages"],
        size :under 200K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Proton Newsletter", "Product Update",
            "Feature Announcement", "Community News", "Proton Blog Post",
            "Service Improvements", "App Release Notes", "New Features",
            "App Update Available", "Proton Tips", "Privacy Tips", "Security Tips",
            "Product Roadmap", "Beta Testing", "Early Access"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["User Survey", "Feedback Request",
            "Rate Your Experience", "Customer Survey", "Product Feedback",
            "Service Rating", "User Research", "Beta Feedback", "Feature Request",
            "Community Poll", "User Study"],
        size :under 300K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Service Status", "Maintenance Notice",
            "System Update", "Scheduled Maintenance", "Service Interruption",
            "Downtime Notice", "System Maintenance", "Server Update",
            "Infrastructure Update", "Network Maintenance", "Service Restored"],
        size :under 300K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Privacy Policy Update", "Terms of Service",
            "EULA Update", "Policy Change", "Terms Change", "Legal Notice",
            "Transparency Report", "Privacy Update", "Data Policy", "User Agreement",
            "Service Agreement", "Compliance Update", "Regulatory Change"],
        size :under 500K
    ) {
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Proton Drive", "File Shared", "Folder Shared",
            "Drive Storage", "Upload Complete", "Sync Complete", "File Updated",
            "Drive Notification", "Sharing Invitation", "Drive Alert"],
        size :under 300K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Proton Calendar", "Event Reminder",
            "Calendar Invitation", "Event Update", "Meeting Reminder",
            "Calendar Notification", "Event Cancelled", "Calendar Sync"],
        size :under 300K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Proton VPN", "VPN Connection", "Server Update",
            "VPN Alert", "Connection Status", "VPN Notification", "Server Maintenance"],
        size :under 300K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Proton Pass", "Password Alert", "Breach Alert",
            "Vault Notification", "Pass Notification", "Security Report",
            "Password Health", "Data Breach"],
        size :under 300K
    ) {
        expire "day" "30";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "10";

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
# Bills & Utilities  (install position 17 of 22)
# ====================================================================================

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

# ====================================================================================
# Legal & Policy Notifications  (install position 16 of 22)
# ====================================================================================

if header :contains "subject" ["EULA Update", "EULA Change", "EULA Revision",
    "EULA Amendment", "Updated EULA", "New EULA Version", "EULA Modification",
    "License Agreement Change", "License Agreement Update",
    "Software License Change", "End User License Agreement", "Terms of Service",
    "Terms of Use", "ToS Update", "ToS Change", "Updated Terms", "Terms Change",
    "Service Terms Update", "Terms Revision", "Terms Amendment",
    "Terms Modification", "User Agreement", "Service Agreement",
    "Terms and Conditions", "T&C Update", "Updated T&C", "Privacy Policy",
    "Privacy Update", "Privacy Change", "Updated Privacy Policy",
    "Privacy Revision", "Privacy Amendment", "Privacy Notice",
    "Data Privacy Update", "Privacy Settings", "Privacy Preferences",
    "Privacy Rights", "Data Collection", "Data Processing", "Data Usage",
    "Data Policy", "Cookie Policy", "Tracking Policy", "Data Protection",
    "Data Handling", "Data Rights", "Personal Data", "Information Collection",
    "Data Retention", "Data Sharing", "GDPR Update", "GDPR Compliance",
    "Data Protection Regulation", "CCPA Notice", "California Privacy Rights",
    "Compliance Update", "Regulatory Change", "Legal Compliance", "Privacy Law",
    "Data Law", "Legal Update", "Legal Notice", "Legal Change", "Policy Update",
    "Policy Change", "Policy Revision", "Policy Amendment", "Agreement Update",
    "Agreement Change", "Contract Update", "Legal Terms", "Regulatory Update",
    "Community Guidelines", "Content Policy", "Community Standards",
    "Acceptable Use Policy", "Code of Conduct", "Platform Rules",
    "Usage Guidelines", "Community Rules", "Content Standards", "Behavior Policy",
    "Security Policy", "Account Policy", "Access Policy", "Authentication Policy",
    "Password Policy", "Two-Factor Authentication", "Account Security",
    "Login Policy", "Security Update", "Master Service Agreement", "SLA Update",
    "Service Level Agreement", "Subscription Agreement", "Purchase Agreement",
    "Billing Terms", "Payment Terms", "Refund Policy", "Cancellation Policy",
    "Subscription Terms"] {
    addflag "\\Seen";
    fileinto "Legal";

    if anyof (
        header :contains "subject" ["important", "urgent", "critical", "mandatory",
            "required", "action required", "must read", "compliance",
            "legal requirement"],
        header :contains "from" ["legal@", "compliance@", "privacy@", "security@"]
    ) {
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["GDPR", "CCPA", "Data Protection Regulation",
            "Privacy Law", "Data Law", "Regulatory Change"],
        size :over 100K
    ) {
        expire "day" "21";

        stop;
    }

    if header :contains "subject" ["Security Policy", "Account Policy",
        "Authentication Policy", "Password Policy", "Two-Factor",
        "Account Security", "Login Policy"] {
        expire "day" "14";

        stop;
    }

    if allof (
        size :under 200K,
        not header :contains "subject" ["breaking", "major change",
            "significant update"]
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "10";

    stop;
}

if header :contains "subject" ["Legal Action", "Lawsuit", "Court Notice", "Summons",
    "Legal Proceeding", "Cease and Desist", "Copyright Violation", "DMCA",
    "Intellectual Property", "Patent Infringement", "Immediate Legal Action",
    "Legal Department", "Law Firm", "Attorney Notice", "Legal Warning",
    "Legal Violation"] {
    addflag "\\Flagged";
    fileinto "Legal/Suspicious";
    expire "day" "30";

    stop;
}

# ====================================================================================
# Health & Fitness  (install position 15 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["21dayfix.com", "*.21dayfix.com", "23andme.com",
        "*.23andme.com", "7minuteworkout.com", "*.7minuteworkout.com", "8fit.com",
        "*.8fit.com", "aaptiv.com", "*.aaptiv.com", "achievers.com", "*.achievers.com",
        "ada.com", "*.ada.com", "adidas.com", "*.adidas.com", "alo.com", "*.alo.com",
        "alomoves.com", "*.alomoves.com", "alzheimers.net", "*.alzheimers.net",
        "amazfit.com", "*.amazfit.com", "amwell.com", "*.amwell.com", "ancestry.com",
        "*.ancestry.com", "arthritis.org", "*.arthritis.org", "asanarebel.com",
        "*.asanarebel.com", "babylon.health", "*.babylon.health", "balanced-body.com",
        "*.balanced-body.com", "beachbody.com", "*.beachbody.com", "betterhelp.com",
        "*.betterhelp.com", "blogilates.com", "*.blogilates.com", "blueapron.com",
        "*.blueapron.com", "bodybuilding.com", "*.bodybuilding.com", "brain.fm",
        "*.brain.fm", "breethe.com", "*.breethe.com", "brightside.com",
        "*.brightside.com", "bsn.com", "*.bsn.com", "buddhify.com", "*.buddhify.com",
        "calm.com", "*.calm.com", "cancer.org", "*.cancer.org", "castlight.com",
        "*.castlight.com", "cellucor.com", "*.cellucor.com", "centr.com", "*.centr.com",
        "centrum.com", "*.centrum.com", "cerebral.com", "*.cerebral.com",
        "classpass.com", "*.classpass.com", "color.com", "*.color.com", "corepower.com",
        "*.corepower.com", "couchto5k.com", "*.couchto5k.com",
        "crohns-colitis-foundation.org", "*.crohns-colitis-foundation.org",
        "cronometer.com", "*.cronometer.com", "dailyburn.com", "*.dailyburn.com",
        "dailyhiit.com", "*.dailyhiit.com", "dailyyoga.com", "*.dailyyoga.com",
        "daylio.net", "*.daylio.net", "diabetes.org", "*.diabetes.org", "dietbet.com",
        "*.dietbet.com", "doctorondemand.com", "*.doctorondemand.com", "downdogapp.com",
        "*.downdogapp.com", "doyogawithme.com", "*.doyogawithme.com", "drugs.com",
        "*.drugs.com", "dymatize.com", "*.dymatize.com", "endomondo.com",
        "*.endomondo.com", "everlywell.com", "*.everlywell.com", "evolveyou.app",
        "*.evolveyou.app", "fatsecret.com", "*.fatsecret.com", "fitbit.com",
        "*.fitbit.com", "fitbod.me", "*.fitbod.me", "fitfusion.com", "*.fitfusion.com",
        "fitnessrpg.com", "*.fitnessrpg.com", "focus-app.com", "*.focus-app.com",
        "freedom.to", "*.freedom.to", "freeletics.com", "*.freeletics.com",
        "freshly.com", "*.freshly.com", "future.co", "*.future.co", "gaiam.com",
        "*.gaiam.com", "garmin.com", "*.garmin.com", "glo.com", "*.glo.com",
        "gobble.com", "*.gobble.com", "goodrx.com", "*.goodrx.com", "habitica.com",
        "*.habitica.com", "happier.com", "*.happier.com", "headspace.com",
        "*.headspace.com", "healthline.com", "*.healthline.com", "healthtap.com",
        "*.healthtap.com", "heart.org", "*.heart.org", "helix.com", "*.helix.com",
        "hellofresh.com", "*.hellofresh.com", "huawei.com", "*.huawei.com",
        "imaware.health", "*.imaware.health", "insanity.com", "*.insanity.com",
        "inside-tracker.com", "*.inside-tracker.com", "insight-timer.com",
        "*.insight-timer.com", "instacart.com", "*.instacart.com", "jefit.com",
        "*.jefit.com", "jiff.com", "*.jiff.com", "joinforma.com", "*.joinforma.com",
        "justdancenow.com", "*.justdancenow.com", "kidney.org", "*.kidney.org",
        "ladder.app", "*.ladder.app", "lesmills.com", "*.lesmills.com",
        "letsgetchecked.com", "*.letsgetchecked.com", "lifesum.com", "*.lifesum.com",
        "limeade.com", "*.limeade.com", "loseit.com", "*.loseit.com", "lung.org",
        "*.lung.org", "lyra.com", "*.lyra.com", "mapmyfitness.com",
        "*.mapmyfitness.com", "mapmyrun.com", "*.mapmyrun.com", "mayoclinic.org",
        "*.mayoclinic.org", "mdlive.com", "*.mdlive.com", "medscape.com",
        "*.medscape.com", "moodpath.com", "*.moodpath.com", "multiple-sclerosis.org",
        "*.multiple-sclerosis.org", "muscleandstrength.com", "*.muscleandstrength.com",
        "musclepharm.com", "*.musclepharm.com", "muscletech.com", "*.muscletech.com",
        "myfitnesspal.com", "*.myfitnesspal.com", "myheritage.com", "*.myheritage.com",
        "myprotein.com", "*.myprotein.com", "naturemade.com", "*.naturemade.com",
        "niantic.com", "*.niantic.com", "nike.com", "*.nike.com", "noisli.com",
        "*.noisli.com", "noom.com", "*.noom.com", "nutrabio.com", "*.nutrabio.com",
        "nutrigenomix.com", "*.nutrigenomix.com", "nutrisystem.com",
        "*.nutrisystem.com", "obefitness.com", "*.obefitness.com",
        "optimumnutrition.com", "*.optimumnutrition.com", "oura.com", "*.oura.com",
        "p90x.com", "*.p90x.com", "parkinson.org", "*.parkinson.org", "peloton.com",
        "*.peloton.com", "performancelab.com", "*.performancelab.com",
        "pilatesanytime.com", "*.pilatesanytime.com", "pillow.com", "*.pillow.com",
        "pokemon.com", "*.pokemon.com", "pokemongo.com", "*.pokemongo.com", "polar.com",
        "*.polar.com", "popsugar.com", "*.popsugar.com", "practo.com", "*.practo.com",
        "pvolve.com", "*.pvolve.com", "pzizz.com", "*.pzizz.com", "questnutrition.com",
        "*.questnutrition.com", "rainy-mood.com", "*.rainy-mood.com", "redbox-rx.com",
        "*.redbox-rx.com", "reebok.com", "*.reebok.com", "rescue-time.com",
        "*.rescue-time.com", "runkeeper.com", "*.runkeeper.com", "runtastic.com",
        "*.runtastic.com", "samsung.com", "*.samsung.com", "sanvello.com",
        "*.sanvello.com", "shipt.com", "*.shipt.com", "simple-habit.com",
        "*.simple-habit.com", "sleep.com", "*.sleep.com", "sleepbot.com",
        "*.sleepbot.com", "sleepcycle.com", "*.sleepcycle.com", "sleepio.com",
        "*.sleepio.com", "sleepscore.com", "*.sleepscore.com", "sparkpeople.com",
        "*.sparkpeople.com", "stepbet.com", "*.stepbet.com", "stottpilates.com",
        "*.stottpilates.com", "strava.com", "*.strava.com", "stridekick.com",
        "*.stridekick.com", "strongapp.me", "*.strongapp.me", "sunbasket.com",
        "*.sunbasket.com", "suunto.com", "*.suunto.com", "sworkit.com", "*.sworkit.com",
        "symptomate.com", "*.symptomate.com", "talkspace.com", "*.talkspace.com",
        "teladoc.com", "*.teladoc.com", "ten-percent-happier.com",
        "*.ten-percent-happier.com", "thesculptsociety.com", "*.thesculptsociety.com",
        "thorne.com", "*.thorne.com", "thrive.com", "*.thrive.com", "trainiac.com",
        "*.trainiac.com", "trainwell.net", "*.trainwell.net", "under-armour.com",
        "*.under-armour.com", "virgin-pulse.com", "*.virgin-pulse.com",
        "vitafusion.com", "*.vitafusion.com", "vitagene.com", "*.vitagene.com",
        "waking-up.com", "*.waking-up.com", "walkr.space", "*.walkr.space", "webmd.com",
        "*.webmd.com", "weightwatchers.com", "*.weightwatchers.com", "welltok.com",
        "*.welltok.com", "whoop.com", "*.whoop.com", "withings.com", "*.withings.com",
        "ww.com", "*.ww.com", "yazio.com", "*.yazio.com", "yogastudio.com",
        "*.yogastudio.com", "yogaworks.com", "*.yogaworks.com", "youper.ai",
        "*.youper.ai", "zocdoc.com", "*.zocdoc.com", "zombiesrungame.com",
        "*.zombiesrungame.com"],
    header :contains "subject" ["Nhắc nhở tập luyện", "Mục tiêu bước chân hàng ngày",
        "Phiên thiền", "Thử thách thể dục", "Mẹo sức khỏe", "Theo dõi tiến độ",
        "Cảnh báo hoạt động", "Nhắc nhở mục tiêu", "Cập nhật streak",
        "Thời gian di chuyển", "Nhắc nhở đứng lên", "Cảnh báo nước uống",
        "Nhắc nhở thuốc", "Nhắc nhở cuộc hẹn", "Báo cáo tiến độ", "Kế hoạch tập luyện",
        "Mẹo dinh dưỡng", "Hướng dẫn tập luyện", "Bài báo sức khỏe",
        "Kế hoạch chế độ ăn", "Hướng dẫn sức khỏe", "Tin tức sức khỏe",
        "Báo cáo hàng tuần", "Tóm tắt hàng tháng", "Kết quả xét nghiệm", "Báo cáo y tế",
        "Đánh giá sức khỏe", "Xác nhận thanh toán", "Hóa đơn", "Gia hạn thành viên",
        "Cập nhật bảo mật", "锻炼提醒", "每日步数目标", "冥想课程", "健身挑战", "健康小贴士", "跟踪进度", "活动提醒",
        "目标提醒", "连续记录更新", "运动时间", "站立提醒", "饮水提醒", "用药提醒", "预约提醒", "进度报告", "锻炼计划",
        "营养建议", "锻炼指导", "健康文章", "饮食计划", "健康指南", "健康新闻", "周报", "月度总结", "检测结果", "医疗报告",
        "健康评估", "付款确认", "账单", "会员续费", "安全更新", "ワークアウトリマインダー", "1日の歩数目標", "瞑想セッション",
        "フィットネスチャレンジ", "健康のヒント", "進捗追跡", "アクティビティアラート", "目標リマインダー", "ストリーク更新", "運動時間",
        "立ち上がりリマインダー", "水分補給アラート", "薬のリマインダー", "予約リマインダー", "進捗レポート", "トレーニング計画",
        "栄養のアドバイス", "エクササイズチュートリアル", "健康記事", "食事プラン", "健康ガイド", "健康ニュース", "週次レポート",
        "月次サマリー", "検査結果", "医療レポート", "健康評価", "支払い確認", "請求書", "メンバーシップ更新", "セキュリティアップデート"]
) {
    addflag "\\Seen";
    fileinto "Health";

    if allof (
        header :contains "subject" ["Workout Reminder", "Daily Step Goal",
            "Meditation Session", "Fitness Challenge Start", "Health Tip of the Day",
            "Track Your Progress", "Don't Miss Your Session", "Activity Alert",
            "Goal Reminder", "Streak Update", "Time to Move", "Stand Up Reminder",
            "Hydration Alert", "Medicine Reminder", "Appointment Reminder",
            "Check-in Time", "Daily Challenge", "Morning Motivation",
            "Evening Reflection", "Sleep Time Alert"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Special Offer Inside", "Discount on Premium",
            "Free Trial Extension", "Limited Time Deal", "Upgrade Your Plan",
            "Promo Code Alert", "Membership Renewal Offer", "Flash Sale on App",
            "Exclusive Discount", "Rewards Program Update", "Black Friday Deal",
            "Summer Sale", "New Year Special", "First Month Free", "50% Off Premium",
            "Early Bird Discount", "Member Exclusive"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Weekly Report", "Progress Summary", "Weekly Stats",
            "Your Week in Review", "Weekly Achievement", "7-Day Summary",
            "Weekly Challenge Results", "Week's Progress", "Weekly Insights",
            "Performance Summary", "Weekly Goals Review"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Fitness Plan Update", "Nutrition Tip",
            "Weekly Workout Plan", "Custom Training Schedule", "Progress Report",
            "Meal Plan Suggestion", "Personalized Plan Ready",
            "Goal Achievement Update", "Health Education", "Workout Tips",
            "Nutrition Guide", "Exercise Tutorial", "Health Article", "Training Plan",
            "Diet Recommendation", "Wellness Guide", "Health News"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Monthly Report", "Monthly Summary",
            "30-Day Challenge Results", "Monthly Achievement", "Long-term Progress",
            "Monthly Analytics", "Trend Analysis", "Monthly Insights",
            "Your Month in Review", "Monthly Goals Assessment"],
        size :under 500K
    ) {
        expire "day" "21";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Security Alert",
            "Password Change Required", "Suspicious Activity",
            "Health Data Privacy Update", "Login Attempt Notification",
            "Two-Factor Setup", "Data Breach Warning", "Account Locked",
            "Verification Code", "Fraud Detection", "Privacy Policy Update",
            "Terms of Service Change", "HIPAA Compliance", "Data Protection Update",
            "Security Update"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["App Update Available", "New Feature Alert",
            "Version Update", "Feature Release", "App Enhancement", "Bug Fix Update",
            "Performance Improvement", "New Workout Added", "Feature Announcement",
            "Platform Update", "System Upgrade"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    if allof (
        header :contains "subject" ["Test Results", "Lab Results", "Blood Work",
            "Health Screening", "Medical Report", "Genetic Results",
            "Health Assessment", "Diagnostic Results", "Biomarker Results",
            "Health Score", "Risk Assessment", "Health Analysis"],
        size :under 2M
    ) {
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Subscription Renewal", "Payment Confirmation",
            "Invoice", "Billing Statement", "Payment Receipt", "Membership Renewed",
            "Auto-renewal Notice", "Payment Failed", "Card Expired",
            "Subscription Cancelled", "Refund Processed"],
        size :under 500K
    ) {
        expire "day" "365";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "5";

    stop;
}

# ====================================================================================
# Travel  (install position 14 of 22)
# ====================================================================================

if address :domain :matches "from" ["airbnbb.com", "*.airbnbb.com", "bookng.com",
    "*.bookng.com", "delta-airlines.com", "*.delta-airlines.com", "expedia-deals.com",
    "*.expedia-deals.com", "marriot.com", "*.marriot.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if anyof (
    address :domain :matches "from" ["99app.com", "*.99app.com", "aaa.com", "*.aaa.com",
        "accor.com", "*.accor.com", "aeroflot.com", "*.aeroflot.com", "airasia.com",
        "*.airasia.com", "airbnb.com", "*.airbnb.com", "airfrance.com",
        "*.airfrance.com", "airhelp.com", "*.airhelp.com", "airnz.com", "*.airnz.com",
        "alamo.com", "*.alamo.com", "alaskaair.com", "*.alaskaair.com", "alitalia.com",
        "*.alitalia.com", "allegiantair.com", "*.allegiantair.com", "allianz.com",
        "*.allianz.com", "alltrails.com", "*.alltrails.com", "americanairlines.com",
        "*.americanairlines.com", "amtrak.com", "*.amtrak.com", "ana.co.jp",
        "*.ana.co.jp", "asiana.com", "*.asiana.com", "atlasobscura.com",
        "*.atlasobscura.com", "austrian.com", "*.austrian.com", "avis.com",
        "*.avis.com", "away.com", "*.away.com", "axa.com", "*.axa.com", "backpackr.com",
        "*.backpackr.com", "bestwestern.com", "*.bestwestern.com", "boltapp.com",
        "*.boltapp.com", "boltbus.com", "*.boltbus.com", "booking.com", "*.booking.com",
        "breezeairways.com", "*.breezeairways.com", "britishairways.com",
        "*.britishairways.com", "budget.com", "*.budget.com", "cabify.com",
        "*.cabify.com", "campgrounds.com", "*.campgrounds.com", "car2go.com",
        "*.car2go.com", "carnivalcruiseline.com", "*.carnivalcruiseline.com",
        "cathaypacific.com", "*.cathaypacific.com", "cebu-pacific.com",
        "*.cebu-pacific.com", "celebritycruises.com", "*.celebritycruises.com",
        "cheapflights.com", "*.cheapflights.com", "choicehotels.com",
        "*.choicehotels.com", "citymapper.com", "*.citymapper.com", "citypass.com",
        "*.citypass.com", "costacruises.com", "*.costacruises.com", "costcotravel.com",
        "*.costcotravel.com", "couchsurfing.com", "*.couchsurfing.com", "covermore.com",
        "*.covermore.com", "cunard.com", "*.cunard.com", "delta.com", "*.delta.com",
        "deutschebahn.com", "*.deutschebahn.com", "didi.com", "*.didi.com",
        "disneycruise.com", "*.disneycruise.com", "dollar.com", "*.dollar.com",
        "doubletree.com", "*.doubletree.com", "easyjet.com", "*.easyjet.com",
        "embassy.com", "*.embassy.com", "emirates.com", "*.emirates.com",
        "enterprise.com", "*.enterprise.com", "etihad.com", "*.etihad.com",
        "eurail.com", "*.eurail.com", "europcar.com", "*.europcar.com", "expedia.com",
        "*.expedia.com", "fairmont.com", "*.fairmont.com", "fijianairways.com",
        "*.fijianairways.com", "finnair.com", "*.finnair.com", "flightaware.com",
        "*.flightaware.com", "flightright.com", "*.flightright.com", "flipkey.com",
        "*.flipkey.com", "flixbus.com", "*.flixbus.com", "fodors.com", "*.fodors.com",
        "fourseasons.com", "*.fourseasons.com", "foursquare.com", "*.foursquare.com",
        "freenow.com", "*.freenow.com", "frommers.com", "*.frommers.com",
        "frontier.com", "*.frontier.com", "garuda-indonesia.com",
        "*.garuda-indonesia.com", "gasbuddy.com", "*.gasbuddy.com", "getaround.com",
        "*.getaround.com", "gett.com", "*.gett.com", "getyourguide.com",
        "*.getyourguide.com", "glamping.com", "*.glamping.com", "goldstar.com",
        "*.goldstar.com", "grab.com", "*.grab.com", "greyhound.com", "*.greyhound.com",
        "groupon.com", "*.groupon.com", "hamptoninn.com", "*.hamptoninn.com",
        "hawaiianairlines.com", "*.hawaiianairlines.com", "hertz.com", "*.hertz.com",
        "hilton.com", "*.hilton.com", "hipcamp.com", "*.hipcamp.com", "holidayinn.com",
        "*.holidayinn.com", "hollandamerica.com", "*.hollandamerica.com",
        "homeaway.com", "*.homeaway.com", "hopper.com", "*.hopper.com", "hotels.com",
        "*.hotels.com", "hotwire.com", "*.hotwire.com", "hyatt.com", "*.hyatt.com",
        "iberia.com", "*.iberia.com", "icelandair.com", "*.icelandair.com", "ihg.com",
        "*.ihg.com", "insuremytrip.com", "*.insuremytrip.com", "interrail.eu",
        "*.interrail.eu", "jal.com", "*.jal.com", "jetblue.com", "*.jetblue.com",
        "jetstar.com", "*.jetstar.com", "jrpass.com", "*.jrpass.com", "kayak.com",
        "*.kayak.com", "klm.com", "*.klm.com", "klook.com", "*.klook.com", "koa.com",
        "*.koa.com", "koreanair.com", "*.koreanair.com", "laquinta.com",
        "*.laquinta.com", "livingsocial.com", "*.livingsocial.com", "lonelyplanet.com",
        "*.lonelyplanet.com", "loungebuddy.com", "*.loungebuddy.com", "lufthansa.com",
        "*.lufthansa.com", "lyft.com", "*.lyft.com", "malaysiaairlines.com",
        "*.malaysiaairlines.com", "mandarin-oriental.com", "*.mandarin-oriental.com",
        "marriott.com", "*.marriott.com", "meetup.com", "*.meetup.com", "megabus.com",
        "*.megabus.com", "momondo.com", "*.momondo.com", "msc.com", "*.msc.com",
        "national.com", "*.national.com", "ncl.com", "*.ncl.com", "nomadlist.com",
        "*.nomadlist.com", "norwegianair.com", "*.norwegianair.com", "ns.nl", "*.ns.nl",
        "oebb.at", "*.oebb.at", "ola.com", "*.ola.com", "onetravel.com",
        "*.onetravel.com", "opentable.com", "*.opentable.com", "orbitz.com",
        "*.orbitz.com", "packpoint.com", "*.packpoint.com", "peninsula.com",
        "*.peninsula.com", "philippineairlines.com", "*.philippineairlines.com",
        "priceline.com", "*.priceline.com", "princess.com", "*.princess.com",
        "prioritypass.com", "*.prioritypass.com", "qantas.com", "*.qantas.com",
        "qatarairways.com", "*.qatarairways.com", "recreation.gov", "*.recreation.gov",
        "redawning.com", "*.redawning.com", "redlion.com", "*.redlion.com",
        "regent7seas.com", "*.regent7seas.com", "renfe.com", "*.renfe.com",
        "rentalcars.com", "*.rentalcars.com", "reserveamerica.com",
        "*.reserveamerica.com", "resy.com", "*.resy.com", "ricksteves.com",
        "*.ricksteves.com", "rimowa.com", "*.rimowa.com", "ritz-carlton.com",
        "*.ritz-carlton.com", "roadtrippers.com", "*.roadtrippers.com", "rome2rio.com",
        "*.rome2rio.com", "royalcaribbean.com", "*.royalcaribbean.com", "rvlife.com",
        "*.rvlife.com", "ryanair.com", "*.ryanair.com", "samsonite.com",
        "*.samsonite.com", "sas.se", "*.sas.se", "sbb.ch", "*.sbb.ch", "seatguru.com",
        "*.seatguru.com", "sheraton.com", "*.sheraton.com", "silversea.com",
        "*.silversea.com", "singaporeair.com", "*.singaporeair.com", "sixt.com",
        "*.sixt.com", "skyscanner.com", "*.skyscanner.com", "sncf.com", "*.sncf.com",
        "southwest.com", "*.southwest.com", "spirit.com", "*.spirit.com",
        "splitwise.com", "*.splitwise.com", "squaremouth.com", "*.squaremouth.com",
        "stubhub.com", "*.stubhub.com", "sunairlines.com", "*.sunairlines.com",
        "swiss.com", "*.swiss.com", "tap.pt", "*.tap.pt", "thaiairways.com",
        "*.thaiairways.com", "thrifty.com", "*.thrifty.com", "ticketmaster.com",
        "*.ticketmaster.com", "timeout.com", "*.timeout.com", "timeshifter.com",
        "*.timeshifter.com", "tiqets.com", "*.tiqets.com", "trainline.com",
        "*.trainline.com", "travelex.com", "*.travelex.com", "travelguard.com",
        "*.travelguard.com", "travelocity.com", "*.travelocity.com", "travelpro.com",
        "*.travelpro.com", "travelsafe.com", "*.travelsafe.com", "travelzoo.com",
        "*.travelzoo.com", "trenitalia.com", "*.trenitalia.com", "tripadvisor.com",
        "*.tripadvisor.com", "tripit.com", "*.tripit.com", "trivago.com",
        "*.trivago.com", "tumi.com", "*.tumi.com", "turkish.com", "*.turkish.com",
        "turnkey.com", "*.turnkey.com", "turo.com", "*.turo.com", "uber.com",
        "*.uber.com", "united.com", "*.united.com", "vacasa.com", "*.vacasa.com",
        "via.com", "*.via.com", "viator.com", "*.viator.com", "vietnamairlines.com",
        "*.vietnamairlines.com", "vikingcruises.com", "*.vikingcruises.com",
        "virginatlantic.com", "*.virginatlantic.com", "vrbo.com", "*.vrbo.com",
        "vueling.com", "*.vueling.com", "waze.com", "*.waze.com", "westin.com",
        "*.westin.com", "whimstay.com", "*.whimstay.com", "wizzair.com",
        "*.wizzair.com", "worldnomads.com", "*.worldnomads.com", "wyndhamhotels.com",
        "*.wyndhamhotels.com", "xe.com", "*.xe.com", "yelp.com", "*.yelp.com",
        "zipcar.com", "*.zipcar.com", "zomato.com", "*.zomato.com"],
    header :contains "subject" ["Xác nhận chuyến bay", "Hành trình bay",
        "Thẻ lên máy bay", "Đặt vé máy bay", "Vé máy bay", "Biên lai chuyến bay",
        "Hành trình du lịch", "Làm thủ tục sân bay", "Chi tiết chuyến bay",
        "Vé điện tử", "Thông tin khởi hành", "Xác nhận khách sạn",
        "Đặt phòng khách sạn", "Đặt phòng được xác nhận", "Đặt phòng", "Chi tiết chỗ ở",
        "Biên lai khách sạn", "Thông tin nhận phòng", "Đặt khách sạn",
        "Xác nhận lưu trú", "Số đặt chỗ", "Phiếu khách sạn", "Xác nhận thuê xe",
        "Hợp đồng thuê", "Đặt xe", "Thông tin lấy xe", "Đặt xe hơi", "Biên lai thuê xe",
        "Đặt vận chuyển", "Xác nhận chuyến đi", "Biên lai chuyến đi",
        "Chi tiết thuê xe", "Đặt hoạt động", "Xác nhận tour", "Đặt trải nghiệm",
        "Xác nhận vé", "Vé tham quan", "Đặt sự kiện", "Vé chương trình", "Thẻ bảo tàng",
        "Hướng dẫn viên du lịch", "Đặt phiêu lưu", "Tour được xác nhận", "航班确认", "航班行程",
        "登机牌", "航班预订", "机票", "航班收据", "旅行行程", "机场办理登机", "航班详情", "电子机票", "出发信息", "酒店确认",
        "酒店预订", "预订确认", "房间预订", "住宿详情", "酒店收据", "入住信息", "住宿确认", "预订号码", "酒店凭证", "租车确认",
        "租赁协议", "车辆预订", "取车信息", "汽车预订", "租车收据", "交通预订", "行程确认", "行程收据", "租车详情", "活动预订",
        "旅游确认", "体验预订", "门票确认", "景点门票", "演出门票", "博物馆通票", "导游", "冒险预订", "游览确认", "フライト確認",
        "フライト行程", "搭乗券", "フライト予約", "航空券", "フライト領収書", "空港チェックイン", "フライト詳細", "Eチケット",
        "出発情報", "ホテル確認", "ホテル予約", "予約確認", "客室予約", "宿泊詳細", "ホテル領収書", "チェックイン情報", "滞在確認",
        "予約番号", "ホテルバウチャー", "レンタカー確認", "レンタル契約", "車両予約", "受取情報", "車予約", "レンタル領収書",
        "交通予約", "乗車確認", "旅行領収書", "レンタル詳細", "アクティビティ予約", "ツアー確認", "体験予約", "チケット確認",
        "アトラクションチケット", "イベント予約", "ショーチケット", "ミュージアムパス", "ツアーガイド", "アドベンチャー予約",
        "エクスカーション確認"]
) {
    addflag "\\Seen";
    fileinto "Travel";

    if anyof (
        address :domain :matches "from" ["americanairlines.com",
            "*.americanairlines.com", "britishairways.com", "*.britishairways.com",
            "delta.com", "*.delta.com", "emirates.com", "*.emirates.com",
            "lufthansa.com", "*.lufthansa.com", "southwest.com", "*.southwest.com",
            "united.com", "*.united.com"],
        header :contains "subject" ["Flight Confirmation", "Flight Itinerary",
            "Boarding Pass", "Flight Booking", "Airline Ticket", "Flight Receipt",
            "Travel Itinerary", "Airport Check-in", "Flight Details", "E-ticket",
            "Departure Information"]
    ) {
        fileinto "Travel/Flights";

        if allof (
            header :contains "subject" ["Booking Confirmation", "Flight Itinerary",
                "E-ticket Confirmation", "Travel Receipt", "Reservation Confirmed"],
            size :under 1M
        ) {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["airbnb.com", "*.airbnb.com", "booking.com",
            "*.booking.com", "choicehotels.com", "*.choicehotels.com", "expedia.com",
            "*.expedia.com", "hilton.com", "*.hilton.com", "hotels.com", "*.hotels.com",
            "marriott.com", "*.marriott.com", "vrbo.com", "*.vrbo.com",
            "wyndhamhotels.com", "*.wyndhamhotels.com"],
        header :contains "subject" ["Hotel Confirmation", "Hotel Reservation",
            "Booking Confirmed", "Room Reservation", "Accommodation Details",
            "Hotel Receipt", "Check-in Information", "Hotel Booking",
            "Stay Confirmation", "Reservation Number", "Hotel Voucher"]
    ) {
        fileinto "Travel/Hotels";

        if allof (
            header :contains "subject" ["Booking Confirmation",
                "Hotel Reservation Details", "Reservation Confirmed", "Stay Receipt",
                "Hotel Booking"],
            size :under 1M
        ) {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["avis.com", "*.avis.com", "enterprise.com",
            "*.enterprise.com", "hertz.com", "*.hertz.com", "lyft.com", "*.lyft.com",
            "turo.com", "*.turo.com", "uber.com", "*.uber.com", "zipcar.com",
            "*.zipcar.com"],
        header :contains "subject" ["Car Rental Confirmation", "Rental Agreement",
            "Vehicle Reservation", "Pickup Information", "Car Booking",
            "Rental Receipt", "Transportation Booking", "Ride Confirmation",
            "Trip Receipt", "Rental Details"]
    ) {
        fileinto "Travel/Transport";

        if allof (
            header :contains "subject" ["Rental Confirmation", "Car Booking Confirmed",
                "Transportation Receipt", "Ride Receipt", "Trip Summary"],
            size :under 500K
        ) {
            expire "day" "60";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["citypass.com", "*.citypass.com",
            "getyourguide.com", "*.getyourguide.com", "klook.com", "*.klook.com",
            "tiqets.com", "*.tiqets.com", "tripadvisor.com", "*.tripadvisor.com",
            "viator.com", "*.viator.com"],
        header :contains "subject" ["Activity Booking", "Tour Confirmation",
            "Experience Booked", "Ticket Confirmation", "Attraction Tickets",
            "Event Booking", "Show Tickets", "Museum Pass", "Tour Guide",
            "Adventure Booking", "Excursion Confirmed"]
    ) {
        fileinto "Travel/Activities";

        if allof (
            header :contains "subject" ["Activity Confirmed", "Tour Booking",
                "Ticket Purchase", "Experience Receipt", "Activity Voucher"],
            size :under 500K
        ) {
            expire "day" "60";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Travel Deal Alert", "Flash Sale",
            "Limited Time Offer", "Vacation Special", "Flight Deal", "Hotel Discount",
            "Travel Savings", "Exclusive Offer", "Weekend Getaway", "Holiday Package",
            "Last Minute Deal", "Price Drop Alert", "Travel Promo", "Booking Special",
            "Member Discount"],
        header :contains "from" ["deals@", "offers@", "promotions@", "newsletter@"]
    ) {
        fileinto "Travel/Deals";

        if allof (
            header :contains "subject" ["Flash Sale", "Limited Time", "Deal Alert",
                "Price Drop", "Sale Ends", "Last Chance", "24-Hour Sale"],
            size :under 500K
        ) {
            expire "day" "5";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Reminder",
            "Departure Alert", "Arrival Update", "Travel Advisory", "Weather Alert",
            "Security Alert", "Cancellation Notice", "Schedule Change", "Trip Reminder",
            "Boarding Reminder", "Flight Status", "Terminal Change", "Baggage Alert"],
        size :under 200K
    ) {
        fileinto "Travel/Alerts";

        if allof (
            header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Now",
                "Departure Alert", "Boarding", "Last Call", "Emergency Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Rate Your Stay", "Review Your Trip",
            "How Was Your Flight", "Share Your Experience", "Trip Review",
            "Hotel Review", "Travel Feedback", "Review Request", "Trip Survey",
            "Experience Rating", "Service Feedback"],
        header :contains "from" ["review@", "feedback@", "survey@", "experience@"]
    ) {
        fileinto "Travel/Reviews";

        if allof (
            header :contains "subject" ["Rate", "Review", "Feedback", "Survey",
                "Experience"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Top Destinations", "Travel Guide", "Trip Ideas",
            "Destination Spotlight", "Travel Tips", "Best Places to Visit",
            "Travel Inspiration", "Hidden Gems", "Travel Blog", "Destination Review",
            "Travel Trends", "Vacation Ideas", "Travel Newsletter", "Explore",
            "Wanderlust"],
        header :contains "from" ["newsletter@", "blog@", "tips@", "inspiration@"]
    ) {
        fileinto "Travel/Planning";

        if allof (
            header :contains "subject" ["Newsletter", "Weekly", "Monthly", "Guide",
                "Tips", "Ideas", "Inspiration", "Blog"],
            size :under 500K
        ) {
            expire "day" "10";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Account Update", "Password Change",
            "Security Alert", "Profile Update", "Payment Method", "Billing Update",
            "Account Verification", "Two-Factor Authentication", "Login Alert",
            "Account Activity"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Miles Update", "Points Summary", "Elite Status",
            "Loyalty Program", "Rewards Balance", "Member Benefits", "Status Update",
            "Points Earned", "Reward Redemption", "Member Newsletter"],
        size :under 500K
    ) {
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Travel News", "Weekly Update",
            "Monthly Digest", "Travel Trends", "Industry News", "Company Update"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "10";

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

# ====================================================================================
# Study & Education  (install position 12 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["*.ac.jp", "*.ac.uk", "academia.edu",
        "*.academia.edu", "academy.edu", "*.academy.edu", "acm.org", "*.acm.org",
        "adobe.com", "*.adobe.com", "anki.com", "*.anki.com", "artstation.com",
        "*.artstation.com", "autodesk.com", "*.autodesk.com", "babbel.com",
        "*.babbel.com", "blackboard.com", "*.blackboard.com", "brilliant.org",
        "*.brilliant.org", "busuu.com", "*.busuu.com", "cambly.com", "*.cambly.com",
        "cambridge.ac.uk", "*.cambridge.ac.uk", "canvas.com", "*.canvas.com",
        "cengage.com", "*.cengage.com", "cern.ch", "*.cern.ch", "chegg.com",
        "*.chegg.com", "cisco.com", "*.cisco.com", "classdojo.com", "*.classdojo.com",
        "classroom.google.com", "*.classroom.google.com", "codecademy.com",
        "*.codecademy.com", "codepen.io", "*.codepen.io", "codewars.com",
        "*.codewars.com", "college.edu", "*.college.edu", "collegeboard.org",
        "*.collegeboard.org", "comptia.org", "*.comptia.org", "coursehero.com",
        "*.coursehero.com", "coursera.org", "*.coursera.org", "cramfighter.com",
        "*.cramfighter.com", "creativelive.com", "*.creativelive.com", "desmos.com",
        "*.desmos.com", "domestika.org", "*.domestika.org", "drawabox.com",
        "*.drawabox.com", "dribbble.com", "*.dribbble.com", "duolingo.com",
        "*.duolingo.com", "edmodo.com", "*.edmodo.com", "*.edu.au", "*.edu.cn",
        "*.edu.my", "*.edu.sg", "*.edu.tw", "*.edu.vn", "education.gov",
        "*.education.gov", "edx.org", "*.edx.org", "elsevier.com", "*.elsevier.com",
        "epic.com", "epicresearch.org", "*.epicresearch.org", "ets.org", "*.ets.org",
        "exampal.com", "*.exampal.com", "fender.com", "*.fender.com", "flipgrid.com",
        "*.flipgrid.com", "flowkey.com", "*.flowkey.com", "freecodecamp.org",
        "*.freecodecamp.org", "geogebra.org", "*.geogebra.org", "glitch.com",
        "*.glitch.com", "gnomon.edu", "*.gnomon.edu", "hackerrank.com",
        "*.hackerrank.com", "harvard.edu", "*.harvard.edu", "hellotalk.com",
        "*.hellotalk.com", "ibm.com", "*.ibm.com", "ieee.org", "*.ieee.org",
        "institute.edu", "*.institute.edu", "italki.com", "*.italki.com", "jstor.org",
        "*.jstor.org", "kahoot.com", "*.kahoot.com", "kaptest.com", "*.kaptest.com",
        "khanacademy.org", "*.khanacademy.org", "labxchange.org", "*.labxchange.org",
        "leetcode.com", "*.leetcode.com", "lingoda.com", "*.lingoda.com", "lynda.com",
        "*.lynda.com", "magoosh.com", "*.magoosh.com", "manhattanprep.com",
        "*.manhattanprep.com", "masterclass.com", "*.masterclass.com", "mathway.com",
        "*.mathway.com", "mcgraw-hill.com", "*.mcgraw-hill.com", "memrise.com",
        "*.memrise.com", "mendeley.com", "*.mendeley.com", "mit.edu", "*.mit.edu",
        "moodle.org", "*.moodle.org", "musictheory.net", "*.musictheory.net",
        "nasa.gov", "*.nasa.gov", "nature.com", "*.nature.com", "nih.gov", "*.nih.gov",
        "nsf.gov", "*.nsf.gov", "oracle.com", "*.oracle.com", "oxford.ac.uk",
        "*.oxford.ac.uk", "padlet.com", "*.padlet.com", "pearson.com", "*.pearson.com",
        "phet.colorado.edu", "*.phet.colorado.edu", "photomath.com", "*.photomath.com",
        "pluralsight.com", "*.pluralsight.com", "preply.com", "*.preply.com",
        "princetonreview.com", "*.princetonreview.com", "proko.com", "*.proko.com",
        "quizlet.com", "*.quizlet.com", "repl.it", "*.repl.it", "research.org",
        "*.research.org", "researchgate.net", "*.researchgate.net", "rocksmith.com",
        "*.rocksmith.com", "rosettastone.com", "*.rosettastone.com", "salesforce.com",
        "*.salesforce.com", "scholarship.org", "*.scholarship.org", "school.edu",
        "*.school.edu", "schoolism.com", "*.schoolism.com", "schoology.com",
        "*.schoology.com", "science.org", "*.science.org", "seesaw.me", "*.seesaw.me",
        "simply-piano.com", "*.simply-piano.com", "skillshare.com", "*.skillshare.com",
        "sololearn.com", "*.sololearn.com", "speaky.com", "*.speaky.com", "sporcle.com",
        "*.sporcle.com", "springer.com", "*.springer.com", "stanford.edu",
        "*.stanford.edu", "studyblue.com", "*.studyblue.com", "symbolab.com",
        "*.symbolab.com", "tandem.net", "*.tandem.net", "ted.com", "*.ted.com",
        "tenuto.com", "*.tenuto.com", "udacity.com", "*.udacity.com", "udemy.com",
        "*.udemy.com", "university.edu", "*.university.edu", "vmware.com",
        "*.vmware.com", "wiley.com", "*.wiley.com", "wolfram.com", "*.wolfram.com",
        "yousician.com", "*.yousician.com", "zotero.org", "*.zotero.org"],
    header :contains "subject" ["Học tập", "Bài tập về nhà", "Bài kiểm tra", "Khóa học",
        "Giáo trình", "Nghiên cứu", "Luận văn", "Đề tài", "Thí nghiệm",
        "Phòng thí nghiệm", "Môn học", "Chương trình học", "Kỳ thi", "Điểm số",
        "Học kỳ", "Giảng dạy", "Hướng dẫn", "Workshop", "Seminar", "Thực hành", "学习",
        "作业", "考试", "课程", "教材", "研究", "论文", "课题", "实验", "实验室", "学科", "课程表", "期末考试",
        "成绩", "学期", "教学", "指导", "研习班", "讲座", "实践", "勉強", "宿題", "試験", "コース", "教科書", "論文",
        "課題", "実験", "実験室", "科目", "カリキュラム", "期末試験", "成績", "教育", "指導", "ワークショップ", "セミナー",
        "実習"]
) {
    addflag "\\Seen";
    fileinto "Study";

    if anyof (
        address :domain :matches "from" ["codecademy.com", "*.codecademy.com",
            "codewars.com", "*.codewars.com", "freecodecamp.org", "*.freecodecamp.org",
            "hackerrank.com", "*.hackerrank.com", "leetcode.com", "*.leetcode.com"],
        header :contains "subject" ["Coding Tutorial", "Programming Assignment",
            "Learn Python", "Code Review", "Programming Challenge", "Debugging Tips",
            "Software Development", "Coding Bootcamp", "Java Lesson", "C++ Project",
            "JavaScript", "HTML CSS", "Web Development", "Mobile App", "Database",
            "API", "Framework", "Library", "study code", "research programming",
            "assignment code", "leetcode", "hackerrank"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Programming";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["codewars.com", "*.codewars.com",
            "hackerrank.com", "*.hackerrank.com", "leetcode.com", "*.leetcode.com"],
        header :contains "subject" ["Algorithm Problem", "Data Structures",
            "Sorting Algorithm", "Graph Theory", "Algorithm Assignment",
            "Complexity Analysis", "Dynamic Programming", "Algorithm Quiz",
            "Search Algorithm", "Recursion", "Tree Structure", "Hash Table",
            "study algorithm", "research data structures", "assignment recursion",
            "Big O"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Algorithms";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["brilliant.org", "*.brilliant.org",
            "desmos.com", "*.desmos.com", "khanacademy.org", "*.khanacademy.org",
            "mathway.com", "*.mathway.com", "symbolab.com", "*.symbolab.com",
            "wolfram.com", "*.wolfram.com"],
        header :contains "subject" ["Math Problem", "Calculus", "Algebra", "Geometry",
            "Statistics", "Differential Equations", "Linear Algebra", "Math Homework",
            "Probability Theory", "Math Challenge", "Trigonometry", "Number Theory",
            "study math", "research calculus", "assignment algebra", "mathematical"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Mathematics";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org",
            "phet.colorado.edu", "*.phet.colorado.edu"],
        header :contains "subject" ["Physics Experiment", "Quantum Mechanics",
            "Classical Mechanics", "Thermodynamics", "Electromagnetism", "Physics Lab",
            "Relativity Theory", "Wave Physics", "Particle Physics", "Astrophysics",
            "Optics", "Nuclear Physics", "study physics", "research quantum",
            "assignment mechanics", "physical science"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Physics";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org"],
        header :contains "subject" ["Biology Lab", "Genetics", "Cell Biology",
            "Evolution", "Ecology", "Microbiology", "Human Anatomy", "Plant Biology",
            "Biotechnology", "DNA Analysis", "Molecular Biology", "Biochemistry",
            "Physiology", "study biology", "research genetics", "assignment ecology",
            "life science"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Biology";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["labxchange.org", "*.labxchange.org"],
        header :contains "subject" ["Chemistry Reaction", "Organic Chemistry",
            "Inorganic Chemistry", "Chemical Bonding", "Periodic Table", "Lab Safety",
            "Biochemistry", "Analytical Chemistry", "Physical Chemistry",
            "Experiment Results", "Stoichiometry", "study chemistry",
            "research organic", "assignment bonding", "chemical"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Chemistry";

        stop;
    }

    if header :contains "subject" ["History Timeline", "Ancient Civilizations",
        "World War", "Historical Figures", "Revolution", "Medieval History",
        "Modern History", "Cultural Heritage", "Archaeology", "Historical Analysis",
        "Political Science", "study history", "research civilizations",
        "assignment revolution", "historical"] {
        addflag "\\Seen";
        fileinto "Study/History";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["babbel.com", "*.babbel.com", "busuu.com",
            "*.busuu.com", "duolingo.com", "*.duolingo.com", "italki.com",
            "*.italki.com", "lingoda.com", "*.lingoda.com", "memrise.com",
            "*.memrise.com", "rosettastone.com", "*.rosettastone.com"],
        header :contains "subject" ["Language Lesson", "Vocabulary", "Grammar",
            "Conversation Practice", "Language Immersion", "Translation",
            "Pronunciation", "Foreign Language", "Idioms", "Language Certification",
            "TOEFL", "IELTS", "Linguistic", "study language", "research vocabulary",
            "assignment grammar"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Languages";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["creativelive.com", "*.creativelive.com",
            "domestika.org", "*.domestika.org", "drawabox.com", "*.drawabox.com",
            "proko.com", "*.proko.com", "schoolism.com", "*.schoolism.com",
            "skillshare.com", "*.skillshare.com"],
        header :contains "subject" ["Art Tutorial", "Design Principles",
            "Drawing Lesson", "Painting Technique", "Digital Art", "Graphic Design",
            "UI UX Design", "Photography", "3D Modeling", "Animation", "Illustration",
            "Creative Process", "study art", "research design", "assignment drawing"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Art";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["fender.com", "*.fender.com", "flowkey.com",
            "*.flowkey.com", "musictheory.net", "*.musictheory.net", "simply-piano.com",
            "*.simply-piano.com", "yousician.com", "*.yousician.com"],
        header :contains "subject" ["Music Theory", "Piano Lesson", "Guitar Tutorial",
            "Music Composition", "Audio Production", "Music History",
            "Instrument Practice", "Music Technology", "Sound Design",
            "Music Performance", "study music", "research composition",
            "assignment theory"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Music";

        stop;
    }

    if header :contains "subject" ["Business Administration", "Economics", "Finance",
        "Marketing", "Management", "Entrepreneurship", "Business Strategy",
        "Accounting", "Investment", "MBA", "Business Case Study", "study business",
        "research economics", "assignment marketing"] {
        addflag "\\Seen";
        fileinto "Study/Business";

        stop;
    }

    if header :contains "subject" ["Engineering Design", "Mechanical Engineering",
        "Electrical Engineering", "Civil Engineering", "Chemical Engineering",
        "Software Engineering", "Engineering Mathematics", "CAD", "Circuit Design",
        "Structural Analysis", "study engineering", "research design",
        "assignment circuit"] {
        addflag "\\Seen";
        fileinto "Study/Engineering";

        stop;
    }

    if header :contains "subject" ["Medical Studies", "Anatomy", "Physiology",
        "Pharmacology", "Clinical Medicine", "Medical Research", "Health Science",
        "Nursing", "Public Health", "Medical Ethics", "Patient Care",
        "study medicine", "research clinical", "assignment anatomy"] {
        addflag "\\Seen";
        fileinto "Study/Medicine";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["collegeboard.org", "*.collegeboard.org",
            "ets.org", "*.ets.org", "kaptest.com", "*.kaptest.com", "magoosh.com",
            "*.magoosh.com", "princetonreview.com", "*.princetonreview.com"],
        header :contains "subject" ["SAT Prep", "GRE Preparation", "GMAT Study",
            "TOEFL Test", "IELTS Preparation", "ACT Practice", "Test Strategy",
            "Exam Preparation", "Practice Test", "Test Score", "Standardized Test",
            "study test", "research exam", "assignment practice"]
    ) {
        addflag "\\Seen";
        fileinto "Study/TestPrep";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cisco.com", "*.cisco.com",
            "classroom.google.com", "*.classroom.google.com", "comptia.org",
            "*.comptia.org", "salesforce.com", "*.salesforce.com"],
        header :contains "subject" ["Certification Exam", "Professional Certificate",
            "IT Certification", "AWS Certification", "Microsoft Certification",
            "Google Certification", "CompTIA", "Cisco Certification",
            "Project Management", "PMP", "study certification", "research certificate",
            "assignment exam"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Certification";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["academia.edu", "*.academia.edu",
            "elsevier.com", "*.elsevier.com", "jstor.org", "*.jstor.org",
            "mendeley.com", "*.mendeley.com", "nature.com", "*.nature.com",
            "researchgate.net", "*.researchgate.net", "springer.com", "*.springer.com"],
        header :contains "subject" ["Research Paper", "Academic Writing", "Thesis",
            "Dissertation", "Literature Review", "Research Methodology", "Citation",
            "Bibliography", "Peer Review", "Academic Publication", "Journal Article",
            "study research", "research writing", "assignment thesis"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Research";

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cengage.com", "*.cengage.com",
            "mcgraw-hill.com", "*.mcgraw-hill.com", "pearson.com", "*.pearson.com",
            "springer.com", "*.springer.com", "wiley.com", "*.wiley.com"],
        header :contains "subject" ["Textbook", "Reference Book", "Course Book",
            "Study Guide", "Academic Book", "Digital Book", "Ebook", "Required Reading",
            "Course Material", "Study Resources", "study textbook", "research book",
            "assignment reading"]
    ) {
        addflag "\\Seen";
        fileinto "Study/Textbooks";

        stop;
    }

    if header :contains "subject" ["Study", "Learning", "Education", "Academic",
        "Course", "Lesson", "Tutorial", "Lecture", "Assignment", "Homework", "Quiz",
        "Exam", "Grade", "Semester", "Module", "Workshop", "Webinar",
        "study general", "research overview", "assignment general", "educational"] {
        addflag "\\Seen";
        fileinto "Study/General";

        stop;
    }

    stop;
}

# ====================================================================================
# Recruiting & Applications  (install position 11 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["applytojob.com", "*.applytojob.com",
        "ashbyhq.com", "*.ashbyhq.com", "breezy.hr", "*.breezy.hr", "greenhouse.io",
        "*.greenhouse.io", "icims.com", "*.icims.com", "jazzhr.com", "*.jazzhr.com",
        "jobvite.com", "*.jobvite.com", "lever.co", "*.lever.co", "myworkdayjobs.com",
        "*.myworkdayjobs.com", "otta.com", "*.otta.com", "recruitee.com",
        "*.recruitee.com", "smartrecruiters.com", "*.smartrecruiters.com",
        "successfactors.com", "*.successfactors.com", "taleo.net", "*.taleo.net",
        "teamtailor.com", "*.teamtailor.com", "workable.com", "*.workable.com"],
    header :contains "subject" ["Application Received", "Application Update",
        "Interview Invitation", "Interview Scheduled", "Offer Letter",
        "Candidate Assessment", "Take-home Assignment", "Reference Request",
        "Application Status", "Thank You for Applying", "Next Steps"]
) {
    addflag "\\Seen";
    fileinto "Recruiting";

    stop;
}

# ====================================================================================
# Gaming  (install position 10 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["100thieves.com", "*.100thieves.com",
        "11bitstudios.com", "*.11bitstudios.com", "2k.com", "*.2k.com", "4gamer.net",
        "*.4gamer.net", "505games.com", "*.505games.com", "87kgames.com",
        "*.87kgames.com", "abandonware-magazines.org", "*.abandonware-magazines.org",
        "activision.com", "*.activision.com", "allkeyshop.com", "*.allkeyshop.com",
        "amplitude-studios.com", "*.amplitude-studios.com", "aniplex.co.jp",
        "*.aniplex.co.jp", "annapurnainteractive.com", "*.annapurnainteractive.com",
        "app.dealroom.co", "*.app.dealroom.co", "archive.org", "*.archive.org",
        "arimiadev.com", "*.arimiadev.com", "arkane-studios.com",
        "*.arkane-studios.com", "asobostudio.com", "*.asobostudio.com",
        "bandainamco.com", "*.bandainamco.com", "bandainamcoent.com",
        "*.bandainamcoent.com", "battle.net", "*.battle.net", "beamable.com",
        "*.beamable.com", "beamdog.com", "*.beamdog.com", "beebom.com", "*.beebom.com",
        "bethesda.net", "*.bethesda.net", "bioware.com", "*.bioware.com",
        "blizzard.com", "*.blizzard.com", "bloggers.feedspot.com",
        "*.bloggers.feedspot.com", "blooberteam.com", "*.blooberteam.com",
        "builtin.com", "*.builtin.com", "buy-keys.com", "*.buy-keys.com", "capcom.com",
        "*.capcom.com", "cdaction.pl", "*.cdaction.pl", "cdkeys.com", "*.cdkeys.com",
        "cdprojekt.com", "*.cdprojekt.com", "cdprojektred.com", "*.cdprojektred.com",
        "cgmpublishinggroup.com", "*.cgmpublishinggroup.com", "cheapshark.com",
        "*.cheapshark.com", "cloud9.gg", "*.cloud9.gg", "codesupply.co",
        "*.codesupply.co", "coffee-stain.com", "*.coffee-stain.com",
        "criteriongames.com", "*.criteriongames.com", "crustlab.com", "*.crustlab.com",
        "crytek.com", "*.crytek.com", "curvegames.com", "*.curvegames.com",
        "cygames.jp", "*.cygames.jp", "dealroom.co", "*.dealroom.co", "deepsilver.com",
        "*.deepsilver.com", "dengekionline.com", "*.dengekionline.com",
        "destructoid.com", "*.destructoid.com", "devolverdigital.com",
        "*.devolverdigital.com", "dice.se", "*.dice.se", "direct2drive.com",
        "*.direct2drive.com", "dlgamer.com", "*.dlgamer.com",
        "dontnod-entertainment.com", "*.dontnod-entertainment.com", "dreamhack.com",
        "*.dreamhack.com", "dualshockers.com", "*.dualshockers.com", "ea.com",
        "*.ea.com", "edge-online.com", "*.edge-online.com", "egamersworld.com",
        "*.egamersworld.com", "embracer.com", "*.embracer.com", "eneba.com",
        "*.eneba.com", "ennead.cc", "*.ennead.cc", "epicgames.com", "*.epicgames.com",
        "escapistmagazine.com", "*.escapistmagazine.com", "escharts.com",
        "*.escharts.com", "esl.gg", "*.esl.gg", "esportsinsider.com",
        "*.esportsinsider.com", "eurogamer.net", "*.eurogamer.net", "evilgeniuses.gg",
        "*.evilgeniuses.gg", "faceit.com", "*.faceit.com", "famitsu.com",
        "*.famitsu.com", "fanatical.com", "*.fanatical.com", "fatdoggames.com",
        "*.fatdoggames.com", "fatsharkgames.com", "*.fatsharkgames.com", "fazeclan.com",
        "*.fazeclan.com", "fdg-entertainment.com", "*.fdg-entertainment.com",
        "firaxis.com", "*.firaxis.com", "flyingwildhog.com", "*.flyingwildhog.com",
        "fnatic.com", "*.fnatic.com", "focus-home.com", "*.focus-home.com",
        "fromsoftware.jp", "*.fromsoftware.jp", "frontier.co.uk", "*.frontier.co.uk",
        "fungies.io", "*.fungies.io", "g2a.com", "*.g2a.com", "g2esports.com",
        "*.g2esports.com", "gaimingladiators.gg", "*.gaimingladiators.gg",
        "gamedaily.com", "*.gamedaily.com", "gamefaqs.com", "*.gamefaqs.com",
        "gamefly.com", "*.gamefly.com", "gamefront.com", "*.gamefront.com",
        "gameinformer.com", "*.gameinformer.com", "gamepro.com", "*.gamepro.com",
        "gamerant.com", "*.gamerant.com", "gamersgate.com", "*.gamersgate.com",
        "gamesdomain.com", "*.gamesdomain.com", "gamesindustry.biz",
        "*.gamesindustry.biz", "gamesplanet.com", "*.gamesplanet.com", "gamespot.com",
        "*.gamespot.com", "gamesradar.com", "*.gamesradar.com", "gamingmagz.com",
        "*.gamingmagz.com", "gearboxsoftware.com", "*.gearboxsoftware.com",
        "gematsu.com", "*.gematsu.com", "getgamesgo.com", "*.getgamesgo.com",
        "gg.deals", "*.gg.deals", "ghostship.dk", "*.ghostship.dk", "giantbomb.com",
        "*.giantbomb.com", "globalesportsfederation.org",
        "*.globalesportsfederation.org", "gog.com", "*.gog.com", "goodoldgames.com",
        "*.goodoldgames.com", "greenmangaming.com", "*.greenmangaming.com", "gry.wp.pl",
        "*.gry.wp.pl", "hangargames.com", "*.hangargames.com", "hellogames.co.uk",
        "*.hellogames.co.uk", "hoogspel.nl", "*.hoogspel.nl", "hoyoverse.com",
        "*.hoyoverse.com", "humblebundle.com", "*.humblebundle.com", "hypergryph.com",
        "*.hypergryph.com", "idsoftware.com", "*.idsoftware.com", "ign.com",
        "*.ign.com", "indiedb.com", "*.indiedb.com", "indiegala.com", "*.indiegala.com",
        "inven.ai", "*.inven.ai", "itch.io", "*.itch.io", "joblife.gg", "*.joblife.gg",
        "k4g.com", "*.k4g.com", "karminecorp.gg", "*.karminecorp.gg", "kartridge.com",
        "*.kartridge.com", "kinguin.net", "*.kinguin.net", "koi.gg", "*.koi.gg",
        "kojimaproductions.jp", "*.kojimaproductions.jp", "konami.com", "*.konami.com",
        "kotaku.com", "*.kotaku.com", "larian.com", "*.larian.com", "liquipedia.net",
        "*.liquipedia.net", "macgamestore.com", "*.macgamestore.com", "magzter.com",
        "*.magzter.com", "mandatory.gg", "*.mandatory.gg", "mandragoragames.com",
        "*.mandragoragames.com", "manjuu.com", "*.manjuu.com", "mcmbuzz.com",
        "*.mcmbuzz.com", "metacritic.com", "*.metacritic.com", "mihoyo.com",
        "*.mihoyo.com", "mlg.com", "*.mlg.com", "moist.gg", "*.moist.gg", "ndw.jp",
        "*.ndw.jp", "netease.com", "*.netease.com", "newegg.com", "*.newegg.com",
        "ninichimusic.com", "*.ninichimusic.com", "nintendo.com", "*.nintendo.com",
        "nintendolife.com", "*.nintendolife.com", "nomanssky.com", "*.nomanssky.com",
        "noobfeed.com", "*.noobfeed.com", "nrg.gg", "*.nrg.gg", "nrvnqsr.com",
        "*.nrvnqsr.com", "opticgaming.com", "*.opticgaming.com", "origin.com",
        "*.origin.com", "panstudio.com", "*.panstudio.com", "paradoxinteractive.com",
        "*.paradoxinteractive.com", "parivision.gg", "*.parivision.gg", "pcgamer.com",
        "*.pcgamer.com", "peoplecanfly.com", "*.peoplecanfly.com", "plarium.com",
        "*.plarium.com", "playmeter.com", "*.playmeter.com", "playstation.com",
        "*.playstation.com", "pley.gg", "*.pley.gg", "polygon.com", "*.polygon.com",
        "prnews.io", "*.prnews.io", "purexbox.com", "*.purexbox.com", "pushsquare.com",
        "*.pushsquare.com", "quartertothree.com", "*.quartertothree.com", "rawfury.com",
        "*.rawfury.com", "relic.com", "*.relic.com", "repeat.gg", "*.repeat.gg",
        "replaymag.com", "*.replaymag.com", "resetera.com", "*.resetera.com",
        "respawn.com", "*.respawn.com", "retromags.com", "*.retromags.com",
        "revillution.net", "*.revillution.net", "riotgames.com", "*.riotgames.com",
        "rockpapershotgun.com", "*.rockpapershotgun.com", "rockstargames.com",
        "*.rockstargames.com", "sabergames.com", "*.sabergames.com", "sega.com",
        "*.sega.com", "sentinels.gg", "*.sentinels.gg", "shacknews.com",
        "*.shacknews.com", "shop.pixel-magazine.com", "*.shop.pixel-magazine.com",
        "sierragamers.com", "*.sierragamers.com", "siliconera.com", "*.siliconera.com",
        "square-enix-games.com", "*.square-enix-games.com", "steampowered.com",
        "*.steampowered.com", "streamscharts.com", "*.streamscharts.com",
        "supergiantgames.com", "*.supergiantgames.com", "take2games.com",
        "*.take2games.com", "taleworlds.com", "*.taleworlds.com", "team17.com",
        "*.team17.com", "teamliquid.com", "*.teamliquid.com", "techland.net",
        "*.techland.net", "ten.gg", "*.ten.gg", "tencent.com", "*.tencent.com",
        "thatgamecompany.com", "*.thatgamecompany.com", "thegamer.com",
        "*.thegamer.com", "themongolz.gg", "*.themongolz.gg", "thesegalounge.com",
        "*.thesegalounge.com", "thqnordic.com", "*.thqnordic.com", "tinybuild.com",
        "*.tinybuild.com", "tsm.gg", "*.tsm.gg", "turtle-entertainment.com",
        "*.turtle-entertainment.com", "ubisoft.com", "*.ubisoft.com", "udonis.co",
        "*.udonis.co", "valve.com", "*.valve.com", "vbrae.com", "*.vbrae.com",
        "versus-evil.com", "*.versus-evil.com", "vg247.com", "*.vg247.com", "voidu.com",
        "*.voidu.com", "volition-inc.com", "*.volition-inc.com", "wingamestore.com",
        "*.wingamestore.com", "xbox.com", "*.xbox.com", "yostar.com", "*.yostar.com"],
    header :contains "subject" ["Trò chơi mới", "Cập nhật game", "Bản vá lỗi",
        "Sự kiện trong game", "Giảm giá game", "Mua game", "Hóa đơn game",
        "Tin tức game", "Cộng đồng game", "Beta test", "DLC mới", "Tải trước", "游戏更新",
        "补丁下载", "游戏折扣", "预购游戏", "游戏新闻", "社区更新", "测试邀请", "DLC发布", "游戏活动", "购买确认", "游戏收据",
        "开发日记", "ゲームアップデート", "パッチノート", "ゲームセール", "先行予約", "ゲームニュース", "コミュニティ更新",
        "ベータテスト", "DLCリリース", "ゲームイベント", "購入確認", "ゲームレシート", "開発者日記"]
) {
    addflag "\\Seen";
    fileinto "Gaming";

    if allof (
        header :contains "subject" ["Playtest", "Early Access", "Beta Invite",
            "Playtest Invitation", "Early Access Beta", "Test Our Game",
            "You're Invited to Beta", "Beta Program Access", "Join Beta Testing",
            "Exclusive Beta", "Beta Registration", "Try Beta Now"],
        size :under 500K
    ) {
        expire "day" "21";

        stop;
    }

    if header :contains "subject" ["your Steam wishlist is now on sale", "steam sale",
        "Steam Sale Alert", "Epic Deals Now", "Discount on Games",
        "Flash Sale Steam", "Weekly Deals Epic", "Game Discounts Live",
        "Steam Midweek Madness", "Epic Mega Sale", "Holiday Sale Steam",
        "Bundle Deals Now", "Summer Sale", "Winter Sale", "Spring Sale",
        "Autumn Sale", "Epic Games Sale", "Steam Sale Event"] {
        expire "day" "5";

        stop;
    }

    if allof (
        header :contains "subject" ["IGN Daily News", "Gamespot Update",
            "Breaking Gaming News", "IGN Review Roundup", "Gamespot Newsletter",
            "Daily Gaming Digest", "IGN Top Stories", "Gamespot Game Releases",
            "Weekly Gaming Recap", "IGN Insider News", "gaming news", "weekly roundup",
            "latest updates", "breaking gaming", "game newsletter", "daily digest",
            "news alert", "industry news", "esports update", "review roundup",
            "top stories gaming"],
        size :under 500K
    ) {
        expire "day" "2";

        stop;
    }

    if allof (
        header :contains "subject" ["Purchase Confirmation", "Your Game Receipt",
            "Order Invoice", "Digital Purchase Details", "Game Buy Receipt",
            "Transaction Summary", "Your Order Shipped", "Payment Confirmation",
            "Receipt for Game", "Invoice Attached", "Epic Games Receipt",
            "Steam purchase"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Patch Notes", "Hotfix", "Patch Notes Released",
            "Game Update Available", "Version X Patch", "Update Notes Inside",
            "New Patch Details", "Balance Update", "Bug Fix Patch",
            "Maintenance Update", "Hotfix Notes", "Game Version Update",
            "Version Update", "Patch Release Notes", "Server Update"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["New DLC Available", "Expansion Release",
            "DLC Launch Alert", "Add-On Now Live", "Download New DLC",
            "DLC Content Update", "Season Pass DLC", "Free DLC Drop", "Premium DLC Out",
            "Story DLC Released"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["live event", "Upcoming Game Event",
            "Event Registration Open", "Join Our Event", "Live Event Alert",
            "Gaming Expo Invite", "In-Game Event", "Community Event",
            "Tournament Announcement", "Webinar on Games", "Special Event Details",
            "holiday event", "limited event"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    if allof (
        header :contains "subject" ["Available on Steam", "Pre-Order Reminder",
            "Your Pre-Order Update", "Pre-Order Now Live", "Secure Your Pre-Order",
            "Pre-Order Bonus Alert", "Reminder: Pre-Order Ends",
            "Game Pre-Order Details", "Early Pre-Order Access",
            "Pre-Order Confirmation", "Don't Miss Pre-Order"],
        size :under 500K
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Community Newsletter", "Insider Community Update",
            "Forum Update Alert", "Player Community News", "Dev Community Post",
            "Weekly Community Recap", "Community Feedback Update",
            "Server Community News", "Guild Update", "Fan Community Digest",
            "Dev Community Insights", "Community Engagement News", "Dev Diary",
            "Community Spotlight", "Player Community Highlights"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    stop;
}

# ====================================================================================
# Entertainment  (install position 9 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["500px.com", "*.500px.com", "8tracks.com",
        "*.8tracks.com", "abc.net.au", "*.abc.net.au", "accesshollywood.com",
        "*.accesshollywood.com", "allarts.org", "*.allarts.org", "allmusic.com",
        "*.allmusic.com", "anchor.fm", "*.anchor.fm", "animelab.com", "*.animelab.com",
        "appletv.com", "*.appletv.com", "audible.com", "*.audible.com", "audioboom.com",
        "*.audioboom.com", "bandcamp.com", "*.bandcamp.com", "bandsintown.com",
        "*.bandsintown.com", "bbc.co.uk", "*.bbc.co.uk", "bbc.com", "*.bbc.com",
        "bilibili.com", "*.bilibili.com", "bilibili.tv", "*.bilibili.tv", "bookbub.com",
        "*.bookbub.com", "brownpapertickets.com", "*.brownpapertickets.com",
        "buzzsprout.com", "*.buzzsprout.com", "castbox.fm", "*.castbox.fm", "castro.fm",
        "*.castro.fm", "cbc.ca", "*.cbc.ca", "channel4.com", "*.channel4.com",
        "comixology.com", "*.comixology.com", "crackle.com", "*.crackle.com",
        "crave.ca", "*.crave.ca", "criterionchannel.com", "*.criterionchannel.com",
        "crunchyroll.com", "*.crunchyroll.com", "darkhorse.com", "*.darkhorse.com",
        "dazn.com", "*.dazn.com", "dccomics.com", "*.dccomics.com", "deadline.com",
        "*.deadline.com", "deezer.com", "*.deezer.com", "deviantart.com",
        "*.deviantart.com", "directv.com", "*.directv.com", "discogs.com",
        "*.discogs.com", "discoveryplus.com", "*.discoveryplus.com", "disneyplus.com",
        "*.disneyplus.com", "entertainment.com", "*.entertainment.com", "etonline.com",
        "*.etonline.com", "eventbrite.com", "*.eventbrite.com", "ew.com", "*.ew.com",
        "extratv.com", "*.extratv.com", "fanart.tv", "*.fanart.tv", "fandom.com",
        "*.fandom.com", "fearless.li", "*.fearless.li", "flickr.com", "*.flickr.com",
        "freesound.org", "*.freesound.org", "fubotv.com", "*.fubotv.com",
        "funimation.com", "*.funimation.com", "goodreads.com", "*.goodreads.com",
        "hollywoodreporter.com", "*.hollywoodreporter.com", "hotstar.com",
        "*.hotstar.com", "hulu.com", "*.hulu.com", "iheartradio.com",
        "*.iheartradio.com", "imagecomics.com", "*.imagecomics.com", "imdb.com",
        "*.imdb.com", "iqiyi.com", "*.iqiyi.com", "itv.com", "*.itv.com", "jamendo.com",
        "*.jamendo.com", "justwatch.com", "*.justwatch.com", "kanopy.com",
        "*.kanopy.com", "kidoodle.tv", "*.kidoodle.tv", "kindle.com", "*.kindle.com",
        "kobo.com", "*.kobo.com", "last.fm", "*.last.fm", "letterboxd.com",
        "*.letterboxd.com", "librivox.org", "*.librivox.org", "libsyn.com",
        "*.libsyn.com", "listnr.com", "*.listnr.com", "marvel.com", "*.marvel.com",
        "max.com", "*.max.com", "mixcloud.com", "*.mixcloud.com", "music.youtube.com",
        "*.music.youtube.com", "musicbrainz.org", "*.musicbrainz.org", "netflix.com",
        "*.netflix.com", "now.com", "*.now.com", "npr.org", "*.npr.org",
        "okmagazine.com", "*.okmagazine.com", "overcast.fm", "*.overcast.fm",
        "pandora.com", "*.pandora.com", "paramount.com", "*.paramount.com",
        "paramountplus.com", "*.paramountplus.com", "peacocktv.com", "*.peacocktv.com",
        "people.com", "*.people.com", "pexels.com", "*.pexels.com", "pitchfork.com",
        "*.pitchfork.com", "pixabay.com", "*.pixabay.com", "pluto.tv", "*.pluto.tv",
        "pocketcasts.com", "*.pocketcasts.com", "podbean.com", "*.podbean.com",
        "popcornflix.com", "*.popcornflix.com", "primevideo.com", "*.primevideo.com",
        "qobuz.com", "*.qobuz.com", "quora.com", "*.quora.com", "radio.com",
        "*.radio.com", "radiotime.com", "*.radiotime.com", "rateyourmusic.com",
        "*.rateyourmusic.com", "reddit.com", "*.reddit.com", "reelgood.com",
        "*.reelgood.com", "rottentomatoes.com", "*.rottentomatoes.com", "rte.ie",
        "*.rte.ie", "scribd.com", "*.scribd.com", "scrobbles.fm", "*.scrobbles.fm",
        "seatgeek.com", "*.seatgeek.com", "setlist.fm", "*.setlist.fm", "showclix.com",
        "*.showclix.com", "shudder.com", "*.shudder.com", "simkl.com", "*.simkl.com",
        "sky.com", "*.sky.com", "sling.com", "*.sling.com", "songkick.com",
        "*.songkick.com", "soundcloud.com", "*.soundcloud.com", "spotify.com",
        "*.spotify.com", "spreaker.com", "*.spreaker.com", "stackexchange.com",
        "*.stackexchange.com", "starz.com", "*.starz.com", "stitcher.com",
        "*.stitcher.com", "themoviedb.org", "*.themoviedb.org", "ticketfly.com",
        "*.ticketfly.com", "ticketweb.com", "*.ticketweb.com", "tidal.com",
        "*.tidal.com", "tmz.com", "*.tmz.com", "trakt.tv", "*.trakt.tv", "tubitv.com",
        "*.tubitv.com", "tunein.com", "*.tunein.com", "tv.com", "*.tv.com",
        "tvtime.com", "*.tvtime.com", "tvtropes.org", "*.tvtropes.org", "universe.com",
        "*.universe.com", "unsplash.com", "*.unsplash.com", "usweekly.com",
        "*.usweekly.com", "variety.com", "*.variety.com", "viki.com", "*.viki.com",
        "viu.com", "*.viu.com", "vivid.com", "*.vivid.com", "vudu.com", "*.vudu.com",
        "wakanim.com", "*.wakanim.com", "wikia.com", "*.wikia.com", "youku.com",
        "*.youku.com", "youtube.com", "*.youtube.com"],
    header :contains "subject" ["Phim mới", "Tập mới", "Chương trình TV", "Âm nhạc mới",
        "Album mới", "Podcast mới", "Sách mới", "Truyện tranh", "Sự kiện trực tiếp",
        "Vé concert", "Đánh giá phim", "Tin giải trí", "Khuyến mãi đặc biệt",
        "Ưu đãi có thời hạn", "Miễn phí thử", "Hóa đơn thuê bao",
        "Thông báo thanh toán", "Phát trực tiếp", "Sự kiện âm nhạc", "Festival phim",
        "新电影", "新剧集", "电视节目", "新音乐", "新专辑", "新播客", "新书推荐", "漫画更新", "现场活动", "音乐会门票",
        "影评", "娱乐新闻", "特别优惠", "限时折扣", "免费试用", "订阅账单", "付款确认", "直播提醒", "音乐节", "电影节",
        "新作映画", "新エピソード", "テレビ番組", "新しい音楽", "新アルバム", "新しいポッドキャスト", "新刊書籍", "マンガ更新",
        "ライブイベント", "コンサートチケット", "映画レビュー", "エンターテインメントニュース", "特別オファー", "期間限定割引",
        "無料トライアル", "サブスクリプション請求書", "支払い確認", "ライブ配信", "音楽フェスティバル", "映画祭"]
) {
    addflag "\\Seen";
    fileinto "Entertainment/General";

    if anyof (
        address :domain :matches "from" ["crunchyroll.com", "*.crunchyroll.com",
            "disneyplus.com", "*.disneyplus.com", "hulu.com", "*.hulu.com", "max.com",
            "*.max.com", "netflix.com", "*.netflix.com", "paramount.com",
            "*.paramount.com", "primevideo.com", "*.primevideo.com"],
        header :contains "subject" ["New Movie", "TV Series", "Episode Available",
            "Season Finale", "Movie Recommendation", "Watch Now", "Streaming Alert",
            "Movie Release", "TV Show Update", "Binge Watch", "Movie Night",
            "Series Premiere", "Film Festival", "Documentary", "Movie Trailer",
            "TV Guide"]
    ) {
        fileinto "Entertainment/Movies-TV";

        if allof (
            header :contains "subject" ["New Release Alert", "Watch This Now",
                "Recommended for You", "New Episode Available", "Movie Recommendation",
                "Top Picks This Week", "Personalized Recommendations", "Just Added",
                "Coming Soon"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bandcamp.com", "*.bandcamp.com", "deezer.com",
            "*.deezer.com", "pandora.com", "*.pandora.com", "soundcloud.com",
            "*.soundcloud.com", "spotify.com", "*.spotify.com", "tidal.com",
            "*.tidal.com"],
        header :contains "subject" ["New Album", "Playlist Update",
            "Track Recommendation", "Music Discovery", "Artist Alert",
            "Concert Tickets", "Music Release", "Spotify Wrapped", "Your Mix",
            "Release Radar", "Discover Weekly", "Concert Alert", "Tour Dates",
            "Music Festival", "Album Review"]
    ) {
        fileinto "Entertainment/Music";

        if allof (
            header :contains "subject" ["New Track Dropped", "Album Release",
                "Playlist Update", "Music Recommendation", "Artist Update",
                "Release Alert", "New Music Friday"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["anchor.fm", "*.anchor.fm", "audible.com",
            "*.audible.com", "castbox.fm", "*.castbox.fm", "overcast.fm",
            "*.overcast.fm", "spotify.com", "*.spotify.com", "stitcher.com",
            "*.stitcher.com"],
        header :contains "subject" ["New Podcast", "Episode Released",
            "Podcast Recommendation", "Audio Update", "Podcast Alert", "Listen Now",
            "Podcast Series", "Audio Drama", "Talk Show", "Interview", "Audiobook"]
    ) {
        fileinto "Entertainment/Podcasts";

        if allof (
            header :contains "subject" ["New Episode", "Episode Available",
                "Latest Episode", "Podcast Update", "Episode Alert", "New Chapter",
                "Audio Available"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["audible.com", "*.audible.com", "bookbub.com",
            "*.bookbub.com", "goodreads.com", "*.goodreads.com", "kindle.com",
            "*.kindle.com", "kobo.com", "*.kobo.com", "scribd.com", "*.scribd.com"],
        header :contains "subject" ["Book Recommendation", "New Release",
            "Reading List", "Book Review", "Author Alert", "Book Club",
            "Reading Challenge", "Bestseller", "Book Deal", "Pre-order", "Kindle Deal",
            "Free Book"]
    ) {
        fileinto "Entertainment/Books";

        if allof (
            header :contains "subject" ["Book Deal", "Free Book", "Discount Alert",
                "Limited Time Offer", "Book Sale", "Reading Recommendation"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["comixology.com", "*.comixology.com",
            "darkhorse.com", "*.darkhorse.com", "dccomics.com", "*.dccomics.com",
            "imagecomics.com", "*.imagecomics.com", "marvel.com", "*.marvel.com"],
        header :contains "subject" ["New Comic", "Comic Release", "Graphic Novel",
            "Marvel Comics", "DC Comics", "Comic Book", "Superhero", "Manga Update",
            "Comic Review", "Comic Convention", "Artist Spotlight"]
    ) {
        fileinto "Entertainment/Comics";

        if allof (
            header :contains "subject" ["New Issue", "Comic Release", "Issue Available",
                "Series Update", "Comic Alert", "New Chapter"],
            size :under 500K
        ) {
            expire "day" "10";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bandsintown.com", "*.bandsintown.com",
            "eventbrite.com", "*.eventbrite.com", "seatgeek.com", "*.seatgeek.com",
            "songkick.com", "*.songkick.com"],
        header :contains "subject" ["Concert Tickets", "Event Alert", "Show Tickets",
            "Live Performance", "Festival Tickets", "Theater Show", "Comedy Show",
            "Ticket Sale", "Event Reminder", "Show Information", "Venue Alert"]
    ) {
        fileinto "Entertainment/Events";

        if allof (
            header :contains "subject" ["Event Reminder", "Show Tonight", "Last Chance",
                "Event Starting", "Live Now", "Doors Open", "Show Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["hollywoodreporter.com",
            "*.hollywoodreporter.com", "imdb.com", "*.imdb.com", "pitchfork.com",
            "*.pitchfork.com", "rottentomatoes.com", "*.rottentomatoes.com",
            "variety.com", "*.variety.com"],
        header :contains "subject" ["Movie Review", "Album Review", "Book Review",
            "Show Review", "Critics Pick", "Review Roundup", "Rating Update",
            "Score Alert", "Review Digest", "Critical Consensus", "Expert Review"]
    ) {
        fileinto "Entertainment/Reviews";

        if allof (
            header :contains "subject" ["Review", "Rating", "Score", "Critics",
                "Analysis"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["accesshollywood.com", "*.accesshollywood.com",
            "deadline.com", "*.deadline.com", "ew.com", "*.ew.com", "people.com",
            "*.people.com", "tmz.com", "*.tmz.com", "variety.com", "*.variety.com"],
        header :contains "subject" ["Entertainment News", "Celebrity News",
            "Hollywood Update", "Breaking Entertainment", "Industry News",
            "Show Business", "Celebrity Gossip", "Red Carpet", "Award Show",
            "Film Festival", "TV News"]
    ) {
        fileinto "Entertainment/News";

        if allof (
            header :contains "subject" ["News", "Update", "Breaking", "Alert", "Report"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Billing Statement", "Subscription Invoice",
            "Payment Confirmation", "Renewal Notice", "Account Charged", "Monthly Bill",
            "Receipt for Subscription", "Payment Due", "Invoice Attached",
            "Transaction Summary"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Live Stream Starting", "Event Reminder",
            "Concert Alert", "Premiere Live", "Watch Party Invite", "Live Podcast",
            "Stream Notification", "Upcoming Live", "Real-Time Update",
            "Broadcast Alert"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Special Offer", "Limited Time", "Discount",
            "Free Trial", "Promo Code", "Sale Alert", "Deal of the Day", "Flash Sale",
            "Member Exclusive"],
        size :under 500K
    ) {
        expire "day" "5";

        stop;
    }

    stop;
}

# ====================================================================================
# News & Newsletters  (install position 8 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["9to5mac.com", "*.9to5mac.com", "abcnews.com",
        "*.abcnews.com", "accuweather.com", "*.accuweather.com", "aljazeera.com",
        "*.aljazeera.com", "androidpolice.com", "*.androidpolice.com", "ansa.it",
        "*.ansa.it", "apnews.com", "*.apnews.com", "arstechnica.com",
        "*.arstechnica.com", "athleticnews.com", "*.athleticnews.com", "avclub.com",
        "*.avclub.com", "axios.com", "*.axios.com", "ballotpedia.org",
        "*.ballotpedia.org", "barrons.com", "*.barrons.com", "beehiiv.com",
        "*.beehiiv.com", "bleacherreport.com", "*.bleacherreport.com", "bloomberg.com",
        "*.bloomberg.com", "bostonglobe.com", "*.bostonglobe.com", "breitbart.com",
        "*.breitbart.com", "businessinsider.com", "*.businessinsider.com",
        "buzzfeed.com", "*.buzzfeed.com", "c4isrnet.com", "*.c4isrnet.com",
        "campaignmonitor.com", "*.campaignmonitor.com", "cbsnews.com", "*.cbsnews.com",
        "cbssports.com", "*.cbssports.com", "cdc.gov", "*.cdc.gov",
        "chicagotribune.com", "*.chicagotribune.com", "cleveland.com",
        "*.cleveland.com", "cnbc.com", "*.cnbc.com", "cnet.com", "*.cnet.com",
        "cnn.com", "*.cnn.com", "constantcontact.com", "*.constantcontact.com",
        "convertkit.com", "*.convertkit.com", "cookpolitical.com",
        "*.cookpolitical.com", "cyberscoop.com", "*.cyberscoop.com", "dailykos.com",
        "*.dailykos.com", "dailywire.com", "*.dailywire.com", "dallasnews.com",
        "*.dallasnews.com", "defensenews.com", "*.defensenews.com", "denverpost.com",
        "*.denverpost.com", "dw.com", "*.dw.com", "economist.com", "*.economist.com",
        "engadget.com", "*.engadget.com", "espn.com", "*.espn.com", "fastcompany.com",
        "*.fastcompany.com", "federalnewsnetwork.com", "*.federalnewsnetwork.com",
        "firetimes.com", "*.firetimes.com", "fool.com", "*.fool.com", "forbes.com",
        "*.forbes.com", "fortune.com", "*.fortune.com", "foxnews.com", "*.foxnews.com",
        "foxsports.com", "*.foxsports.com", "france24.com", "*.france24.com", "ft.com",
        "*.ft.com", "getpocket.com", "*.getpocket.com", "ghost.org", "*.ghost.org",
        "gizmodo.com", "*.gizmodo.com", "govtech.com", "*.govtech.com", "harpers.org",
        "*.harpers.org", "houstonchronicle.com", "*.houstonchronicle.com",
        "huffpost.com", "*.huffpost.com", "inc.com", "*.inc.com", "jacobinmag.com",
        "*.jacobinmag.com", "kyodonews.net", "*.kyodonews.net", "latimes.com",
        "*.latimes.com", "livescience.com", "*.livescience.com", "mailchimp.com",
        "*.mailchimp.com", "marketwatch.com", "*.marketwatch.com", "mashable.com",
        "*.mashable.com", "medium.com", "*.medium.com", "miamiherald.com",
        "*.miamiherald.com", "militarytimes.com", "*.militarytimes.com", "money.com",
        "*.money.com", "motherjones.com", "*.motherjones.com", "msnbc.com",
        "*.msnbc.com", "nationaljournal.com", "*.nationaljournal.com",
        "nationalreview.com", "*.nationalreview.com", "nbcnews.com", "*.nbcnews.com",
        "nbcsports.com", "*.nbcsports.com", "newrepublic.com", "*.newrepublic.com",
        "newscientist.com", "*.newscientist.com", "newsletter.com", "*.newsletter.com",
        "newyorker.com", "*.newyorker.com", "noaa.gov", "*.noaa.gov", "nola.com",
        "*.nola.com", "nws.noaa.gov", "*.nws.noaa.gov", "nypost.com", "*.nypost.com",
        "nytimes.com", "*.nytimes.com", "oregonlive.com", "*.oregonlive.com", "pbs.org",
        "*.pbs.org", "policyone.com", "*.policyone.com", "politico.com",
        "*.politico.com", "pri.org", "*.pri.org", "propublica.org", "*.propublica.org",
        "quartz.com", "*.quartz.com", "reason.com", "*.reason.com", "redstate.com",
        "*.redstate.com", "reuters.com", "*.reuters.com", "revealnews.org",
        "*.revealnews.org", "rollcall.com", "*.rollcall.com", "rollingstone.com",
        "*.rollingstone.com", "rt.com", "*.rt.com", "salon.com", "*.salon.com",
        "sbnation.com", "*.sbnation.com", "sciencedaily.com", "*.sciencedaily.com",
        "sciencemag.org", "*.sciencemag.org", "scientificamerican.com",
        "*.scientificamerican.com", "seattletimes.com", "*.seattletimes.com",
        "sfgate.com", "*.sfgate.com", "si.com", "*.si.com", "skysports.com",
        "*.skysports.com", "slate.com", "*.slate.com", "space.com", "*.space.com",
        "sputniknews.com", "*.sputniknews.com", "substack.com", "*.substack.com",
        "tass.com", "*.tass.com", "techcrunch.com", "*.techcrunch.com", "techradar.com",
        "*.techradar.com", "theathletic.com", "*.theathletic.com", "theatlantic.com",
        "*.theatlantic.com", "thedailybeast.com", "*.thedailybeast.com",
        "theguardian.com", "*.theguardian.com", "thehill.com", "*.thehill.com",
        "theintercept.com", "*.theintercept.com", "thenation.com", "*.thenation.com",
        "theregister.com", "*.theregister.com", "theringer.com", "*.theringer.com",
        "theverge.com", "*.theverge.com", "townhall.com", "*.townhall.com",
        "usatoday.com", "*.usatoday.com", "usnews.com", "*.usnews.com",
        "venturebeat.com", "*.venturebeat.com", "vox.com", "*.vox.com", "vulture.com",
        "*.vulture.com", "washingtonpost.com", "*.washingtonpost.com", "weather.com",
        "*.weather.com", "weatherchannel.com", "*.weatherchannel.com", "who.int",
        "*.who.int", "wired.com", "*.wired.com", "wsj.com", "*.wsj.com",
        "xinhuanet.com", "*.xinhuanet.com", "yahoo.com", "*.yahoo.com",
        "yonhapnews.co.kr", "*.yonhapnews.co.kr", "zdnet.com", "*.zdnet.com"],
    header :contains "subject" ["Tin tức mới nhất", "Báo cáo đặc biệt",
        "Thông tin nóng", "Cập nhật chính trị", "Tin kinh tế", "Tin thể thao",
        "Tin khoa học", "Tin quốc tế", "Tin giải trí", "Cảnh báo thời tiết",
        "Phân tích chuyên sâu", "Tin khẩn cấp", "Bản tin hàng ngày", "Tóm tắt tin tức",
        "Điểm tin", "Thông báo chính phủ", "Tin thị trường", "Tin công nghệ",
        "Tin y tế", "Tin môi trường", "最新新闻", "突发新闻", "政治新闻", "经济报道", "体育新闻", "科技资讯",
        "国际新闻", "娱乐新闻", "天气预警", "深度分析", "紧急通知", "每日简报", "新闻摘要", "头条新闻", "政府通告", "市场报告",
        "科学发现", "医疗突破", "环境新闻", "文化活动", "最新ニュース", "速報ニュース", "政治ニュース", "経済報告",
        "スポーツニュース", "科学技術ニュース", "国際ニュース", "エンターテインメントニュース", "気象警報", "詳細分析", "緊急通知",
        "デイリーブリーフィング", "ニュース要約", "トップストーリー", "政府発表", "市場レポート", "科学的発見", "医学的進歩",
        "環境ニュース", "文化イベント"]
) {
    addflag "\\Seen";
    fileinto "News";

    if anyof (
        address :domain :matches "from" ["ballotpedia.org", "*.ballotpedia.org",
            "cookpolitical.com", "*.cookpolitical.com", "nationaljournal.com",
            "*.nationaljournal.com", "politico.com", "*.politico.com", "rollcall.com",
            "*.rollcall.com", "thehill.com", "*.thehill.com"],
        header :contains "subject" ["Election Update", "Policy News",
            "Government Alert", "Politics Recap", "Bill Passed", "Debate Highlights",
            "Political Analysis", "Campaign News", "Congress Update",
            "White House Briefing", "Senate Vote", "House Committee", "Supreme Court",
            "Federal Court", "Political Poll", "Voting Rights", "Democracy Report",
            "Legislative Update"]
    ) {
        fileinto "News/Politics";

        if allof (
            header :contains "subject" ["Breaking Political", "Election Results",
                "Vote Count", "Political Breaking", "Congress Votes",
                "Supreme Court Ruling"],
            size :under 500K
        ) {
            expire "day" "2";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["9to5mac.com", "*.9to5mac.com",
            "arstechnica.com", "*.arstechnica.com", "engadget.com", "*.engadget.com",
            "gizmodo.com", "*.gizmodo.com", "techcrunch.com", "*.techcrunch.com",
            "theverge.com", "*.theverge.com", "wired.com", "*.wired.com"],
        header :contains "subject" ["Tech News", "Gadget Review", "AI Breakthrough",
            "Software Update", "Cybersecurity Alert", "Innovation Report",
            "Tech Trends", "Startup News", "Device Launch", "Digital Transformation",
            "Silicon Valley", "Apple News", "Google Update", "Microsoft Announcement",
            "Tesla News", "Cryptocurrency", "Bitcoin Update", "Blockchain News",
            "NFT Alert"]
    ) {
        fileinto "News/Tech";

        if allof (
            header :contains "subject" ["Product Launch", "New iPhone",
                "Android Update", "Software Release", "App Update", "Device Review",
                "Gadget Announcement"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bloomberg.com", "*.bloomberg.com",
            "businessinsider.com", "*.businessinsider.com", "cnbc.com", "*.cnbc.com",
            "fortune.com", "*.fortune.com", "marketwatch.com", "*.marketwatch.com",
            "wsj.com", "*.wsj.com"],
        header :contains "subject" ["Market Report", "Stock News", "Economy Forecast",
            "Business Merger", "Financial Analysis", "Corporate Earnings",
            "Industry Update", "Trade News", "Investment Tips", "CEO Interview",
            "IPO News", "Acquisition Alert", "Quarterly Report", "Market Close",
            "Dow Jones", "S&P 500", "NASDAQ Update", "Federal Reserve",
            "Interest Rates", "Inflation Report", "GDP Growth"]
    ) {
        fileinto "News/Business";

        if allof (
            header :contains "subject" ["Market Close", "Daily Market", "Stock Report",
                "Market Summary", "Trading Update", "Market Recap"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bleacherreport.com", "*.bleacherreport.com",
            "cbssports.com", "*.cbssports.com", "espn.com", "*.espn.com",
            "foxsports.com", "*.foxsports.com", "nbcsports.com", "*.nbcsports.com",
            "si.com", "*.si.com"],
        header :contains "subject" ["Game Recap", "Sports Highlights", "Match Results",
            "Player Trade", "Tournament Update", "Team News", "Athlete Profile",
            "Score Alert", "League Standings", "Championship Preview", "Draft News",
            "Injury Report", "Season Recap", "Playoff Update", "World Cup", "Olympics",
            "Super Bowl", "World Series", "NBA Finals", "Stanley Cup"]
    ) {
        fileinto "News/Sports";

        if allof (
            header :contains "subject" ["Score Alert", "Live Score", "Game Update",
                "Final Score", "Breaking Sports", "Injury Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cdc.gov", "*.cdc.gov", "newscientist.com",
            "*.newscientist.com", "sciencedaily.com", "*.sciencedaily.com",
            "scientificamerican.com", "*.scientificamerican.com", "who.int",
            "*.who.int"],
        header :contains "subject" ["Scientific Discovery", "Research Findings",
            "Space News", "Climate Study", "Medical Breakthrough", "Tech in Science",
            "Environmental Report", "Biology Update", "Physics Experiment",
            "Astronomy Alert", "NASA Mission", "Health Study", "Vaccine News",
            "Pandemic Update", "Disease Alert", "Drug Trial", "Climate Change",
            "Global Warming", "Renewable Energy", "Conservation News"]
    ) {
        fileinto "News/Science";

        if allof (
            header :contains "subject" ["Health Alert", "Disease Outbreak",
                "Vaccine Update", "Medical Emergency", "Public Health", "FDA Warning"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["aljazeera.com", "*.aljazeera.com",
            "apnews.com", "*.apnews.com", "dw.com", "*.dw.com", "france24.com",
            "*.france24.com", "reuters.com", "*.reuters.com"],
        header :contains "subject" ["International News", "Global Events",
            "World Affairs", "Foreign Policy", "Crisis Update", "Diplomatic Relations",
            "Geopolitical Analysis", "UN Report", "Regional Conflict",
            "Human Rights News", "War Update", "Peace Treaty", "Embassy News",
            "Trade War", "Sanctions News", "Refugee Crisis", "Natural Disaster",
            "Earthquake Alert", "Hurricane Update", "Tsunami Warning"]
    ) {
        fileinto "News/World";

        if allof (
            header :contains "subject" ["Breaking International", "Global Breaking",
                "World Breaking", "Crisis Alert", "Emergency Update"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["rollingstone.com", "*.rollingstone.com"],
        header :contains "subject" ["Celebrity News", "Movie Review", "Music News",
            "TV Show Update", "Award Show", "Red Carpet", "Hollywood News",
            "Concert Review", "Book Review", "Art Exhibition", "Cultural Event",
            "Festival News", "Grammy Awards", "Oscar News", "Emmy Update",
            "Golden Globes", "Cannes Festival", "Comic-Con"]
    ) {
        fileinto "News/Entertainment";

        if allof (
            header :contains "subject" ["Celebrity Gossip", "Star Spotted",
                "Dating News", "Breakup Alert", "Wedding News", "Baby News",
                "Social Media Drama"],
            size :under 500K
        ) {
            expire "day" "2";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["accuweather.com", "*.accuweather.com",
            "noaa.gov", "*.noaa.gov", "nws.noaa.gov", "*.nws.noaa.gov", "weather.com",
            "*.weather.com", "weatherchannel.com", "*.weatherchannel.com"],
        header :contains "subject" ["Weather Alert", "Storm Warning",
            "Hurricane Update", "Tornado Watch", "Flood Warning", "Drought Alert",
            "Heat Wave", "Cold Snap", "Blizzard Warning", "Severe Weather",
            "Climate Report", "Environmental News"]
    ) {
        fileinto "News/Weather";

        if allof (
            header :contains "subject" ["Weather Alert", "Storm Warning",
                "Weather Emergency"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Breaking News", "Urgent Alert", "Flash Update",
            "Live Coverage", "Developing Story", "News Alert", "Immediate Update",
            "Hot Off the Press", "Real-Time News", "Emergency Broadcast"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Daily News Digest", "Morning Briefing",
            "Evening Recap", "Headline Summary", "Top Stories Today", "News Roundup",
            "Daily Update", "Newsletter Edition", "Breaking News Summary",
            "Quick Reads"],
        size :under 500K
    ) {
        expire "day" "2";

        stop;
    }

    if allof (
        header :contains "subject" ["In-Depth Report", "Feature Story",
            "Investigative Piece", "Long-Form Analysis", "Opinion Column",
            "Expert Commentary", "Deep Dive", "Special Report", "Backgrounder",
            "Explainer Article"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "3";

    stop;
}

# ====================================================================================
# Social Media  (install position 7 of 22)
# ====================================================================================

if address :domain :matches "from" ["faceb00k.com", "*.faceb00k.com", "lnkedin.com",
    "*.lnkedin.com", "twiter.com", "*.twiter.com", "youutube.com", "*.youutube.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if anyof (
    address :domain :matches "from" ["17.live", "*.17.live", "air.chat", "*.air.chat",
        "ameba.jp", "*.ameba.jp", "askfm.com", "*.askfm.com", "badoo.com",
        "*.badoo.com", "beeper.com", "*.beeper.com", "behance.net", "*.behance.net",
        "bere.al", "*.bere.al", "bigo.tv", "*.bigo.tv", "blogger.com", "*.blogger.com",
        "briarproject.org", "*.briarproject.org", "bsky.social", "*.bsky.social",
        "bumble.com", "*.bumble.com", "careerbuilder.com", "*.careerbuilder.com",
        "clubhouse.com", "*.clubhouse.com", "coverstar.com", "*.coverstar.com",
        "curse.com", "*.curse.com", "cyworld.com", "*.cyworld.com", "digg.com",
        "*.digg.com", "dingtalk.com", "*.dingtalk.com", "discord.com", "*.discord.com",
        "dispo.fun", "*.dispo.fun", "douyin.com", "*.douyin.com", "eharmony.com",
        "*.eharmony.com", "element.io", "*.element.io", "facebook.com",
        "*.facebook.com", "feishu.cn", "*.feishu.cn", "fiverr.com", "*.fiverr.com",
        "freelancer.com", "*.freelancer.com", "friendster.com", "*.friendster.com",
        "getsession.org", "*.getsession.org", "giphy.com", "*.giphy.com",
        "glassdoor.com", "*.glassdoor.com", "gree.jp", "*.gree.jp", "guilded.gg",
        "*.guilded.gg", "guru.com", "*.guru.com", "hackernews.com", "*.hackernews.com",
        "hi5.com", "*.hi5.com", "hinge.co", "*.hinge.co", "imgur.com", "*.imgur.com",
        "indeed.com", "*.indeed.com", "instagram.com", "*.instagram.com", "jagat.io",
        "*.jagat.io", "kakao.com", "*.kakao.com", "kick.com", "*.kick.com", "lapse.com",
        "*.lapse.com", "lark.com", "*.lark.com", "line.me", "*.line.me", "liveme.com",
        "*.liveme.com", "mastodon.social", "*.mastodon.social", "match.com",
        "*.match.com", "matrix.org", "*.matrix.org", "mattermost.com",
        "*.mattermost.com", "messenger.com", "*.messenger.com", "mewe.com",
        "*.mewe.com", "migente.com", "*.migente.com", "mixi.jp", "*.mixi.jp",
        "monster.com", "*.monster.com", "mumble.info", "*.mumble.info", "myspace.com",
        "*.myspace.com", "niconico.jp", "*.niconico.jp", "noplace.com", "*.noplace.com",
        "obs.live", "*.obs.live", "odnoklassniki.ru", "*.odnoklassniki.ru", "ok.ru",
        "*.ok.ru", "okcupid.com", "*.okcupid.com", "overwolf.com", "*.overwolf.com",
        "pinterest.com", "*.pinterest.com", "pixiv.net", "*.pixiv.net",
        "plentyoffish.com", "*.plentyoffish.com", "poparazzi.com", "*.poparazzi.com",
        "qq.com", "*.qq.com", "raidcall.com", "*.raidcall.com", "restream.io",
        "*.restream.io", "revolt.chat", "*.revolt.chat", "rocket.chat", "*.rocket.chat",
        "sharechat.com", "*.sharechat.com", "signal.org", "*.signal.org", "skype.com",
        "*.skype.com", "slack.com", "*.slack.com", "slashdot.org", "*.slashdot.org",
        "snapchat.com", "*.snapchat.com", "sonico.com", "*.sonico.com", "spaces.live",
        "*.spaces.live", "steam.com", "*.steam.com", "streamlabs.com",
        "*.streamlabs.com", "streamyard.com", "*.streamyard.com", "tagged.com",
        "*.tagged.com", "taringa.net", "*.taringa.net", "teamspeak.com",
        "*.teamspeak.com", "telegram.org", "*.telegram.org", "tenor.com", "*.tenor.com",
        "tenten.app", "*.tenten.app", "texts.com", "*.texts.com", "threads.net",
        "*.threads.net", "threema.ch", "*.threema.ch", "tiktok.com", "*.tiktok.com",
        "toptal.com", "*.toptal.com", "tuenti.com", "*.tuenti.com", "tumblr.com",
        "*.tumblr.com", "twitch.tv", "*.twitch.tv", "twitter.com", "*.twitter.com",
        "uplive.com", "*.uplive.com", "upwork.com", "*.upwork.com", "ventrilo.com",
        "*.ventrilo.com", "vero.co", "*.vero.co", "viber.com", "*.viber.com", "vk.com",
        "*.vk.com", "wechat.com", "*.wechat.com", "weibo.com", "*.weibo.com",
        "whatsapp.com", "*.whatsapp.com", "wickr.com", "*.wickr.com", "wire.com",
        "*.wire.com", "wordpress.com", "*.wordpress.com", "x.com", "*.x.com",
        "xiaohongshu.com", "*.xiaohongshu.com", "xing.com", "*.xing.com", "younow.com",
        "*.younow.com", "zalo.me", "*.zalo.me", "ziprecruiter.com",
        "*.ziprecruiter.com", "zoosk.com", "*.zoosk.com"],
    header :contains "subject" ["Lời mời kết bạn", "Bình luận mới", "Thích bài viết",
        "Chia sẻ bài viết", "Tin nhắn mới", "Thông báo hoạt động",
        "Cập nhật trạng thái", "Nhắc đến bạn", "Theo dõi mới", "Sự kiện mới",
        "Lời mời nhóm", "Cảnh báo bảo mật", "Tài khoản bị khóa", "Hoạt động đáng nghi",
        "Cập nhật ứng dụng", "Nội dung quảng cáo", "Ưu đãi đặc biệt", "Báo cáo tuần",
        "Tóm tắt tháng", "好友请求", "新评论", "点赞通知", "分享提醒", "私信通知", "活动提醒", "状态更新", "提及通知",
        "新关注者", "活动邀请", "群组邀请", "安全警报", "账户锁定", "可疑活动", "应用更新", "赞助内容", "特别优惠", "周报",
        "月度总结", "友達リクエスト", "新しいコメント", "いいね通知", "シェア通知", "メッセージ通知", "アクティビティ通知",
        "ステータス更新", "メンション通知", "新しいフォロワー", "イベント招待", "グループ招待", "セキュリティ警告", "アカウントロック",
        "不審な活動", "アプリ更新", "スポンサーコンテンツ", "特別オファー", "週次レポート", "月次サマリー"]
) {
    addflag "\\Seen";
    fileinto "Social Account";

    if allof (
        header :contains "subject" ["Friend Request", "New Friend",
            "Connection Request", "Like Notification", "New Like", "Post Liked",
            "Share Alert", "Post Shared", "Live Stream Started", "Live Now",
            "Message Read", "Seen Your Message", "Comment Added", "New Comment",
            "Tag Notification", "You Were Tagged", "Follow Request", "New Follower",
            "Notification", "Activity Alert", "Story Update", "Status Update",
            "Mention Alert", "Reply Notification"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Locked", "Ban Notification",
            "Restriction Alert", "Weak Password Warning", "Password Change Required",
            "Hack Detected", "Unauthorized Access", "Security Breach",
            "Account Compromised", "Login Attempt Alert", "Two-Factor Setup",
            "Verification Code", "Suspicious Activity", "Account Suspended",
            "Password Reset", "Security Warning", "Login Alert", "New Device Login"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Event Invite", "Group Invitation", "Join Event",
            "Community Event", "Live Event Alert", "Invitation Accepted",
            "RSVP Reminder", "Event Notification", "Party Invite", "Meetup Alert",
            "Calendar Invite", "Meeting Invite", "Webinar Invite", "Conference Invite",
            "Workshop Invite"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Platform Update", "New Feature Alert",
            "App Update Available", "Version Release", "Feature Launch",
            "System Maintenance", "Update Notes", "News Digest", "Weekly Recap",
            "Platform Changes", "Service Update", "Bug Fix", "Performance Improvement",
            "New Version", "Release Notes"],
        size :under 500K
    ) {
        expire "day" "5";

        stop;
    }

    if allof (
        header :contains "subject" ["Sponsored Content", "Deal Alert", "Promo Code",
            "Special Offer Inside", "Ad Notification", "Partner Promotion",
            "Discount Reminder", "Flash Deal", "Limited Promo", "Sponsored Post",
            "Advertisement", "Promoted Content", "Marketing Message",
            "Brand Partnership", "Product Launch", "Sale Alert", "Coupon Code",
            "Exclusive Offer"],
        size :under 500K
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Weekly Digest", "Monthly Summary",
            "Activity Summary", "Weekly Roundup", "Monthly Report", "Your Week",
            "Your Month", "Stats Summary", "Usage Report", "Engagement Report",
            "Performance Summary"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    stop;
}

if header :contains "subject" ["Fake Profile Alert", "Scam Warning",
    "Phishing Attempt", "Suspicious Account", "Report Fake Account",
    "Identity Theft Warning", "Romance Scam", "Investment Scam",
    "Cryptocurrency Scam"] {
    addflag "\\Seen";
    fileinto "Social Account";

    stop;
}

# ====================================================================================
# AI Services  (install position 6 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["anthropic.com", "*.anthropic.com", "character.ai",
        "*.character.ai", "civitai.com", "*.civitai.com", "claude.ai", "*.claude.ai",
        "cohere.com", "*.cohere.com", "copy.ai", "*.copy.ai", "deepmind.com",
        "*.deepmind.com", "descript.com", "*.descript.com", "elevenlabs.io",
        "*.elevenlabs.io", "fireworks.ai", "*.fireworks.ai", "groq.com", "*.groq.com",
        "huggingface.co", "*.huggingface.co", "ideogram.ai", "*.ideogram.ai",
        "jasper.ai", "*.jasper.ai", "langchain.com", "*.langchain.com", "leonardo.ai",
        "*.leonardo.ai", "midjourney.com", "*.midjourney.com", "mistral.ai",
        "*.mistral.ai", "openai.com", "*.openai.com", "perplexity.ai",
        "*.perplexity.ai", "poe.com", "*.poe.com", "replicate.com", "*.replicate.com",
        "runwayml.com", "*.runwayml.com", "stability.ai", "*.stability.ai", "suno.com",
        "*.suno.com", "synthesia.io", "*.synthesia.io", "together.ai", "*.together.ai",
        "writesonic.com", "*.writesonic.com"],
    header :contains "subject" ["Usage Summary", "Credit Balance", "Model Update",
        "API Key", "Rate Limit", "New Model Available", "Beta Access", "Waitlist"]
) {
    addflag "\\Seen";
    fileinto "AI";
    expire "day" "30";

    stop;
}

# ====================================================================================
# Developer Tools  (install position 5 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["circleci.com", "*.circleci.com", "crates.io",
        "*.crates.io", "datadoghq.com", "*.datadoghq.com", "docker.com", "*.docker.com",
        "elastic.co", "*.elastic.co", "fastly.com", "*.fastly.com", "fly.io",
        "*.fly.io", "hashicorp.com", "*.hashicorp.com", "jenkins.io", "*.jenkins.io",
        "jetbrains.com", "*.jetbrains.com", "jfrog.com", "*.jfrog.com", "linode.com",
        "*.linode.com", "mongodb.com", "*.mongodb.com", "neon.tech", "*.neon.tech",
        "npmjs.com", "*.npmjs.com", "nuget.org", "*.nuget.org", "packagist.org",
        "*.packagist.org", "pagerduty.com", "*.pagerduty.com", "planetscale.com",
        "*.planetscale.com", "pulumi.com", "*.pulumi.com", "pypi.org", "*.pypi.org",
        "quay.io", "*.quay.io", "railway.app", "*.railway.app", "render.com",
        "*.render.com", "rubygems.org", "*.rubygems.org", "snyk.io", "*.snyk.io",
        "sourcegraph.com", "*.sourcegraph.com", "statuspage.io", "*.statuspage.io",
        "supabase.com", "*.supabase.com", "travis-ci.com", "*.travis-ci.com",
        "vultr.com", "*.vultr.com"],
    header :contains "subject" ["Build Failed", "Build Succeeded", "Deployment",
        "Security Advisory", "Vulnerability Alert", "Dependency Update", "Incident",
        "Downtime", "Usage Report", "Quota Exceeded", "New Release",
        "Package Published"]
) {
    addflag "\\Seen";
    fileinto "Dev";
    expire "day" "30";

    stop;
}

# ====================================================================================
# Food & Delivery  (install position 4 of 22)
# ====================================================================================

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

# ====================================================================================
# Work  (install position 3 of 22)
# ====================================================================================

if anyof (
    address :domain :matches "from" ["15five.com", "*.15five.com", "activeinboxhq.com",
        "*.activeinboxhq.com", "acuityscheduling.com", "*.acuityscheduling.com",
        "adp.com", "*.adp.com", "airtable.com", "*.airtable.com", "amplitude.com",
        "*.amplitude.com", "angel.co", "*.angel.co", "any.do", "*.any.do", "aol.com",
        "*.aol.com", "apollo.io", "*.apollo.io", "appear.in", "*.appear.in",
        "appointlet.com", "*.appointlet.com", "asana.com", "*.asana.com",
        "atlassian.com", "*.atlassian.com", "aws.amazon.com", "*.aws.amazon.com",
        "azure.com", "*.azure.com", "bamboohr.com", "*.bamboohr.com", "basecamp.com",
        "*.basecamp.com", "bear.app", "*.bear.app", "bigbluebutton.org",
        "*.bigbluebutton.org", "bitbucket.org", "*.bitbucket.org", "bookwhen.com",
        "*.bookwhen.com", "boomeranggmail.com", "*.boomeranggmail.com", "box.com",
        "*.box.com", "breathehr.com", "*.breathehr.com", "calendly.com",
        "*.calendly.com", "canva.com", "*.canva.com", "chartio.com", "*.chartio.com",
        "clickup.com", "*.clickup.com", "clio.com", "*.clio.com", "clockify.me",
        "*.clockify.me", "clockwise.com", "*.clockwise.com", "close.com", "*.close.com",
        "cloudflare.com", "*.cloudflare.com", "coda.io", "*.coda.io", "concur.com",
        "*.concur.com", "confluence.com", "*.confluence.com", "contractbook.com",
        "*.contractbook.com", "copper.com", "*.copper.com", "craft.do", "*.craft.do",
        "datadog.com", "*.datadog.com", "dice.com", "*.dice.com", "digitalocean.com",
        "*.digitalocean.com", "docusign.com", "*.docusign.com", "drift.com",
        "*.drift.com", "drive.google.com", "*.drive.google.com", "dropbox.com",
        "*.dropbox.com", "egghead.io", "*.egghead.io", "evernote.com", "*.evernote.com",
        "expensify.com", "*.expensify.com", "figma.com", "*.figma.com", "framer.com",
        "*.framer.com", "freeagent.com", "*.freeagent.com", "freshbooks.com",
        "*.freshbooks.com", "freshdesk.com", "*.freshdesk.com", "freshworks.com",
        "*.freshworks.com", "frontapp.com", "*.frontapp.com", "getmailbird.com",
        "*.getmailbird.com", "github.com", "*.github.com", "gitlab.com", "*.gitlab.com",
        "gmail.com", "*.gmail.com", "gmx.com", "*.gmx.com", "google-analytics.com",
        "*.google-analytics.com", "google.com", "*.google.com", "gotomeeting.com",
        "*.gotomeeting.com", "grafana.com", "*.grafana.com", "gsuite.google.com",
        "*.gsuite.google.com", "gusto.com", "*.gusto.com", "harvest.com",
        "*.harvest.com", "height.app", "*.height.app", "hellosign.com",
        "*.hellosign.com", "helpwise.io", "*.helpwise.io", "heroku.com", "*.heroku.com",
        "hibob.com", "*.hibob.com", "hired.com", "*.hired.com", "hiverhq.com",
        "*.hiverhq.com", "hotjar.com", "*.hotjar.com", "hubspot.com", "*.hubspot.com",
        "ia.net", "*.ia.net", "icloud.com", "*.icloud.com", "insightly.com",
        "*.insightly.com", "intercom.com", "*.intercom.com", "invisionapp.com",
        "*.invisionapp.com", "ironclad.com", "*.ironclad.com", "jira.com", "*.jira.com",
        "jitsi.org", "*.jitsi.org", "kashoo.com", "*.kashoo.com", "khan.org",
        "*.khan.org", "klaviyo.com", "*.klaviyo.com", "laracasts.com",
        "*.laracasts.com", "lattice.com", "*.lattice.com", "lawgeex.com",
        "*.lawgeex.com", "linear.app", "*.linear.app", "linkedin.com", "*.linkedin.com",
        "logseq.com", "*.logseq.com", "looker.com", "*.looker.com", "lucidchart.com",
        "*.lucidchart.com", "mail.com", "*.mail.com", "meet.google.com",
        "*.meet.google.com", "mega.nz", "*.mega.nz", "metabase.com", "*.metabase.com",
        "microsoft.com", "*.microsoft.com", "miro.com", "*.miro.com", "mixmax.com",
        "*.mixmax.com", "mixpanel.com", "*.mixpanel.com", "monday.com", "*.monday.com",
        "mural.co", "*.mural.co", "mycase.com", "*.mycase.com", "namely.com",
        "*.namely.com", "netlify.com", "*.netlify.com", "netsuite.com",
        "*.netsuite.com", "newrelic.com", "*.newrelic.com", "nextcloud.com",
        "*.nextcloud.com", "nimble.com", "*.nimble.com", "notion.so", "*.notion.so",
        "obsidian.md", "*.obsidian.md", "office365.com", "*.office365.com",
        "omnifocus.com", "*.omnifocus.com", "onedrive.com", "*.onedrive.com",
        "onenote.com", "*.onenote.com", "outlook.com", "*.outlook.com", "outreach.io",
        "*.outreach.io", "owncloud.com", "*.owncloud.com", "pandadoc.com",
        "*.pandadoc.com", "paychex.com", "*.paychex.com", "pcloud.com", "*.pcloud.com",
        "personio.com", "*.personio.com", "pipedrive.com", "*.pipedrive.com",
        "pivotaltracker.com", "*.pivotaltracker.com", "powerbi.microsoft.com",
        "*.powerbi.microsoft.com", "practicepanther.com", "*.practicepanther.com",
        "principle.design", "*.principle.design", "quickbooks.com", "*.quickbooks.com",
        "receipt-bank.com", "*.receipt-bank.com", "rescuetime.com", "*.rescuetime.com",
        "rightinbox.com", "*.rightinbox.com", "rippling.com", "*.rippling.com",
        "roamresearch.com", "*.roamresearch.com", "sage.com", "*.sage.com",
        "salesloft.com", "*.salesloft.com", "sendinblue.com", "*.sendinblue.com",
        "sentry.io", "*.sentry.io", "setmore.com", "*.setmore.com", "shortcut.com",
        "*.shortcut.com", "signrequest.com", "*.signrequest.com", "sketch.com",
        "*.sketch.com", "smartsheet.com", "*.smartsheet.com", "sourceforge.net",
        "*.sourceforge.net", "spotdraft.com", "*.spotdraft.com", "stackoverflow.com",
        "*.stackoverflow.com", "streak.com", "*.streak.com", "superhuman.com",
        "*.superhuman.com", "sync.com", "*.sync.com", "tableau.com", "*.tableau.com",
        "teams.microsoft.com", "*.teams.microsoft.com", "things.app", "*.things.app",
        "thunderbird.net", "*.thunderbird.net", "ticktick.com", "*.ticktick.com",
        "timely.com", "*.timely.com", "todoist.com", "*.todoist.com", "toggl.com",
        "*.toggl.com", "treehouse.com", "*.treehouse.com", "trello.com", "*.trello.com",
        "tresorit.com", "*.tresorit.com", "triplebyte.com", "*.triplebyte.com",
        "tryshift.com", "*.tryshift.com", "ulysses.app", "*.ulysses.app", "vercel.com",
        "*.vercel.com", "wave.com", "*.wave.com", "webex.com", "*.webex.com",
        "wellfound.com", "*.wellfound.com", "whereby.com", "*.whereby.com",
        "whimsical.com", "*.whimsical.com", "workday.com", "*.workday.com",
        "workspace.google.com", "*.workspace.google.com", "wrike.com", "*.wrike.com",
        "xero.com", "*.xero.com", "youcanbook.me", "*.youcanbook.me", "zendesk.com",
        "*.zendesk.com", "zenefits.com", "*.zenefits.com", "zeplin.io", "*.zeplin.io",
        "zoho.com", "*.zoho.com", "zoom.us", "*.zoom.us", "zoomus.com", "*.zoomus.com"],
    header :contains "subject" ["Work", "Office", "Business", "Professional",
        "Corporate", "Company", "Team", "Department", "Meeting", "Project", "Task",
        "Assignment", "Deadline", "Report", "Analysis", "Quarterly", "Annual",
        "Performance", "KPI", "Metrics", "Dashboard", "Training", "Workshop", "Seminar",
        "Conference", "Client", "Customer", "Vendor", "Công việc", "Văn phòng",
        "Kinh doanh", "Chuyên nghiệp", "Công ty", "Nhóm", "Phòng ban", "Cuộc họp",
        "Dự án", "Nhiệm vụ", "Bài tập", "Hạn chót", "Báo cáo", "Phân tích", "Hàng quý",
        "Hàng năm", "Hiệu suất", "Chỉ số KPI", "Số liệu", "Bảng điều khiển", "Đào tạo",
        "Hội thảo", "Hội nghị", "Khách hàng", "Nhà cung cấp", "Nhắc nhở cuộc họp",
        "Lời mời lịch", "Cập nhật lịch trình", "Cuộc gọi hội nghị", "Cuộc họp Zoom",
        "Cuộc họp Teams", "Xác nhận cuộc hẹn", "Cập nhật dự án", "Nhiệm vụ được giao",
        "Cột mốc quan trọng", "Sắp đến hạn", "Báo cáo dự án", "Tiến độ nhóm",
        "Đánh giá hiệu suất", "Khảo sát nhân viên", "Yêu cầu đào tạo", "Thông báo HR",
        "Lương", "Phiếu lương", "Phúc lợi", "Yêu cầu nghỉ phép",
        "Cảnh báo khách hàng tiềm năng", "Cập nhật giao dịch", "Báo cáo đường ống",
        "Mục tiêu bán hàng", "Thông báo IT", "Cập nhật hệ thống", "Cảnh báo bảo mật",
        "工作", "办公室", "商业", "专业的", "公司", "团队", "部门", "会议", "项目", "任务", "作业", "截止日期",
        "报告", "分析", "季度", "年度", "绩效", "关键绩效指标", "指标", "仪表板", "培训", "研讨会", "客户", "供应商",
        "会议提醒", "日历邀请", "日程更新", "电话会议", "Zoom会议", "Teams会议", "预约确认", "项目更新", "分配任务",
        "里程碑", "截止日期临近", "项目报告", "团队进度", "绩效评估", "员工调查", "培训要求", "人力资源通知", "工资单", "薪资",
        "福利", "请假申请", "潜在客户提醒", "交易更新", "销售管道报告", "销售目标", "IT通知", "系统更新", "安全警报", "仕事",
        "オフィス", "ビジネス", "プロフェッショナル", "会社", "チーム", "部門", "会議", "プロジェクト", "タスク", "課題",
        "締切", "報告書", "四半期", "年次", "パフォーマンス", "重要業績評価指標", "メトリクス", "ダッシュボード", "研修",
        "ワークショップ", "セミナー", "クライアント", "顧客", "ベンダー", "会議リマインダー", "カレンダー招待", "スケジュール更新",
        "電話会議", "Zoom会議", "Teams会議", "予約確認", "プロジェクト更新", "タスク割当", "マイルストーン", "締切間近",
        "プロジェクト報告", "チーム進捗", "人事評価", "従業員調査", "研修必須", "人事通知", "給与", "給与明細", "福利厚生",
        "有給申請", "リード警告", "取引更新", "パイプライン報告", "売上目標", "ITお知らせ", "システム更新", "セキュリティ警告"],
    header :matches "from" ["*@*corp.com", "*@*inc.com", "*@*ltd.com", "*@*llc.com",
        "*@*group.com", "*@*company.com", "*@*business.com", "*@*enterprise.com",
        "*@*consulting.com", "*@*solutions.com"]
) {
    addflag "\\Seen";
    fileinto "Work";

    if anyof (
        address :domain :matches "from" ["acuityscheduling.com",
            "*.acuityscheduling.com", "calendly.com", "*.calendly.com",
            "meet.google.com", "*.meet.google.com", "teams.microsoft.com",
            "*.teams.microsoft.com", "webex.com", "*.webex.com", "zoom.us", "*.zoom.us"],
        header :contains "subject" ["Meeting Reminder", "Calendar Invite",
            "Schedule Update", "Conference Call", "Zoom Meeting", "Teams Meeting",
            "Webinar Registration", "Appointment Confirmation", "Call Scheduled",
            "Event Reminder", "Meeting Request", "Calendar Update", "Meeting Cancelled",
            "Reschedule Meeting", "Standup Meeting", "All-hands Meeting",
            "Team Meeting", "1:1 Meeting", "Client Meeting"]
    ) {
        fileinto "Work/Meetings";

        if allof (
            header :contains "subject" ["Meeting Today", "Starting in", "Reminder",
                "Now"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["asana.com", "*.asana.com", "clickup.com",
            "*.clickup.com", "github.com", "*.github.com", "gitlab.com", "*.gitlab.com",
            "jira.com", "*.jira.com", "monday.com", "*.monday.com", "trello.com",
            "*.trello.com"],
        header :contains "subject" ["Project Update", "Task Assigned", "Milestone",
            "Deadline Approaching", "Project Report", "Team Progress", "Assignment",
            "Sprint Review", "Epic Update", "Story Points", "Backlog Update",
            "Code Review", "Pull Request", "Merge Request", "Issue Created",
            "Bug Report", "Feature Request", "Release Notes", "Deployment"]
    ) {
        fileinto "Work/Projects";

        if allof (
            header :contains "subject" ["Daily", "Today's Tasks", "Task Reminder",
                "Due Today"],
            size :under 300K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["adp.com", "*.adp.com", "bamboohr.com",
            "*.bamboohr.com", "gusto.com", "*.gusto.com", "workday.com",
            "*.workday.com", "zenefits.com", "*.zenefits.com"],
        header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "PTO Request",
            "Time Off", "Leave Request", "Performance Review", "Employee Survey",
            "Training Required", "Compliance Training", "Policy Update", "HR Notice",
            "Open Enrollment", "401k", "Health Insurance", "Dental Coverage",
            "Employee Handbook", "Code of Conduct", "Onboarding", "Offboarding"]
    ) {
        fileinto "Work/HR";

        if header :contains "subject" ["Payroll", "Pay Stub", "Benefits", "401k",
            "Tax"] {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["freshworks.com", "*.freshworks.com",
            "hubspot.com", "*.hubspot.com", "pipedrive.com", "*.pipedrive.com",
            "zendesk.com", "*.zendesk.com"],
        header :contains "subject" ["Lead Alert", "Deal Update", "Pipeline Report",
            "Sales Target", "Commission Report", "Customer Update", "CRM Notification",
            "Opportunity Created", "Quote Sent", "Proposal Sent", "Contract Signed",
            "Invoice Sent", "Payment Received", "Customer Feedback", "Support Ticket"]
    ) {
        fileinto "Work/Sales";

        if header :contains "subject" ["Contract", "Invoice", "Payment", "Agreement"] {
            expire "day" "60";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Performance Report", "Analytics Summary",
            "Quarterly Review", "KPI Update", "Metrics Dashboard", "Sales Report",
            "Financial Report", "Business Intelligence", "Data Insights",
            "Audit Results", "Compliance Report", "Weekly Report", "Monthly Report",
            "Annual Report", "Executive Summary"],
        size :over 100K
    ) {
        fileinto "Work/Reports";

        if allof (
            header :contains "subject" ["Quarterly", "Annual", "Executive", "Board",
                "Audit"],
            size :over 500K
        ) {
            expire "day" "180";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["linkedin.com", "*.linkedin.com"],
        header :contains "subject" ["Job Alert", "Career Opportunity",
            "LinkedIn Connection", "Networking Event", "Professional Development",
            "Training Session", "Workshop", "Certification", "Conference Registration",
            "Mentorship", "Resume Update", "Skill Assessment", "Learning Path",
            "Course Enrollment"]
    ) {
        fileinto "Work/Career";

        if allof (
            header :contains "subject" ["Job Alert", "Career Opportunity", "Apply Now"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Daily Reminder", "Follow-up Alert", "Action Item",
            "To-Do Update", "Priority Notification", "Overdue Task", "Quick Check-in",
            "Status Update", "Pending Action", "Time Tracking", "Deadline Today",
            "Daily Standup", "Morning Briefing", "End of Day", "Weekly Goals"],
        size :under 200K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        fileinto "Work/Reminders";

        if header :contains "subject" ["Daily", "Today", "Right Now", "Immediate"] {
            expire "day" "1";
        }

        stop;
    }

    if header :contains "subject" ["IT Notice", "System Update", "Security Alert",
        "Network Maintenance", "Password Expiry", "VPN Access", "Software License",
        "Security Training", "Phishing Test", "Backup Complete",
        "Server Maintenance", "Domain Renewal", "SSL Certificate",
        "Firewall Update", "Antivirus Scan"] {
        fileinto "Work/IT";

        if header :contains "subject" ["Security Alert", "Breach", "Incident",
            "Threat"] {
            expire "day" "30";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["concur.com", "*.concur.com", "expensify.com",
            "*.expensify.com", "freshbooks.com", "*.freshbooks.com", "quickbooks.com",
            "*.quickbooks.com", "xero.com", "*.xero.com"],
        header :contains "subject" ["Invoice", "Receipt", "Expense Report",
            "Budget Update", "Financial Statement", "Account Balance",
            "Payment Confirmation", "Purchase Order", "Vendor Payment", "Reimbursement",
            "Tax Document", "Billing Statement", "Credit Note", "Refund",
            "Subscription Renewal"]
    ) {
        fileinto "Work/Finance";
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Product Update",
            "Feature Announcement", "Company News", "Industry News", "Blog Post"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "14";

    stop;
}

# ====================================================================================
# Shopping  (install position 2 of 22)
# ====================================================================================

if address :domain :matches "from" ["amazcn.com", "*.amazcn.com", "ebay-inc.com",
    "*.ebay-inc.com", "paypai.com", "*.paypai.com", "target-store.com",
    "*.target-store.com", "wallmart.com", "*.wallmart.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if anyof (
    address :domain :matches "from" ["abebooks.com", "*.abebooks.com",
        "abercrombie.com", "*.abercrombie.com", "academy.com", "*.academy.com",
        "acer.com", "*.acer.com", "ae.com", "*.ae.com", "aeropostale.com",
        "*.aeropostale.com", "ajio.com", "*.ajio.com", "albertsons.com",
        "*.albertsons.com", "alibaba.com", "*.alibaba.com", "aliexpress.com",
        "*.aliexpress.com", "amazon.ca", "*.amazon.ca", "amazon.co.jp",
        "*.amazon.co.jp", "amazon.co.uk", "*.amazon.co.uk", "amazon.com",
        "*.amazon.com", "amazon.com.au", "*.amazon.com.au", "amazon.de", "*.amazon.de",
        "amazon.es", "*.amazon.es", "amazon.fr", "*.amazon.fr", "amazon.in",
        "*.amazon.in", "amazon.it", "*.amazon.it", "amazonfresh.com",
        "*.amazonfresh.com", "anthropologie.com", "*.anthropologie.com", "artfire.com",
        "*.artfire.com", "asics.com", "*.asics.com", "asus.com", "*.asus.com",
        "athleta.com", "*.athleta.com", "backcountry.com", "*.backcountry.com",
        "bananarepublic.com", "*.bananarepublic.com", "banggood.com", "*.banggood.com",
        "barnesandnoble.com", "*.barnesandnoble.com", "bathandbodyworks.com",
        "*.bathandbodyworks.com", "beautybrands.com", "*.beautybrands.com",
        "bedbathandbeyond.com", "*.bedbathandbeyond.com", "belk.com", "*.belk.com",
        "bhphotovideo.com", "*.bhphotovideo.com", "birkenstock.com",
        "*.birkenstock.com", "bjs.com", "*.bjs.com", "bloomingdales.com",
        "*.bloomingdales.com", "bonanza.com", "*.bonanza.com", "bookdepository.com",
        "*.bookdepository.com", "booksamillion.com", "*.booksamillion.com",
        "boscovs.com", "*.boscovs.com", "cabelas.com", "*.cabelas.com", "cafepress.com",
        "*.cafepress.com", "champssports.com", "*.champssports.com", "clarks.com",
        "*.clarks.com", "clinique.com", "*.clinique.com", "columbia.com",
        "*.columbia.com", "containerstore.com", "*.containerstore.com", "converse.com",
        "*.converse.com", "costco.com", "*.costco.com", "crateandbarrel.com",
        "*.crateandbarrel.com", "crocs.com", "*.crocs.com", "customink.com",
        "*.customink.com", "dell.com", "*.dell.com", "dermstore.com", "*.dermstore.com",
        "dhgate.com", "*.dhgate.com", "dickssportinggoods.com",
        "*.dickssportinggoods.com", "dillards.com", "*.dillards.com", "discovery.com",
        "*.discovery.com", "disney.com", "*.disney.com", "dji.com", "*.dji.com",
        "dsw.com", "*.dsw.com", "eastbay.com", "*.eastbay.com", "ebay.ca", "*.ebay.ca",
        "ebay.co.uk", "*.ebay.co.uk", "ebay.de", "*.ebay.de", "ebay.es", "*.ebay.es",
        "ebay.fr", "*.ebay.fr", "express.com", "*.express.com", "famousfootwear.com",
        "*.famousfootwear.com", "fashionphile.com", "*.fashionphile.com",
        "finishline.com", "*.finishline.com", "flipkart.com", "*.flipkart.com",
        "footaction.com", "*.footaction.com", "footlocker.com", "*.footlocker.com",
        "forever21.com", "*.forever21.com", "freepeople.com", "*.freepeople.com",
        "gap.com", "*.gap.com", "gopro.com", "*.gopro.com", "hbomax.com",
        "*.hbomax.com", "hm.com", "*.hm.com", "hollisterco.com", "*.hollisterco.com",
        "homedepot.com", "*.homedepot.com", "homegoods.com", "*.homegoods.com",
        "hp.com", "*.hp.com", "ikea.com", "*.ikea.com", "jcpenney.com",
        "*.jcpenney.com", "jcrew.com", "*.jcrew.com", "jd.com", "*.jd.com",
        "kiehls.com", "*.kiehls.com", "kohls.com", "*.kohls.com", "kroger.com",
        "*.kroger.com", "lazada.com", "*.lazada.com", "lenovo.com", "*.lenovo.com",
        "lg.com", "*.lg.com", "lordandtaylor.com", "*.lordandtaylor.com", "lowes.com",
        "*.lowes.com", "lululemon.com", "*.lululemon.com", "lushusa.com",
        "*.lushusa.com", "maccosmetics.com", "*.maccosmetics.com", "macys.com",
        "*.macys.com", "madewell.com", "*.madewell.com", "menards.com", "*.menards.com",
        "mercari.com", "*.mercari.com", "moosejaw.com", "*.moosejaw.com", "myntra.com",
        "*.myntra.com", "neimanmarcus.com", "*.neimanmarcus.com", "newbalance.com",
        "*.newbalance.com", "nordstrom.com", "*.nordstrom.com", "nordstromrack.com",
        "*.nordstromrack.com", "nykaa.com", "*.nykaa.com", "oldnavy.com",
        "*.oldnavy.com", "overstock.com", "*.overstock.com", "patagonia.com",
        "*.patagonia.com", "pier1.com", "*.pier1.com", "poshmark.com", "*.poshmark.com",
        "potterybarn.com", "*.potterybarn.com", "powells.com", "*.powells.com",
        "printful.com", "*.printful.com", "publix.com", "*.publix.com", "puma.com",
        "*.puma.com", "quadpay.com", "*.quadpay.com", "rakuten.co.jp",
        "*.rakuten.co.jp", "rakuten.com", "*.rakuten.com", "rebag.com", "*.rebag.com",
        "redbubble.com", "*.redbubble.com", "rei.com", "*.rei.com", "safeway.com",
        "*.safeway.com", "saksfifthavenue.com", "*.saksfifthavenue.com",
        "sallybeauty.com", "*.sallybeauty.com", "samsclub.com", "*.samsclub.com",
        "sephora.com", "*.sephora.com", "shein.com", "*.shein.com", "shopee.com",
        "*.shopee.com", "shutterfly.com", "*.shutterfly.com", "skechers.com",
        "*.skechers.com", "skinstore.com", "*.skinstore.com", "snapdeal.com",
        "*.snapdeal.com", "snapfish.com", "*.snapfish.com", "society6.com",
        "*.society6.com", "sony.com", "*.sony.com", "sportsmans.com",
        "*.sportsmans.com", "spreadshirt.com", "*.spreadshirt.com", "square.com",
        "*.square.com", "taobao.com", "*.taobao.com", "teespring.com",
        "*.teespring.com", "temu.com", "*.temu.com", "tesla.com", "*.tesla.com",
        "thebodyshop.com", "*.thebodyshop.com", "thenorthface.com",
        "*.thenorthface.com", "therealreal.com", "*.therealreal.com", "threadless.com",
        "*.threadless.com", "thredup.com", "*.thredup.com", "thriftbooks.com",
        "*.thriftbooks.com", "tigerdirect.com", "*.tigerdirect.com", "timberland.com",
        "*.timberland.com", "tjmaxx.com", "*.tjmaxx.com", "tmall.com", "*.tmall.com",
        "ugg.com", "*.ugg.com", "ulta.com", "*.ulta.com", "underarmour.com",
        "*.underarmour.com", "uniqlo.com", "*.uniqlo.com", "urbanoutfitters.com",
        "*.urbanoutfitters.com", "vans.com", "*.vans.com", "vestiairecollective.com",
        "*.vestiairecollective.com", "vistaprint.com", "*.vistaprint.com",
        "wayfair.com", "*.wayfair.com", "wegmans.com", "*.wegmans.com", "westelm.com",
        "*.westelm.com", "whatgoesaroundnyc.com", "*.whatgoesaroundnyc.com",
        "wholefoodsmarket.com", "*.wholefoodsmarket.com", "williams-sonoma.com",
        "*.williams-sonoma.com", "wish.com", "*.wish.com", "worldmarket.com",
        "*.worldmarket.com", "zappos.com", "*.zappos.com", "zara.com", "*.zara.com",
        "zazzle.com", "*.zazzle.com"],
    header :contains "subject" ["Order Confirmation", "Purchase Confirmation",
        "Your Cart", "Abandoned Cart", "Checkout", "Order Shipped", "Out for Delivery",
        "Tracking Number", "Flash Sale", "Black Friday", "Cyber Monday", "Holiday Sale",
        "Limited Time Offer", "Clearance Sale", "Promo Code", "Xác nhận đơn hàng",
        "Hóa đơn mua hàng", "Thanh toán thành công", "Đơn hàng đã đặt", "Giao hàng",
        "Theo dõi đơn hàng", "Đã giao hàng", "Khuyến mãi", "Giảm giá", "Mã giảm giá",
        "Ưu đãi đặc biệt", "Thời gian có hạn", "Giỏ hàng bỏ quên", "Hoàn trả",
        "Hoàn tiền", "Trao đổi", "Điểm thưởng", "Chương trình khách hàng thân thiết",
        "Đánh giá sản phẩm", "Đăng ký định kỳ", "Danh sách yêu thích",
        "Cập nhật tài khoản", "Phương thức thanh toán", "Cảnh báo bảo mật", "订单确认",
        "购买确认", "交易完成", "付款成功", "已下订单", "感谢您的订单", "发货", "跟踪号码", "正在配送", "已送达", "包裹到达",
        "配送更新", "促销", "限时优惠", "闪购", "价格下跌", "清仓销售", "黑色星期五", "网购星期一", "购物车提醒", "完成购买",
        "退货", "退款", "换货", "积分奖励", "会员福利", "产品评价", "订阅", "自动配送", "愿望清单", "价格下跌提醒",
        "账户更新", "付款方式", "安全警报", "注文確認", "購入確認", "取引完了", "お支払い完了", "ご注文ありがとうございます",
        "発送済み", "追跡番号", "配送中", "配達完了", "荷物到着", "セール", "限定オファー", "タイムセール", "価格下落",
        "在庫処分", "ブラックフライデー", "サイバーマンデー", "カートリマインダー", "購入を完了", "返品", "返金", "交換",
        "ポイント獲得", "会員特典", "商品レビュー", "サブスクリプション", "定期配送", "ウィッシュリスト", "価格下落通知",
        "アカウント更新", "支払い方法", "セキュリティ警告"]
) {
    addflag "\\Seen";
    fileinto "Shopping";

    if allof (
        header :contains "subject" ["Order Confirmation", "Purchase Confirmation",
            "Order Receipt", "Purchase Receipt", "Transaction Complete",
            "Payment Received", "Order Placed Successfully", "Thank You for Your Order",
            "Order Summary", "Invoice", "Receipt", "Transaction Summary",
            "Payment Confirmation"],
        size :under 1M
    ) {
        fileinto "Shopping/Orders";
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Shipped", "Tracking Number", "On the Way",
            "Out for Delivery", "Delivered", "Package Arrived", "Delivery Update",
            "Shipment Notification", "In Transit", "Delivery Attempt",
            "Ready for Pickup", "Package Delayed", "Delivery Rescheduled",
            "Signature Required"],
        size :under 500K
    ) {
        fileinto "Shopping/Shipping";
        expire "day" "60";

        stop;
    }

    if allof (
        header :contains "subject" ["Flash Sale", "Daily Deal", "Limited Time Offer",
            "Sale Alert", "Price Drop", "Clearance Sale", "Black Friday",
            "Cyber Monday", "Holiday Sale", "Weekend Sale", "Exclusive Deal",
            "Member Sale", "VIP Sale", "Early Access", "Presale", "Special Offer",
            "Discount Alert", "Coupon Inside", "Promo Code", "% Off", "Free Shipping",
            "Buy One Get One"],
        size :under 500K,
        not header :contains "subject" ["Order", "Confirmation", "Receipt"]
    ) {
        fileinto "Shopping/Deals";

        if header :contains "subject" ["Flash Sale", "Today Only", "Ends Tonight",
            "Last Hours", "Final Hours", "Midnight Sale"] {
            expire "day" "1";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Abandoned Cart", "Items in Your Cart",
            "Complete Your Purchase", "Forgot Something", "Cart Reminder",
            "Don't Miss Out", "Still Interested", "Your Cart Expires", "Items Reserved",
            "Checkout Now", "Return to Cart", "Save Your Cart"],
        size :under 300K
    ) {
        fileinto "Shopping/Cart";
        expire "day" "2";

        stop;
    }

    if allof (
        header :contains "subject" ["Recommended for You", "You Might Like",
            "Personalized Picks", "Based on Your Browsing", "Similar Items",
            "Customers Also Bought", "New Arrivals", "Trending Now", "Popular Items",
            "Curated Selection", "Handpicked", "Just for You", "Inspired by"],
        size :under 500K
    ) {
        fileinto "Shopping/Recommendations";
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Return", "Refund", "Exchange", "Credit Issued",
            "Returned Item", "Refund Processed", "Return Label", "RMA Number",
            "Return Authorized", "Exchange Approved", "Store Credit", "Refund Status"],
        size :under 500K
    ) {
        fileinto "Shopping/Returns";
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Rewards Points", "Loyalty Program",
            "Member Benefits", "Points Earned", "Cashback", "Reward Balance",
            "VIP Status", "Tier Update", "Member Exclusive", "Points Expiring",
            "Redeem Points", "Reward Available"],
        size :under 300K
    ) {
        fileinto "Shopping/Rewards";
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["Review Your Purchase", "Rate Your Order",
            "How Was Your Experience", "Product Review", "Share Your Thoughts",
            "Tell Us About", "Feedback Request", "Review Reminder", "Rate This Item"],
        size :under 300K
    ) {
        fileinto "Shopping/Reviews";
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Subscription", "Auto-delivery", "Recurring Order",
            "Subscription Renewal", "Auto-renewal", "Subscribe & Save",
            "Monthly Delivery", "Subscription Update", "Pause Subscription",
            "Cancel Subscription"],
        size :under 500K
    ) {
        fileinto "Shopping/Subscriptions";
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Wishlist", "Saved Items", "Price Drop on Saved",
            "Item Back in Stock", "Saved for Later", "Favorites Update", "Watch List"],
        size :under 300K
    ) {
        fileinto "Shopping/Wishlist";
        expire "day" "21";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Update", "Password Changed",
            "Payment Method", "Billing Address", "Security Alert", "Login Alert",
            "Account Verification", "Profile Update", "Settings Changed",
            "Two-Factor Authentication"],
        size :under 500K
    ) {
        fileinto "Shopping/Account";
        expire "day" "60";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Company News", "Brand Update",
            "New Collection", "Season Preview", "Style Guide", "Trend Report"],
        size :under 500K,
        not header :contains "subject" ["Sale", "Deal", "Offer", "Discount"]
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Sale", "Deal", "Discount", "Coupon", "Promo",
            "Offer", "Clearance", "Save ", "% Off", "Newsletter", "New Arrivals",
            "Recommended", "Just for You", "Back in Stock"],
        size :under 500K,
        not header :contains "subject" ["Order", "Shipping", "Delivery", "Return",
            "Refund"]
    ) {
        expire "day" "10";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "14";

    stop;
}

# ====================================================================================
# Spam  (install position 1 of 22)
# ====================================================================================

if header :contains "subject" ["Money Transfer", "Lottery Winner", "Inheritance Fund",
    "Bank Transfer", "Compensation Fund", "ATM Card Delivery",
    "Western Union Transfer", "MoneyGram Payment", "Wire Transfer Alert",
    "Unclaimed Funds", "Beneficiary Payment", "Estate Settlement",
    "Insurance Claim", "Government Compensation", "UN Compensation Fund",
    "Nigerian Prince", "Government Official", "UN Fund Director",
    "IMF Payment Officer", "World Bank Agent", "Federal Reserve Notice",
    "Oil Contract Deal", "Gold Investment Deal", "Diamond Investment",
    "Business Partnership Proposal", "Confidential Business",
    "Urgent Business Proposal", "Investment Partnership",
    "Cryptocurrency Investment Opportunity", "Bitcoin Mining Profits",
    "Forex Trading Guaranteed", "Binary Options Winner", "Trading Bot Profits",
    "Get Rich Quick Crypto", "Guaranteed Investment Returns",
    "High Yield Investment", "Risk-Free Investment", "Double Your Bitcoin",
    "Crypto Mining Contract", "Make Money Fast", "Earn $5000 Daily",
    "Get Rich Quick", "Work From Home $$$", "Easy Money Online", "Instant Wealth",
    "Cash in 24 Hours", "Guaranteed Income", "Passive Income Secrets",
    "Money Making System", "Financial Freedom Now", "Millionaire in 30 Days",
    "Work From Home Opportunity", "Data Entry Jobs $$$", "Envelope Stuffing Jobs",
    "Online Survey Money", "Typing Jobs Online", "Assembly Work From Home",
    "Product Testing Jobs", "Mystery Shopping Jobs", "Google Cash Kit",
    "Amazon Work From Home", "Congratulations Winner", "You've Won $",
    "Lottery Prize", "Sweepstakes Winner", "Cash Prize Alert",
    "Million Dollar Winner", "Prize Claim", "Jackpot Winner",
    "Contest Winner Notification", "Prize Delivery Notice", "Claim Your Prize",
    "Winner Verification Required", "Free iPhone Giveaway", "Free Gift Card",
    "Free Amazon Card", "Free PlayStation", "Free Laptop Giveaway",
    "Birthday Giveaway", "Anniversary Gift", "Limited Time Giveaway",
    "Exclusive Gift Offer", "Special Gift Selection",
    "Account Suspended Immediately", "Urgent Account Verification",
    "Account Will Be Closed", "Verify Account Now", "Account Security Alert",
    "Suspicious Account Activity", "Account Locked Notice",
    "Immediate Action Required", "Account Termination Notice",
    "Payment Method Expired", "Security Breach Alert", "Virus Detected on Your PC",
    "Your Computer Is Infected", "Microsoft Security Alert",
    "Apple Security Warning", "Google Security Notice", "PayPal Security Alert",
    "Bank Security Notice", "Credit Card Fraud Alert", "Identity Theft Protection",
    "Looking for True Love", "Seeking Serious Relationship",
    "Lonely Heart Seeking Love", "Military Personnel Overseas",
    "Widowed Looking for Love", "Doctor Seeking Partner",
    "Engineer in Foreign Country", "Business Owner Traveling",
    "Single Parent Seeking Love", "Ready for Marriage", "Hot Singles in Your Area",
    "Local Dating Alert", "Someone Wants to Meet You", "Dating Site Match",
    "Profile View Alert", "Someone Likes You", "New Message from", "Flirt Alert",
    "Date Request", "Miracle Weight Loss", "Lose 30 Pounds Fast",
    "Male Enhancement Pills", "Viagra Alternative", "Natural Viagra",
    "Penis Enlargement", "Breast Enhancement", "Hair Growth Miracle",
    "Anti-Aging Secret", "Diabetes Cure", "Cancer Cure Natural",
    "Cheap Viagra Online", "No Prescription Required", "Online Pharmacy Discount",
    "Prescription Drugs Cheap", "Buy Medications Online", "Generic Viagra Sale",
    "Cialis Discount", "Prescription Free Drugs", "Legal Action Against You",
    "Court Summons", "Lawsuit Filed", "Legal Notice Final", "Attorney Notice",
    "Law Firm Warning", "Legal Department Alert", "Cease and Desist Notice",
    "Copyright Infringement Notice", "Patent Violation Alert",
    "Outstanding Debt Notice", "Collection Agency Alert", "Payment Overdue Notice",
    "Debt Settlement Offer", "Wage Garnishment Notice", "Tax Lien Notice",
    "IRS Payment Notice", "Government Debt Notice", "University Diploma Fast",
    "College Degree in Days", "PhD Certificate Online", "Accredited Degree Program",
    "Life Experience Degree", "No Study Required Degree",
    "Instant University Degree", "Diploma Mill Certificate",
    "Professional Certification Easy", "IT Certification Fast",
    "Medical Certificate Online", "Trade License Quick",
    "Professional License Easy", "Act Now or Lose Out", "Limited Time Only",
    "Offer Expires Today", "Last Chance Sale", "Final Notice",
    "Immediate Response Required", "Don't Miss Out", "Once in Lifetime",
    "Urgent Response Needed", "Time Running Out", "Expires at Midnight",
    "100% Guaranteed", "Risk-Free Investment", "No Questions Asked",
    "Money Back Guarantee", "Absolutely Free", "No Catch", "No Strings Attached",
    "Scientifically Proven", "Doctors Recommend", "Celebrity Endorsed",
    "RE: (no subject)", "RE: your message", "RE: important", "RE: hello", "RE: hi",
    "RE: urgent", "RE: question", "RE: help", "Important Message for You",
    "Personal Message", "Confidential Information", "Private Message",
    "Urgent Communication", "Special Notification", "Exclusive Information",
    "Classified Information", "Prayer Request Donation", "Church Building Fund",
    "Missionary Needs Help", "Religious Charity Donation",
    "Pastor Needs Assistance", "Biblical Prophecy Money", "God's Blessing Money",
    "Christian Investment", "Faith-Based Investment", "Religious Organization Fund",
    "Disaster Relief Donation", "Children's Charity Help", "Medical Charity Case",
    "Orphanage Needs Help", "Cancer Patient Needs", "Hurricane Victim Relief",
    "Earthquake Relief Fund", "Refugee Assistance", "IRS Tax Refund",
    "Government Grant Money", "Social Security Benefits", "Medicare Refund Check",
    "Stimulus Payment", "Tax Relief Program", "Government Assistance",
    "Federal Grant Award", "State Benefits Payment", "Unemployment Benefits",
    "Visa Lottery Winner", "Green Card Lottery", "Immigration Help",
    "Visa Processing Fast", "Citizenship Fast Track", "Immigration Attorney",
    "Free Antivirus Download", "PC Speedup Software", "Registry Cleaner Free",
    "System Optimizer", "Malware Removal Tool", "Computer Cleanup Free",
    "Windows Repair Tool", "Driver Update Software", "Microsoft Tech Support",
    "Windows Support Alert", "Apple Tech Support", "Computer Support Call",
    "Technical Support Needed", "System Error Alert", "Computer Virus Warning",
    "Security Software Update", "Làm giàu nhanh", "Kiếm tiền dễ dàng",
    "Trúng số độc đắc", "Thừa kế tài sản", "Chuyển khoản khẩn cấp", "Cơ hội đầu tư",
    "Làm việc tại nhà", "Giảm cân thần kỳ", "Thuốc không cần toa",
    "Tài khoản bị khóa", "快速致富", "轻松赚钱", "中奖通知", "遗产继承", "紧急转账", "投资机会", "在家工作",
    "神奇减肥", "无处方药物", "账户被锁", "簡単にお金を稼ぐ", "宝くじに当選", "遺産相続", "緊急送金", "投資機会", "在宅ワーク",
    "奇跡のダイエット", "処方箋不要", "アカウント停止", "セキュリティ警告"] {
    addflag "\\Seen";
    fileinto "Spam";
    expire "day" "7";

    stop;
}

if allof (
    header :contains "subject" ["Important", "Urgent", "Notice", "Alert", "Update"],
    header :contains "from" ["noreply@", "no-reply@", "donotreply@", "Customer Service",
        "Account Manager", "Business Partner", "Investment Advisor",
        "Financial Consultant", "Legal Department", "Security Team"],
    header :matches "from" ["*@*.tk", "*@*.ml", "*@*.ga", "*@*.cf", "*@*.gq"],
    not header :contains "subject" ["@amazon.com", "@google.com", "@facebook.com",
        "@microsoft.com", "@apple.com", "@paypal.com", "@ebay.com", "@twitter.com",
        "@linkedin.com", "@instagram.com", "@pinterest.com", "@snapchat.com",
        "@steampowered.com", "@valvesoftware.com", "@discord.com", "@proton.me"]
) {
    addflag "\\Seen";
    fileinto "Spam";
    expire "day" "7";

    stop;
}

# End of Everything bundle
