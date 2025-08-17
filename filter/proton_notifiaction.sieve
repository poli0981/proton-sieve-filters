# Sieve filter
# Filter_Proton.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters messages related to Proton Mail notifications, moves them to "Proton" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to Proton Mail notifications
if anyof (
    # Official Proton domains
    address :domain :matches "from" ["*proton.me", "*protonmail.com", "*pm.me", 
    "*proton.ch", "*protonmail.ch", "*protonstatus.com", "*protonvpn.com", 
    "*protoncalendar.com", "*protondrive.com"],
    
    # Specific Proton sender addresses
    header :contains "from" ["noreply@proton.me", "no-reply@proton.me", 
    "notifications@proton.me", "support@proton.me", "security@proton.me",
    "billing@proton.me", "newsletter@proton.me", "updates@proton.me",
    "community@proton.me", "feedback@proton.me", "survey@proton.me"],
    
    # Proton subject line indicators
    header :contains "subject" ["Proton Mail", "Proton VPN", "Proton Drive", 
    "Proton Calendar", "Proton Pass", "Proton Account", "ProtonMail"]
) {
    # Mark email as read (apply before fileinto to set flag before move)
    addflag "\\Seen";
    
    # Move to "Proton" folder
    fileinto "Proton";

    # ========================================================================
    # CRITICAL SECURITY ALERTS - Keep longer for investigation
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Security Alert", "Account Compromised", 
        "Unauthorized Access", "Login Alert", "Security Breach", "Account Locked",
        "Suspicious Activity", "Password Changed", "Two-Factor Authentication",
        "Device Authorization", "Login from New Location", "Security Warning"]
    ) {
        # Remove read flag for security alerts - need immediate attention
        removeflag "\\Seen";
        addflag "\\Flagged";
        expire "day" "90";
        stop;
    }

    # ========================================================================
    # BILLING & SUBSCRIPTION - Important financial records
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Subscription Confirmation", "Billing Update", 
        "Payment Received", "Renewal Notice", "Invoice Attached", "Account Charged", 
        "Plan Upgrade", "Plan Downgrade", "Subscription Details", "Billing Statement", 
        "Payment Reminder", "Payment Failed", "Card Expired", "Subscription Cancelled",
        "Refund Processed", "Credit Applied", "Proton Plus", "Proton Unlimited"],
        size :under 1M  # Billing emails can be larger with attachments
    ) {
        expire "day" "365";
        stop;
    }

    # ========================================================================
    # ACCOUNT MANAGEMENT - Moderate importance
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Account Verification", "Email Verified", 
        "Profile Update", "Settings Changed", "Account Activity", "Login Confirmation", 
        "Device Added", "Device Removed", "Account Recovery", "Email Preferences Update", 
        "Proton Account Alert", "User Settings Notification", "Recovery Email",
        "Account Activated", "Welcome to Proton", "Account Setup Complete"],
        size :under 500K
    ) {
        expire "day" "30";
        stop;
    }

    # ========================================================================
    # DAILY NOTIFICATIONS - Short retention
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["New Message in Inbox", "Unread Email Notification", 
        "Inbox Update", "Message Received", "Email Alert", "Proton Mail Notification", 
        "New Email Arrived", "Inbox Activity", "Message Waiting", "Check Your Inbox",
        "Daily Summary", "Inbox Digest", "Message Count", "Unread Messages"],
        size :under 200K,  # Notifications are typically small
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "1";
        # Delete daily notifications quickly
        stop;
    }

    # ========================================================================
    # PRODUCT UPDATES & NEWSLETTERS - Medium retention
    # ========================================================================
    
    if anyof (
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

    # ========================================================================
    # SURVEYS & FEEDBACK - Short retention
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["User Survey", "Feedback Request", "Rate Your Experience", 
        "Customer Survey", "Product Feedback", "Service Rating", "User Research",
        "Beta Feedback", "Feature Request", "Community Poll", "User Study"],
        size :under 300K
    ) {
        expire "day" "7";
        stop;
    }

    # ========================================================================
    # SERVICE STATUS & MAINTENANCE - Short retention
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Service Status", "Maintenance Notice", 
        "System Update", "Scheduled Maintenance", "Service Interruption", 
        "Downtime Notice", "System Maintenance", "Server Update", 
        "Infrastructure Update", "Network Maintenance", "Service Restored"],
        size :under 300K
    ) {
        expire "day" "7";
        stop;
    }

    # ========================================================================
    # LEGAL & POLICY UPDATES - Important for compliance
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Privacy Policy Update", "Terms of Service", 
        "EULA Update", "Policy Change", "Terms Change", "Legal Notice", 
        "Transparency Report", "Privacy Update", "Data Policy", "User Agreement",
        "Service Agreement", "Compliance Update", "Regulatory Change"],
        size :under 500K
    ) {
        expire "day" "90";
        stop;
    }

    # ========================================================================
    # PROTON DRIVE NOTIFICATIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Proton Drive", "File Shared", "Folder Shared", 
        "Drive Storage", "Upload Complete", "Sync Complete", "File Updated", 
        "Drive Notification", "Sharing Invitation", "Drive Alert"],
        size :under 300K
    ) {
        expire "day" "14";
        stop;
    }

    # ========================================================================
    # PROTON CALENDAR NOTIFICATIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Proton Calendar", "Event Reminder", 
        "Calendar Invitation", "Event Update", "Meeting Reminder", 
        "Calendar Notification", "Event Cancelled", "Calendar Sync"],
        size :under 300K
    ) {
        expire "day" "7";
        stop;
    }

    # ========================================================================
    # PROTON VPN NOTIFICATIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Proton VPN", "VPN Connection", "Server Update", 
        "VPN Alert", "Connection Status", "VPN Notification", "Server Maintenance"],
        size :under 300K
    ) {
        expire "day" "7";
        stop;
    }

    # ========================================================================
    # PROTON PASS NOTIFICATIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Proton Pass", "Password Alert", "Breach Alert", 
        "Vault Notification", "Pass Notification", "Security Report", 
        "Password Health", "Data Breach"],
        size :under 300K
    ) {
        expire "day" "30";
        stop;
    }

    # ========================================================================
    # DEFAULT EXPIRATION - Catch-all for other Proton emails
    # ========================================================================
    
    expire "day" "10";
    
    stop;
}

# End of Sieve script for Proton filter

