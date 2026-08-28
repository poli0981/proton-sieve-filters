# Spam filter -- filter/spam.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/spam.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Additional spam heuristics beyond Proton's own.
#
# Folders: Spam
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 1 of 22. Filters run in the order you install them,
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

# End of Spam filter
