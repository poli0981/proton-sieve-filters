# Sieve filter
# Filter_Social.sieve
# Only for user use Proton Mail
# Version: 0.1.0 -> 0.2.0
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

# Filter messages from social networks and messaging platforms
if anyof (
    # Major social media platforms
    address :domain :matches "from" ["*facebook.com", "*instagram.com", "*tiktok.com",
    "*x.com", "*twitter.com", "*linkedin.com", "*reddit.com", "*pinterest.com",
    "*youtube.com", "*threads.net", "*snapchat.com", "*twitch.tv", "*kick.com"],

    # Alternative and emerging social platforms
    address :domain :matches "from" ["*bsky.social", "*mastodon.social", "*bere.al",
    "*vero.co", "*mewe.com", "*noplace.com", "*tenten.app", "*air.chat",
    "*substack.com", "*coverstar.com", "*jagat.io", "*vk.com", "*ok.ru",
    "*weibo.com", "*douyin.com", "*xiaohongshu.com", "*clubhouse.com",
    "*spaces.live", "*poparazzi.com", "*dispo.fun", "*lapse.com"],

    # Professional and business networks
    address :domain :matches "from" ["*xing.com", "*meetup.com", "*eventbrite.com",
    "*sharechat.com", "*bumble.com", "*hinge.co", "*badoo.com", "*plenty offish.com",
    "*zoosk.com", "*match.com", "*eharmony.com", "*okcupid.com"],

    # Gaming and streaming social platforms
    address :domain :matches "from" ["*steam.com", "*discord.com", "*guilded.gg",
    "*revolt.chat", "*teamspeak.com", "*mumble.info", "*ventrilo.com",
    "*raidcall.com", "*curse.com", "*overwolf.com"],

    # Messaging apps and communication platforms
    address :domain :matches "from" ["*whatsapp.com", "*wechat.com", "*messenger.com",
    "*telegram.org", "*viber.com", "*line.me", "*signal.org", "*apple.com",
    "*kakao.com", "*zalo.me", "*skype.com", "*briarproject.org",
    "*getsession.org", "*beeper.com", "*texts.com"],

    # International messaging platforms
    address :domain :matches "from" ["*wechat.com", "*qq.com", "*dingtalk.com",
    "*feishu.cn", "*lark.com", "*slack.com", "*mattermost.com", "*rocket.chat",
    "*element.io", "*matrix.org", "*wire.com", "*threema.ch", "*wickr.com"],

    # Regional social platforms
    address :domain :matches "from" ["*odnoklassniki.ru", "*taringa.net", "*orkut.com",
    "*myspace.com", "*friendster.com", "*hi5.com", "*tagged.com", "*badoo.com",
    "*migente.com", "*sonico.com", "*tuenti.com", "*cyworld.com", "*mixi.jp",
    "*gree.jp", "*ameba.jp", "*pixiv.net", "*niconico.jp"],

    # Content creation and sharing platforms
    address :domain :matches "from" ["*medium.com", "*wordpress.com", "*blogger.com",
    "*tumblr.com", "*deviantart.com", "*behance.net", "*dribbble.com",
    "*500px.com", "*flickr.com", "*imgur.com", "*giphy.com", "*tenor.com"],

    # Live streaming and video platforms
    address :domain :matches "from" ["*periscope.tv", "*meerkat.co", "*bigo.tv",
    "*liveme.com", "*younow.com", "*17.live", "*uplive.com", "*streamlabs.com",
    "*obs.live", "*restream.io", "*streamyard.com"],

    # Professional and career platforms
    address :domain :matches "from" ["*glassdoor.com", "*indeed.com", "*monster.com",
    "*careerbuilder.com", "*ziprecruiter.com", "*upwork.com", "*freelancer.com",
    "*fiverr.com", "*toptal.com", "*guru.com"],

    # Community and forum platforms
    address :domain :matches "from" ["*stackexchange.com", "*stackoverflow.com",
    "*quora.com", "*askfm.com", "*answers.yahoo.com", "*reddit.com",
    "*digg.com", "*stumbleupon.com", "*slashdot.org", "*hackernews.com"],

    # Voice and audio social platforms
    address :domain :matches "from" ["*spotify.com", "*soundcloud.com", "*anchor.fm",
    "*castbox.fm", "*podbean.com", "*buzzsprout.com", "*libsyn.com",
    "*spreaker.com", "*audioboom.com", "*stitcher.com"]

    ) {
    # Move to "Social Account" folder first
    fileinto "Social Account";
    
    # Mark email as read
    addflag "\\Seen";

    # Social media notifications (expire 1 day)
    if allof (
        header :contains "subject" ["Friend Request", "New Friend", "Connection Request",
        "Like Notification", "New Like", "Post Liked", "Share Alert", "Post Shared", 
        "Live Stream Started", "Live Now", "Message Read", "Seen Your Message", 
        "Comment Added", "New Comment", "Tag Notification", "You Were Tagged", 
        "Follow Request", "New Follower", "Notification", "Activity Alert",
        "Story Update", "Status Update", "Mention Alert", "Reply Notification"],
        size :under 500K
    ) {
        expire "day" "1";
    }

    # Security alerts (expire 28 days - important to keep for reference)
    if allof (
        header :contains "subject" ["Account Locked", "Ban Notification", "Restriction Alert", 
        "Weak Password Warning", "Password Change Required", "Hack Detected", 
        "Unauthorized Access", "Security Breach", "Account Compromised", 
        "Login Attempt Alert", "Two-Factor Setup", "Verification Code", 
        "Suspicious Activity", "Account Suspended", "Password Reset",
        "Security Warning", "Login Alert", "New Device Login"],
        size :under 500K
    ) {
        expire "day" "28";
    }

    # Invites/Events (expire 7 days)
    if allof (
        header :contains "subject" ["Event Invite", "Group Invitation", "Join Event",
        "Community Event", "Live Event Alert", "Invitation Accepted", "RSVP Reminder",
        "Event Notification", "Party Invite", "Meetup Alert", "Calendar Invite",
        "Meeting Invite", "Webinar Invite", "Conference Invite", "Workshop Invite"],
        size :under 500K
    ) {
        expire "day" "7";
    }

    # Platform Updates/News (expire 5 days)
    if allof (
        header :contains "subject" ["Platform Update", "New Feature Alert", "App Update Available",
        "Version Release", "Feature Launch", "System Maintenance", "Update Notes",
        "News Digest", "Weekly Recap", "Platform Changes", "Service Update",
        "Bug Fix", "Performance Improvement", "New Version", "Release Notes"],
        size :under 500K
    ) {
        expire "day" "5";
    }

    # Promotional content (expire 3 days)
    if allof (
        header :contains "subject" ["Sponsored Content", "Deal Alert", "Promo Code",
        "Special Offer Inside", "Ad Notification", "Partner Promotion",
        "Discount Reminder", "Flash Deal", "Limited Promo", "Sponsored Post",
        "Advertisement", "Promoted Content", "Marketing Message", "Brand Partnership",
        "Product Launch", "Sale Alert", "Coupon Code", "Exclusive Offer"],
        size :under 500K
    ) {
        expire "day" "3";
    }

    # Weekly/Monthly digests (expire 10 days)
    if allof (
        header :contains "subject" ["Weekly Digest", "Monthly Summary", "Activity Summary",
        "Weekly Roundup", "Monthly Report", "Your Week", "Your Month", "Stats Summary",
        "Usage Report", "Engagement Report", "Performance Summary"],
        size :under 500K
    ) {
        expire "day" "10";
    }

    stop;
}

# Filter social media spam and fake accounts
if anyof (
    header :contains "subject" ["Fake Profile Alert", "Scam Warning", "Phishing Attempt",
    "Suspicious Account", "Report Fake Account", "Identity Theft Warning",
    "Romance Scam", "Investment Scam", "Cryptocurrency Scam"],
    header :contains "from" ["noreply", "no-reply", "donotreply", "do-not-reply"]
) {
    # Keep these for security reference
    fileinto "Social Account";
    addflag "\\Seen";
    stop;
}

# End of Social Media Filter