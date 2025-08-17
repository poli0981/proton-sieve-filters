# Sieve filter
# Filter_Shopping.sieve
# Only for user use Proton Mail.
# Version: 0.2.0
# This Sieve script filters messages related to shopping/e-commerce platforms, moves them to "Shopping" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to shopping/e-commerce
if anyof (
    address :domain :matches "from" [
    # Major E-commerce Platforms
    "*amazon.com", "*amazon.ca", "*amazon.co.uk", "*amazon.de", "*amazon.fr",
    "*amazon.es", "*amazon.it", "*amazon.com.au", "*amazon.co.jp", "*amazon.in",
    "*ebay.com", "*ebay.ca", "*ebay.co.uk", "*ebay.de", "*ebay.fr", "*ebay.es",
    "*aliexpress.com", "*alibaba.com", "*dhgate.com", "*banggood.com",
    "*shopee.com", "*lazada.com", "*wish.com", "*temu.com", "*shein.com",
    
    # US Retail Giants
    "*walmart.com", "*target.com", "*costco.com", "*bestbuy.com", "*samsclub.com",
    "*bjs.com", "*menards.com", "*homedepot.com", "*lowes.com", "*wayfair.com",
    "*overstock.com", "*newegg.com", "*tigerdirect.com", "*bhphotovideo.com",
    
    # Fashion & Apparel
    "*zara.com", "*hm.com", "*uniqlo.com", "*gap.com", "*oldnavy.com",
    "*bananarepublic.com", "*jcrew.com", "*madewell.com", "*abercrombie.com",
    "*hollisterco.com", "*ae.com", "*aeropostale.com", "*forever21.com",
    "*express.com", "*urbanoutfitters.com", "*anthropologie.com", "*freepeople.com",
    "*nordstrom.com", "*nordstromrack.com", "*macys.com", "*bloomingdales.com",
    "*saksfifthavenue.com", "*neimanmarcus.com", "*dillards.com", "*belk.com",
    "*kohls.com", "*jcpenney.com", "*boscovs.com", "*lordandtaylor.com",
    
    # Sportswear & Athletic
    "*nike.com", "*adidas.com", "*underarmour.com", "*puma.com", "*reebok.com",
    "*newbalance.com", "*asics.com", "*vans.com", "*converse.com", "*skechers.com",
    "*lululemon.com", "*athleta.com", "*patagonia.com", "*thenorthface.com",
    "*columbia.com", "*rei.com", "*backcountry.com", "*moosejaw.com",
    "*dickssportinggoods.com", "*academy.com", "*sportsmans.com", "*cabelas.com",
    
    # Footwear
    "*zappos.com", "*dsw.com", "*famousfootwear.com", "*footlocker.com",
    "*champssports.com", "*footaction.com", "*eastbay.com", "*finishline.com",
    "*ugg.com", "*timberland.com", "*clarks.com", "*crocs.com", "*birkenstock.com",
    
    # Beauty & Personal Care
    "*sephora.com", "*ulta.com", "*sallybeauty.com", "*beautybrands.com",
    "*dermstore.com", "*skinstore.com", "*bathandbodyworks.com", "*lushusa.com",
    "*thebodyshop.com", "*kiehls.com", "*clinique.com", "*maccosmetics.com",
    
    # Electronics & Tech
    "*apple.com", "*samsung.com", "*lg.com", "*sony.com", "*hp.com", "*dell.com",
    "*lenovo.com", "*asus.com", "*acer.com", "*microsoft.com", "*google.com",
    "*tesla.com", "*dji.com", "*gopro.com", "*fitbit.com", "*garmin.com",
    
    # Home & Garden
    "*ikea.com", "*crateandbarrel.com", "*potterybarn.com", "*westelm.com",
    "*williams-sonoma.com", "*bedbathandbeyond.com", "*containerstore.com",
    "*worldmarket.com", "*pier1.com", "*homegoods.com", "*tjmaxx.com",
    
    # Specialty & Niche
    "*etsy.com", "*etsystudio.com", "*artfire.com", "*bonanza.com", "*mercari.com",
    "*poshmark.com", "*thredup.com", "*vestiairecollective.com", "*therealreal.com",
    "*fashionphile.com", "*rebag.com", "*whatgoesaroundnyc.com",
    
    # Asian Markets
    "*taobao.com", "*tmall.com", "*jd.com", "*rakuten.com", "*rakuten.co.jp",
    "*flipkart.com", "*myntra.com", "*ajio.com", "*snapdeal.com", "*nykaa.com",
    
    # Print & Custom Products
    "*vistaprint.com", "*shutterfly.com", "*snapfish.com", "*cafepress.com",
    "*redbubble.com", "*teespring.com", "*spreadshirt.com", "*threadless.com",
    "*society6.com", "*zazzle.com", "*customink.com", "*printful.com",
    
    # Books & Media
    "*barnesandnoble.com", "*booksamillion.com", "*thriftbooks.com", "*abebooks.com",
    "*bookdepository.com", "*powells.com", "*audible.com", "*kindle.com",
    "*spotify.com", "*netflix.com", "*hulu.com", "*disneyplus.com", "*hbomax.com",
    
    # Food & Grocery
    "*instacart.com", "*shipt.com", "*amazonfresh.com", "*wholefoodsmarket.com",
    "*kroger.com", "*safeway.com", "*albertsons.com", "*publix.com", "*wegmans.com",
    "*hellofresh.com", "*blueapron.com", "*freshly.com", "*sunbasket.com",
    
    # Subscription Services
    "*netflix.com", "*spotify.com", "*disney.com", "*hulu.com", "*paramount.com",
    "*discovery.com", "*peacocktv.com", "*appletv.com", "*youtube.com",
    
    # Payment & Shopping Services
    "*paypal.com", "*stripe.com", "*square.com", "*klarna.com", "*afterpay.com",
    "*affirm.com", "*sezzle.com", "*quadpay.com", "*splitit.com", "*zip.co"
    ],
    
    # Shopping-related keywords
    header :contains "subject" ["Order", "Purchase", "Cart", "Checkout", "Payment",
    "Receipt", "Invoice", "Shipping", "Delivery", "Tracking", "Sale", "Deal",
    "Discount", "Coupon", "Promo", "Offer", "Clearance", "Black Friday",
    "Cyber Monday", "Holiday Sale", "Flash Sale", "Limited Time"]
) {
    # Mark email as read (apply before fileinto)
    addflag "\\Seen";

    # Move to "Shopping" folder by default
    fileinto "Shopping";

    # ========================================================================
    # ORDER CONFIRMATIONS & RECEIPTS - Keep longer for records
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Order Confirmation", "Purchase Confirmation", 
        "Order Receipt", "Purchase Receipt", "Transaction Complete", "Payment Received",
        "Order Placed Successfully", "Thank You for Your Order", "Order Summary",
        "Invoice", "Receipt", "Transaction Summary", "Payment Confirmation"],
        size :under 1M  # Receipts can have attachments
    ) {
        fileinto "Shopping/Orders";
        expire "day" "365";
        stop;
    }

    # ========================================================================
    # SHIPPING & DELIVERY - Important tracking info
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Shipped", "Tracking Number", "On the Way",
        "Out for Delivery", "Delivered", "Package Arrived", "Delivery Update",
        "Shipment Notification", "In Transit", "Delivery Attempt", "Ready for Pickup",
        "Package Delayed", "Delivery Rescheduled", "Signature Required"],
        size :under 500K
    ) {
        fileinto "Shopping/Shipping";
        expire "day" "60";
        stop;
    }

    # ========================================================================
    # DEALS & PROMOTIONS - Short retention for time-sensitive offers
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Flash Sale", "Daily Deal", "Limited Time Offer",
        "Sale Alert", "Price Drop", "Clearance Sale", "Black Friday", "Cyber Monday",
        "Holiday Sale", "Weekend Sale", "Exclusive Deal", "Member Sale",
        "VIP Sale", "Early Access", "Presale", "Special Offer", "Discount Alert",
        "Coupon Inside", "Promo Code", "% Off", "Free Shipping", "Buy One Get One"],
        size :under 500K,
        not header :contains "subject" ["Order", "Confirmation", "Receipt"]
    ) {
        fileinto "Shopping/Deals";
        
        # Flash sales expire quickly
        if header :contains "subject" ["Flash Sale", "Today Only", "Ends Tonight", 
        "Last Hours", "Final Hours", "Midnight Sale"] {
            expire "day" "1";
        # Regular sales
        } else {
            expire "day" "5";
        }
        
        stop;
    }

    # ========================================================================
    # CART ABANDONMENT & REMINDERS - Very short retention
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Abandoned Cart", "Items in Your Cart", 
        "Complete Your Purchase", "Forgot Something", "Cart Reminder",
        "Don't Miss Out", "Still Interested", "Your Cart Expires",
        "Items Reserved", "Checkout Now", "Return to Cart", "Save Your Cart"],
        size :under 300K
    ) {
        fileinto "Shopping/Cart";
        expire "day" "2";
        stop;
    }

    # ========================================================================
    # RECOMMENDATIONS & PERSONALIZED SUGGESTIONS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Recommended for You", "You Might Like", 
        "Personalized Picks", "Based on Your Browsing", "Similar Items",
        "Customers Also Bought", "New Arrivals", "Trending Now", "Popular Items",
        "Curated Selection", "Handpicked", "Just for You", "Inspired by"],
        size :under 500K
    ) {
        fileinto "Shopping/Recommendations";
        expire "day" "7";
        stop;
    }

    # ========================================================================
    # RETURNS & REFUNDS - Important for customer service
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Return", "Refund", "Exchange", "Credit Issued",
        "Returned Item", "Refund Processed", "Return Label", "RMA Number",
        "Return Authorized", "Exchange Approved", "Store Credit", "Refund Status"],
        size :under 500K
    ) {
        fileinto "Shopping/Returns";
        expire "day" "90";
        stop;
    }

    # ========================================================================
    # LOYALTY & REWARDS PROGRAMS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Rewards Points", "Loyalty Program", "Member Benefits",
        "Points Earned", "Cashback", "Reward Balance", "VIP Status", "Tier Update",
        "Member Exclusive", "Points Expiring", "Redeem Points", "Reward Available"],
        size :under 300K
    ) {
        fileinto "Shopping/Rewards";
        expire "day" "30";
        stop;
    }

    # ========================================================================
    # PRODUCT REVIEWS & FEEDBACK
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Review Your Purchase", "Rate Your Order", 
        "How Was Your Experience", "Product Review", "Share Your Thoughts",
        "Tell Us About", "Feedback Request", "Review Reminder", "Rate This Item"],
        size :under 300K
    ) {
        fileinto "Shopping/Reviews";
        expire "day" "14";
        stop;
    }

    # ========================================================================
    # SUBSCRIPTION & RECURRING ORDERS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Subscription", "Auto-delivery", "Recurring Order",
        "Subscription Renewal", "Auto-renewal", "Subscribe & Save", "Monthly Delivery",
        "Subscription Update", "Pause Subscription", "Cancel Subscription"],
        size :under 500K
    ) {
        fileinto "Shopping/Subscriptions";
        expire "day" "90";
        stop;
    }

    # ========================================================================
    # WISHLISTS & SAVED ITEMS
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Wishlist", "Saved Items", "Price Drop on Saved",
        "Item Back in Stock", "Saved for Later", "Favorites Update", "Watch List"],
        size :under 300K
    ) {
        fileinto "Shopping/Wishlist";
        expire "day" "21";
        stop;
    }

    # ========================================================================
    # ACCOUNT & SECURITY (Shopping-related)
    # ========================================================================
    
    if anyof (
        header :contains "subject" ["Account Update", "Password Changed", "Payment Method",
        "Billing Address", "Security Alert", "Login Alert", "Account Verification",
        "Profile Update", "Settings Changed", "Two-Factor Authentication"],
        size :under 500K
    ) {
        fileinto "Shopping/Account";
        expire "day" "60";
        stop;
    }

    # ========================================================================
    # GENERAL EXPIRATION RULES
    # ========================================================================

    # EULA/ToS/Privacy updates (expire 2 days)
    if allof (
        header :contains "subject" ["EULA Update", "Terms Change", "Policy Revision", 
        "Privacy Policy Update", "Terms of Service", "User Agreement Update"],
        size :under 500K
    ) {
        expire "day" "2";
        stop;
    }

    # Newsletter & company updates (expire 7 days)
    if allof (
        header :contains "subject" ["Newsletter", "Company News", "Brand Update",
        "New Collection", "Season Preview", "Style Guide", "Trend Report"],
        size :under 500K,
        not header :contains "subject" ["Sale", "Deal", "Offer", "Discount"]
    ) {
        expire "day" "7";
        stop;
    }

    # General promotional emails (expire 10 days)
    if allof (
        size :under 500K,
        not header :contains "subject" ["Order", "Shipping", "Delivery", "Return", "Refund"]
    ) {
        expire "day" "10";
        stop;
    }

    # Default expiration for uncategorized shopping emails
    expire "day" "14";
    
    stop;
}

# End of Sieve script for shopping filter