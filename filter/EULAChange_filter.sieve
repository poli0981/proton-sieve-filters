# Sieve filter
# Legal_Notifications_filter.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters legal notifications (EULA, ToS, Privacy Policy, Data Collection changes) and moves them to "Legal" folder.

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

# Filter legal notifications and policy changes
if anyof (
    # EULA (End User License Agreement) changes
    header :contains "subject" ["EULA Update", "EULA Change", "EULA Revision", "EULA Amendment", 
    "Updated EULA", "New EULA Version", "EULA Modification", "License Agreement Change",
    "License Agreement Update", "Software License Change", "End User License Agreement"],

    # Terms of Service changes
    header :contains "subject" ["Terms of Service", "Terms of Use", "ToS Update", "ToS Change",
    "Updated Terms", "Terms Change", "Service Terms Update", "Terms Revision",
    "Terms Amendment", "Terms Modification", "User Agreement", "Service Agreement",
    "Terms and Conditions", "T&C Update", "Updated T&C"],

    # Privacy Policy changes
    header :contains "subject" ["Privacy Policy", "Privacy Update", "Privacy Change", 
    "Updated Privacy Policy", "Privacy Revision", "Privacy Amendment", "Privacy Notice",
    "Data Privacy Update", "Privacy Settings", "Privacy Preferences", "Privacy Rights"],

    # Data Collection and Processing changes
    header :contains "subject" ["Data Collection", "Data Processing", "Data Usage", "Data Policy",
    "Cookie Policy", "Tracking Policy", "Data Protection", "Data Handling", "Data Rights",
    "Personal Data", "Information Collection", "Data Retention", "Data Sharing"],

    # GDPR and Compliance notifications
    header :contains "subject" ["GDPR Update", "GDPR Compliance", "Data Protection Regulation",
    "CCPA Notice", "California Privacy Rights", "Compliance Update", "Regulatory Change",
    "Legal Compliance", "Privacy Law", "Data Law"],

    # General legal and policy terms
    header :contains "subject" ["Legal Update", "Legal Notice", "Legal Change", "Policy Update",
    "Policy Change", "Policy Revision", "Policy Amendment", "Agreement Update",
    "Agreement Change", "Contract Update", "Legal Terms", "Regulatory Update"],

    # Community Guidelines and Content Policy
    header :contains "subject" ["Community Guidelines", "Content Policy", "Community Standards",
    "Acceptable Use Policy", "Code of Conduct", "Platform Rules", "Usage Guidelines",
    "Community Rules", "Content Standards", "Behavior Policy"],

    # Security and Account Policy changes
    header :contains "subject" ["Security Policy", "Account Policy", "Access Policy", 
    "Authentication Policy", "Password Policy", "Two-Factor Authentication",
    "Account Security", "Login Policy", "Security Update"],

    # Specific legal document types
    header :contains "subject" ["Master Service Agreement", "SLA Update", "Service Level Agreement",
    "Subscription Agreement", "Purchase Agreement", "Billing Terms", "Payment Terms",
    "Refund Policy", "Cancellation Policy", "Subscription Terms"]
) {
    # Mark email as read
    addflag "\\Seen";

    # Move to "Legal" folder
    fileinto "Legal";

    # Set different expiration based on importance and type
    
    # Critical legal changes - keep longer (30 days)
    if anyof (
        header :contains "subject" ["important", "urgent", "critical", "mandatory", "required",
        "action required", "must read", "compliance", "legal requirement"],
        header :contains "from" ["legal@", "compliance@", "privacy@", "security@"]
    ) {
        expire "day" "30";
        stop;
    }

    # GDPR and major privacy law changes - keep longer (21 days)
    if anyof (
        header :contains "subject" ["GDPR", "CCPA", "Data Protection Regulation", 
        "Privacy Law", "Data Law", "Regulatory Change"],
        size :over 100K  # Detailed legal documents are usually larger
    ) {
        expire "day" "21";
        stop;
    }

    # Security policy changes - important for account safety (14 days)
    if header :contains "subject" ["Security Policy", "Account Policy", "Authentication Policy",
    "Password Policy", "Two-Factor", "Account Security", "Login Policy"] {
        expire "day" "14";
        stop;
    }

    # Regular policy updates - standard retention (7 days)
    if allof (
        size :under 200K,  # Smaller, routine notifications
        not header :contains "subject" ["breaking", "major change", "significant update"]
    ) {
        expire "day" "7";
        stop;
    }

    # Default expiration for other legal notifications (10 days)
    expire "day" "10";
    
    stop;
}

# Filter potential legal spam and phishing
if anyof (
    # Fake legal threats
    header :contains "subject" ["Legal Action", "Lawsuit", "Court Notice", "Summons",
    "Legal Proceeding", "Cease and Desist", "Copyright Violation", "DMCA",
    "Intellectual Property", "Patent Infringement"],
    
    # Suspicious legal language
    header :contains "subject" ["Immediate Legal Action", "Legal Department", "Law Firm",
    "Attorney Notice", "Legal Warning", "Legal Violation"],
    
    # But exclude legitimate sources
    not anyof (
        # Legitimate legal domains (add your known legitimate sources)
        address :domain :matches "from" ["*government.gov", "*gov.uk", "*europa.eu",
        "*eff.org", "*aclu.org", "*legalaid.org"],
        
        # Known service providers
        header :list "from" ":addrbook:personal"
    )
) {
    # Move suspicious legal emails to a separate folder for review
    fileinto "Legal/Suspicious";
    addflag "\\Flagged";
    expire "day" "30"; 
    stop;
}

# End of Legal Notifications Filter