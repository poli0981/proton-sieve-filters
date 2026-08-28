# Gaming filter -- filter/gaming.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/gaming.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Game stores, publishers, esports and gaming news.
#
# Folders: Gaming
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 10 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Drop what Proton already knows is spam.
if header :list "from" ":incomingdefaults:spam" {
    discard;
    stop;
}

if anyof (
    address :domain :matches "from" ["100thieves.com", "*.100thieves.com",
        "11bitstudios.com", "*.11bitstudios.com", "2k.com", "*.2k.com", "4gamer.net",
        "*.4gamer.net", "505games.com", "*.505games.com", "87kgames.com",
        "*.87kgames.com", "abandonware-magazines.org", "*.abandonware-magazines.org",
        "activision.com", "*.activision.com", "allkeyshop.com", "*.allkeyshop.com",
        "amplitude-studios.com", "*.amplitude-studios.com", "aniplex.co.jp",
        "*.aniplex.co.jp", "annapurnainteractive.com", "*.annapurnainteractive.com",
        "app.dealroom.co", "*.app.dealroom.co", "archive.org", "*.archive.org",
        "arimiadev.com", "*.arimiadev.com", "arkane-studios.com",
        "*.arkane-studios.com", "asobostudio.com", "*.asobostudio.com",
        "bandainamco.com", "*.bandainamco.com", "bandainamcoent.com",
        "*.bandainamcoent.com", "battle.net", "*.battle.net", "beamable.com",
        "*.beamable.com", "beamdog.com", "*.beamdog.com", "beebom.com", "*.beebom.com",
        "bethesda.net", "*.bethesda.net", "bioware.com", "*.bioware.com",
        "blizzard.com", "*.blizzard.com", "bloggers.feedspot.com",
        "*.bloggers.feedspot.com", "blooberteam.com", "*.blooberteam.com",
        "builtin.com", "*.builtin.com", "buy-keys.com", "*.buy-keys.com", "capcom.com",
        "*.capcom.com", "cdaction.pl", "*.cdaction.pl", "cdkeys.com", "*.cdkeys.com",
        "cdprojekt.com", "*.cdprojekt.com", "cdprojektred.com", "*.cdprojektred.com",
        "cgmpublishinggroup.com", "*.cgmpublishinggroup.com", "cheapshark.com",
        "*.cheapshark.com", "cloud9.gg", "*.cloud9.gg", "codesupply.co",
        "*.codesupply.co", "coffee-stain.com", "*.coffee-stain.com",
        "criteriongames.com", "*.criteriongames.com", "crustlab.com", "*.crustlab.com",
        "crytek.com", "*.crytek.com", "curvegames.com", "*.curvegames.com",
        "cygames.jp", "*.cygames.jp", "dealroom.co", "*.dealroom.co", "deepsilver.com",
        "*.deepsilver.com", "dengekionline.com", "*.dengekionline.com",
        "destructoid.com", "*.destructoid.com", "devolverdigital.com",
        "*.devolverdigital.com", "dice.se", "*.dice.se", "direct2drive.com",
        "*.direct2drive.com", "dlgamer.com", "*.dlgamer.com",
        "dontnod-entertainment.com", "*.dontnod-entertainment.com", "dreamhack.com",
        "*.dreamhack.com", "dualshockers.com", "*.dualshockers.com", "ea.com",
        "*.ea.com", "edge-online.com", "*.edge-online.com", "egamersworld.com",
        "*.egamersworld.com", "embracer.com", "*.embracer.com", "eneba.com",
        "*.eneba.com", "ennead.cc", "*.ennead.cc", "epicgames.com", "*.epicgames.com",
        "escapistmagazine.com", "*.escapistmagazine.com", "escharts.com",
        "*.escharts.com", "esl.gg", "*.esl.gg", "esportsinsider.com",
        "*.esportsinsider.com", "eurogamer.net", "*.eurogamer.net", "evilgeniuses.gg",
        "*.evilgeniuses.gg", "faceit.com", "*.faceit.com", "famitsu.com",
        "*.famitsu.com", "fanatical.com", "*.fanatical.com", "fatdoggames.com",
        "*.fatdoggames.com", "fatsharkgames.com", "*.fatsharkgames.com", "fazeclan.com",
        "*.fazeclan.com", "fdg-entertainment.com", "*.fdg-entertainment.com",
        "firaxis.com", "*.firaxis.com", "flyingwildhog.com", "*.flyingwildhog.com",
        "fnatic.com", "*.fnatic.com", "focus-home.com", "*.focus-home.com",
        "fromsoftware.jp", "*.fromsoftware.jp", "frontier.co.uk", "*.frontier.co.uk",
        "fungies.io", "*.fungies.io", "g2a.com", "*.g2a.com", "g2esports.com",
        "*.g2esports.com", "gaimingladiators.gg", "*.gaimingladiators.gg",
        "gamedaily.com", "*.gamedaily.com", "gamefaqs.com", "*.gamefaqs.com",
        "gamefly.com", "*.gamefly.com", "gamefront.com", "*.gamefront.com",
        "gameinformer.com", "*.gameinformer.com", "gamepro.com", "*.gamepro.com",
        "gamerant.com", "*.gamerant.com", "gamersgate.com", "*.gamersgate.com",
        "gamesdomain.com", "*.gamesdomain.com", "gamesindustry.biz",
        "*.gamesindustry.biz", "gamesplanet.com", "*.gamesplanet.com", "gamespot.com",
        "*.gamespot.com", "gamesradar.com", "*.gamesradar.com", "gamingmagz.com",
        "*.gamingmagz.com", "gearboxsoftware.com", "*.gearboxsoftware.com",
        "gematsu.com", "*.gematsu.com", "getgamesgo.com", "*.getgamesgo.com",
        "gg.deals", "*.gg.deals", "ghostship.dk", "*.ghostship.dk", "giantbomb.com",
        "*.giantbomb.com", "globalesportsfederation.org",
        "*.globalesportsfederation.org", "gog.com", "*.gog.com", "goodoldgames.com",
        "*.goodoldgames.com", "greenmangaming.com", "*.greenmangaming.com", "gry.wp.pl",
        "*.gry.wp.pl", "hangargames.com", "*.hangargames.com", "hellogames.co.uk",
        "*.hellogames.co.uk", "hoogspel.nl", "*.hoogspel.nl", "hoyoverse.com",
        "*.hoyoverse.com", "humblebundle.com", "*.humblebundle.com", "hypergryph.com",
        "*.hypergryph.com", "idsoftware.com", "*.idsoftware.com", "ign.com",
        "*.ign.com", "indiedb.com", "*.indiedb.com", "indiegala.com", "*.indiegala.com",
        "inven.ai", "*.inven.ai", "itch.io", "*.itch.io", "joblife.gg", "*.joblife.gg",
        "k4g.com", "*.k4g.com", "karminecorp.gg", "*.karminecorp.gg", "kartridge.com",
        "*.kartridge.com", "kinguin.net", "*.kinguin.net", "koi.gg", "*.koi.gg",
        "kojimaproductions.jp", "*.kojimaproductions.jp", "konami.com", "*.konami.com",
        "kotaku.com", "*.kotaku.com", "larian.com", "*.larian.com", "liquipedia.net",
        "*.liquipedia.net", "macgamestore.com", "*.macgamestore.com", "magzter.com",
        "*.magzter.com", "mandatory.gg", "*.mandatory.gg", "mandragoragames.com",
        "*.mandragoragames.com", "manjuu.com", "*.manjuu.com", "mcmbuzz.com",
        "*.mcmbuzz.com", "metacritic.com", "*.metacritic.com", "mihoyo.com",
        "*.mihoyo.com", "mlg.com", "*.mlg.com", "moist.gg", "*.moist.gg", "ndw.jp",
        "*.ndw.jp", "netease.com", "*.netease.com", "newegg.com", "*.newegg.com",
        "ninichimusic.com", "*.ninichimusic.com", "nintendo.com", "*.nintendo.com",
        "nintendolife.com", "*.nintendolife.com", "nomanssky.com", "*.nomanssky.com",
        "noobfeed.com", "*.noobfeed.com", "nrg.gg", "*.nrg.gg", "nrvnqsr.com",
        "*.nrvnqsr.com", "opticgaming.com", "*.opticgaming.com", "origin.com",
        "*.origin.com", "panstudio.com", "*.panstudio.com", "paradoxinteractive.com",
        "*.paradoxinteractive.com", "parivision.gg", "*.parivision.gg", "pcgamer.com",
        "*.pcgamer.com", "peoplecanfly.com", "*.peoplecanfly.com", "plarium.com",
        "*.plarium.com", "playmeter.com", "*.playmeter.com", "playstation.com",
        "*.playstation.com", "pley.gg", "*.pley.gg", "polygon.com", "*.polygon.com",
        "prnews.io", "*.prnews.io", "purexbox.com", "*.purexbox.com", "pushsquare.com",
        "*.pushsquare.com", "quartertothree.com", "*.quartertothree.com", "rawfury.com",
        "*.rawfury.com", "relic.com", "*.relic.com", "repeat.gg", "*.repeat.gg",
        "replaymag.com", "*.replaymag.com", "resetera.com", "*.resetera.com",
        "respawn.com", "*.respawn.com", "retromags.com", "*.retromags.com",
        "revillution.net", "*.revillution.net", "riotgames.com", "*.riotgames.com",
        "rockpapershotgun.com", "*.rockpapershotgun.com", "rockstargames.com",
        "*.rockstargames.com", "sabergames.com", "*.sabergames.com", "sega.com",
        "*.sega.com", "sentinels.gg", "*.sentinels.gg", "shacknews.com",
        "*.shacknews.com", "shop.pixel-magazine.com", "*.shop.pixel-magazine.com",
        "sierragamers.com", "*.sierragamers.com", "siliconera.com", "*.siliconera.com",
        "square-enix-games.com", "*.square-enix-games.com", "steampowered.com",
        "*.steampowered.com", "streamscharts.com", "*.streamscharts.com",
        "supergiantgames.com", "*.supergiantgames.com", "take2games.com",
        "*.take2games.com", "taleworlds.com", "*.taleworlds.com", "team17.com",
        "*.team17.com", "teamliquid.com", "*.teamliquid.com", "techland.net",
        "*.techland.net", "ten.gg", "*.ten.gg", "tencent.com", "*.tencent.com",
        "thatgamecompany.com", "*.thatgamecompany.com", "thegamer.com",
        "*.thegamer.com", "themongolz.gg", "*.themongolz.gg", "thesegalounge.com",
        "*.thesegalounge.com", "thqnordic.com", "*.thqnordic.com", "tinybuild.com",
        "*.tinybuild.com", "tsm.gg", "*.tsm.gg", "turtle-entertainment.com",
        "*.turtle-entertainment.com", "ubisoft.com", "*.ubisoft.com", "udonis.co",
        "*.udonis.co", "valve.com", "*.valve.com", "vbrae.com", "*.vbrae.com",
        "versus-evil.com", "*.versus-evil.com", "vg247.com", "*.vg247.com", "voidu.com",
        "*.voidu.com", "volition-inc.com", "*.volition-inc.com", "wingamestore.com",
        "*.wingamestore.com", "xbox.com", "*.xbox.com", "yostar.com", "*.yostar.com"],
    header :contains "subject" ["Trò chơi mới", "Cập nhật game", "Bản vá lỗi",
        "Sự kiện trong game", "Giảm giá game", "Mua game", "Hóa đơn game",
        "Tin tức game", "Cộng đồng game", "Beta test", "DLC mới", "Tải trước", "游戏更新",
        "补丁下载", "游戏折扣", "预购游戏", "游戏新闻", "社区更新", "测试邀请", "DLC发布", "游戏活动", "购买确认", "游戏收据",
        "开发日记", "ゲームアップデート", "パッチノート", "ゲームセール", "先行予約", "ゲームニュース", "コミュニティ更新",
        "ベータテスト", "DLCリリース", "ゲームイベント", "購入確認", "ゲームレシート", "開発者日記"]
) {
    addflag "\\Seen";
    fileinto "Gaming";

    if allof (
        header :contains "subject" ["Playtest", "Early Access", "Beta Invite",
            "Playtest Invitation", "Early Access Beta", "Test Our Game",
            "You're Invited to Beta", "Beta Program Access", "Join Beta Testing",
            "Exclusive Beta", "Beta Registration", "Try Beta Now"],
        size :under 500K
    ) {
        expire "day" "21";

        stop;
    }

    if header :contains "subject" ["your Steam wishlist is now on sale", "steam sale",
        "Steam Sale Alert", "Epic Deals Now", "Discount on Games",
        "Flash Sale Steam", "Weekly Deals Epic", "Game Discounts Live",
        "Steam Midweek Madness", "Epic Mega Sale", "Holiday Sale Steam",
        "Bundle Deals Now", "Summer Sale", "Winter Sale", "Spring Sale",
        "Autumn Sale", "Epic Games Sale", "Steam Sale Event"] {
        expire "day" "5";

        stop;
    }

    if allof (
        header :contains "subject" ["IGN Daily News", "Gamespot Update",
            "Breaking Gaming News", "IGN Review Roundup", "Gamespot Newsletter",
            "Daily Gaming Digest", "IGN Top Stories", "Gamespot Game Releases",
            "Weekly Gaming Recap", "IGN Insider News", "gaming news", "weekly roundup",
            "latest updates", "breaking gaming", "game newsletter", "daily digest",
            "news alert", "industry news", "esports update", "review roundup",
            "top stories gaming"],
        size :under 500K
    ) {
        expire "day" "2";

        stop;
    }

    if allof (
        header :contains "subject" ["Purchase Confirmation", "Your Game Receipt",
            "Order Invoice", "Digital Purchase Details", "Game Buy Receipt",
            "Transaction Summary", "Your Order Shipped", "Payment Confirmation",
            "Receipt for Game", "Invoice Attached", "Epic Games Receipt",
            "Steam purchase"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Patch Notes", "Hotfix", "Patch Notes Released",
            "Game Update Available", "Version X Patch", "Update Notes Inside",
            "New Patch Details", "Balance Update", "Bug Fix Patch",
            "Maintenance Update", "Hotfix Notes", "Game Version Update",
            "Version Update", "Patch Release Notes", "Server Update"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["New DLC Available", "Expansion Release",
            "DLC Launch Alert", "Add-On Now Live", "Download New DLC",
            "DLC Content Update", "Season Pass DLC", "Free DLC Drop", "Premium DLC Out",
            "Story DLC Released"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["live event", "Upcoming Game Event",
            "Event Registration Open", "Join Our Event", "Live Event Alert",
            "Gaming Expo Invite", "In-Game Event", "Community Event",
            "Tournament Announcement", "Webinar on Games", "Special Event Details",
            "holiday event", "limited event"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    if allof (
        header :contains "subject" ["Available on Steam", "Pre-Order Reminder",
            "Your Pre-Order Update", "Pre-Order Now Live", "Secure Your Pre-Order",
            "Pre-Order Bonus Alert", "Reminder: Pre-Order Ends",
            "Game Pre-Order Details", "Early Pre-Order Access",
            "Pre-Order Confirmation", "Don't Miss Pre-Order"],
        size :under 500K
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Community Newsletter", "Insider Community Update",
            "Forum Update Alert", "Player Community News", "Dev Community Post",
            "Weekly Community Recap", "Community Feedback Update",
            "Server Community News", "Guild Update", "Fan Community Digest",
            "Dev Community Insights", "Community Engagement News", "Dev Diary",
            "Community Spotlight", "Player Community Highlights"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    stop;
}

# End of Gaming filter
