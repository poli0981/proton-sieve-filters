# Travel filter -- filter/travel.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/travel.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Flights, hotels, car hire and trip planning.
#
# Folders: Spam, Travel, Travel/Activities, Travel/Alerts, Travel/Deals,
#          Travel/Flights, Travel/Hotels, Travel/Planning, Travel/Reviews,
#          Travel/Transport
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 6 of 14. Filters run in the order you install them, and on
# conflicting actions the last one wins -- see README.md for the full order.
#
# Version: 0.2.1

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Known typosquats of the services this filter handles. These are lookalike
# domains, not the real senders -- flag them instead of filing them away.
if address :domain :matches "from" ["airbnbb.com", "*.airbnbb.com", "bookng.com",
    "*.bookng.com", "delta-airlines.com", "*.delta-airlines.com", "expedia-deals.com",
    "*.expedia-deals.com", "marriot.com", "*.marriot.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if address :domain :matches "from" ["99app.com", "*.99app.com", "aaa.com", "*.aaa.com",
    "accor.com", "*.accor.com", "aeroflot.com", "*.aeroflot.com", "airasia.com",
    "*.airasia.com", "airbnb.com", "*.airbnb.com", "airfrance.com",
    "*.airfrance.com", "airhelp.com", "*.airhelp.com", "airnz.com", "*.airnz.com",
    "alamo.com", "*.alamo.com", "alaskaair.com", "*.alaskaair.com", "alitalia.com",
    "*.alitalia.com", "allegiantair.com", "*.allegiantair.com", "allianz.com",
    "*.allianz.com", "alltrails.com", "*.alltrails.com", "americanairlines.com",
    "*.americanairlines.com", "amtrak.com", "*.amtrak.com", "ana.co.jp",
    "*.ana.co.jp", "asiana.com", "*.asiana.com", "atlasobscura.com",
    "*.atlasobscura.com", "austrian.com", "*.austrian.com", "avis.com",
    "*.avis.com", "away.com", "*.away.com", "axa.com", "*.axa.com", "backpackr.com",
    "*.backpackr.com", "bestwestern.com", "*.bestwestern.com", "boltapp.com",
    "*.boltapp.com", "boltbus.com", "*.boltbus.com", "booking.com", "*.booking.com",
    "breezeairways.com", "*.breezeairways.com", "britishairways.com",
    "*.britishairways.com", "budget.com", "*.budget.com", "cabify.com",
    "*.cabify.com", "campgrounds.com", "*.campgrounds.com", "car2go.com",
    "*.car2go.com", "carnivalcruiseline.com", "*.carnivalcruiseline.com",
    "cathaypacific.com", "*.cathaypacific.com", "cebu-pacific.com",
    "*.cebu-pacific.com", "celebritycruises.com", "*.celebritycruises.com",
    "cheapflights.com", "*.cheapflights.com", "choicehotels.com",
    "*.choicehotels.com", "citymapper.com", "*.citymapper.com", "citypass.com",
    "*.citypass.com", "costacruises.com", "*.costacruises.com", "costcotravel.com",
    "*.costcotravel.com", "couchsurfing.com", "*.couchsurfing.com", "covermore.com",
    "*.covermore.com", "cunard.com", "*.cunard.com", "delta.com", "*.delta.com",
    "deutschebahn.com", "*.deutschebahn.com", "didi.com", "*.didi.com",
    "disneycruise.com", "*.disneycruise.com", "dollar.com", "*.dollar.com",
    "doubletree.com", "*.doubletree.com", "easyjet.com", "*.easyjet.com",
    "embassy.com", "*.embassy.com", "emirates.com", "*.emirates.com",
    "enterprise.com", "*.enterprise.com", "etihad.com", "*.etihad.com",
    "eurail.com", "*.eurail.com", "europcar.com", "*.europcar.com", "expedia.com",
    "*.expedia.com", "fairmont.com", "*.fairmont.com", "fijianairways.com",
    "*.fijianairways.com", "finnair.com", "*.finnair.com", "flightaware.com",
    "*.flightaware.com", "flightright.com", "*.flightright.com", "flipkey.com",
    "*.flipkey.com", "flixbus.com", "*.flixbus.com", "fodors.com", "*.fodors.com",
    "fourseasons.com", "*.fourseasons.com", "foursquare.com", "*.foursquare.com",
    "freenow.com", "*.freenow.com", "frommers.com", "*.frommers.com",
    "frontier.com", "*.frontier.com", "garuda-indonesia.com",
    "*.garuda-indonesia.com", "gasbuddy.com", "*.gasbuddy.com", "getaround.com",
    "*.getaround.com", "gett.com", "*.gett.com", "getyourguide.com",
    "*.getyourguide.com", "glamping.com", "*.glamping.com", "goldstar.com",
    "*.goldstar.com", "grab.com", "*.grab.com", "greyhound.com", "*.greyhound.com",
    "groupon.com", "*.groupon.com", "hamptoninn.com", "*.hamptoninn.com",
    "hawaiianairlines.com", "*.hawaiianairlines.com", "hertz.com", "*.hertz.com",
    "hilton.com", "*.hilton.com", "hipcamp.com", "*.hipcamp.com", "holidayinn.com",
    "*.holidayinn.com", "hollandamerica.com", "*.hollandamerica.com",
    "homeaway.com", "*.homeaway.com", "hopper.com", "*.hopper.com", "hotels.com",
    "*.hotels.com", "hotwire.com", "*.hotwire.com", "hyatt.com", "*.hyatt.com",
    "iberia.com", "*.iberia.com", "icelandair.com", "*.icelandair.com", "ihg.com",
    "*.ihg.com", "insuremytrip.com", "*.insuremytrip.com", "interrail.eu",
    "*.interrail.eu", "jal.com", "*.jal.com", "jetblue.com", "*.jetblue.com",
    "jetstar.com", "*.jetstar.com", "jrpass.com", "*.jrpass.com", "kayak.com",
    "*.kayak.com", "klm.com", "*.klm.com", "klook.com", "*.klook.com", "koa.com",
    "*.koa.com", "koreanair.com", "*.koreanair.com", "laquinta.com",
    "*.laquinta.com", "livingsocial.com", "*.livingsocial.com", "lonelyplanet.com",
    "*.lonelyplanet.com", "loungebuddy.com", "*.loungebuddy.com", "lufthansa.com",
    "*.lufthansa.com", "lyft.com", "*.lyft.com", "malaysiaairlines.com",
    "*.malaysiaairlines.com", "mandarin-oriental.com", "*.mandarin-oriental.com",
    "marriott.com", "*.marriott.com", "meetup.com", "*.meetup.com", "megabus.com",
    "*.megabus.com", "momondo.com", "*.momondo.com", "msc.com", "*.msc.com",
    "national.com", "*.national.com", "ncl.com", "*.ncl.com", "nomadlist.com",
    "*.nomadlist.com", "norwegianair.com", "*.norwegianair.com", "ns.nl", "*.ns.nl",
    "oebb.at", "*.oebb.at", "ola.com", "*.ola.com", "onetravel.com",
    "*.onetravel.com", "opentable.com", "*.opentable.com", "orbitz.com",
    "*.orbitz.com", "packpoint.com", "*.packpoint.com", "peninsula.com",
    "*.peninsula.com", "philippineairlines.com", "*.philippineairlines.com",
    "priceline.com", "*.priceline.com", "princess.com", "*.princess.com",
    "prioritypass.com", "*.prioritypass.com", "qantas.com", "*.qantas.com",
    "qatarairways.com", "*.qatarairways.com", "recreation.gov", "*.recreation.gov",
    "redawning.com", "*.redawning.com", "redlion.com", "*.redlion.com",
    "regent7seas.com", "*.regent7seas.com", "renfe.com", "*.renfe.com",
    "rentalcars.com", "*.rentalcars.com", "reserveamerica.com",
    "*.reserveamerica.com", "resy.com", "*.resy.com", "ricksteves.com",
    "*.ricksteves.com", "rimowa.com", "*.rimowa.com", "ritz-carlton.com",
    "*.ritz-carlton.com", "roadtrippers.com", "*.roadtrippers.com", "rome2rio.com",
    "*.rome2rio.com", "royalcaribbean.com", "*.royalcaribbean.com", "rvlife.com",
    "*.rvlife.com", "ryanair.com", "*.ryanair.com", "samsonite.com",
    "*.samsonite.com", "sas.se", "*.sas.se", "sbb.ch", "*.sbb.ch", "seatguru.com",
    "*.seatguru.com", "sheraton.com", "*.sheraton.com", "silversea.com",
    "*.silversea.com", "singaporeair.com", "*.singaporeair.com", "sixt.com",
    "*.sixt.com", "skyscanner.com", "*.skyscanner.com", "sncf.com", "*.sncf.com",
    "southwest.com", "*.southwest.com", "spirit.com", "*.spirit.com",
    "splitwise.com", "*.splitwise.com", "squaremouth.com", "*.squaremouth.com",
    "stubhub.com", "*.stubhub.com", "sunairlines.com", "*.sunairlines.com",
    "swiss.com", "*.swiss.com", "tap.pt", "*.tap.pt", "thaiairways.com",
    "*.thaiairways.com", "thrifty.com", "*.thrifty.com", "ticketmaster.com",
    "*.ticketmaster.com", "timeout.com", "*.timeout.com", "timeshifter.com",
    "*.timeshifter.com", "tiqets.com", "*.tiqets.com", "trainline.com",
    "*.trainline.com", "travelex.com", "*.travelex.com", "travelguard.com",
    "*.travelguard.com", "travelocity.com", "*.travelocity.com", "travelpro.com",
    "*.travelpro.com", "travelsafe.com", "*.travelsafe.com", "travelzoo.com",
    "*.travelzoo.com", "trenitalia.com", "*.trenitalia.com", "tripadvisor.com",
    "*.tripadvisor.com", "tripit.com", "*.tripit.com", "trivago.com",
    "*.trivago.com", "tumi.com", "*.tumi.com", "turkish.com", "*.turkish.com",
    "turnkey.com", "*.turnkey.com", "turo.com", "*.turo.com", "uber.com",
    "*.uber.com", "united.com", "*.united.com", "vacasa.com", "*.vacasa.com",
    "via.com", "*.via.com", "viator.com", "*.viator.com", "vietnamairlines.com",
    "*.vietnamairlines.com", "vikingcruises.com", "*.vikingcruises.com",
    "virginatlantic.com", "*.virginatlantic.com", "vrbo.com", "*.vrbo.com",
    "vueling.com", "*.vueling.com", "waze.com", "*.waze.com", "westin.com",
    "*.westin.com", "whimstay.com", "*.whimstay.com", "wizzair.com",
    "*.wizzair.com", "worldnomads.com", "*.worldnomads.com", "wyndhamhotels.com",
    "*.wyndhamhotels.com", "xe.com", "*.xe.com", "yelp.com", "*.yelp.com",
    "zipcar.com", "*.zipcar.com", "zomato.com", "*.zomato.com"] {
    addflag "\\Seen";
    fileinto "Travel";

    if anyof (
        address :domain :matches "from" ["americanairlines.com",
            "*.americanairlines.com", "britishairways.com", "*.britishairways.com",
            "delta.com", "*.delta.com", "emirates.com", "*.emirates.com",
            "lufthansa.com", "*.lufthansa.com", "southwest.com", "*.southwest.com",
            "united.com", "*.united.com"],
        header :contains "subject" ["Flight Confirmation", "Flight Itinerary",
            "Boarding Pass", "Flight Booking", "Airline Ticket", "Flight Receipt",
            "Travel Itinerary", "Airport Check-in", "Flight Details", "E-ticket",
            "Departure Information"]
    ) {
        fileinto "Travel/Flights";

        if allof (
            header :contains "subject" ["Booking Confirmation", "Flight Itinerary",
                "E-ticket Confirmation", "Travel Receipt", "Reservation Confirmed"],
            size :under 1M
        ) {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["airbnb.com", "*.airbnb.com", "booking.com",
            "*.booking.com", "choicehotels.com", "*.choicehotels.com", "expedia.com",
            "*.expedia.com", "hilton.com", "*.hilton.com", "hotels.com", "*.hotels.com",
            "marriott.com", "*.marriott.com", "vrbo.com", "*.vrbo.com",
            "wyndhamhotels.com", "*.wyndhamhotels.com"],
        header :contains "subject" ["Hotel Confirmation", "Hotel Reservation",
            "Booking Confirmed", "Room Reservation", "Accommodation Details",
            "Hotel Receipt", "Check-in Information", "Hotel Booking",
            "Stay Confirmation", "Reservation Number", "Hotel Voucher"]
    ) {
        fileinto "Travel/Hotels";

        if allof (
            header :contains "subject" ["Booking Confirmation",
                "Hotel Reservation Details", "Reservation Confirmed", "Stay Receipt",
                "Hotel Booking"],
            size :under 1M
        ) {
            expire "day" "90";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["avis.com", "*.avis.com", "enterprise.com",
            "*.enterprise.com", "hertz.com", "*.hertz.com", "lyft.com", "*.lyft.com",
            "turo.com", "*.turo.com", "uber.com", "*.uber.com", "zipcar.com",
            "*.zipcar.com"],
        header :contains "subject" ["Car Rental Confirmation", "Rental Agreement",
            "Vehicle Reservation", "Pickup Information", "Car Booking",
            "Rental Receipt", "Transportation Booking", "Ride Confirmation",
            "Trip Receipt", "Rental Details"]
    ) {
        fileinto "Travel/Transport";

        if allof (
            header :contains "subject" ["Rental Confirmation", "Car Booking Confirmed",
                "Transportation Receipt", "Ride Receipt", "Trip Summary"],
            size :under 500K
        ) {
            expire "day" "60";
        }

        stop;
    }

    if anyof (
        address :domain :matches "from" ["citypass.com", "*.citypass.com",
            "getyourguide.com", "*.getyourguide.com", "klook.com", "*.klook.com",
            "tiqets.com", "*.tiqets.com", "tripadvisor.com", "*.tripadvisor.com",
            "viator.com", "*.viator.com"],
        header :contains "subject" ["Activity Booking", "Tour Confirmation",
            "Experience Booked", "Ticket Confirmation", "Attraction Tickets",
            "Event Booking", "Show Tickets", "Museum Pass", "Tour Guide",
            "Adventure Booking", "Excursion Confirmed"]
    ) {
        fileinto "Travel/Activities";

        if allof (
            header :contains "subject" ["Activity Confirmed", "Tour Booking",
                "Ticket Purchase", "Experience Receipt", "Activity Voucher"],
            size :under 500K
        ) {
            expire "day" "60";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Travel Deal Alert", "Flash Sale",
            "Limited Time Offer", "Vacation Special", "Flight Deal", "Hotel Discount",
            "Travel Savings", "Exclusive Offer", "Weekend Getaway", "Holiday Package",
            "Last Minute Deal", "Price Drop Alert", "Travel Promo", "Booking Special",
            "Member Discount"],
        header :contains "from" ["deals@", "offers@", "promotions@", "newsletter@"]
    ) {
        fileinto "Travel/Deals";

        if allof (
            header :contains "subject" ["Flash Sale", "Limited Time", "Deal Alert",
                "Price Drop", "Sale Ends", "Last Chance", "24-Hour Sale"],
            size :under 500K
        ) {
            expire "day" "5";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Reminder",
            "Departure Alert", "Arrival Update", "Travel Advisory", "Weather Alert",
            "Security Alert", "Cancellation Notice", "Schedule Change", "Trip Reminder",
            "Boarding Reminder", "Flight Status", "Terminal Change", "Baggage Alert"],
        size :under 200K
    ) {
        fileinto "Travel/Alerts";

        if allof (
            header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Now",
                "Departure Alert", "Boarding", "Last Call", "Emergency Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Rate Your Stay", "Review Your Trip",
            "How Was Your Flight", "Share Your Experience", "Trip Review",
            "Hotel Review", "Travel Feedback", "Review Request", "Trip Survey",
            "Experience Rating", "Service Feedback"],
        header :contains "from" ["review@", "feedback@", "survey@", "experience@"]
    ) {
        fileinto "Travel/Reviews";

        if allof (
            header :contains "subject" ["Rate", "Review", "Feedback", "Survey",
                "Experience"],
            size :under 500K
        ) {
            expire "day" "7";
        }

        stop;
    }

    if anyof (
        header :contains "subject" ["Top Destinations", "Travel Guide", "Trip Ideas",
            "Destination Spotlight", "Travel Tips", "Best Places to Visit",
            "Travel Inspiration", "Hidden Gems", "Travel Blog", "Destination Review",
            "Travel Trends", "Vacation Ideas", "Travel Newsletter", "Explore",
            "Wanderlust"],
        header :contains "from" ["newsletter@", "blog@", "tips@", "inspiration@"]
    ) {
        fileinto "Travel/Planning";

        if allof (
            header :contains "subject" ["Newsletter", "Weekly", "Monthly", "Guide",
                "Tips", "Ideas", "Inspiration", "Blog"],
            size :under 500K
        ) {
            expire "day" "10";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Account Update", "Password Change",
            "Security Alert", "Profile Update", "Payment Method", "Billing Update",
            "Account Verification", "Two-Factor Authentication", "Login Alert",
            "Account Activity"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Miles Update", "Points Summary", "Elite Status",
            "Loyalty Program", "Rewards Balance", "Member Benefits", "Status Update",
            "Points Earned", "Reward Redemption", "Member Newsletter"],
        size :under 500K
    ) {
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Travel News", "Weekly Update",
            "Monthly Digest", "Travel Trends", "Industry News", "Company Update"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "10";

    stop;
}

# End of Travel filter
