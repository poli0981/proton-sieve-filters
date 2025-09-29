# Sieve filter
# Filter_News.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters messages related to news platforms, moves them to "News" folder or subfolders by category.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to news
if anyof (
    address :domain :matches "from" [
    # Major US News Networks
    "*nytimes.com", "*cnn.com", "*washingtonpost.com", "*usatoday.com",
    "*foxnews.com", "*abcnews.com", "*cbsnews.com", "*nbcnews.com",
    "*msnbc.com", "*huffpost.com", "*usnews.com", "*yahoo.com",
    "*axios.com", "*vox.com", "*buzzfeed.com", "*slate.com",
    "*salon.com", "*thedailybeast.com", "*nypost.com", "*thehill.com"],

    # International News
    address :domain :matches "from" ["*bbc.com", "*bbc.co.uk", "*theguardian.com",
    "*reuters.com", "*apnews.com", "*aljazeera.com", "*france24.com",
    "*dw.com", "*rt.com", "*sputniknews.com", "*xinhuanet.com",
    "*tass.com", "*ansa.it", "*kyodonews.net", "*yonhapnews.co.kr", "*theathletic.com"],

    # Business & Financial News
    address :domain :matches "from" ["*wsj.com", "*bloomberg.com", "*cnbc.com",
    "*forbes.com", "*marketwatch.com", "*barrons.com", "*fortune.com",
    "*businessinsider.com", "*ft.com", "*economist.com", "*quartz.com",
    "*fastcompany.com", "*inc.com", "*money.com", "*fool.com"],

    # Technology News
    address :domain :matches "from" ["*techcrunch.com", "*theverge.com", "*wired.com",
    "*arstechnica.com", "*engadget.com", "*mashable.com", "*gizmodo.com",
    "*zdnet.com", "*cnet.com", "*techradar.com", "*9to5mac.com",
    "*androidpolice.com", "*theregister.com", "*venturebeat.com"],

    # Science & Health News
    address :domain :matches "from" ["*sciencedaily.com", "*sciencemag.org", "*nature.com",
    "*scientificamerican.com", "*newscientist.com", "*livescience.com",
    "*space.com", "*nasa.gov", "*nih.gov", "*cdc.gov",
    "*who.int", "*healthline.com", "*webmd.com", "*mayoclinic.org","*getpocket.com"],

    # Sports News
    address :domain :matches "from" ["*espn.com", "*si.com", "*bleacherreport.com",
    "*sbnation.com", "*theringer.com", "*athleticnews.com", "*cbssports.com",
    "*nbcsports.com", "*foxsports.com", "*skysports.com", "*bbc.co.uk/sport"],

    # Entertainment & Culture
    address :domain :matches "from" ["*ew.com", "*people.com", "*tmz.com",
    "*variety.com", "*hollywoodreporter.com", "*rollingstone.com",
    "*pitchfork.com", "*vulture.com", "*avclub.com", "*entertainment.com"],

    # Political News
    address :domain :matches "from" ["*politico.com", "*thehill.com", "*nationalreview.com",
    "*motherjones.com", "*jacobinmag.com", "*reason.com", "*townhall.com",
    "*dailykos.com", "*redstate.com", "*breitbart.com", "*dailywire.com"],

    # Investigative & Long-form
    address :domain :matches "from" ["*propublica.org", "*theintercept.com",
    "*newyorker.com", "*theatlantic.com", "*harpers.org", "*newrepublic.com",
    "*thenation.com", "*motherjones.com", "*revealnews.org"],

    # Local & Regional News
    address :domain :matches "from" ["*latimes.com", "*chicagotribune.com",
    "*bostonglobe.com", "*seattletimes.com", "*denverpost.com",
    "*miamiherald.com", "*dallasnews.com", "*houstonchronicle.com",
    "*sfgate.com", "*oregonlive.com", "*cleveland.com", "*nola.com"],

    # Public Media
    address :domain :matches "from" ["*npr.org", "*pbs.org", "*pri.org",
    "*bbc.co.uk", "*cbc.ca", "*abc.net.au", "*rte.ie", "*france24.com"],

    # Newsletter Platforms & Substacks
    address :domain :matches "from" ["*substack.com", "*medium.com", "*mailchimp.com",
    "*constantcontact.com", "*campaignmonitor.com", "*convertkit.com",
    "*beehiiv.com", "*ghost.org", "*newsletter.com"],

    # Specialized News
    address :domain :matches "from" ["*militarytimes.com", "*policyone.com",
    "*firetimes.com", "*govtech.com", "*federalnewsnetwork.com",
    "*defensenews.com", "*c4isrnet.com", "*cyberscoop.com"]
) {
    # Mark email as read first
    addflag "\\Seen";
    
    # Politics & Government
    if anyof (
        header :contains "subject" ["Election Update", "Policy News", "Government Alert", 
        "Politics Recap", "Bill Passed", "Debate Highlights", "Political Analysis", 
        "Campaign News", "Congress Update", "White House Briefing", "Senate Vote",
        "House Committee", "Supreme Court", "Federal Court", "Political Poll",
        "Voting Rights", "Democracy Report", "Legislative Update"],
        address :domain :matches "from" ["*politico.com", "*thehill.com", "*rollcall.com",
        "*nationaljournal.com", "*cookpolitical.com", "*ballotpedia.org"]
    ) {
        fileinto "News/Politics";
        
        # Breaking political news (expire 2 days)
        if allof (
            header :contains "subject" ["Breaking Political", "Election Results", "Vote Count",
            "Political Breaking", "Congress Votes", "Supreme Court Ruling"],
            size :under 500K
        ) {
            expire "day" "2";
        }
        
        stop;
    }

    # Technology
    if anyof (
        header :contains "subject" ["Tech News", "Gadget Review", "AI Breakthrough", 
        "Software Update", "Cybersecurity Alert", "Innovation Report", "Tech Trends", 
        "Startup News", "Device Launch", "Digital Transformation", "Silicon Valley",
        "Apple News", "Google Update", "Microsoft Announcement", "Tesla News",
        "Cryptocurrency", "Bitcoin Update", "Blockchain News", "NFT Alert"],
        address :domain :matches "from" ["*techcrunch.com", "*theverge.com", "*wired.com",
        "*arstechnica.com", "*engadget.com", "*gizmodo.com", "*9to5mac.com"]
    ) {
        fileinto "News/Tech";
        
        # Tech product launches (expire 7 days)
        if allof (
            header :contains "subject" ["Product Launch", "New iPhone", "Android Update",
            "Software Release", "App Update", "Device Review", "Gadget Announcement"],
            size :under 500K
        ) {
            expire "day" "7";
        }
        
        stop;
    }

    # Business & Finance
    if anyof (
        header :contains "subject" ["Market Report", "Stock News", "Economy Forecast", 
        "Business Merger", "Financial Analysis", "Corporate Earnings", "Industry Update", 
        "Trade News", "Investment Tips", "CEO Interview", "IPO News", "Acquisition Alert",
        "Quarterly Report", "Market Close", "Dow Jones", "S&P 500", "NASDAQ Update",
        "Federal Reserve", "Interest Rates", "Inflation Report", "GDP Growth"],
        address :domain :matches "from" ["*wsj.com", "*bloomberg.com", "*cnbc.com",
        "*marketwatch.com", "*businessinsider.com", "*fortune.com"]
    ) {
        fileinto "News/Business";
        
        # Daily market reports (expire 3 days)
        if allof (
            header :contains "subject" ["Market Close", "Daily Market", "Stock Report",
            "Market Summary", "Trading Update", "Market Recap"],
            size :under 500K
        ) {
            expire "day" "3";
        }
        
        stop;
    }

    # Sports
    if anyof (
        header :contains "subject" ["Game Recap", "Sports Highlights", "Match Results", 
        "Player Trade", "Tournament Update", "Team News", "Athlete Profile", 
        "Score Alert", "League Standings", "Championship Preview", "Draft News",
        "Injury Report", "Season Recap", "Playoff Update", "World Cup", "Olympics",
        "Super Bowl", "World Series", "NBA Finals", "Stanley Cup"],
        address :domain :matches "from" ["*espn.com", "*si.com", "*bleacherreport.com",
        "*cbssports.com", "*nbcsports.com", "*foxsports.com"]
    ) {
        fileinto "News/Sports";
        
        # Live sports scores (expire 1 day)
        if allof (
            header :contains "subject" ["Score Alert", "Live Score", "Game Update",
            "Final Score", "Breaking Sports", "Injury Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }
        
        stop;
    }

    # Science & Health
    if anyof (
        header :contains "subject" ["Scientific Discovery", "Research Findings", "Space News", 
        "Climate Study", "Medical Breakthrough", "Tech in Science", "Environmental Report", 
        "Biology Update", "Physics Experiment", "Astronomy Alert", "NASA Mission",
        "Health Study", "Vaccine News", "Pandemic Update", "Disease Alert", "Drug Trial",
        "Climate Change", "Global Warming", "Renewable Energy", "Conservation News"],
        address :domain :matches "from" ["*sciencedaily.com", "*nature.com", "*nasa.gov",
        "*scientificamerican.com", "*newscientist.com", "*cdc.gov", "*who.int"]
    ) {
        fileinto "News/Science";
        
        # Health alerts (expire 14 days)
        if allof (
            header :contains "subject" ["Health Alert", "Disease Outbreak", "Vaccine Update",
            "Medical Emergency", "Public Health", "FDA Warning"],
            size :under 500K
        ) {
            expire "day" "14";
        }
        
        stop;
    }

    # World & International
    if anyof (
        header :contains "subject" ["International News", "Global Events", "World Affairs", 
        "Foreign Policy", "Crisis Update", "Diplomatic Relations", "Geopolitical Analysis", 
        "UN Report", "Regional Conflict", "Human Rights News", "War Update", "Peace Treaty",
        "Embassy News", "Trade War", "Sanctions News", "Refugee Crisis", "Natural Disaster",
        "Earthquake Alert", "Hurricane Update", "Tsunami Warning"],
        address :domain :matches "from" ["*bbc.com", "*reuters.com", "*aljazeera.com",
        "*apnews.com", "*france24.com", "*dw.com"]
    ) {
        fileinto "News/World";
        
        # Breaking international news (expire 3 days)
        if allof (
            header :contains "subject" ["Breaking International", "Global Breaking",
            "World Breaking", "Crisis Alert", "Emergency Update"],
            size :under 500K
        ) {
            expire "day" "3";
        }
        
        stop;
    }

    # Entertainment & Culture
    if anyof (
        header :contains "subject" ["Celebrity News", "Movie Review", "Music News", 
        "TV Show Update", "Award Show", "Red Carpet", "Hollywood News", "Concert Review",
        "Book Review", "Art Exhibition", "Cultural Event", "Festival News", "Grammy Awards",
        "Oscar News", "Emmy Update", "Golden Globes", "Cannes Festival", "Comic-Con"],
        address :domain :matches "from" ["*ew.com", "*people.com", "*variety.com",
        "*hollywoodreporter.com", "*rollingstone.com", "*pitchfork.com"]
    ) {
        fileinto "News/Entertainment";
        
        # Celebrity gossip (expire 2 days)
        if allof (
            header :contains "subject" ["Celebrity Gossip", "Star Spotted", "Dating News",
            "Breakup Alert", "Wedding News", "Baby News", "Social Media Drama"],
            size :under 500K
        ) {
            expire "day" "2";
        }
        
        stop;
    }

    # Weather & Environment
    if anyof (
        header :contains "subject" ["Weather Alert", "Storm Warning", "Hurricane Update",
        "Tornado Watch", "Flood Warning", "Drought Alert", "Heat Wave", "Cold Snap",
        "Blizzard Warning", "Severe Weather", "Climate Report", "Environmental News"],
        address :domain :matches "from" ["*weather.com", "*accuweather.com", "*noaa.gov",
        "*nws.noaa.gov", "*weatherchannel.com"]
    ) {
        fileinto "News/Weather";
        
        # Weather alerts (expire 1 day)
        if allof (
            header :contains "subject" ["Weather Alert", "Storm Warning", "Weather Emergency"],
            size :under 500K
        ) {
            expire "day" "1";
        }
        
        stop;
    }

    # Default to "News" folder for uncategorized news
    fileinto "News";

    # General expiration rules for news content
    
    # Breaking news/alerts (expire 1 day)
    if allof (
        header :contains "subject" ["Breaking News", "Urgent Alert", "Flash Update", 
        "Live Coverage", "Developing Story", "News Alert", "Immediate Update", 
        "Hot Off the Press", "Real-Time News", "Emergency Broadcast"],
        size :under 500K
    ) {
        expire "day" "1";
        stop;
    }

    # Daily news/digests (expire 2 days)
    if allof (
        header :contains "subject" ["Daily News Digest", "Morning Briefing", "Evening Recap", 
        "Headline Summary", "Top Stories Today", "News Roundup", "Daily Update", 
        "Newsletter Edition", "Breaking News Summary", "Quick Reads"],
        size :under 500K
    ) {
        expire "day" "2";
        stop;
    }

    # In-depth articles/analysis (expire 7 days)
    if allof (
        header :contains "subject" ["In-Depth Report", "Feature Story", "Investigative Piece", 
        "Long-Form Analysis", "Opinion Column", "Expert Commentary", "Deep Dive", 
        "Special Report", "Backgrounder", "Explainer Article"],
        size :under 500K
    ) {
        expire "day" "7";
        stop;
    }

    # Default expiration for other news (3 days)
    expire "day" "3";
    
    stop;
}

# End of News Filter