# Legal & Policy Notifications filter -- filter/legal.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/legal.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Terms of service, privacy policy and EULA changes.
#
# Folders: Legal, Legal/Suspicious
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 4 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

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

# End of Legal & Policy Notifications filter
