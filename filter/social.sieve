# Social Media filter -- filter/social.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/social.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Social network notifications.
#
# Folders: Social Account, Spam
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 11 of 14. Filters run in the order you install them, and on
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

# Known typosquats of the services this filter handles. These are lookalike
# domains, not the real senders -- flag them instead of filing them away.
if address :domain :matches "from" ["faceb00k.com", "*.faceb00k.com", "lnkedin.com",
    "*.lnkedin.com", "twiter.com", "*.twiter.com", "youutube.com", "*.youutube.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if address :domain :matches "from" ["17.live", "*.17.live", "air.chat", "*.air.chat",
    "ameba.jp", "*.ameba.jp", "askfm.com", "*.askfm.com", "badoo.com",
    "*.badoo.com", "beeper.com", "*.beeper.com", "behance.net", "*.behance.net",
    "bere.al", "*.bere.al", "bigo.tv", "*.bigo.tv", "blogger.com", "*.blogger.com",
    "briarproject.org", "*.briarproject.org", "bsky.social", "*.bsky.social",
    "bumble.com", "*.bumble.com", "careerbuilder.com", "*.careerbuilder.com",
    "clubhouse.com", "*.clubhouse.com", "coverstar.com", "*.coverstar.com",
    "curse.com", "*.curse.com", "cyworld.com", "*.cyworld.com", "digg.com",
    "*.digg.com", "dingtalk.com", "*.dingtalk.com", "discord.com", "*.discord.com",
    "dispo.fun", "*.dispo.fun", "douyin.com", "*.douyin.com", "eharmony.com",
    "*.eharmony.com", "element.io", "*.element.io", "facebook.com",
    "*.facebook.com", "feishu.cn", "*.feishu.cn", "fiverr.com", "*.fiverr.com",
    "freelancer.com", "*.freelancer.com", "friendster.com", "*.friendster.com",
    "getsession.org", "*.getsession.org", "giphy.com", "*.giphy.com",
    "glassdoor.com", "*.glassdoor.com", "gree.jp", "*.gree.jp", "guilded.gg",
    "*.guilded.gg", "guru.com", "*.guru.com", "hackernews.com", "*.hackernews.com",
    "hi5.com", "*.hi5.com", "hinge.co", "*.hinge.co", "imgur.com", "*.imgur.com",
    "indeed.com", "*.indeed.com", "instagram.com", "*.instagram.com", "jagat.io",
    "*.jagat.io", "kakao.com", "*.kakao.com", "kick.com", "*.kick.com", "lapse.com",
    "*.lapse.com", "lark.com", "*.lark.com", "line.me", "*.line.me", "liveme.com",
    "*.liveme.com", "mastodon.social", "*.mastodon.social", "match.com",
    "*.match.com", "matrix.org", "*.matrix.org", "mattermost.com",
    "*.mattermost.com", "messenger.com", "*.messenger.com", "mewe.com",
    "*.mewe.com", "migente.com", "*.migente.com", "mixi.jp", "*.mixi.jp",
    "monster.com", "*.monster.com", "mumble.info", "*.mumble.info", "myspace.com",
    "*.myspace.com", "niconico.jp", "*.niconico.jp", "noplace.com", "*.noplace.com",
    "obs.live", "*.obs.live", "odnoklassniki.ru", "*.odnoklassniki.ru", "ok.ru",
    "*.ok.ru", "okcupid.com", "*.okcupid.com", "overwolf.com", "*.overwolf.com",
    "pinterest.com", "*.pinterest.com", "pixiv.net", "*.pixiv.net",
    "plentyoffish.com", "*.plentyoffish.com", "poparazzi.com", "*.poparazzi.com",
    "qq.com", "*.qq.com", "raidcall.com", "*.raidcall.com", "restream.io",
    "*.restream.io", "revolt.chat", "*.revolt.chat", "rocket.chat", "*.rocket.chat",
    "sharechat.com", "*.sharechat.com", "signal.org", "*.signal.org", "skype.com",
    "*.skype.com", "slack.com", "*.slack.com", "slashdot.org", "*.slashdot.org",
    "snapchat.com", "*.snapchat.com", "sonico.com", "*.sonico.com", "spaces.live",
    "*.spaces.live", "steam.com", "*.steam.com", "streamlabs.com",
    "*.streamlabs.com", "streamyard.com", "*.streamyard.com", "tagged.com",
    "*.tagged.com", "taringa.net", "*.taringa.net", "teamspeak.com",
    "*.teamspeak.com", "telegram.org", "*.telegram.org", "tenor.com", "*.tenor.com",
    "tenten.app", "*.tenten.app", "texts.com", "*.texts.com", "threads.net",
    "*.threads.net", "threema.ch", "*.threema.ch", "tiktok.com", "*.tiktok.com",
    "toptal.com", "*.toptal.com", "tuenti.com", "*.tuenti.com", "tumblr.com",
    "*.tumblr.com", "twitch.tv", "*.twitch.tv", "twitter.com", "*.twitter.com",
    "uplive.com", "*.uplive.com", "upwork.com", "*.upwork.com", "ventrilo.com",
    "*.ventrilo.com", "vero.co", "*.vero.co", "viber.com", "*.viber.com", "vk.com",
    "*.vk.com", "wechat.com", "*.wechat.com", "weibo.com", "*.weibo.com",
    "whatsapp.com", "*.whatsapp.com", "wickr.com", "*.wickr.com", "wire.com",
    "*.wire.com", "wordpress.com", "*.wordpress.com", "x.com", "*.x.com",
    "xiaohongshu.com", "*.xiaohongshu.com", "xing.com", "*.xing.com", "younow.com",
    "*.younow.com", "zalo.me", "*.zalo.me", "ziprecruiter.com",
    "*.ziprecruiter.com", "zoosk.com", "*.zoosk.com"] {
    addflag "\\Seen";
    fileinto "Social Account";

    if allof (
        header :contains "subject" ["Friend Request", "New Friend",
            "Connection Request", "Like Notification", "New Like", "Post Liked",
            "Share Alert", "Post Shared", "Live Stream Started", "Live Now",
            "Message Read", "Seen Your Message", "Comment Added", "New Comment",
            "Tag Notification", "You Were Tagged", "Follow Request", "New Follower",
            "Notification", "Activity Alert", "Story Update", "Status Update",
            "Mention Alert", "Reply Notification"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Locked", "Ban Notification",
            "Restriction Alert", "Weak Password Warning", "Password Change Required",
            "Hack Detected", "Unauthorized Access", "Security Breach",
            "Account Compromised", "Login Attempt Alert", "Two-Factor Setup",
            "Verification Code", "Suspicious Activity", "Account Suspended",
            "Password Reset", "Security Warning", "Login Alert", "New Device Login"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Event Invite", "Group Invitation", "Join Event",
            "Community Event", "Live Event Alert", "Invitation Accepted",
            "RSVP Reminder", "Event Notification", "Party Invite", "Meetup Alert",
            "Calendar Invite", "Meeting Invite", "Webinar Invite", "Conference Invite",
            "Workshop Invite"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Platform Update", "New Feature Alert",
            "App Update Available", "Version Release", "Feature Launch",
            "System Maintenance", "Update Notes", "News Digest", "Weekly Recap",
            "Platform Changes", "Service Update", "Bug Fix", "Performance Improvement",
            "New Version", "Release Notes"],
        size :under 500K
    ) {
        expire "day" "5";

        stop;
    }

    if allof (
        header :contains "subject" ["Sponsored Content", "Deal Alert", "Promo Code",
            "Special Offer Inside", "Ad Notification", "Partner Promotion",
            "Discount Reminder", "Flash Deal", "Limited Promo", "Sponsored Post",
            "Advertisement", "Promoted Content", "Marketing Message",
            "Brand Partnership", "Product Launch", "Sale Alert", "Coupon Code",
            "Exclusive Offer"],
        size :under 500K
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Weekly Digest", "Monthly Summary",
            "Activity Summary", "Weekly Roundup", "Monthly Report", "Your Week",
            "Your Month", "Stats Summary", "Usage Report", "Engagement Report",
            "Performance Summary"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    stop;
}

if header :contains "subject" ["Fake Profile Alert", "Scam Warning",
    "Phishing Attempt", "Suspicious Account", "Report Fake Account",
    "Identity Theft Warning", "Romance Scam", "Investment Scam",
    "Cryptocurrency Scam"] {
    addflag "\\Seen";
    fileinto "Social Account";

    stop;
}

# End of Social Media filter
