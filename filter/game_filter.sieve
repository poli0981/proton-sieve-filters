# Sieve filter
# Filter_Game.sieve
# Only for user use Proton Mail.
# Version: 0.1.0 -> 0.2.0 (Optimized, added new filters, and fixed bugs)
# This Sieve script filters messages related to gaming service, newspaper, game publisher, etc. and moves them to "Gaming" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Delete messages if they are in the spam list
if header :list "from" ":incomingdefaults:spam" {
        discard;
        stop;
}

# Filter messages related to gaming
if anyof (

    address :domain :matches "from" ["*steampowered.com", "*epicgames.com", 
    "*gog.com", "*origin.com", "*humblebundle.com", "*steam.com",
    "*itch.io", "*gamefly.com", "*greenmangaming.com", "*gamersgate.com",
    "*getgamesgo.com", "*cheapshark.com", "*beamdog.com", "*desura.com", "*indiedb.com", "*kartridge.com",
    "*goodoldgames.com", "*nintendo.com", "*playstation.com", "*xbox.com",
    "*fanatical.com", "*dlgamer.com", "*gamesplanet.com", "*voidu.com",
    "*wingamestore.com", "*macgamestore.com", "*direct2drive.com",
    "*ubisoft.com", "*battle.net", "*rockstargames.com",
    "*square-enix-games.com", "*capcom.com", "*bandainamcoent.com",
    "*sega.com", "*bethesda.net", "*frontier.com"],              # Game distribution platforms and publishers

    address :domain :matches "from" ["*blizzard.com", "*riotgames.com", "*ea.com",
    "*activision.com", "*cdprojekt.com", "*valve.com","*bandainamco.com",
    "*konami.com", "*take2games.com", "*cdprojektred.com",
    "*paradoxinteractive.com", "*focus-home.com","*thqnordic.com",
    "*embracer.com","*devolverdigital.com", "*team17.com", "*annapurnainteractive.com",
    "*rawfury.com", "*curvegames.com", "*tinybuild.com",
    "*versus-evil.com","*505games.com", "*gearboxsoftware.com",
    "*frontier.co.uk", "*larian.com","*fromsoftware.jp",
    "*kojimaproductions.jp", "*supergiantgames.com",
    "*thatgamecompany.com", "*hellogames.co.uk",
    "*nomanssky.com", "*dontnod-entertainment.com","*asobostudio.com",
    "*arkane-studios.com", "*idsoftware.com", "*respawn.com",
    "*criteriongames.com", "*dice.se", "*bioware.com",
    "*ghostship.dk", "*coffee-stain.com","*fatsharkgames.com",
    "*sabergames.com", "*taleworlds.com",
    "*amplitude-studios.com", "*firaxis.com",
    "*2k.com", "*hangargames.com", "*relic.com", "*volition-inc.com",
    "*deepsilver.com", "*crytek.com", "*techland.net", "*peoplecanfly.com",
    "*flyingwildhog.com", "*blooberteam.com",
    "*11bitstudios.com", "*fdg-entertainment.com", "*fatdoggames.com",
    "*mandragoragames.com", "*beamable.com","*fungies.io",
    "*udonis.co", "*arimiadev.com", "*ninichimusic.com", "*87kgames.com"], # Game developers and publishers

    address :domain :matches "from" ["*metacritic.com","*ign.com", "*gamespot.com",
    "*kotaku.com", "*polygon.com", "*eurogamer.net","*vg247.com",
    "*gamesindustry.biz", "*pcgamer.com","*rockpapershotgun.com",
    "*destructoid.com", "*gamerant.com","*thegamer.com",
    "*gameinformer.com", "*gamepro.com", "*nintendolife.com", "*pushsquare.com",
    "*purexbox.com", "*gamesradar.com","*edge-online.com",
    "*gamedaily.com", "*gamefaqs.com","*gamefront.com",
    "*gamesdomain.com","*gamespy.com", "*escapistmagazine.com",
    "*joystiq.com", "*shacknews.com", "*giantbomb.com",
    "*dualshockers.com", "*siliconera.com","*gematsu.com",
    "*famitsu.com","*dengekionline.com","*4gamer.net",
    "*cdaction.pl", "*playmeter.com",
    "*replaymag.com","*cgmpublishinggroup.com","*gry.wp.pl",
    "*archive.org", "*gamingmagz.com", "*sierragamers.com",
    "*hoogspel.nl", "*mcmbuzz.com", "*ndw.jp",
    "*magzter.com", "*abandonware-magazines.org",
    "*retromags.com", "*shop.pixel-magazine.com",
    "*thesegalounge.com", "*bloggers.feedspot.com",
    "*prnews.io", "*codesupply.co","*quartertothree.com"], # Gaming news and review sites

    address :domain :matches "from" ["*esl.gg", "*faceit.com",
    "*globalesportsfederation.org", "*mlg.com","*dreamhack.com",
    "*liquipedia.net", "*egamersworld.com", "*escharts.com","*ten.gg",
    "*dealroom.co", "*builtin.com", "*crustlab.com", "*esportsinsider.com",
    "*streamscharts.com", "*inven.ai", "*pley.gg",
    "*app.dealroom.co","*g2esports.com","*teamliquid.com", "*tsm.gg",
    "*100thieves.com", "*themongolz.gg","*gaimingladiators.gg",
    "*parivision.gg", "*fnatic.com", "*cloud9.gg",
    "*fazeclan.com", "*opticgaming.com","*nrg.gg",
    "*sentinels.gg","*evilgeniuses.gg", "*karminecorp.gg",
    "*koi.gg", "*moist.gg", "*joblife.gg","*mandatory.gg",
    "*repeat.gg", "*turtle-entertainment.com"],

    address :domain :matches "from" ["*cdkeys.com", "*kinguin.net", "*eneba.com", "*allkeyshop.com",
    "*k4g.com", "*g2a.com", "*vbrae.com","*buy-keys.com","*gg.deals","*indiegala.com", "*newegg.com"],
    # Key resellers and gaming deals

    address :domain :matches "from" ["*mihoyo.com", "*hoyoverse.com", "*hypergryph.com",
    "*cygames.jp", "*aniplex.co.jp", "*plarium.com", "*netease.com",
    "*tencent.com", "*manjuu.com", "*panstudio.com", "*yostar.com",
    "*ennead.cc", "*revillution.net", "*noobfeed.com", "*beebom.com",
    "*resetera.com", "*nrvnqsr.com"]            # Gacha games and mobile gaming
){
       # Mark as read
    addflag "\\Seen";
    # Move to Gaming folder first
    fileinto "Gaming";

    # Delete Playtest/ Beta Test Messages
    if anyof (
        header :contains "subject" ["Playtest", "Early Access", "Beta Invite", "Playtest Invitation", "Early Access Beta", 
        "Test Our Game", "You're Invited to Beta", "Beta Program Access", "Join Beta Testing", "Exclusive Beta",
        "Beta Registration", "Try Beta Now"],
        size :under 500K
    ) {
        expire "day" "21";
    }

    # Delete notification sales
    if anyof (
        header :contains "subject" ["your Steam wishlist is now on sale","steam sale", "Steam Sale Alert", "Epic Deals Now", "Discount on Games", "Flash Sale Steam", "Weekly Deals Epic", 
        "Game Discounts Live", "Steam Midweek Madness", "Epic Mega Sale","Holiday Sale Steam"
        , "Bundle Deals Now", "Summer Sale", "Winter Sale", "Spring Sale", "Autumn Sale", "Epic Games Sale", "Steam Sale Event"]
    ) {
        expire "day" "5";
    }

    # Delete messages about News
    if anyof (
        header :contains "subject" ["IGN Daily News", "Gamespot Update", "Breaking Gaming News", "IGN Review Roundup", "Gamespot Newsletter",
        "Daily Gaming Digest", "IGN Top Stories", "Gamespot Game Releases", "Weekly Gaming Recap", "IGN Insider News",
        "gaming news", "weekly roundup", "latest updates", "breaking gaming", "game newsletter", "daily digest", "news alert",
        "industry news", "esports update", "review roundup", "top stories gaming"],
        size :under 500K
    ) {
        expire "day" "2";
    }
    
    # Delete messages about Recipts, purchases, Orders or Invoice
    if anyof (
        header :contains "subject" ["Purchase Confirmation", "Your Game Receipt", "Order Invoice", 
        "Digital Purchase Details", "Game Buy Receipt", "Transaction Summary", 
        "Your Order Shipped", "Payment Confirmation", "Receipt for Game", "Invoice Attached", "Epic Games Receipt", "Steam purchase"],
        size :under 500K
    ) {
        expire "day" "14";
    }

    # Delete messages about Game Updates, Patches
    if anyof (
        header :contains "subject" ["Patch Notes", "Hotfix", "Patch Notes Released", "Game Update Available", 
        "Version X Patch", "Update Notes Inside", "New Patch Details", "Balance Update", "Bug Fix Patch", 
        "Maintenance Update", "Hotfix Notes", "Game Version Update", "Version Update", "Patch Release Notes",
        "Server Update"],
        size :under 500K
    ) {
        expire "day" "7";
    }

    # Delete mess about DLC
        if anyof (
        header :contains "subject" ["New DLC Available", "Expansion Release",
        "DLC Launch Alert", "Add-On Now Live", "Download New DLC", "DLC Content Update", 
        "Season Pass DLC", "Free DLC Drop", "Premium DLC Out", "Story DLC Released"],
        size :under 500K
    ) {
        expire "day" "7";
    }

    # Delete Event
        if anyof ( header :contains "subject" ["live event", "Upcoming Game Event", "Event Registration Open", 
        "Join Our Event", "Live Event Alert", "Gaming Expo Invite", "In-Game Event", 
        "Community Event", "Tournament Announcement", "Webinar on Games",
        "Special Event Details", "holiday event", "limited event"],
        size :under 500K
    ) {
        expire "day" "10";
    }

    # Delete messages about Pre-Order and Release Date
            if anyof ( header :contains "subject" ["Available on Steam","Pre-Order Reminder", "Your Pre-Order Update", "Pre-Order Now Live",
             "Secure Your Pre-Order", "Pre-Order Bonus Alert", "Reminder: Pre-Order Ends", 
             "Game Pre-Order Details", "Early Pre-Order Access", "Pre-Order Confirmation", "Don't Miss Pre-Order"],
        size :under 500K
    ) {
        expire "day" "3";
    }

    # Messages Community Update
    if anyof (
        header :contains "subject" ["Community Newsletter", "Insider Community Update", "Forum Update Alert", 
        "Player Community News", "Dev Community Post", "Weekly Community Recap", 
        "Community Feedback Update", "Server Community News", "Guild Update", 
        "Fan Community Digest", "Dev Community Insights", "Community Engagement News",
        "Dev Diary", "Community Spotlight", "Player Community Highlights"],
        size :under 500K
    ) {
        expire "day" "7";
    }

    stop;
}