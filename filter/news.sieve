# News & Newsletters filter -- filter/news.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/news.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# News outlets and newsletter platforms.
#
# Folders: News, News/Business, News/Entertainment, News/Politics, News/Science,
#          News/Sports, News/Tech, News/Weather, News/World
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 10 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if address :domain :matches "from" ["9to5mac.com", "*.9to5mac.com", "abcnews.com",
    "*.abcnews.com", "accuweather.com", "*.accuweather.com", "aljazeera.com",
    "*.aljazeera.com", "androidpolice.com", "*.androidpolice.com", "ansa.it",
    "*.ansa.it", "apnews.com", "*.apnews.com", "arstechnica.com",
    "*.arstechnica.com", "athleticnews.com", "*.athleticnews.com", "avclub.com",
    "*.avclub.com", "axios.com", "*.axios.com", "ballotpedia.org",
    "*.ballotpedia.org", "barrons.com", "*.barrons.com", "beehiiv.com",
    "*.beehiiv.com", "bleacherreport.com", "*.bleacherreport.com", "bloomberg.com",
    "*.bloomberg.com", "bostonglobe.com", "*.bostonglobe.com", "breitbart.com",
    "*.breitbart.com", "businessinsider.com", "*.businessinsider.com",
    "buzzfeed.com", "*.buzzfeed.com", "c4isrnet.com", "*.c4isrnet.com",
    "campaignmonitor.com", "*.campaignmonitor.com", "cbsnews.com", "*.cbsnews.com",
    "cbssports.com", "*.cbssports.com", "cdc.gov", "*.cdc.gov",
    "chicagotribune.com", "*.chicagotribune.com", "cleveland.com",
    "*.cleveland.com", "cnbc.com", "*.cnbc.com", "cnet.com", "*.cnet.com",
    "cnn.com", "*.cnn.com", "constantcontact.com", "*.constantcontact.com",
    "convertkit.com", "*.convertkit.com", "cookpolitical.com",
    "*.cookpolitical.com", "cyberscoop.com", "*.cyberscoop.com", "dailykos.com",
    "*.dailykos.com", "dailywire.com", "*.dailywire.com", "dallasnews.com",
    "*.dallasnews.com", "defensenews.com", "*.defensenews.com", "denverpost.com",
    "*.denverpost.com", "dw.com", "*.dw.com", "economist.com", "*.economist.com",
    "engadget.com", "*.engadget.com", "espn.com", "*.espn.com", "fastcompany.com",
    "*.fastcompany.com", "federalnewsnetwork.com", "*.federalnewsnetwork.com",
    "firetimes.com", "*.firetimes.com", "fool.com", "*.fool.com", "forbes.com",
    "*.forbes.com", "fortune.com", "*.fortune.com", "foxnews.com", "*.foxnews.com",
    "foxsports.com", "*.foxsports.com", "france24.com", "*.france24.com", "ft.com",
    "*.ft.com", "getpocket.com", "*.getpocket.com", "ghost.org", "*.ghost.org",
    "gizmodo.com", "*.gizmodo.com", "govtech.com", "*.govtech.com", "harpers.org",
    "*.harpers.org", "houstonchronicle.com", "*.houstonchronicle.com",
    "huffpost.com", "*.huffpost.com", "inc.com", "*.inc.com", "jacobinmag.com",
    "*.jacobinmag.com", "kyodonews.net", "*.kyodonews.net", "latimes.com",
    "*.latimes.com", "livescience.com", "*.livescience.com", "mailchimp.com",
    "*.mailchimp.com", "marketwatch.com", "*.marketwatch.com", "mashable.com",
    "*.mashable.com", "medium.com", "*.medium.com", "miamiherald.com",
    "*.miamiherald.com", "militarytimes.com", "*.militarytimes.com", "money.com",
    "*.money.com", "motherjones.com", "*.motherjones.com", "msnbc.com",
    "*.msnbc.com", "nationaljournal.com", "*.nationaljournal.com",
    "nationalreview.com", "*.nationalreview.com", "nbcnews.com", "*.nbcnews.com",
    "nbcsports.com", "*.nbcsports.com", "newrepublic.com", "*.newrepublic.com",
    "newscientist.com", "*.newscientist.com", "newsletter.com", "*.newsletter.com",
    "newyorker.com", "*.newyorker.com", "noaa.gov", "*.noaa.gov", "nola.com",
    "*.nola.com", "nws.noaa.gov", "*.nws.noaa.gov", "nypost.com", "*.nypost.com",
    "nytimes.com", "*.nytimes.com", "oregonlive.com", "*.oregonlive.com", "pbs.org",
    "*.pbs.org", "policyone.com", "*.policyone.com", "politico.com",
    "*.politico.com", "pri.org", "*.pri.org", "propublica.org", "*.propublica.org",
    "quartz.com", "*.quartz.com", "reason.com", "*.reason.com", "redstate.com",
    "*.redstate.com", "reuters.com", "*.reuters.com", "revealnews.org",
    "*.revealnews.org", "rollcall.com", "*.rollcall.com", "rollingstone.com",
    "*.rollingstone.com", "rt.com", "*.rt.com", "salon.com", "*.salon.com",
    "sbnation.com", "*.sbnation.com", "sciencedaily.com", "*.sciencedaily.com",
    "sciencemag.org", "*.sciencemag.org", "scientificamerican.com",
    "*.scientificamerican.com", "seattletimes.com", "*.seattletimes.com",
    "sfgate.com", "*.sfgate.com", "si.com", "*.si.com", "skysports.com",
    "*.skysports.com", "slate.com", "*.slate.com", "space.com", "*.space.com",
    "sputniknews.com", "*.sputniknews.com", "substack.com", "*.substack.com",
    "tass.com", "*.tass.com", "techcrunch.com", "*.techcrunch.com", "techradar.com",
    "*.techradar.com", "theathletic.com", "*.theathletic.com", "theatlantic.com",
    "*.theatlantic.com", "thedailybeast.com", "*.thedailybeast.com",
    "theguardian.com", "*.theguardian.com", "thehill.com", "*.thehill.com",
    "theintercept.com", "*.theintercept.com", "thenation.com", "*.thenation.com",
    "theregister.com", "*.theregister.com", "theringer.com", "*.theringer.com",
    "theverge.com", "*.theverge.com", "townhall.com", "*.townhall.com",
    "usatoday.com", "*.usatoday.com", "usnews.com", "*.usnews.com",
    "venturebeat.com", "*.venturebeat.com", "vox.com", "*.vox.com", "vulture.com",
    "*.vulture.com", "washingtonpost.com", "*.washingtonpost.com", "weather.com",
    "*.weather.com", "weatherchannel.com", "*.weatherchannel.com", "who.int",
    "*.who.int", "wired.com", "*.wired.com", "wsj.com", "*.wsj.com",
    "xinhuanet.com", "*.xinhuanet.com", "yahoo.com", "*.yahoo.com",
    "yonhapnews.co.kr", "*.yonhapnews.co.kr", "zdnet.com", "*.zdnet.com"] {
    addflag "\\Seen";
    fileinto "News";

    if anyof (
        address :domain :matches "from" ["ballotpedia.org", "*.ballotpedia.org",
            "cookpolitical.com", "*.cookpolitical.com", "nationaljournal.com",
            "*.nationaljournal.com", "politico.com", "*.politico.com", "rollcall.com",
            "*.rollcall.com", "thehill.com", "*.thehill.com"],
        header :contains "subject" ["Election Update", "Policy News",
            "Government Alert", "Politics Recap", "Bill Passed", "Debate Highlights",
            "Political Analysis", "Campaign News", "Congress Update",
            "White House Briefing", "Senate Vote", "House Committee", "Supreme Court",
            "Federal Court", "Political Poll", "Voting Rights", "Democracy Report",
            "Legislative Update"]
    ) {
        fileinto "News/Politics";

        if allof (
            header :contains "subject" ["Breaking Political", "Election Results",
                "Vote Count", "Political Breaking", "Congress Votes",
                "Supreme Court Ruling"],
            size :under 500K
        ) {
            expire "day" "2";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["9to5mac.com", "*.9to5mac.com",
            "arstechnica.com", "*.arstechnica.com", "engadget.com", "*.engadget.com",
            "gizmodo.com", "*.gizmodo.com", "techcrunch.com", "*.techcrunch.com",
            "theverge.com", "*.theverge.com", "wired.com", "*.wired.com"],
        header :contains "subject" ["Tech News", "Gadget Review", "AI Breakthrough",
            "Software Update", "Cybersecurity Alert", "Innovation Report",
            "Tech Trends", "Startup News", "Device Launch", "Digital Transformation",
            "Silicon Valley", "Apple News", "Google Update", "Microsoft Announcement",
            "Tesla News", "Cryptocurrency", "Bitcoin Update", "Blockchain News",
            "NFT Alert"]
    ) {
        fileinto "News/Tech";

        if allof (
            header :contains "subject" ["Product Launch", "New iPhone",
                "Android Update", "Software Release", "App Update", "Device Review",
                "Gadget Announcement"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bloomberg.com", "*.bloomberg.com",
            "businessinsider.com", "*.businessinsider.com", "cnbc.com", "*.cnbc.com",
            "fortune.com", "*.fortune.com", "marketwatch.com", "*.marketwatch.com",
            "wsj.com", "*.wsj.com"],
        header :contains "subject" ["Market Report", "Stock News", "Economy Forecast",
            "Business Merger", "Financial Analysis", "Corporate Earnings",
            "Industry Update", "Trade News", "Investment Tips", "CEO Interview",
            "IPO News", "Acquisition Alert", "Quarterly Report", "Market Close",
            "Dow Jones", "S&P 500", "NASDAQ Update", "Federal Reserve",
            "Interest Rates", "Inflation Report", "GDP Growth"]
    ) {
        fileinto "News/Business";

        if allof (
            header :contains "subject" ["Market Close", "Daily Market", "Stock Report",
                "Market Summary", "Trading Update", "Market Recap"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bleacherreport.com", "*.bleacherreport.com",
            "cbssports.com", "*.cbssports.com", "espn.com", "*.espn.com",
            "foxsports.com", "*.foxsports.com", "nbcsports.com", "*.nbcsports.com",
            "si.com", "*.si.com"],
        header :contains "subject" ["Game Recap", "Sports Highlights", "Match Results",
            "Player Trade", "Tournament Update", "Team News", "Athlete Profile",
            "Score Alert", "League Standings", "Championship Preview", "Draft News",
            "Injury Report", "Season Recap", "Playoff Update", "World Cup", "Olympics",
            "Super Bowl", "World Series", "NBA Finals", "Stanley Cup"]
    ) {
        fileinto "News/Sports";

        if allof (
            header :contains "subject" ["Score Alert", "Live Score", "Game Update",
                "Final Score", "Breaking Sports", "Injury Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["cdc.gov", "*.cdc.gov", "newscientist.com",
            "*.newscientist.com", "sciencedaily.com", "*.sciencedaily.com",
            "scientificamerican.com", "*.scientificamerican.com", "who.int",
            "*.who.int"],
        header :contains "subject" ["Scientific Discovery", "Research Findings",
            "Space News", "Climate Study", "Medical Breakthrough", "Tech in Science",
            "Environmental Report", "Biology Update", "Physics Experiment",
            "Astronomy Alert", "NASA Mission", "Health Study", "Vaccine News",
            "Pandemic Update", "Disease Alert", "Drug Trial", "Climate Change",
            "Global Warming", "Renewable Energy", "Conservation News"]
    ) {
        fileinto "News/Science";

        if allof (
            header :contains "subject" ["Health Alert", "Disease Outbreak",
                "Vaccine Update", "Medical Emergency", "Public Health", "FDA Warning"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["aljazeera.com", "*.aljazeera.com",
            "apnews.com", "*.apnews.com", "dw.com", "*.dw.com", "france24.com",
            "*.france24.com", "reuters.com", "*.reuters.com"],
        header :contains "subject" ["International News", "Global Events",
            "World Affairs", "Foreign Policy", "Crisis Update", "Diplomatic Relations",
            "Geopolitical Analysis", "UN Report", "Regional Conflict",
            "Human Rights News", "War Update", "Peace Treaty", "Embassy News",
            "Trade War", "Sanctions News", "Refugee Crisis", "Natural Disaster",
            "Earthquake Alert", "Hurricane Update", "Tsunami Warning"]
    ) {
        fileinto "News/World";

        if allof (
            header :contains "subject" ["Breaking International", "Global Breaking",
                "World Breaking", "Crisis Alert", "Emergency Update"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["rollingstone.com", "*.rollingstone.com"],
        header :contains "subject" ["Celebrity News", "Movie Review", "Music News",
            "TV Show Update", "Award Show", "Red Carpet", "Hollywood News",
            "Concert Review", "Book Review", "Art Exhibition", "Cultural Event",
            "Festival News", "Grammy Awards", "Oscar News", "Emmy Update",
            "Golden Globes", "Cannes Festival", "Comic-Con"]
    ) {
        fileinto "News/Entertainment";

        if allof (
            header :contains "subject" ["Celebrity Gossip", "Star Spotted",
                "Dating News", "Breakup Alert", "Wedding News", "Baby News",
                "Social Media Drama"],
            size :under 500K
        ) {
            expire "day" "2";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["accuweather.com", "*.accuweather.com",
            "noaa.gov", "*.noaa.gov", "nws.noaa.gov", "*.nws.noaa.gov", "weather.com",
            "*.weather.com", "weatherchannel.com", "*.weatherchannel.com"],
        header :contains "subject" ["Weather Alert", "Storm Warning",
            "Hurricane Update", "Tornado Watch", "Flood Warning", "Drought Alert",
            "Heat Wave", "Cold Snap", "Blizzard Warning", "Severe Weather",
            "Climate Report", "Environmental News"]
    ) {
        fileinto "News/Weather";

        if allof (
            header :contains "subject" ["Weather Alert", "Storm Warning",
                "Weather Emergency"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Breaking News", "Urgent Alert", "Flash Update",
            "Live Coverage", "Developing Story", "News Alert", "Immediate Update",
            "Hot Off the Press", "Real-Time News", "Emergency Broadcast"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Daily News Digest", "Morning Briefing",
            "Evening Recap", "Headline Summary", "Top Stories Today", "News Roundup",
            "Daily Update", "Newsletter Edition", "Breaking News Summary",
            "Quick Reads"],
        size :under 500K
    ) {
        expire "day" "2";

        stop;
    }

    if allof (
        header :contains "subject" ["In-Depth Report", "Feature Story",
            "Investigative Piece", "Long-Form Analysis", "Opinion Column",
            "Expert Commentary", "Deep Dive", "Special Report", "Backgrounder",
            "Explainer Article"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "3";

    stop;
}

# End of News & Newsletters filter
