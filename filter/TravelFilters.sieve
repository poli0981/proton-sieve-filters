# Sieve filter
# Filter_Travel.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters messages related to travel and booking platforms, moves them to "Travel" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to travel/booking
if anyof (
    # Major Travel Booking Platforms
    address :domain :matches "from" ["*booking.com", "*expedia.com", "*tripadvisor.com",
    "*kayak.com", "*priceline.com", "*trivago.com", "*hotwire.com",
    "*orbitz.com", "*travelocity.com", "*momondo.com", "*skyscanner.com",
    "*cheapflights.com", "*onetravel.com", "*travelzoo.com", "*viator.com",
    "*getyourguide.com", "*klook.com", "*tiqets.com", "*citypass.com"],

    # Accommodation Platforms
    address :domain :matches "from" ["*airbnb.com", "*vrbo.com", "*homeaway.com",
    "*vacasa.com", "*turnkey.com", "*redawning.com",
    "*flipkey.com", "*whimstay.com", "*glamping.com", "*hipcamp.com",
    "*koa.com", "*recreation.gov", "*reserveamerica.com"],

    # Hotel Chains & Booking Sites
    address :domain :matches "from" ["*hotels.com", "*marriott.com", "*hilton.com",
    "*ihg.com", "*wyndhamhotels.com", "*accor.com", "*hyatt.com",
    "*bestwestern.com", "*choicehotels.com", "*redlion.com", "*laquinta.com",
    "*hamptoninn.com", "*holidayinn.com", "*doubletree.com", "*embassy.com",
    "*sheraton.com", "*westin.com", "*fairmont.com", "*fourseasons.com",
    "*ritz-carlton.com", "*mandarin-oriental.com", "*peninsula.com"],

    # Airlines - US Domestic
    address :domain :matches "from" ["*delta.com", "*united.com", "*americanairlines.com",
    "*southwest.com", "*jetblue.com", "*alaskaair.com", "*spirit.com",
    "*frontier.com", "*hawaiianairlines.com", "*allegiantair.com",
    "*sunairlines.com", "*breezeairways.com"],

    # Airlines - International
    address :domain :matches "from" ["*emirates.com", "*qatarairways.com", "*etihad.com",
    "*lufthansa.com", "*klm.com", "*airfrance.com", "*britishairways.com",
    "*virginatlantic.com", "*swiss.com", "*austrian.com", "*turkish.com",
    "*aeroflot.com", "*alitalia.com", "*iberia.com", "*tap.pt", "*sas.se",
    "*finnair.com", "*icelandair.com", "*norwegianair.com", "*ryanair.com",
    "*easyjet.com", "*wizzair.com", "*vueling.com"],

    # Airlines - Asian & Pacific
    address :domain :matches "from" ["*singaporeair.com", "*cathaypacific.com",
    "*jal.com", "*ana.co.jp", "*koreanair.com", "*asiana.com", "*thaiairways.com",
    "*malaysiaairlines.com", "*philippineairlines.com", "*garuda-indonesia.com",
    "*vietnamairlines.com", "*airasia.com", "*cebu-pacific.com", "*jetstar.com",
    "*qantas.com", "*airnz.com", "*fijianairways.com"],

    # Car Rental Companies
    address :domain :matches "from" ["*hertz.com", "*avis.com", "*enterprise.com",
    "*budget.com", "*alamo.com", "*national.com", "*thrifty.com", "*dollar.com",
    "*sixt.com", "*europcar.com", "*zipcar.com", "*turo.com", "*getaround.com",
    "*car2go.com", "*kayak.com", "*rentalcars.com", "*expedia.com"],

    # Ride-sharing & Transportation
    address :domain :matches "from" ["*uber.com", "*lyft.com", "*via.com",
    "*gett.com", "*juno.com", "*grab.com", "*didi.com", "*ola.com",
    "*99app.com", "*cabify.com", "*boltapp.com", "*freenow.com"],

    # Cruise Lines
    address :domain :matches "from" ["*royalcaribbean.com", "*carnivalcruiseline.com",
    "*ncl.com", "*princess.com", "*celebritycruises.com", "*hollandamerica.com",
    "*msc.com", "*costacruises.com", "*cunard.com", "*disneycruise.com",
    "*vikingcruises.com", "*silversea.com", "*regent7seas.com"],

    # Public Transportation & Rail
    address :domain :matches "from" ["*amtrak.com", "*greyhound.com", "*megabus.com",
    "*flixbus.com", "*boltbus.com", "*trainline.com", "*eurail.com",
    "*interrail.eu", "*sncf.com", "*trenitalia.com", "*renfe.com", "*ns.nl",
    "*deutschebahn.com", "*sbb.ch", "*oebb.at", "*jrpass.com"],

    # Travel Insurance & Services
    address :domain :matches "from" ["*worldnomads.com", "*allianz.com", "*axa.com",
    "*travelsafe.com", "*insuremytrip.com", "*squaremouth.com", "*travelguard.com",
    "*covermore.com", "*travelex.com", "*airhelp.com", "*flightright.com"],

    # Travel Apps & Utilities
    address :domain :matches "from" ["*tripit.com", "*hopper.com", "*citymapper.com",
    "*rome2rio.com", "*waze.com", "*google.com", "*apple.com",
    "*loungebuddy.com", "*prioritypass.com", "*seatguru.com", "*xe.com",
    "*splitwise.com", "*packpoint.com", "*timeshifter.com", "*flightaware.com"],

    # Activity & Experience Booking
    address :domain :matches "from" ["*alltrails.com", "*roadtrippers.com", "*yelp.com",
    "*foursquare.com", "*zomato.com", "*opentable.com", "*resy.com",
    "*eventbrite.com", "*stubhub.com", "*ticketmaster.com", "*goldstar.com",
    "*groupon.com", "*livingsocial.com"],

    # Travel Communities & Reviews
    address :domain :matches "from" ["*lonelyplanet.com", "*frommers.com", "*fodors.com",
    "*ricksteves.com", "*timeout.com", "*atlasobscura.com", "*nomadlist.com",
    "*couchsurfing.com", "*meetup.com", "*backpackr.com"],

    # Specialty Travel Services
    address :domain :matches "from" ["*costcotravel.com", "*aaa.com", "*samsonite.com",
    "*away.com", "*rimowa.com", "*tumi.com", "*travelpro.com", "*gasbuddy.com",
    "*roadtrippers.com", "*campgrounds.com", "*rvlife.com"]
) {
    # Mark email as read first
    addflag "\\Seen";

    # Flight & Transportation Bookings
    if anyof (
        header :contains "subject" ["Flight Confirmation", "Flight Itinerary", "Boarding Pass",
        "Flight Booking", "Airline Ticket", "Flight Receipt", "Travel Itinerary",
        "Airport Check-in", "Flight Details", "E-ticket", "Departure Information"],
        address :domain :matches "from" ["*delta.com", "*united.com", "*americanairlines.com",
        "*southwest.com", "*emirates.com", "*lufthansa.com", "*britishairways.com"]
    ) {
        fileinto "Travel/Flights";
        
        # Flight confirmations (expire 90 days)
        if allof (
            header :contains "subject" ["Booking Confirmation", "Flight Itinerary", 
            "E-ticket Confirmation", "Travel Receipt", "Reservation Confirmed"],
            size :under 1M
        ) {
            expire "day" "90";
        }
        
        stop;
    }

    # Hotel & Accommodation Bookings
    if anyof (
        header :contains "subject" ["Hotel Confirmation", "Hotel Reservation", "Booking Confirmed",
        "Room Reservation", "Accommodation Details", "Hotel Receipt", "Check-in Information",
        "Hotel Booking", "Stay Confirmation", "Reservation Number", "Hotel Voucher"],
        address :domain :matches "from" ["*booking.com", "*hotels.com", "*expedia.com",
        "*marriott.com", "*hilton.com", "*airbnb.com", "*vrbo.com"]
    ) {
        fileinto "Travel/Hotels";
        
        # Hotel confirmations (expire 90 days)
        if allof (
            header :contains "subject" ["Booking Confirmation", "Hotel Reservation Details",
            "Reservation Confirmed", "Stay Receipt", "Hotel Booking"],
            size :under 1M
        ) {
            expire "day" "90";
        }
        
        stop;
    }

    # Car Rental & Transportation
    if anyof (
        header :contains "subject" ["Car Rental Confirmation", "Rental Agreement", "Vehicle Reservation",
        "Pickup Information", "Car Booking", "Rental Receipt", "Transportation Booking",
        "Ride Confirmation", "Trip Receipt", "Rental Details"],
        address :domain :matches "from" ["*hertz.com", "*avis.com", "*enterprise.com",
        "*uber.com", "*lyft.com", "*turo.com", "*zipcar.com"]
    ) {
        fileinto "Travel/Transport";
        
        # Transportation confirmations (expire 60 days)
        if allof (
            header :contains "subject" ["Rental Confirmation", "Car Booking Confirmed",
            "Transportation Receipt", "Ride Receipt", "Trip Summary"],
            size :under 500K
        ) {
            expire "day" "60";
        }
        
        stop;
    }

    # Activities & Experiences
    if anyof (
        header :contains "subject" ["Activity Booking", "Tour Confirmation", "Experience Booked",
        "Ticket Confirmation", "Attraction Tickets", "Event Booking", "Show Tickets",
        "Museum Pass", "Tour Guide", "Adventure Booking", "Excursion Confirmed"],
        address :domain :matches "from" ["*viator.com", "*getyourguide.com", "*klook.com",
        "*tiqets.com", "*citypass.com", "*eventbrite.com", "*tripadvisor.com"]
    ) {
        fileinto "Travel/Activities";
        
        # Activity confirmations (expire 60 days)
        if allof (
            header :contains "subject" ["Activity Confirmed", "Tour Booking", "Ticket Purchase",
            "Experience Receipt", "Activity Voucher"],
            size :under 500K
        ) {
            expire "day" "60";
        }
        
        stop;
    }

    # Travel Deals & Promotions
    if anyof (
        header :contains "subject" ["Travel Deal Alert", "Flash Sale", "Limited Time Offer",
        "Vacation Special", "Flight Deal", "Hotel Discount", "Travel Savings",
        "Exclusive Offer", "Weekend Getaway", "Holiday Package", "Last Minute Deal",
        "Price Drop Alert", "Travel Promo", "Booking Special", "Member Discount"],
        header :contains "from" ["deals@", "offers@", "promotions@", "newsletter@"]
    ) {
        fileinto "Travel/Deals";
        
        # Deal alerts (expire 5 days)
        if allof (
            header :contains "subject" ["Flash Sale", "Limited Time", "Deal Alert",
            "Price Drop", "Sale Ends", "Last Chance", "24-Hour Sale"],
            size :under 500K
        ) {
            expire "day" "5";
        }
        
        stop;
    }

    # Travel Alerts & Notifications
    if anyof (
        header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Reminder",
        "Departure Alert", "Arrival Update", "Travel Advisory", "Weather Alert",
        "Security Alert", "Cancellation Notice", "Schedule Change", "Trip Reminder",
        "Boarding Reminder", "Flight Status", "Terminal Change", "Baggage Alert"],
        size :under 200K  # Alerts are typically smaller
    ) {
        fileinto "Travel/Alerts";
        
        # Time-sensitive alerts (expire 1 day)
        if allof (
            header :contains "subject" ["Flight Delay", "Gate Change", "Check-in Now",
            "Departure Alert", "Boarding", "Last Call", "Emergency Alert"],
            size :under 500K
        ) {
            expire "day" "1";
        }
        
        stop;
    }

    # Travel Reviews & Recommendations
    if anyof (
        header :contains "subject" ["Rate Your Stay", "Review Your Trip", "How Was Your Flight",
        "Share Your Experience", "Trip Review", "Hotel Review", "Travel Feedback",
        "Review Request", "Trip Survey", "Experience Rating", "Service Feedback"],
        header :contains "from" ["review@", "feedback@", "survey@", "experience@"]
    ) {
        fileinto "Travel/Reviews";
        
        # Review requests (expire 7 days)
        if allof (
            header :contains "subject" ["Rate", "Review", "Feedback", "Survey", "Experience"],
            size :under 500K
        ) {
            expire "day" "7";
        }
        
        stop;
    }

    # Travel Planning & Inspiration
    if anyof (
        header :contains "subject" ["Top Destinations", "Travel Guide", "Trip Ideas",
        "Destination Spotlight", "Travel Tips", "Best Places to Visit", "Travel Inspiration",
        "Hidden Gems", "Travel Blog", "Destination Review", "Travel Trends",
        "Vacation Ideas", "Travel Newsletter", "Explore", "Wanderlust"],
        header :contains "from" ["newsletter@", "blog@", "tips@", "inspiration@"]
    ) {
        fileinto "Travel/Planning";
        
        # Travel inspiration (expire 10 days)
        if allof (
            header :contains "subject" ["Newsletter", "Weekly", "Monthly", "Guide",
            "Tips", "Ideas", "Inspiration", "Blog"],
            size :under 500K
        ) {
            expire "day" "10";
        }
        
        stop;
    }

    # Default to "Travel" folder
    fileinto "Travel";

    # General expiration rules for travel content

    # Account & Security notifications (expire 14 days)
    if allof (
        header :contains "subject" ["Account Update", "Password Change", "Security Alert",
        "Profile Update", "Payment Method", "Billing Update", "Account Verification",
        "Two-Factor Authentication", "Login Alert", "Account Activity"],
        size :under 500K
    ) {
        expire "day" "14";
        stop;
    }

    # Loyalty program updates (expire 30 days)
    if allof (
        header :contains "subject" ["Miles Update", "Points Summary", "Elite Status",
        "Loyalty Program", "Rewards Balance", "Member Benefits", "Status Update",
        "Points Earned", "Reward Redemption", "Member Newsletter"],
        size :under 500K
    ) {
        expire "day" "30";
        stop;
    }

    # Newsletter & marketing (expire 7 days)
    if allof (
        header :contains "subject" ["Newsletter", "Travel News", "Weekly Update",
        "Monthly Digest", "Travel Trends", "Industry News", "Company Update"],
        size :under 500K
    ) {
        expire "day" "7";
        stop;
    }

    # Default expiration for other travel content (10 days)
    expire "day" "10";
    
    stop;
}

# End of Travel Filter