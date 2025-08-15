# Sieve filter
# Filter_Social.sieve
# Only for user use Proton Mail
# Version: 0.1.0
# This Sieve script filters messages from social networks and moves them to "Social Account" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal"{
    stop;
}

# Filter messages from social networks
if anyof (
    address :domain :matches "from" "*x.com",
    address :domain :matches "from" "*twitter.com",
    address :domain :matches "from" "*tiktok.com",
    address :domain :matches "from" "*instagram.com",
    address :domain :matches "from" "*bsky.social",
    address :domain :matches "from" "*twitch.tv",
    address :domain :matches "from" "*pinterest.com",
    address :domain :matches "from" "*facebookmail.com",
    address :domain :matches "from" "*linkedin.com",
    address :domain :matches "from" "*snapchat.com",
    address :domain :matches "from" "*last.fm",
    address :domain :matches "from" "*redditmail.com",
    address :domain :matches "from" "*google.com",
    address :domain :matches "from" "*youtube.com",
    address :domain :matches "from" "*deviantart.com",
    address :domain :matches "from" "*mastodon.social",
    address :domain :matches "from" "*discord.com",
    address :domain :matches "from" "*tumblr.com",
    address :domain :matches "from" "*flickr.com",
    address :domain :matches "from" "*vk.com",
    address :domain :matches "from" "*quora.com",
    address :domain :matches "from" "*medium.com",
    address :domain :matches "from" "*spotify.com"
) {
    # Mark e-mail as read
    addflag "\\Seen";
    # Move to "Social Account" folder
    fileinto "Social Account";

    # Delete messages containing "alert", "notification", etc. in subject after 7 days
    if allof (header :contains "subject" ["alert", "notification", "update", "reminder"],
              size :under 500K)
              {
        expire "day" "7";
    }
}

# Reject messages with specific keywords in subject (if not matched above)
elsif allof (header :contains "subject" ["Spam", "Ads", "Offers", "Promotions"]) {
    fileinto "Spam";
}
else {
    # Fallback: if no conditions matched, keep in Inbox
    addflag "\\Flagged";
}
# End of Sieve script