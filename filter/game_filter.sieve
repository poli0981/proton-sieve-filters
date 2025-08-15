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
    # Store gaming-related domains here
    address :domain :is "from" "steampowered.com",
    address :domain :is "from" "epicgames.com",
    address :domain :is "from" "gog.com",
    address :domain :matches "from" "*origin.com",
    address :domain :is "from" "humblebundle.com",
    address :domain :matches "from" "*steam.com",
    address :domain :is "from" "itch.io",
    address :domain :is "from" "gamefly.com",
    address :domain :is "from" "greenmangaming.com",
    address :domain :is "from" "gamersgate.com",
    address :domain :is "from" "getgamesgo.com",
    address :domain :is "from" "cheapshark.com",
    address :domain :is "from" "beamdog.com",
    address :domain :is "from" "desura.com",
    address :domain :is "from" "indiedb.com",
    address :domain :is "from" "kartridge.com",
    address :domain :is "from" "goodoldgames.com",
    address :domain :is "from" "nintendo.com",
    address :domain :is "from" "playstation.com",
    address :domain :is "from" "xbox.com",
    address :domain :is "from" "fanatical.com",
    address :domain :is "from" "dlgamer.com",
    address :domain :is "from" "gamesplanet.com",
    address :domain :is "from" "voidu.com",
    address :domain :is "from" "wingamestore.com",
    address :domain :is "from" "macgamestore.com",
    address :domain :is "from" "direct2drive.com",
    address :domain :matches "from" "*ubisoft.com",
    address :domain :matches "from" "*battle.net",
    address :domain :matches "from" "*rockstargames.com",
    address :domain :matches "from" "*square-enix-games.com",
    address :domain :matches "from" "*capcom.com",
    address :domain :matches "from" "*bandainamcoent.com",
    address :domain :matches "from" "*sega.com",
    address :domain :matches "from" "*bethesda.net",
    address :domain :is "from" "frontier.com",

    # Dev and publisher domains
    address :domain :is "from" "blizzard.com",
    address :domain :is "from" "riotgames.com",
    address :domain :is "from" "ea.com",
    address :domain :is "from" "activision.com",
    address :domain :is "from" "cdprojekt.com",
    address :domain :is "from" "valve.com",
    address :domain :is "from" "bandainamco.com",
    address :domain :is "from" "konami.com",
    address :domain :is "from" "take2games.com",
    address :domain :is "from" "cdprojektred.com",
    address :domain :is "from" "paradoxinteractive.com",
    address :domain :is "from" "focus-home.com",
    address :domain :is "from" "thqnordic.com",
    address :domain :is "from" "embracer.com",
    address :domain :is "from" "devolverdigital.com",
    address :domain :is "from" "team17.com",
    address :domain :is "from" "annapurnainteractive.com",
    address :domain :is "from" "rawfury.com",
    address :domain :is "from" "curvegames.com",
    address :domain :is "from" "tinybuild.com",
    address :domain :is "from" "versus-evil.com",
    address :domain :matches "from" "*505games.com",
    address :domain :matches "from" "*gearboxsoftware.com",
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