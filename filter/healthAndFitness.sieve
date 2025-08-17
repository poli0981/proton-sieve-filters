# Sieve filter
# Filter_Health_And_Fitness.sieve
# Only for user use Proton Mail.
# Version: 1.0.0
# This Sieve script filters messages related to health and fitness platforms/apps, moves them to "Health" folder.

require ["fileinto", "imap4flags", "vnd.proton.expire", "reject", "extlists"];

# Whitelist
if header :list "from" ":addrbook:personal" {
    stop;
}

# Filter messages related to health/fitness
if anyof (
    # Major Fitness Apps & Platforms
    address :domain :matches "from" ["*nike.com", "*peloton.com", "*centr.com",
    "*classpass.com", "*lesmills.com", "*fitfusion.com", "*dailyburn.com",
    "*obefitness.com", "*thesculptsociety.com", "*evolveyou.app", "*popsugar.com",
    "*apple.com", "*future.co", "*joinforma.com", "*fitbod.me", "*aaptiv.com",
    "*blogilates.com", "*8fit.com", "*asanarebel.com", "*glo.com", "*ladder.app",
    "*pvolve.com", "*alomoves.com", "*trainwell.net", "*strongapp.me"],

    # Meditation & Mental Health Apps
    address :domain :matches "from" ["*calm.com", "*headspace.com", "*happier.com",
    "*sleepcycle.com", "*insight-timer.com", "*ten-percent-happier.com", "*waking-up.com",
    "*buddhify.com", "*simple-habit.com", "*breethe.com", "*sanvello.com",
    "*youper.ai", "*daylio.net", "*moodpath.com", "*talkspace.com", "*betterhelp.com",
    "*cerebral.com", "*brightside.com", "*lyra.com"],

    # Fitness Tracking & Wearables
    address :domain :matches "from" ["*myfitnesspal.com", "*strava.com", "*fitbit.com",
    "*whoop.com", "*garmin.com", "*suunto.com", "*polar.com", "*samsung.com",
    "*huawei.com", "*amazfit.com", "*withings.com", "*oura.com", "*mapmyrun.com",
    "*mapmyfitness.com", "*runkeeper.com", "*runtastic.com", "*endomondo.com"],

    # Nutrition & Diet Apps
    address :domain :matches "from" ["*lifesum.com", "*loseit.com", "*cronometer.com",
    "*fatsecret.com", "*sparkpeople.com", "*yazio.com", "*noom.com", "*ww.com",
    "*weightwatchers.com", "*nutrisystem.com", "*hellofresh.com", "*blueapron.com",
    "*freshly.com", "*sunbasket.com", "*plated.com", "*gobble.com"],

    # Workout & Training Platforms
    address :domain :matches "from" ["*beachbody.com", "*p90x.com", "*insanity.com",
    "*21dayfix.com", "*dailyhiit.com", "*7minuteworkout.com", "*sworkit.com",
    "*freeletics.com", "*adidas.com", "*under-armour.com", "*reebok.com",
    "*trainiac.com", "*jefit.com", "*bodybuilding.com", "*muscleandstrength.com"],

    # Yoga & Pilates Apps
    address :domain :matches "from" ["*downdogapp.com", "*dailyyoga.com", "*yogastudio.com",
    "*gaiam.com", "*doyogawithme.com", "*alo.com", "*corepower.com", "*yogaworks.com",
    "*pilatesanytime.com", "*blogilates.com", "*balanced-body.com", "*stottpilates.com"],

    # Health Monitoring & Medical Apps
    address :domain :matches "from" ["*healthtap.com", "*teladoc.com", "*amwell.com",
    "*mdlive.com", "*doctorondemand.com", "*zocdoc.com", "*practo.com", "*babylon.health",
    "*ada.com", "*symptomate.com", "*webmd.com", "*mayoclinic.org", "*healthline.com",
    "*medscape.com", "*drugs.com", "*goodrx.com"],

    # Gaming Fitness & Activity Apps
    address :domain :matches "from" ["*pokemon.com", "*pokemongo.com", "*niantic.com",
    "*zombiesrungame.com", "*couchto5k.com", "*justdancenow.com", "*fitnessrpg.com",
    "*habitica.com", "*stridekick.com", "*stepbet.com", "*dietbet.com", "*walkr.space"],

    # Sleep & Recovery Apps
    address :domain :matches "from" ["*sleep.com", "*sleepscore.com", "*pillow.com",
    "*sleepbot.com", "*sleepio.com", "*pzizz.com", "*noisli.com", "*rainy-mood.com",
    "*brain.fm", "*focus-app.com", "*freedom.to", "*rescue-time.com"],

    # Supplement & Wellness Companies
    address :domain :matches "from" ["*myprotein.com", "*optimumnutrition.com", "*bsn.com",
    "*cellucor.com", "*musclepharm.com", "*dymatize.com", "*questnutrition.com",
    "*muscletech.com", "*nutrabio.com", "*performancelab.com", "*thorne.com",
    "*naturemade.com", "*centrum.com", "*vitafusion.com"],

    # Professional Health Services
    address :domain :matches "from" ["*23andme.com", "*ancestry.com", "*myheritage.com",
    "*color.com", "*helix.com", "*everlywell.com", "*letsgetchecked.com", "*imaware.health",
    "*inside-tracker.com", "*vitagene.com", "*nutrigenomix.com", "*arivale.com"],

    # Specialized Health Platforms
    address :domain :matches "from" ["*diabetes.org", "*heart.org", "*cancer.org",
    "*arthritis.org", "*kidney.org", "*lung.org", "*alzheimers.net", "*parkinson.org",
    "*multiple-sclerosis.org", "*crohns-colitis-foundation.org"],

    # Corporate Wellness Platforms
    address :domain :matches "from" ["*virgin-pulse.com", "*limeade.com", "*thrive.com",
    "*achievers.com", "*welltok.com", "*castlight.com", "*jiff.com", "*redbox-rx.com",
    "*shipt.com", "*instacart.com"]
) {
    # Mark email as read first
    addflag "\\Seen";
    
    # Move to "Health" folder
    fileinto "Health";

    # Daily Reminders & Notifications (expire 1 day)
    if allof (
        header :contains "subject" ["Workout Reminder", "Daily Step Goal", "Meditation Session", 
        "Fitness Challenge Start", "Health Tip of the Day", "Track Your Progress", 
        "Don't Miss Your Session", "Activity Alert", "Goal Reminder", "Streak Update",
        "Time to Move", "Stand Up Reminder", "Hydration Alert", "Medicine Reminder",
        "Appointment Reminder", "Check-in Time", "Daily Challenge", "Morning Motivation",
        "Evening Reflection", "Sleep Time Alert"],
        size :under 500K
    ) {
        expire "day" "1";
        stop;
    }

    # Promotional Content & Deals (expire 3 days)
    if allof (
        header :contains "subject" ["Special Offer Inside", "Discount on Premium", 
        "Free Trial Extension", "Limited Time Deal", "Upgrade Your Plan", "Promo Code Alert", 
        "Membership Renewal Offer", "Flash Sale on App", "Exclusive Discount", 
        "Rewards Program Update", "Black Friday Deal", "Summer Sale", "New Year Special",
        "First Month Free", "50% Off Premium", "Early Bird Discount", "Member Exclusive"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "3";
        stop;
    }

    # Weekly Reports & Progress Updates (expire 7 days)
    if allof (
        header :contains "subject" ["Weekly Report", "Progress Summary", "Weekly Stats",
        "Your Week in Review", "Weekly Achievement", "7-Day Summary", "Weekly Challenge Results",
        "Week's Progress", "Weekly Insights", "Performance Summary", "Weekly Goals Review"],
        size :under 500K
    ) {
        expire "day" "7";
        stop;
    }

    # Plans, Tips & Educational Content (expire 14 days)
    if allof (
        header :contains "subject" ["Fitness Plan Update", "Nutrition Tip", "Weekly Workout Plan", 
        "Custom Training Schedule", "Progress Report", "Meal Plan Suggestion", 
        "Personalized Plan Ready", "Goal Achievement Update", "Health Education",
        "Workout Tips", "Nutrition Guide", "Exercise Tutorial", "Health Article",
        "Training Plan", "Diet Recommendation", "Wellness Guide", "Health News"],
        size :under 500K
    ) {
        expire "day" "14";
        stop;
    }

    # Monthly Reports & Long-term Analytics (expire 21 days)
    if allof (
        header :contains "subject" ["Monthly Report", "Monthly Summary", "30-Day Challenge Results",
        "Monthly Achievement", "Long-term Progress", "Monthly Analytics", "Trend Analysis",
        "Monthly Insights", "Your Month in Review", "Monthly Goals Assessment"],
        size :under 500K
    ) {
        expire "day" "21";
        stop;
    }

    # Security & Account Management (expire 28 days)
    if allof (
        header :contains "subject" ["Account Security Alert", "Password Change Required", 
        "Suspicious Activity", "Health Data Privacy Update", "Login Attempt Notification", 
        "Two-Factor Setup", "Data Breach Warning", "Account Locked", "Verification Code", 
        "Fraud Detection", "Privacy Policy Update", "Terms of Service Change",
        "HIPAA Compliance", "Data Protection Update", "Security Update"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "28";
        stop;
    }

    # App Updates & New Features (expire 10 days)
    if allof (
        header :contains "subject" ["App Update Available", "New Feature Alert", "Version Update",
        "Feature Release", "App Enhancement", "Bug Fix Update", "Performance Improvement",
        "New Workout Added", "Feature Announcement", "Platform Update", "System Upgrade"],
        size :under 500K
    ) {
        expire "day" "10";
        stop;
    }

    # Medical & Health Test Results (expire 90 days - important for health records)
    if allof (
        header :contains "subject" ["Test Results", "Lab Results", "Blood Work", "Health Screening",
        "Medical Report", "Genetic Results", "Health Assessment", "Diagnostic Results",
        "Biomarker Results", "Health Score", "Risk Assessment", "Health Analysis"],
        size :under 2M  # Medical reports can be larger
    ) {
        expire "day" "90";
        stop;
    }

    # Subscription & Billing (expire 365 days - important for records)
    if allof (
        header :contains "subject" ["Subscription Renewal", "Payment Confirmation", "Invoice",
        "Billing Statement", "Payment Receipt", "Membership Renewed", "Auto-renewal Notice",
        "Payment Failed", "Card Expired", "Subscription Cancelled", "Refund Processed"],
        size :under 500K
    ) {
        expire "day" "365";
        stop;
    }

    # Default expiration for other health/fitness content (5 days)
    expire "day" "5";
    
    stop;
}

# End of Health & Fitness Filter