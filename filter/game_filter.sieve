# Sieve filter
# Filter_Game.sieve
# Only for user use Proton Mail.
# Version: 0.1.0
# This Sieve script filters messages related to gaming service, newspaper, game publisher, etc. and moves them to "Gaming" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists", "date", "relational"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}


# Filter messages related to gaming
if anyof (
    address :domain :matches "from" "${gaming_domains}"
) {
    # Move to "Gaming" folder.
    # Make sure the "Gaming" folder is created. If the folder does not exist, this script will not run.
    fileinto "Gaming";
    # Mark e-mail as read
    addflag "\\Seen";

    # Delete messages containing specific gaming terms in subject after 9 days
    if allof (header :contains "subject" ["game", "update", "patch", "event", "sale", "dlc", "beta", "access", "launch", "announcement", "pre-order", "release", "mod"],
              size :under 500K,
              not header :contains "subject" ["important", "urgent", "critical"]) {
        expire "day" "9";
    }
}

# Reject messages with specific keywords in subject (if not matched above)
elsif allof (header :contains "subject" ["Spam", "Ads", "Offers", "Promotions"]) {
    discard; # Delete the message without notification
    # Optionally, you can use fileinto "Spam"; to move to Spam folder instead
    # Uncomment the line below if you want to move to Spam folder instead of discarding
    # fileinto "Spam";
    reject "Your message has been rejected as it contains unwanted content.";
    
}
else {
    # Fallback: if no conditions matched, keep in Inbox
    addflag "\\Flagged";
}

# End of Sieve script for gaming filter