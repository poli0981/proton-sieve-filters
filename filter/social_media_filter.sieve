# Sieve filter
# Filter_Social.sieve
# Only for user use Proton Mail
# Version: 0.1.0
# This Sieve script filters messages from social networks and moves them to "Social Account" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if anyof (
    header :list "from" ":addrbook:personal",
    header :list "from" ":addrbook:myself"
){
    stop;
}

# Delete messages if they are in the spam list
if header :list "from" ":incomingdefaults:spam" {
        discard;
        stop;
}

# Filter messages from social networks
if anyof (
    # Social media domains
    address :domain :matches "from" "*facebook.com",
    address :domain :matches "from" "*instagram.com",
    address :domain :matches "from" "*tiktok.com",
    address :domain :matches "from" "*x.com",  # X (formerly Twitter)
    address :domain :matches "from" "*linkedin.com",
    address :domain :matches "from" "*reddit.com",
    address :domain :matches "from" "*pinterest.com",
    address :domain :matches "from" "*youtube.com",
    address :domain :matches "from" "*threads.net",
    address :domain :matches "from" "*discord.com",
    address :domain :matches "from" "*snapchat.com",
    address :domain :matches "from" "*bsky.social",
    address :domain :matches "from" "*mastodon.social",
    address :domain :matches "from" "*bere.al",
    address :domain :matches "from" "*vero.co",
    address :domain :matches "from" "*mewe.com",
    address :domain :matches "from" "*noplace.com",
    address :domain :matches "from" "*tenten.app",
    address :domain :matches "from" "*air.chat",
    address :domain :matches "from" "*substack.com",
    address :domain :matches "from" "*coverstar.com",
    address :domain :matches "from" "*jagat.io",
    address :domain :matches "from" "*twitch.tv",
    address :domain :matches "from" "*kick.com",
    address :domain :matches "from" "*vk.com",

    # Messaging apps domains
    address :domain :matches "from" "*whatsapp.com",
    address :domain :matches "from" "*wechat.com",
    address :domain :matches "from" "*messenger.com",
    address :domain :matches "from" "*telegram.org",
    address :domain :matches "from" "*viber.com",
    address :domain :matches "from" "*line.me",
    address :domain :matches "from" "*signal.org",
    address :domain :matches "from" "*apple.com", # iMessage
    address :domain :matches "from" "*kakao.com",
    address :domain :matches "from" "*zalo.me",
    address :domain :matches "from" "*skype.com",
    address :domain :matches "from" "*briarproject.org",
    address :domain :matches "from" "*getsession.org",
    address :domain :matches "from" "*beeper.com",
    address :domain :matches "from" "*texts.com"

    ) {
    # Mark e-mail as read
    addflag "\\Seen";
    # Move to "Social Account" folder
    fileinto "Social Account";

    # Delete mail about social media notifications
    if allof (header :contains "subject" ["Friend Request", "New Friend", "Connection Request",
    "Like Notification", "New Like", "Post Liked", "Share Alert", "Post Shared", "Live Stream Started",
    "Live Now", "Message Read", "Seen Your Message", "Comment Added", "New Comment", "Tag Notification",
    "You Were Tagged", "Follow Request", "New Follower", "Notfication"],
              size :under 500K) {
            expire "day" "1";
    }

    # EULA/Terms/Policy Updates
    if allof (header :contains "subject" ["EULA Update", "Terms Change", "Policy Revision",
     "Updated Terms of Service", "License Agreement Change", "New EULA Version", 
     "Service Terms Update", "Agreement Modification", "Legal Update Alert", "Policy Amendment", 
     "Privacy Policy Update", "ToS Changes", "Data Policy Revision"],
              size :under 500K) {
        expire "day" "2";
    }

    if allof (header :contains "subject" ["Account Locked", "Ban Notification", "Restriction Alert", "Weak Password Warning", "Password Change Required", "Hack Detected", "Unauthorized Access", "Security Breach", "Account Compromised", "Login Attempt Alert", "Two-Factor Setup", "Verification Code", "Suspicious Activity", "Account Suspended", "Password Reset"],
              size :under 500K) {
        expire "day" "28";
    }

    # Invites/Events
    if allof (header :contains "subject" ["Event Invite", "Group Invitation", "Join Event",
            "Community Event", "Live Event Alert", "Invitation Accepted", "RSVP Reminder",
            "Event Notification", "Party Invite", "Meetup Alert"],
              size :under 500K) {
        expire "day" "7";
    }

    # Platform Updates/News
    if allof (header :contains "subject" ["Platform Update", "New Feature Alert", "App Update Available",
            "Version Release", "Feature Launch", "System Maintenance", "Update Notes",
            "News Digest", "Weekly Recap", "Platform Changes"],
              size :under 500K) {
        expire "day" "5";
    }

    # Delete e-mail about Promo/Ads
    if allof (header :contains "subject" ["Sponsored Content", "Deal Alert", "Promo Code",
     "Special Offer Inside", "Ad Notification", "Partner Promotion",
      "Discount Reminder", "Flash Deal", "Limited Promo", "Sponsored Post"],
              size :under 500K) {
        expire "day" "3";
    }
    stop;
}

# Reject messages with specific keywords in subject (if not matched above)
elsif anyof (
    header :contains "subject" ["100% free", "act now", "apply now", "avoid bankruptcy"],
    header :contains "subject" ["bargain", "best price", "big money", "beneficiary"],
    header :contains "subject" ["cash", "claims", "debt", "earn cash"],
    header :contains "subject" ["earn extra cash", "earn money", "free", "get rich quick"],
    header :contains "subject" ["make money", "make money fast", "money back", "quote"],
    header :contains "subject" ["refinance", "save big money", "winner", "bonus"],
    header :contains "subject" ["big bucks", "cash bonus", "cheap", "credit"],
    header :contains "subject" ["discount", "double your income", "earn $", "extra income"],
    header :contains "subject" ["fast cash", "financial freedom", "for just $", "hidden assets"],
    header :contains "subject" ["income from home", "increase sales", "increase traffic", "insurance"],
    header :contains "subject" ["investment", "lowest price", "luxury", "millionaire"],
    header :contains "subject" ["money making", "no cost", "no fees", "offer"],
    header :contains "subject" ["one time", "pennies a day", "potential earnings", "profit"],
    header :contains "subject" ["pure profit", "risk free", "save $", "serious cash"],
    header :contains "subject" ["unlimited", "buy now", "call now", "click here"],
    header :contains "subject" ["don't miss out", "exclusive deal", "expires", "for a limited time"],
    header :contains "subject" ["hurry", "immediate action", "last chance", "limited time"],
    header :contains "subject" ["limited time offer", "now only", "offer expires", "once in a lifetime"],
    header :contains "subject" ["only", "order now", "special promotion", "time limited"],
    header :contains "subject" ["today only", "urgent", "while supplies last", "24 hours"],
    header :contains "subject" ["don't delay", "get it now", "instant", "new"],
    header :contains "subject" ["required", "action", "request", "blank subject"],
    header :contains "subject" ["file", "message", "update", "100% satisfied"],
    header :contains "subject" ["all new", "as seen on", "best deal", "best offer"],
    header :contains "subject" ["buy direct", "cancel at any time", "check or money order", "congratulations"],
    header :contains "subject" ["deal", "direct email", "direct marketing", "ecommerce"],
    header :contains "subject" ["email marketing", "get started now", "gift certificate", "great offer"],
    header :contains "subject" ["guarantee", "information you requested", "internet marketing", "join millions"],
    header :contains "subject" ["marketing solutions", "mass email", "member", "no gimmick"],
    header :contains "subject" ["no obligation", "no questions asked", "no strings attached", "not spam"],
    header :contains "subject" ["online marketing", "opt in", "performance", "pre-approved"],
    header :contains "subject" ["promotion", "sale", "sales", "search engine"],
    header :contains "subject" ["shopping spree", "sign up free", "special offer", "supplies limited"],
    header :contains "subject" ["take action", "this won't last", "trial", "unsubscribe"],
    header :contains "subject" ["visit our website", "web traffic", "weekend getaway", "what are you waiting for"],
    header :contains "subject" ["while you sleep", "will not believe your eyes", "work from home", "all natural"],
    header :contains "subject" ["anti-aging", "cures", "lose weight", "medicine"],
    header :contains "subject" ["miracle cure", "no prescription needed", "online pharmacy", "pure and natural"],
    header :contains "subject" ["remove wrinkles", "reverses aging", "stop snoring", "viagra"],
    header :contains "subject" ["weight loss", "wonder drug", "youthful", "affordable healthcare"],
    header :contains "subject" ["diet", "enlarge", "hair loss", "human growth hormone"],
    header :contains "subject" ["life insurance", "lose weight fast", "medical", "meds"],
    header :contains "subject" ["pharmaceuticals", "prescription", "sample", "score with babes"],
    header :contains "subject" ["valium", "vicodin", "xanax", "acceptance"],
    header :contains "subject" ["accordingly", "avoid", "be your own boss", "believe me"],
    header :contains "subject" ["being a member", "bulk email", "chance", "confidentiality"],
    header :contains "subject" ["dormant", "freedom", "get out of debt", "here"],
    header :contains "subject" ["hidden", "if only", "important information", "info you requested"],
    header :contains "subject" ["information", "legal", "maintained", "meet singles"],
    header :contains "subject" ["message contains", "multi level marketing", "multi-level marketing", "no catch"],
    header :contains "subject" ["no credit check", "no hidden costs", "no investment", "no middleman"],
    header :contains "subject" ["no purchase necessary", "no refund", "no risk", "not intended"],
    header :contains "subject" ["obligation", "offshore", "one hundred percent guaranteed", "opportunity"],
    header :contains "subject" ["password", "passwords", "problem", "promise"],
    header :contains "subject" ["promises", "removal", "requires initial investment", "reserves the right"],
    header :contains "subject" ["risk-free", "satisfaction", "save big", "score"],
    header :contains "subject" ["search engines", "see for yourself", "sent in compliance", "serious only"],
    header :contains "subject" ["social security number", "stainless steel", "stock alert", "stock disclaimer statement"],
    header :contains "subject" ["stock pick", "stop", "strong buy", "stuff"],
    header :contains "subject" ["subject to", "terms", "they keep your", "this isn't junk"],
    header :contains "subject" ["this isn't spam", "undisclosed", "university diplomas", "us dollars"],
    header :contains "subject" ["warranty", "we hate spam", "why pay more", "will not"],
    header :contains "subject" ["winner", "winning", "winnings", "you are a winner"],
    header :contains "subject" ["you have been selected", "your chance", "zero chance", "adult"],
    header :contains "subject" ["casino", "cialis", "copy dvds", "form"],
    header :contains "subject" ["free hosting", "free website", "friend", "friendship"],
    header :contains "subject" ["get paid", "inc", "increase your chances", "internet"],
    header :contains "subject" ["investment decision", "junk", "levitra", "lotto"],
    header :contains "subject" ["mail in order form", "mlm", "nigerian", "no age restrictions"],
    header :contains "subject" ["no claim forms", "no disappointment", "no inventory", "no medical exams"],
    header :contains "subject" ["no selling", "not junk", "now", "number one"],
    header :contains "subject" ["oasis", "online biz opportunity", "online degree", "online income"],
    header :contains "subject" ["open", "opt-in", "order", "order shipped by"],
    header :contains "subject" ["order status", "orders shipped by", "per day", "per week"],
    header :contains "subject" ["print form signature", "print out and fax", "priority mail", "produced and sent out"],
    header :contains "subject" ["profits", "promise you", "removal instructions", "remove"],
    header :contains "subject" ["removes", "reply remove subject", "reverse", "rolex"],
    header :contains "subject" ["round the world", "s 1618", "safemail", "save up to"],
    header :contains "subject" ["search engine listings", "section 301", "shopping spree", "sign up free today"],
    header :contains "subject" ["subject to credit", "supplies", "take action now", "talks about prizes"],
    header :contains "subject" ["talks about search engine listings", "tells you it's an ad", "terms and conditions", "the best rates"],
    header :contains "subject" ["the following form", "they keep your money", "they're just giving it away", "this won't last"],
    header :contains "subject" ["thousands", "traffic", "vacation", "vacation offers"],
    header :contains "subject" ["we honor all", "weekend getaway", "what are you waiting for?"],
    header :contains "subject" ["while supplies last", "who really wins?", "why pay more?"],
    header :contains "subject" ["will not believe your eyes", "win", "work at home"],
    header :contains "subject" ["www", "you are a winner!", "your income"]
) {
    fileinto "Spam";
    stop;

    # reject "Blocked as spam";  # Uncomment IF YOU USE reject
    # discard;  # Uncomment IF YOU USE discard
}

else {
    # Fallback: if no conditions matched, keep in Inbox
    addflag "\\Flagged";
}
# End of Sieve script