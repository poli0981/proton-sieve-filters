# Security & Account filter -- filter/security.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/security.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Account alerts, sign-in notifications, 2FA and breach warnings.
#
# Folders: Security, Security/Authentication, Security/Billing, Security/Changes,
#          Security/Compliance, Security/Critical, Security/Education,
#          Security/General, Security/Login, Security/Permissions
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 21 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if anyof (
    header :list "from" ":addrbook:personal",
    header :list "from" ":addrbook:myself"
) {
    stop;
}

# Drop what Proton already knows is spam.
if header :list "from" ":incomingdefaults:spam" {
    discard;
    stop;
}

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

# End of Security & Account filter
