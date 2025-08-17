# Sieve filter
# spam_filter.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters spam messages based on specific subject lines and content patterns.

require ["fileinto", "imap4flags", "reject", "discard", "extlists"];

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

# Filter spam messages
if anyof (
    # ============================================================================
    # 1. FINANCIAL SCAMS & FRAUD
    # ============================================================================
    
    ## Money Transfer & Inheritance Scams
    header :contains "subject" ["Money Transfer", "Lottery Winner", "Inheritance Fund", 
    "Bank Transfer", "Compensation Fund", "ATM Card Delivery", "Western Union Transfer",
    "MoneyGram Payment", "Wire Transfer Alert", "Unclaimed Funds", "Beneficiary Payment",
    "Estate Settlement", "Insurance Claim", "Government Compensation", "UN Compensation Fund"],

    ## Nigerian & Advance Fee Scams
    header :contains "subject" ["Nigerian Prince", "Government Official", "UN Fund Director", 
    "IMF Payment Officer", "World Bank Agent", "Federal Reserve Notice", "Oil Contract Deal",
    "Gold Investment Deal", "Diamond Investment", "Business Partnership Proposal",
    "Confidential Business", "Urgent Business Proposal", "Investment Partnership"],

    ## Cryptocurrency & Investment Scams
    header :contains "subject" ["Cryptocurrency Investment Opportunity", "Bitcoin Mining Profits", 
    "Forex Trading Guaranteed", "Binary Options Winner", "Trading Bot Profits",
    "Get Rich Quick Crypto", "Guaranteed Investment Returns", "High Yield Investment",
    "Risk-Free Investment", "Double Your Bitcoin", "Crypto Mining Contract"],

    # ============================================================================
    # 2. GET RICH QUICK SCHEMES
    # ============================================================================
    
    ## Money-Making Promises
    header :contains "subject" ["Make Money Fast", "Earn $5000 Daily", "Get Rich Quick",
    "Work From Home $$$", "Easy Money Online", "Instant Wealth", "Cash in 24 Hours",
    "Guaranteed Income", "Passive Income Secrets", "Money Making System",
    "Financial Freedom Now", "Millionaire in 30 Days"],

    ## Work From Home Scams
    header :contains "subject" ["Work From Home Opportunity", "Data Entry Jobs $$$",
    "Envelope Stuffing Jobs", "Online Survey Money", "Typing Jobs Online",
    "Assembly Work From Home", "Product Testing Jobs", "Mystery Shopping Jobs",
    "Google Cash Kit", "Amazon Work From Home"],

    # ============================================================================
    # 3. FAKE PRIZES & LOTTERY
    # ============================================================================
    
    ## Prize & Lottery Scams
    header :contains "subject" ["Congratulations Winner", "You've Won $", "Lottery Prize",
    "Sweepstakes Winner", "Cash Prize Alert", "Million Dollar Winner", "Prize Claim",
    "Jackpot Winner", "Contest Winner Notification", "Prize Delivery Notice",
    "Claim Your Prize", "Winner Verification Required"],

    ## Fake Giveaways
    header :contains "subject" ["Free iPhone Giveaway", "Free Gift Card", "Free Amazon Card",
    "Free PlayStation", "Free Laptop Giveaway", "Birthday Giveaway", "Anniversary Gift",
    "Limited Time Giveaway", "Exclusive Gift Offer", "Special Gift Selection"],

    # ============================================================================
    # 4. PHISHING & FAKE ALERTS
    # ============================================================================
    
    ## Account Suspension Scams
    header :contains "subject" ["Account Suspended Immediately", "Urgent Account Verification",
    "Account Will Be Closed", "Verify Account Now", "Account Security Alert",
    "Suspicious Account Activity", "Account Locked Notice", "Immediate Action Required",
    "Account Termination Notice", "Payment Method Expired"],

    ## Fake Security Alerts
    header :contains "subject" ["Security Breach Alert", "Virus Detected on Your PC",
    "Your Computer Is Infected", "Microsoft Security Alert", "Apple Security Warning",
    "Google Security Notice", "PayPal Security Alert", "Bank Security Notice",
    "Credit Card Fraud Alert", "Identity Theft Protection"],

    # ============================================================================
    # 5. ROMANCE & RELATIONSHIP SCAMS
    # ============================================================================
    
    ## Romance Scam Indicators
    header :contains "subject" ["Looking for True Love", "Seeking Serious Relationship",
    "Lonely Heart Seeking Love", "Military Personnel Overseas", "Widowed Looking for Love",
    "Doctor Seeking Partner", "Engineer in Foreign Country", "Business Owner Traveling",
    "Single Parent Seeking Love", "Ready for Marriage"],

    ## Dating Site Spam
    header :contains "subject" ["Hot Singles in Your Area", "Local Dating Alert",
    "Someone Wants to Meet You", "Dating Site Match", "Profile View Alert",
    "Someone Likes You", "New Message from", "Flirt Alert", "Date Request"],

    # ============================================================================
    # 6. HEALTH & PHARMACEUTICAL SCAMS
    # ============================================================================
    
    ## Fake Medical Products
    header :contains "subject" ["Miracle Weight Loss", "Lose 30 Pounds Fast", "Male Enhancement Pills",
    "Viagra Alternative", "Natural Viagra", "Penis Enlargement", "Breast Enhancement",
    "Hair Growth Miracle", "Anti-Aging Secret", "Diabetes Cure", "Cancer Cure Natural"],

    ## Prescription Drug Spam
    header :contains "subject" ["Cheap Viagra Online", "No Prescription Required",
    "Online Pharmacy Discount", "Prescription Drugs Cheap", "Buy Medications Online",
    "Generic Viagra Sale", "Cialis Discount", "Prescription Free Drugs"],

    # ============================================================================
    # 7. FAKE LEGAL THREATS
    # ============================================================================
    
    ## Legal Intimidation Scams
    header :contains "subject" ["Legal Action Against You", "Court Summons", "Lawsuit Filed",
    "Legal Notice Final", "Attorney Notice", "Law Firm Warning", "Legal Department Alert",
    "Cease and Desist Notice", "Copyright Infringement Notice", "Patent Violation Alert"],

    ## Debt Collection Scams
    header :contains "subject" ["Outstanding Debt Notice", "Collection Agency Alert",
    "Payment Overdue Notice", "Debt Settlement Offer", "Wage Garnishment Notice",
    "Tax Lien Notice", "IRS Payment Notice", "Government Debt Notice"],

    # ============================================================================
    # 8. EDUCATION & CERTIFICATION SCAMS
    # ============================================================================
    
    ## Fake Degree & Diploma Mills
    header :contains "subject" ["University Diploma Fast", "College Degree in Days",
    "PhD Certificate Online", "Accredited Degree Program", "Life Experience Degree",
    "No Study Required Degree", "Instant University Degree", "Diploma Mill Certificate"],

    ## Certification Scams
    header :contains "subject" ["Professional Certification Easy", "IT Certification Fast",
    "Medical Certificate Online", "Trade License Quick", "Professional License Easy"],

    # ============================================================================
    # 9. AGGRESSIVE MARKETING LANGUAGE
    # ============================================================================
    
    ## Urgency & Pressure Tactics
    header :contains "subject" ["Act Now or Lose Out", "Limited Time Only", "Offer Expires Today",
    "Last Chance Sale", "Final Notice", "Immediate Response Required", "Don't Miss Out",
    "Once in Lifetime", "Urgent Response Needed", "Time Running Out", "Expires at Midnight"],

    ## Exaggerated Claims
    header :contains "subject" ["100% Guaranteed", "Risk-Free Investment", "No Questions Asked",
    "Money Back Guarantee", "Absolutely Free", "No Catch", "No Strings Attached",
    "Scientifically Proven", "Doctors Recommend", "Celebrity Endorsed"],

    # ============================================================================
    # 10. SUSPICIOUS TECHNICAL PATTERNS
    # ============================================================================
    
    ## RE: Without Original Message
    header :contains "subject" ["RE: (no subject)", "RE: your message", "RE: important",
    "RE: hello", "RE: hi", "RE: urgent", "RE: question", "RE: help"],

    ## Generic/Vague Subjects
    header :contains "subject" ["Important Message for You", "Personal Message",
    "Confidential Information", "Private Message", "Urgent Communication",
    "Special Notification", "Exclusive Information", "Classified Information"],

    # ============================================================================
    # 11. FAKE RELIGIOUS & CHARITY SCAMS
    # ============================================================================
    
    ## Religious Scams
    header :contains "subject" ["Prayer Request Donation", "Church Building Fund",
    "Missionary Needs Help", "Religious Charity Donation", "Pastor Needs Assistance",
    "Biblical Prophecy Money", "God's Blessing Money", "Christian Investment",
    "Faith-Based Investment", "Religious Organization Fund"],

    ## Charity Scams
    header :contains "subject" ["Disaster Relief Donation", "Children's Charity Help",
    "Medical Charity Case", "Orphanage Needs Help", "Cancer Patient Needs",
    "Hurricane Victim Relief", "Earthquake Relief Fund", "Refugee Assistance"],

    # ============================================================================
    # 12. FAKE GOVERNMENT & TAX SCAMS
    # ============================================================================
    
    ## Government Impersonation
    header :contains "subject" ["IRS Tax Refund", "Government Grant Money", "Social Security Benefits",
    "Medicare Refund Check", "Stimulus Payment", "Tax Relief Program", "Government Assistance",
    "Federal Grant Award", "State Benefits Payment", "Unemployment Benefits"],

    ## Immigration Scams
    header :contains "subject" ["Visa Lottery Winner", "Green Card Lottery", "Immigration Help",
    "Visa Processing Fast", "Citizenship Fast Track", "Immigration Attorney"],

    # ============================================================================
    # 13. TECHNOLOGY & SOFTWARE SCAMS
    # ============================================================================
    
    ## Fake Software Offers
    header :contains "subject" ["Free Antivirus Download", "PC Speedup Software",
    "Registry Cleaner Free", "System Optimizer", "Malware Removal Tool",
    "Computer Cleanup Free", "Windows Repair Tool", "Driver Update Software"],

    ## Tech Support Scams
    header :contains "subject" ["Microsoft Tech Support", "Windows Support Alert",
    "Apple Tech Support", "Computer Support Call", "Technical Support Needed",
    "System Error Alert", "Computer Virus Warning", "Security Software Update"]
) {
    # Move to Spam folder
    fileinto "Spam";
    
    # Mark as read to reduce notification
    addflag "\\Seen";
    
    # Delete after 7 days (short retention for spam)
    expire "day" "7";
    
    stop;
}

# Additional spam indicators based on sender patterns
if anyof (
    # Suspicious sender addresses
    header :matches "from" ["*@*.tk", "*@*.ml", "*@*.ga", "*@*.cf", "*@*.gq"],  # Free domains often used by spammers
    header :contains "from" ["noreply@", "no-reply@", "donotreply@"] {
        # But exclude legitimate services (add more as needed)
        not anyof (
            header :contains "from" ["@amazon.com", "@google.com", "@facebook.com", 
            "@microsoft.com", "@apple.com", "@paypal.com", "@ebay.com", "@twitter.com",
            "@linkedin.com", "@instagram.com", "@pinterest.com", "@snapchat.com",
            "@steampowered.com", "@valvesoftware.com", "@discord.com", "@proton.me"]
        )
    },
    
    # Suspicious sender names
    header :contains "from" ["Customer Service", "Account Manager", "Business Partner",
    "Investment Advisor", "Financial Consultant", "Legal Department", "Security Team"],
    
    # Multiple recipients (often spam)
    header :contains "to" [";", ","] {
        # And generic subjects
        header :contains "subject" ["Important", "Urgent", "Notice", "Alert", "Update"]
    }
) {
    fileinto "Spam";
    addflag "\\Seen";
    expire "day" "7";
    stop;
}

# End of Spam Filter