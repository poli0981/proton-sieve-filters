# Proton Service Notifications filter -- filter/proton.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/proton.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Mail from Proton's own services.
#
# Folders: Proton, Spam
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 20 of 22. Filters run in the order you install them,
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

# End of Proton Service Notifications filter
