# Sieve filter
# Filter_Entertainment.sieve
# Only for user use Proton Mail.
# Version: 0.2.0 (New script release & fix bugs many old filters e.g. game, study, etc.)
# This Sieve script filters messages related to entertainment platforms (movies, music, forums, etc.), moves them to "Entertainment" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to entertainment (movies, music, forums)
if anyof (
    # Movie/TV streaming platforms
    address :domain :matches "from" ["*netflix.com", "*hulu.com", "*disneyplus.com",
    "*primevideo.com", "*max.com", "*paramountplus.com", "*peacocktv.com",
    "*appletv.com", "*youtube.com", "*tubitv.com", "*pluto.tv", "*kanopy.com",
    "*criterionchannel.com", "*shudder.com", "*fubotv.com", "*sling.com",
    "*directv.com", "*starz.com", "*crackle.com", "*popcornflix.com", "*vudu.com",
    "*discoveryplus.com", "*fearless.li", "*kidoodle.tv", "*dazn.com", "*allarts.org"],

    # International streaming platforms
    address :domain :matches "from" ["*bbc.com", "*itv.com", "*channel4.com",
    "*sky.com", "*now.com", "*crave.ca", "*hotstar.com", "*viu.com",
    "*iqiyi.com", "*youku.com", "*bilibili.com", "*viki.com", "*dramafever.com",
    "*crunchyroll.com", "*funimation.com", "*animelab.com", "*wakanim.com"],

    # Music streaming platforms
    address :domain :matches "from" ["*spotify.com", "*apple.com", "*music.youtube.com",
    "*tidal.com", "*deezer.com", "*pandora.com", "*soundcloud.com", "*amazon.com",
    "*bandcamp.com", "*qobuz.com", "*listnr.com", "*iheartradio.com", "*audible.com",
    "*last.fm", "*mixcloud.com", "*8tracks.com", "*jamendo.com", "*freesound.org"],

    # Podcast platforms
    address :domain :matches "from" ["*anchor.fm", "*castbox.fm", "*podbean.com",
    "*buzzsprout.com", "*libsyn.com", "*spreaker.com", "*audioboom.com",
    "*stitcher.com", "*overcast.fm", "*pocketcasts.com", "*castro.fm"],

    # Movie/TV review and rating sites
    address :domain :matches "from" ["*imdb.com", "*rottentomatoes.com", "*letterboxd.com",
    "*metacritic.com", "*themoviedb.org", "*trakt.tv", "*simkl.com", "*tvtime.com",
    "*justwatch.com", "*reelgood.com", "*tv.com", "*fanart.tv"],

    # Music review and discovery sites
    address :domain :matches "from" ["*rateyourmusic.com", "*allmusic.com", "*discogs.com",
    "*musicbrainz.org", "*setlist.fm", "*songkick.com", "*bandsintown.com",
    "*last.fm", "*scrobbles.fm", "*pitchfork.com"],

    # Entertainment news and media
    address :domain :matches "from" ["*variety.com", "*hollywoodreporter.com", "*deadline.com",
    "*entertainment.com", "*ew.com", "*people.com", "*tmz.com", "*accesshollywood.com",
    "*etonline.com", "*extratv.com", "*usweekly.com", "*okmagazine.com"],

    # Comic and book platforms
    address :domain :matches "from" ["*comixology.com", "*marvel.com", "*dccomics.com",
    "*darkhorse.com", "*imagecomics.com", "*goodreads.com", "*scribd.com",
    "*kindle.com", "*kobo.com", "*bookbub.com", "*librivox.org"],

    # Live events and ticketing
    address :domain :matches "from" ["*ticketmaster.com", "*stubhub.com", "*vivid.com",
    "*seatgeek.com", "*eventbrite.com", "*ticketfly.com", "*universe.com",
    "*brownpapertickets.com", "*showclix.com", "*ticketweb.com"],

    # Radio and broadcasting
    address :domain :matches "from" ["*radio.com", "*tunein.com", "*radiotime.com",
    "*npr.org", "*bbc.co.uk", "*cbc.ca", "*abc.net.au", "*rte.ie"],

    # Art and cultural platforms
    address :domain :matches "from" ["*artstation.com", "*deviantart.com", "*behance.net",
    "*flickr.com", "*500px.com", "*unsplash.com", "*pixabay.com", "*pexels.com"],

    # Entertainment forums and communities
    address :domain :matches "from" ["*reddit.com", "*stackexchange.com", "*quora.com",
    "*discord.com", "*fandom.com", "*wikia.com", "*tvtropes.org"]
) {
    # Mark email as read first
    addflag "\\Seen";
    
    # Movie/TV Content
    if anyof (
        header :contains "subject" ["New Movie", "TV Series", "Episode Available", "Season Finale",
        "Movie Recommendation", "Watch Now", "Streaming Alert", "Movie Release",
        "TV Show Update", "Binge Watch", "Movie Night", "Series Premiere",
        "Film Festival", "Documentary", "Movie Trailer", "TV Guide"],
        address :domain :matches "from" ["*netflix.com", "*hulu.com", "*disneyplus.com",
        "*primevideo.com", "*max.com", "*paramount.com", "*crunchyroll.com"]
    ) {
        fileinto "Entertainment/Movies-TV";
        
        # New releases/recommendations (expire 7 days)
        if allof (
            header :contains "subject" ["New Release Alert", "Watch This Now", "Recommended for You", 
            "New Episode Available", "Movie Recommendation", "Top Picks This Week", 
            "Personalized Recommendations", "Just Added", "Coming Soon"],
            size :under 500K
        ) {
            expire "day" "7";
        }
        
        stop;
    }

    # Music Content
    if anyof (
        header :contains "subject" ["New Album", "Playlist Update", "Track Recommendation", 
        "Music Discovery", "Artist Alert", "Concert Tickets", "Music Release",
        "Spotify Wrapped", "Your Mix", "Release Radar", "Discover Weekly",
        "Concert Alert", "Tour Dates", "Music Festival", "Album Review"],
        address :domain :matches "from" ["*spotify.com", "*apple.com", "*tidal.com",
        "*deezer.com", "*pandora.com", "*soundcloud.com", "*bandcamp.com"]
    ) {
        fileinto "Entertainment/Music";
        
        # New releases/recommendations (expire 7 days)
        if allof (
            header :contains "subject" ["New Track Dropped", "Album Release", "Playlist Update",
            "Music Recommendation", "Artist Update", "Release Alert", "New Music Friday"],
            size :under 500K
        ) {
            expire "day" "7";
        }
        
        stop;
    }

    # Podcasts and Audio Content
    if anyof (
        header :contains "subject" ["New Podcast", "Episode Released", "Podcast Recommendation",
        "Audio Update", "Podcast Alert", "Listen Now", "Podcast Series",
        "Audio Drama", "Talk Show", "Interview", "Audiobook"],
        address :domain :matches "from" ["*anchor.fm", "*castbox.fm", "*spotify.com",
        "*apple.com", "*audible.com", "*stitcher.com", "*overcast.fm"]
    ) {
        fileinto "Entertainment/Podcasts";
        
        # New episodes (expire 14 days)
        if allof (
            header :contains "subject" ["New Episode", "Episode Available", "Latest Episode",
            "Podcast Update", "Episode Alert", "New Chapter", "Audio Available"],
            size :under 500K
        ) {
            expire "day" "14";
        }
        
        stop;
    }

    # Books and Reading
    if anyof (
        header :contains "subject" ["Book Recommendation", "New Release", "Reading List",
        "Book Review", "Author Alert", "Book Club", "Reading Challenge",
        "Bestseller", "Book Deal", "Pre-order", "Kindle Deal", "Free Book"],
        address :domain :matches "from" ["*goodreads.com", "*kindle.com", "*kobo.com",
        "*audible.com", "*scribd.com", "*bookbub.com"]
    ) {
        fileinto "Entertainment/Books";
        
        # Book recommendations (expire 14 days)
        if allof (
            header :contains "subject" ["Book Deal", "Free Book", "Discount Alert",
            "Limited Time Offer", "Book Sale", "Reading Recommendation"],
            size :under 500K
        ) {
            expire "day" "14";
        }
        
        stop;
    }

    # Comics and Graphic Novels
    if anyof (
        header :contains "subject" ["New Comic", "Comic Release", "Graphic Novel", 
        "Marvel Comics", "DC Comics", "Comic Book", "Superhero", "Manga Update",
        "Comic Review", "Comic Convention", "Artist Spotlight"],
        address :domain :matches "from" ["*comixology.com", "*marvel.com", "*dccomics.com",
        "*darkhorse.com", "*imagecomics.com"]
    ) {
        fileinto "Entertainment/Comics";
        
        # New releases (expire 10 days)
        if allof (
            header :contains "subject" ["New Issue", "Comic Release", "Issue Available",
            "Series Update", "Comic Alert", "New Chapter"],
            size :under 500K
        ) {
            expire "day" "10";
        }
        
        stop;
    }

    # Live Events and Tickets
    if anyof (
        header :contains "subject" ["Concert Tickets", "Event Alert", "Show Tickets",
        "Live Performance", "Festival Tickets", "Theater Show", "Comedy Show",
        "Ticket Sale", "Event Reminder", "Show Information", "Venue Alert"],
        address :domain :matches "from" ["*ticketmaster.com", "*stubhub.com", "*seatgeek.com",
        "*eventbrite.com", "*bandsintown.com", "*songkick.com"]
    ) {
        fileinto "Entertainment/Events";
        
        # Event alerts (expire 1 day after event date - keep short)
        if allof (
            header :contains "subject" ["Event Reminder", "Show Tonight", "Last Chance",
            "Event Starting", "Live Now", "Doors Open", "Show Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }
        
        stop;
    }

    # Reviews and Critics
    if anyof (
        header :contains "subject" ["Movie Review", "Album Review", "Book Review", "Show Review",
        "Critics Pick", "Review Roundup", "Rating Update", "Score Alert",
        "Review Digest", "Critical Consensus", "Expert Review"],
        address :domain :matches "from" ["*rottentomatoes.com", "*imdb.com", "*metacritic.com",
        "*pitchfork.com", "*variety.com", "*hollywoodreporter.com"]
    ) {
        fileinto "Entertainment/Reviews";
        
        # Reviews (expire 3 days)
        if allof (
            header :contains "subject" ["Review", "Rating", "Score", "Critics", "Analysis"],
            size :under 500K
        ) {
            expire "day" "3";
        }
        
        stop;
    }

    # Entertainment News
    if anyof (
        header :contains "subject" ["Entertainment News", "Celebrity News", "Hollywood Update",
        "Breaking Entertainment", "Industry News", "Show Business", "Celebrity Gossip",
        "Red Carpet", "Award Show", "Film Festival", "TV News"],
        address :domain :matches "from" ["*variety.com", "*deadline.com", "*tmz.com",
        "*people.com", "*ew.com", "*accesshollywood.com"]
    ) {
        fileinto "Entertainment/News";
        
        # Entertainment news (expire 3 days)
        if allof (
            header :contains "subject" ["News", "Update", "Breaking", "Alert", "Report"],
            size :under 500K
        ) {
            expire "day" "3";
        }
        
        stop;
    }

    # General Entertainment (fallback)
    fileinto "Entertainment/General";

    # General expiration rules for all entertainment content
    
    # EULA/ToS/Privacy updates (expire 2 days)
    if allof (
        header :contains "subject" ["EULA Update", "Terms Change", "Policy Revision", 
        "Updated Terms of Service", "License Agreement Change", "New EULA Version", 
        "Service Terms Update", "Agreement Modification", "Legal Update Alert", 
        "Policy Amendment", "Privacy Policy Update", "ToS Changes", "Data Policy Revision"],
        size :under 500K
    ) {
        expire "day" "2";
    }

    # Billing/invoices (expire 28 days)
    if allof (
        header :contains "subject" ["Billing Statement", "Subscription Invoice", "Payment Confirmation", 
        "Renewal Notice", "Account Charged", "Monthly Bill", "Receipt for Subscription", 
        "Payment Due", "Invoice Attached", "Transaction Summary"],
        size :under 500K
    ) {
        expire "day" "28";
    }

    # Live stream alerts (expire 1 day)
    if allof (
        header :contains "subject" ["Live Stream Starting", "Event Reminder", "Concert Alert", 
        "Premiere Live", "Watch Party Invite", "Live Podcast", "Stream Notification", 
        "Upcoming Live", "Real-Time Update", "Broadcast Alert"],
        size :under 500K
    ) {
        expire "day" "1";
    }

    # Promotional content (expire 5 days)
    if allof (
        header :contains "subject" ["Special Offer", "Limited Time", "Discount", "Free Trial",
        "Promo Code", "Sale Alert", "Deal of the Day", "Flash Sale", "Member Exclusive"],
        size :under 500K
    ) {
        expire "day" "5";
    }

    stop;
}

# End of Entertainment Filter