# Sieve filter
# SecurityAccount_filter.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters security and account-related notifications, categorizes them by security level and type.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist - Always allow personal contacts
if anyof (
    header :list "from" ":addrbook:personal",
    header :list "from" ":addrbook:myself"
) {
    stop;
}

# Delete messages if they are in the spam list
if header :list "from" ":incomingdefaults:spam" {
    discard;
    stop;
}

# CRITICAL SECURITY ALERTS - Immediate Action Required
if anyof (
    # Account Compromise & Hacking
    header :contains "subject" ["Account Compromised", "Unauthorized Access Detected", 
    "Security Breach Alert", "Account Hacked", "Suspicious Login Activity", 
    "Unknown Device Login", "Login from New Location", "Unusual Account Activity",
    "Account Access from Unrecognized Device", "Multiple Failed Login Attempts",
    "Password Changed by Someone Else", "Account Takeover Detected"],

    # Data Breaches & Major Security Incidents  
    header :contains "subject" ["Data Breach Alert", "Security Incident Report",
    "Your Data May Have Been Compromised", "Security Vulnerability Found",
    "Emergency Security Update", "Critical Security Patch", "Immediate Action Required",
    "Urgent Security Notice", "Personal Information Exposed", "Data Leak Alert"],

    # Account Lockouts & Suspensions
    header :contains "subject" ["Account Locked", "Account Suspended", "Account Frozen",
    "Account Temporarily Disabled", "Account Access Restricted", "Account Banned",
    "Service Suspended", "Account Under Review", "Access Revoked", "Account Deactivated"],

    # Fraud & Financial Security
    header :contains "subject" ["Fraudulent Activity Detected", "Unauthorized Transaction",
    "Payment Method Compromised", "Card Used Unauthorized", "Suspicious Payment Alert",
    "Identity Theft Warning", "Fraud Alert", "Unauthorized Purchase", "Billing Alert",
    "Credit Card Security Alert", "Payment Fraud Detection"]
) {
    # Mark as important and unread for immediate attention
    addflag "\\Flagged";
    removeflag "\\Seen";
    
    # Move to Critical Security folder
    fileinto "Security/Critical";
    
    # Keep for 90 days (important for investigation)
    expire "day" "90";
    
    stop;
}

# PASSWORD & AUTHENTICATION SECURITY
if anyof (
    # Password Changes & Resets
    header :contains "subject" ["Password Changed Successfully", "Password Reset Request",
    "Password Change Confirmation", "Password Updated", "New Password Created",
    "Password Modification Alert", "Password Recovery", "Reset Password Link",
    "Password Reset Verification", "Temporary Password", "Password Expired",
    "Password Will Expire Soon", "Change Your Password", "Weak Password Alert"],

    # Two-Factor Authentication
    header :contains "subject" ["Two-Factor Authentication", "2FA Setup", "2FA Enabled",
    "2FA Disabled", "Authentication Code", "Verification Code", "Security Code",
    "Login Code", "Access Code", "One-Time Password", "OTP Code", "Multi-Factor Authentication",
    "MFA Setup", "Authenticator App", "Backup Codes", "Recovery Codes"],

    # Authentication Methods
    header :contains "subject" ["Security Key Added", "Security Key Removed", 
    "Biometric Authentication", "Fingerprint Added", "Face ID Setup", 
    "Authentication Method Changed", "Login Method Updated", "Backup Authentication", "Disable two-step login"],

    # Account Recovery
    header :contains "subject" ["Account Recovery", "Recovery Email Updated", 
    "Recovery Phone Updated", "Security Questions", "Account Restoration",
    "Identity Verification Required", "Account Verification", "Verify Your Identity", "verify your email address"]
) {
    # Mark as read but important
    addflag "\\Seen";
    addflag "\\Flagged";
    
    # Move to Password & Auth folder
    fileinto "Security/Authentication";
    
    # Keep for 60 days (moderate importance)
    expire "day" "60";
    
    stop;
}

# LOGIN & ACCESS MONITORING
if anyof (
    # New Device & Location Logins
    header :contains "subject" ["New Device Login", "Login from New Location", 
    "Unrecognized Device", "New Browser Login", "First Time Login", 
    "Login Alert", "Access Notification", "Sign-in Alert", "Login Detected",
    "Device Authorization", "New IP Address Login", "Location Change Alert"],

    # Session Management
    header :contains "subject" ["Session Expired", "Session Terminated", "Active Sessions",
    "Session Security", "Remote Logout", "All Sessions Ended", "Session Alert",
    "Login Session", "Device Sessions", "Session Management"],

    # Access Patterns
    header :contains "subject" ["Multiple Login Attempts", "Repeated Login Failures",
    "Access Pattern Alert", "Login Frequency Alert", "Unusual Access Times",
    "Off-Hours Access", "Weekend Login Alert", "Holiday Access Alert"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Login Monitoring folder  
    fileinto "Security/Login";
    
    # Keep for 30 days (tracking purposes)
    expire "day" "30";
    
    stop;
}

# ACCOUNT SETTINGS & PROFILE CHANGES
if anyof (
    # Profile & Personal Information Changes
    header :contains "subject" ["Profile Updated", "Personal Information Changed",
    "Email Address Changed", "Phone Number Updated", "Name Changed", 
    "Address Updated", "Profile Picture Changed", "Account Details Modified",
    "Contact Information Updated", "Personal Data Changed"],

    # Security Settings Changes  
    header :contains "subject" ["Security Settings Updated", "Privacy Settings Changed",
    "Notification Preferences", "Security Preferences", "Account Preferences",
    "Security Configuration", "Privacy Configuration", "Settings Modified"],

    # Permission & Access Changes
    header :contains "subject" ["Account Permissions", "Access Level Changed", 
    "Role Modified", "Permissions Updated", "Access Rights", "Authorization Level",
    "Account Privileges", "Admin Access", "User Role Changed"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Account Changes folder
    fileinto "Security/Changes";
    
    # Keep for 45 days (moderate importance)
    expire "day" "45";
    
    stop;
}

# PAYMENT & BILLING SECURITY
if anyof (
    # Payment Method Changes
    header :contains "subject" ["Payment Method Added", "Credit Card Added",
    "Payment Method Removed", "Card Expired", "Payment Method Updated",
    "Billing Information Changed", "Payment Details Modified", "Card Declined",
    "Payment Failed", "Subscription Payment", "Auto-renewal Failed"],

    # Billing Security
    header :contains "subject" ["Billing Address Changed", "Tax Information Updated",
    "Invoice Generated", "Payment Confirmation", "Refund Processed", 
    "Chargeback Alert", "Billing Dispute", "Payment Verification Required"],

    # Subscription & Service Changes
    header :contains "subject" ["Subscription Cancelled", "Service Downgraded",
    "Service Upgraded", "Plan Changed", "Billing Cycle Modified",
    "Subscription Renewal", "Service Suspended for Payment", "Account Upgraded"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Billing Security folder
    fileinto "Security/Billing";
    
    # Keep for 365 days (financial records)
    expire "day" "365";
    
    stop;
}

# APP & SERVICE PERMISSIONS
if anyof (
    # Third-party App Access
    header :contains "subject" ["App Permission Granted", "Third-party Access",
    "OAuth Authorization", "API Access Granted", "Connected App", "App Connected",
    "Service Connected", "Integration Authorized", "Permission Revoked",
    "App Access Removed", "Connected Service", "External App Access"],

    # Device & Browser Permissions
    header :contains "subject" ["Device Authorized", "Browser Authorized", 
    "Device Permission", "Location Access", "Camera Permission", "Microphone Access",
    "Notification Permission", "Storage Permission", "Contact Permission"],

    # Data Access & Sharing
    header :contains "subject" ["Data Sharing Agreement", "Information Sharing",
    "Data Access Granted", "Privacy Consent", "Data Processing Consent",
    "Data Export Request", "Data Download", "Account Data", "Personal Data Export"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Permissions folder
    fileinto "Security/Permissions";
    
    # Keep for 30 days (moderate importance)
    expire "day" "30";
    
    stop;
}

# COMPLIANCE & LEGAL SECURITY
if anyof (
    # Privacy Law Compliance
    header :contains "subject" ["GDPR Compliance", "CCPA Notice", "Privacy Law Update",
    "Data Protection Notice", "Regulatory Compliance", "Privacy Rights",
    "Data Subject Rights", "Right to Delete", "Data Portability", "Privacy Request"],

    # Legal & Regulatory Updates
    header :contains "subject" ["Terms of Service Update", "Privacy Policy Update",
    "Legal Notice", "Regulatory Change", "Compliance Update", "Policy Amendment",
    "Legal Requirement", "Regulatory Filing", "Audit Notice", "Compliance Report"],

    # Data Retention & Deletion
    header :contains "subject" ["Data Retention Policy", "Data Deletion Schedule",
    "Account Deletion", "Data Purge Notice", "Retention Period", "Data Cleanup",
    "Information Disposal", "Record Retention", "Data Archive"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Compliance folder
    fileinto "Security/Compliance";
    
    # Keep for 90 days (legal importance)
    expire "day" "90";
    
    stop;
}

# SECURITY EDUCATION & TIPS
if anyof (
    # Security Awareness
    header :contains "subject" ["Security Tips", "Security Best Practices", 
    "Security Awareness", "Phishing Alert", "Security Education", 
    "Stay Safe Online", "Security Training", "Cybersecurity Tips",
    "Privacy Tips", "Safety Reminder", "Security Newsletter"],

    # Threat Alerts & Warnings
    header :contains "subject" ["Threat Alert", "Security Warning", "Scam Alert",
    "Phishing Warning", "Malware Alert", "Virus Warning", "Security Threat",
    "Cyber Threat", "Security Advisory", "Safety Alert", "Fraud Warning"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to Education folder
    fileinto "Security/Education";
    
    # Keep for 14 days (educational value)
    expire "day" "14";
    
    stop;
}

# GENERAL SECURITY NOTIFICATIONS
if anyof (
    # Regular Security Updates
    header :contains "subject" ["Security Update", "Security Patch", "Software Update",
    "System Update", "Security Fix", "Vulnerability Patch", "Security Enhancement",
    "Security Improvement", "Protection Update", "Safety Update"],

    # Account Verification & Confirmation
    header :contains "subject" ["Account Verified", "Email Verified", "Phone Verified",
    "Identity Confirmed", "Verification Complete", "Account Activated",
    "Registration Confirmed", "Account Setup Complete", "Welcome Security"],

    # Maintenance & System Changes
    header :contains "subject" ["System Maintenance", "Security Maintenance", 
    "Scheduled Maintenance", "Service Update", "Platform Update", "Infrastructure Update",
    "Server Maintenance", "Database Maintenance", "Network Maintenance"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to General Security folder
    fileinto "Security/General";
    
    # Keep for 21 days (standard security info)
    expire "day" "21";
    
    stop;
}

# Default Security folder for uncategorized security emails
if anyof (
    # Generic security terms that might not fit other categories
    header :contains "subject" ["Security", "Account", "Password", "Login", "Access",
    "Authentication", "Verification", "Alert", "Warning", "Notice", "Update"],
    
    # Security-related senders
    header :contains "from" ["security@", "noreply@", "account@", "admin@", 
    "support@", "notification@", "alerts@", "no-reply@"],
    
    # Common security keywords in body (if subject filtering isn't enough)
    header :contains "subject" ["Protect", "Safe", "Secure", "Privacy", "Confidential"]
) {
    # Mark as read
    addflag "\\Seen";
    
    # Move to main Security folder
    fileinto "Security";
    
    # Default expiration (14 days)
    expire "day" "14";
    
    stop;
}

# End of Security Account Filter