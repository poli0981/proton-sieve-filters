# Entertainment filter -- filter/entertainment.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/entertainment.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Streaming, music, podcasts, books and events.
#
# Folders: Entertainment/Books, Entertainment/Comics, Entertainment/Events,
#          Entertainment/General, Entertainment/Movies-TV, Entertainment/Music,
#          Entertainment/News, Entertainment/Podcasts, Entertainment/Reviews
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 9 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if address :domain :matches "from" ["500px.com", "*.500px.com", "8tracks.com",
    "*.8tracks.com", "abc.net.au", "*.abc.net.au", "accesshollywood.com",
    "*.accesshollywood.com", "allarts.org", "*.allarts.org", "allmusic.com",
    "*.allmusic.com", "anchor.fm", "*.anchor.fm", "animelab.com", "*.animelab.com",
    "appletv.com", "*.appletv.com", "audible.com", "*.audible.com", "audioboom.com",
    "*.audioboom.com", "bandcamp.com", "*.bandcamp.com", "bandsintown.com",
    "*.bandsintown.com", "bbc.co.uk", "*.bbc.co.uk", "bbc.com", "*.bbc.com",
    "bilibili.com", "*.bilibili.com", "bilibili.tv", "*.bilibili.tv", "bookbub.com",
    "*.bookbub.com", "brownpapertickets.com", "*.brownpapertickets.com",
    "buzzsprout.com", "*.buzzsprout.com", "castbox.fm", "*.castbox.fm", "castro.fm",
    "*.castro.fm", "cbc.ca", "*.cbc.ca", "channel4.com", "*.channel4.com",
    "comixology.com", "*.comixology.com", "crackle.com", "*.crackle.com",
    "crave.ca", "*.crave.ca", "criterionchannel.com", "*.criterionchannel.com",
    "crunchyroll.com", "*.crunchyroll.com", "darkhorse.com", "*.darkhorse.com",
    "dazn.com", "*.dazn.com", "dccomics.com", "*.dccomics.com", "deadline.com",
    "*.deadline.com", "deezer.com", "*.deezer.com", "deviantart.com",
    "*.deviantart.com", "directv.com", "*.directv.com", "discogs.com",
    "*.discogs.com", "discoveryplus.com", "*.discoveryplus.com", "disneyplus.com",
    "*.disneyplus.com", "entertainment.com", "*.entertainment.com", "etonline.com",
    "*.etonline.com", "eventbrite.com", "*.eventbrite.com", "ew.com", "*.ew.com",
    "extratv.com", "*.extratv.com", "fanart.tv", "*.fanart.tv", "fandom.com",
    "*.fandom.com", "fearless.li", "*.fearless.li", "flickr.com", "*.flickr.com",
    "freesound.org", "*.freesound.org", "fubotv.com", "*.fubotv.com",
    "funimation.com", "*.funimation.com", "goodreads.com", "*.goodreads.com",
    "hollywoodreporter.com", "*.hollywoodreporter.com", "hotstar.com",
    "*.hotstar.com", "hulu.com", "*.hulu.com", "iheartradio.com",
    "*.iheartradio.com", "imagecomics.com", "*.imagecomics.com", "imdb.com",
    "*.imdb.com", "iqiyi.com", "*.iqiyi.com", "itv.com", "*.itv.com", "jamendo.com",
    "*.jamendo.com", "justwatch.com", "*.justwatch.com", "kanopy.com",
    "*.kanopy.com", "kidoodle.tv", "*.kidoodle.tv", "kindle.com", "*.kindle.com",
    "kobo.com", "*.kobo.com", "last.fm", "*.last.fm", "letterboxd.com",
    "*.letterboxd.com", "librivox.org", "*.librivox.org", "libsyn.com",
    "*.libsyn.com", "listnr.com", "*.listnr.com", "marvel.com", "*.marvel.com",
    "max.com", "*.max.com", "mixcloud.com", "*.mixcloud.com", "music.youtube.com",
    "*.music.youtube.com", "musicbrainz.org", "*.musicbrainz.org", "netflix.com",
    "*.netflix.com", "now.com", "*.now.com", "npr.org", "*.npr.org",
    "okmagazine.com", "*.okmagazine.com", "overcast.fm", "*.overcast.fm",
    "pandora.com", "*.pandora.com", "paramount.com", "*.paramount.com",
    "paramountplus.com", "*.paramountplus.com", "peacocktv.com", "*.peacocktv.com",
    "people.com", "*.people.com", "pexels.com", "*.pexels.com", "pitchfork.com",
    "*.pitchfork.com", "pixabay.com", "*.pixabay.com", "pluto.tv", "*.pluto.tv",
    "pocketcasts.com", "*.pocketcasts.com", "podbean.com", "*.podbean.com",
    "popcornflix.com", "*.popcornflix.com", "primevideo.com", "*.primevideo.com",
    "qobuz.com", "*.qobuz.com", "quora.com", "*.quora.com", "radio.com",
    "*.radio.com", "radiotime.com", "*.radiotime.com", "rateyourmusic.com",
    "*.rateyourmusic.com", "reddit.com", "*.reddit.com", "reelgood.com",
    "*.reelgood.com", "rottentomatoes.com", "*.rottentomatoes.com", "rte.ie",
    "*.rte.ie", "scribd.com", "*.scribd.com", "scrobbles.fm", "*.scrobbles.fm",
    "seatgeek.com", "*.seatgeek.com", "setlist.fm", "*.setlist.fm", "showclix.com",
    "*.showclix.com", "shudder.com", "*.shudder.com", "simkl.com", "*.simkl.com",
    "sky.com", "*.sky.com", "sling.com", "*.sling.com", "songkick.com",
    "*.songkick.com", "soundcloud.com", "*.soundcloud.com", "spotify.com",
    "*.spotify.com", "spreaker.com", "*.spreaker.com", "stackexchange.com",
    "*.stackexchange.com", "starz.com", "*.starz.com", "stitcher.com",
    "*.stitcher.com", "themoviedb.org", "*.themoviedb.org", "ticketfly.com",
    "*.ticketfly.com", "ticketweb.com", "*.ticketweb.com", "tidal.com",
    "*.tidal.com", "tmz.com", "*.tmz.com", "trakt.tv", "*.trakt.tv", "tubitv.com",
    "*.tubitv.com", "tunein.com", "*.tunein.com", "tv.com", "*.tv.com",
    "tvtime.com", "*.tvtime.com", "tvtropes.org", "*.tvtropes.org", "universe.com",
    "*.universe.com", "unsplash.com", "*.unsplash.com", "usweekly.com",
    "*.usweekly.com", "variety.com", "*.variety.com", "viki.com", "*.viki.com",
    "viu.com", "*.viu.com", "vivid.com", "*.vivid.com", "vudu.com", "*.vudu.com",
    "wakanim.com", "*.wakanim.com", "wikia.com", "*.wikia.com", "youku.com",
    "*.youku.com", "youtube.com", "*.youtube.com"] {
    addflag "\\Seen";
    fileinto "Entertainment/General";

    if anyof (
        address :domain :matches "from" ["crunchyroll.com", "*.crunchyroll.com",
            "disneyplus.com", "*.disneyplus.com", "hulu.com", "*.hulu.com", "max.com",
            "*.max.com", "netflix.com", "*.netflix.com", "paramount.com",
            "*.paramount.com", "primevideo.com", "*.primevideo.com"],
        header :contains "subject" ["New Movie", "TV Series", "Episode Available",
            "Season Finale", "Movie Recommendation", "Watch Now", "Streaming Alert",
            "Movie Release", "TV Show Update", "Binge Watch", "Movie Night",
            "Series Premiere", "Film Festival", "Documentary", "Movie Trailer",
            "TV Guide"]
    ) {
        fileinto "Entertainment/Movies-TV";

        if allof (
            header :contains "subject" ["New Release Alert", "Watch This Now",
                "Recommended for You", "New Episode Available", "Movie Recommendation",
                "Top Picks This Week", "Personalized Recommendations", "Just Added",
                "Coming Soon"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bandcamp.com", "*.bandcamp.com", "deezer.com",
            "*.deezer.com", "pandora.com", "*.pandora.com", "soundcloud.com",
            "*.soundcloud.com", "spotify.com", "*.spotify.com", "tidal.com",
            "*.tidal.com"],
        header :contains "subject" ["New Album", "Playlist Update",
            "Track Recommendation", "Music Discovery", "Artist Alert",
            "Concert Tickets", "Music Release", "Spotify Wrapped", "Your Mix",
            "Release Radar", "Discover Weekly", "Concert Alert", "Tour Dates",
            "Music Festival", "Album Review"]
    ) {
        fileinto "Entertainment/Music";

        if allof (
            header :contains "subject" ["New Track Dropped", "Album Release",
                "Playlist Update", "Music Recommendation", "Artist Update",
                "Release Alert", "New Music Friday"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["anchor.fm", "*.anchor.fm", "audible.com",
            "*.audible.com", "castbox.fm", "*.castbox.fm", "overcast.fm",
            "*.overcast.fm", "spotify.com", "*.spotify.com", "stitcher.com",
            "*.stitcher.com"],
        header :contains "subject" ["New Podcast", "Episode Released",
            "Podcast Recommendation", "Audio Update", "Podcast Alert", "Listen Now",
            "Podcast Series", "Audio Drama", "Talk Show", "Interview", "Audiobook"]
    ) {
        fileinto "Entertainment/Podcasts";

        if allof (
            header :contains "subject" ["New Episode", "Episode Available",
                "Latest Episode", "Podcast Update", "Episode Alert", "New Chapter",
                "Audio Available"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["audible.com", "*.audible.com", "bookbub.com",
            "*.bookbub.com", "goodreads.com", "*.goodreads.com", "kindle.com",
            "*.kindle.com", "kobo.com", "*.kobo.com", "scribd.com", "*.scribd.com"],
        header :contains "subject" ["Book Recommendation", "New Release",
            "Reading List", "Book Review", "Author Alert", "Book Club",
            "Reading Challenge", "Bestseller", "Book Deal", "Pre-order", "Kindle Deal",
            "Free Book"]
    ) {
        fileinto "Entertainment/Books";

        if allof (
            header :contains "subject" ["Book Deal", "Free Book", "Discount Alert",
                "Limited Time Offer", "Book Sale", "Reading Recommendation"],
            size :under 500K
        ) {
            expire "day" "14";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["comixology.com", "*.comixology.com",
            "darkhorse.com", "*.darkhorse.com", "dccomics.com", "*.dccomics.com",
            "imagecomics.com", "*.imagecomics.com", "marvel.com", "*.marvel.com"],
        header :contains "subject" ["New Comic", "Comic Release", "Graphic Novel",
            "Marvel Comics", "DC Comics", "Comic Book", "Superhero", "Manga Update",
            "Comic Review", "Comic Convention", "Artist Spotlight"]
    ) {
        fileinto "Entertainment/Comics";

        if allof (
            header :contains "subject" ["New Issue", "Comic Release", "Issue Available",
                "Series Update", "Comic Alert", "New Chapter"],
            size :under 500K
        ) {
            expire "day" "10";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["bandsintown.com", "*.bandsintown.com",
            "eventbrite.com", "*.eventbrite.com", "seatgeek.com", "*.seatgeek.com",
            "songkick.com", "*.songkick.com"],
        header :contains "subject" ["Concert Tickets", "Event Alert", "Show Tickets",
            "Live Performance", "Festival Tickets", "Theater Show", "Comedy Show",
            "Ticket Sale", "Event Reminder", "Show Information", "Venue Alert"]
    ) {
        fileinto "Entertainment/Events";

        if allof (
            header :contains "subject" ["Event Reminder", "Show Tonight", "Last Chance",
                "Event Starting", "Live Now", "Doors Open", "Show Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["hollywoodreporter.com",
            "*.hollywoodreporter.com", "imdb.com", "*.imdb.com", "pitchfork.com",
            "*.pitchfork.com", "rottentomatoes.com", "*.rottentomatoes.com",
            "variety.com", "*.variety.com"],
        header :contains "subject" ["Movie Review", "Album Review", "Book Review",
            "Show Review", "Critics Pick", "Review Roundup", "Rating Update",
            "Score Alert", "Review Digest", "Critical Consensus", "Expert Review"]
    ) {
        fileinto "Entertainment/Reviews";

        if allof (
            header :contains "subject" ["Review", "Rating", "Score", "Critics",
                "Analysis"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["accesshollywood.com", "*.accesshollywood.com",
            "deadline.com", "*.deadline.com", "ew.com", "*.ew.com", "people.com",
            "*.people.com", "tmz.com", "*.tmz.com", "variety.com", "*.variety.com"],
        header :contains "subject" ["Entertainment News", "Celebrity News",
            "Hollywood Update", "Breaking Entertainment", "Industry News",
            "Show Business", "Celebrity Gossip", "Red Carpet", "Award Show",
            "Film Festival", "TV News"]
    ) {
        fileinto "Entertainment/News";

        if allof (
            header :contains "subject" ["News", "Update", "Breaking", "Alert", "Report"],
            size :under 500K
        ) {
            expire "day" "3";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Billing Statement", "Subscription Invoice",
            "Payment Confirmation", "Renewal Notice", "Account Charged", "Monthly Bill",
            "Receipt for Subscription", "Payment Due", "Invoice Attached",
            "Transaction Summary"],
        size :under 500K
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["Live Stream Starting", "Event Reminder",
            "Concert Alert", "Premiere Live", "Watch Party Invite", "Live Podcast",
            "Stream Notification", "Upcoming Live", "Real-Time Update",
            "Broadcast Alert"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Special Offer", "Limited Time", "Discount",
            "Free Trial", "Promo Code", "Sale Alert", "Deal of the Day", "Flash Sale",
            "Member Exclusive"],
        size :under 500K
    ) {
        expire "day" "5";

        stop;
    }

    stop;
}

# End of Entertainment filter
