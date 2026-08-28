# Health & Fitness filter -- filter/health.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/health.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# Medical, fitness and wellness services.
#
# Folders: Health
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 15 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

if anyof (
    address :domain :matches "from" ["21dayfix.com", "*.21dayfix.com", "23andme.com",
        "*.23andme.com", "7minuteworkout.com", "*.7minuteworkout.com", "8fit.com",
        "*.8fit.com", "aaptiv.com", "*.aaptiv.com", "achievers.com", "*.achievers.com",
        "ada.com", "*.ada.com", "adidas.com", "*.adidas.com", "alo.com", "*.alo.com",
        "alomoves.com", "*.alomoves.com", "alzheimers.net", "*.alzheimers.net",
        "amazfit.com", "*.amazfit.com", "amwell.com", "*.amwell.com", "ancestry.com",
        "*.ancestry.com", "arthritis.org", "*.arthritis.org", "asanarebel.com",
        "*.asanarebel.com", "babylon.health", "*.babylon.health", "balanced-body.com",
        "*.balanced-body.com", "beachbody.com", "*.beachbody.com", "betterhelp.com",
        "*.betterhelp.com", "blogilates.com", "*.blogilates.com", "blueapron.com",
        "*.blueapron.com", "bodybuilding.com", "*.bodybuilding.com", "brain.fm",
        "*.brain.fm", "breethe.com", "*.breethe.com", "brightside.com",
        "*.brightside.com", "bsn.com", "*.bsn.com", "buddhify.com", "*.buddhify.com",
        "calm.com", "*.calm.com", "cancer.org", "*.cancer.org", "castlight.com",
        "*.castlight.com", "cellucor.com", "*.cellucor.com", "centr.com", "*.centr.com",
        "centrum.com", "*.centrum.com", "cerebral.com", "*.cerebral.com",
        "classpass.com", "*.classpass.com", "color.com", "*.color.com", "corepower.com",
        "*.corepower.com", "couchto5k.com", "*.couchto5k.com",
        "crohns-colitis-foundation.org", "*.crohns-colitis-foundation.org",
        "cronometer.com", "*.cronometer.com", "dailyburn.com", "*.dailyburn.com",
        "dailyhiit.com", "*.dailyhiit.com", "dailyyoga.com", "*.dailyyoga.com",
        "daylio.net", "*.daylio.net", "diabetes.org", "*.diabetes.org", "dietbet.com",
        "*.dietbet.com", "doctorondemand.com", "*.doctorondemand.com", "downdogapp.com",
        "*.downdogapp.com", "doyogawithme.com", "*.doyogawithme.com", "drugs.com",
        "*.drugs.com", "dymatize.com", "*.dymatize.com", "endomondo.com",
        "*.endomondo.com", "everlywell.com", "*.everlywell.com", "evolveyou.app",
        "*.evolveyou.app", "fatsecret.com", "*.fatsecret.com", "fitbit.com",
        "*.fitbit.com", "fitbod.me", "*.fitbod.me", "fitfusion.com", "*.fitfusion.com",
        "fitnessrpg.com", "*.fitnessrpg.com", "focus-app.com", "*.focus-app.com",
        "freedom.to", "*.freedom.to", "freeletics.com", "*.freeletics.com",
        "freshly.com", "*.freshly.com", "future.co", "*.future.co", "gaiam.com",
        "*.gaiam.com", "garmin.com", "*.garmin.com", "glo.com", "*.glo.com",
        "gobble.com", "*.gobble.com", "goodrx.com", "*.goodrx.com", "habitica.com",
        "*.habitica.com", "happier.com", "*.happier.com", "headspace.com",
        "*.headspace.com", "healthline.com", "*.healthline.com", "healthtap.com",
        "*.healthtap.com", "heart.org", "*.heart.org", "helix.com", "*.helix.com",
        "hellofresh.com", "*.hellofresh.com", "huawei.com", "*.huawei.com",
        "imaware.health", "*.imaware.health", "insanity.com", "*.insanity.com",
        "inside-tracker.com", "*.inside-tracker.com", "insight-timer.com",
        "*.insight-timer.com", "instacart.com", "*.instacart.com", "jefit.com",
        "*.jefit.com", "jiff.com", "*.jiff.com", "joinforma.com", "*.joinforma.com",
        "justdancenow.com", "*.justdancenow.com", "kidney.org", "*.kidney.org",
        "ladder.app", "*.ladder.app", "lesmills.com", "*.lesmills.com",
        "letsgetchecked.com", "*.letsgetchecked.com", "lifesum.com", "*.lifesum.com",
        "limeade.com", "*.limeade.com", "loseit.com", "*.loseit.com", "lung.org",
        "*.lung.org", "lyra.com", "*.lyra.com", "mapmyfitness.com",
        "*.mapmyfitness.com", "mapmyrun.com", "*.mapmyrun.com", "mayoclinic.org",
        "*.mayoclinic.org", "mdlive.com", "*.mdlive.com", "medscape.com",
        "*.medscape.com", "moodpath.com", "*.moodpath.com", "multiple-sclerosis.org",
        "*.multiple-sclerosis.org", "muscleandstrength.com", "*.muscleandstrength.com",
        "musclepharm.com", "*.musclepharm.com", "muscletech.com", "*.muscletech.com",
        "myfitnesspal.com", "*.myfitnesspal.com", "myheritage.com", "*.myheritage.com",
        "myprotein.com", "*.myprotein.com", "naturemade.com", "*.naturemade.com",
        "niantic.com", "*.niantic.com", "nike.com", "*.nike.com", "noisli.com",
        "*.noisli.com", "noom.com", "*.noom.com", "nutrabio.com", "*.nutrabio.com",
        "nutrigenomix.com", "*.nutrigenomix.com", "nutrisystem.com",
        "*.nutrisystem.com", "obefitness.com", "*.obefitness.com",
        "optimumnutrition.com", "*.optimumnutrition.com", "oura.com", "*.oura.com",
        "p90x.com", "*.p90x.com", "parkinson.org", "*.parkinson.org", "peloton.com",
        "*.peloton.com", "performancelab.com", "*.performancelab.com",
        "pilatesanytime.com", "*.pilatesanytime.com", "pillow.com", "*.pillow.com",
        "pokemon.com", "*.pokemon.com", "pokemongo.com", "*.pokemongo.com", "polar.com",
        "*.polar.com", "popsugar.com", "*.popsugar.com", "practo.com", "*.practo.com",
        "pvolve.com", "*.pvolve.com", "pzizz.com", "*.pzizz.com", "questnutrition.com",
        "*.questnutrition.com", "rainy-mood.com", "*.rainy-mood.com", "redbox-rx.com",
        "*.redbox-rx.com", "reebok.com", "*.reebok.com", "rescue-time.com",
        "*.rescue-time.com", "runkeeper.com", "*.runkeeper.com", "runtastic.com",
        "*.runtastic.com", "samsung.com", "*.samsung.com", "sanvello.com",
        "*.sanvello.com", "shipt.com", "*.shipt.com", "simple-habit.com",
        "*.simple-habit.com", "sleep.com", "*.sleep.com", "sleepbot.com",
        "*.sleepbot.com", "sleepcycle.com", "*.sleepcycle.com", "sleepio.com",
        "*.sleepio.com", "sleepscore.com", "*.sleepscore.com", "sparkpeople.com",
        "*.sparkpeople.com", "stepbet.com", "*.stepbet.com", "stottpilates.com",
        "*.stottpilates.com", "strava.com", "*.strava.com", "stridekick.com",
        "*.stridekick.com", "strongapp.me", "*.strongapp.me", "sunbasket.com",
        "*.sunbasket.com", "suunto.com", "*.suunto.com", "sworkit.com", "*.sworkit.com",
        "symptomate.com", "*.symptomate.com", "talkspace.com", "*.talkspace.com",
        "teladoc.com", "*.teladoc.com", "ten-percent-happier.com",
        "*.ten-percent-happier.com", "thesculptsociety.com", "*.thesculptsociety.com",
        "thorne.com", "*.thorne.com", "thrive.com", "*.thrive.com", "trainiac.com",
        "*.trainiac.com", "trainwell.net", "*.trainwell.net", "under-armour.com",
        "*.under-armour.com", "virgin-pulse.com", "*.virgin-pulse.com",
        "vitafusion.com", "*.vitafusion.com", "vitagene.com", "*.vitagene.com",
        "waking-up.com", "*.waking-up.com", "walkr.space", "*.walkr.space", "webmd.com",
        "*.webmd.com", "weightwatchers.com", "*.weightwatchers.com", "welltok.com",
        "*.welltok.com", "whoop.com", "*.whoop.com", "withings.com", "*.withings.com",
        "ww.com", "*.ww.com", "yazio.com", "*.yazio.com", "yogastudio.com",
        "*.yogastudio.com", "yogaworks.com", "*.yogaworks.com", "youper.ai",
        "*.youper.ai", "zocdoc.com", "*.zocdoc.com", "zombiesrungame.com",
        "*.zombiesrungame.com"],
    header :contains "subject" ["Nhắc nhở tập luyện", "Mục tiêu bước chân hàng ngày",
        "Phiên thiền", "Thử thách thể dục", "Mẹo sức khỏe", "Theo dõi tiến độ",
        "Cảnh báo hoạt động", "Nhắc nhở mục tiêu", "Cập nhật streak",
        "Thời gian di chuyển", "Nhắc nhở đứng lên", "Cảnh báo nước uống",
        "Nhắc nhở thuốc", "Nhắc nhở cuộc hẹn", "Báo cáo tiến độ", "Kế hoạch tập luyện",
        "Mẹo dinh dưỡng", "Hướng dẫn tập luyện", "Bài báo sức khỏe",
        "Kế hoạch chế độ ăn", "Hướng dẫn sức khỏe", "Tin tức sức khỏe",
        "Báo cáo hàng tuần", "Tóm tắt hàng tháng", "Kết quả xét nghiệm", "Báo cáo y tế",
        "Đánh giá sức khỏe", "Xác nhận thanh toán", "Hóa đơn", "Gia hạn thành viên",
        "Cập nhật bảo mật", "锻炼提醒", "每日步数目标", "冥想课程", "健身挑战", "健康小贴士", "跟踪进度", "活动提醒",
        "目标提醒", "连续记录更新", "运动时间", "站立提醒", "饮水提醒", "用药提醒", "预约提醒", "进度报告", "锻炼计划",
        "营养建议", "锻炼指导", "健康文章", "饮食计划", "健康指南", "健康新闻", "周报", "月度总结", "检测结果", "医疗报告",
        "健康评估", "付款确认", "账单", "会员续费", "安全更新", "ワークアウトリマインダー", "1日の歩数目標", "瞑想セッション",
        "フィットネスチャレンジ", "健康のヒント", "進捗追跡", "アクティビティアラート", "目標リマインダー", "ストリーク更新", "運動時間",
        "立ち上がりリマインダー", "水分補給アラート", "薬のリマインダー", "予約リマインダー", "進捗レポート", "トレーニング計画",
        "栄養のアドバイス", "エクササイズチュートリアル", "健康記事", "食事プラン", "健康ガイド", "健康ニュース", "週次レポート",
        "月次サマリー", "検査結果", "医療レポート", "健康評価", "支払い確認", "請求書", "メンバーシップ更新", "セキュリティアップデート"]
) {
    addflag "\\Seen";
    fileinto "Health";

    if allof (
        header :contains "subject" ["Workout Reminder", "Daily Step Goal",
            "Meditation Session", "Fitness Challenge Start", "Health Tip of the Day",
            "Track Your Progress", "Don't Miss Your Session", "Activity Alert",
            "Goal Reminder", "Streak Update", "Time to Move", "Stand Up Reminder",
            "Hydration Alert", "Medicine Reminder", "Appointment Reminder",
            "Check-in Time", "Daily Challenge", "Morning Motivation",
            "Evening Reflection", "Sleep Time Alert"],
        size :under 500K
    ) {
        expire "day" "1";

        stop;
    }

    if allof (
        header :contains "subject" ["Special Offer Inside", "Discount on Premium",
            "Free Trial Extension", "Limited Time Deal", "Upgrade Your Plan",
            "Promo Code Alert", "Membership Renewal Offer", "Flash Sale on App",
            "Exclusive Discount", "Rewards Program Update", "Black Friday Deal",
            "Summer Sale", "New Year Special", "First Month Free", "50% Off Premium",
            "Early Bird Discount", "Member Exclusive"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "3";

        stop;
    }

    if allof (
        header :contains "subject" ["Weekly Report", "Progress Summary", "Weekly Stats",
            "Your Week in Review", "Weekly Achievement", "7-Day Summary",
            "Weekly Challenge Results", "Week's Progress", "Weekly Insights",
            "Performance Summary", "Weekly Goals Review"],
        size :under 500K
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Fitness Plan Update", "Nutrition Tip",
            "Weekly Workout Plan", "Custom Training Schedule", "Progress Report",
            "Meal Plan Suggestion", "Personalized Plan Ready",
            "Goal Achievement Update", "Health Education", "Workout Tips",
            "Nutrition Guide", "Exercise Tutorial", "Health Article", "Training Plan",
            "Diet Recommendation", "Wellness Guide", "Health News"],
        size :under 500K
    ) {
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Monthly Report", "Monthly Summary",
            "30-Day Challenge Results", "Monthly Achievement", "Long-term Progress",
            "Monthly Analytics", "Trend Analysis", "Monthly Insights",
            "Your Month in Review", "Monthly Goals Assessment"],
        size :under 500K
    ) {
        expire "day" "21";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Security Alert",
            "Password Change Required", "Suspicious Activity",
            "Health Data Privacy Update", "Login Attempt Notification",
            "Two-Factor Setup", "Data Breach Warning", "Account Locked",
            "Verification Code", "Fraud Detection", "Privacy Policy Update",
            "Terms of Service Change", "HIPAA Compliance", "Data Protection Update",
            "Security Update"],
        size :under 500K,
        not header :contains "subject" ["important", "urgent", "critical"]
    ) {
        expire "day" "28";

        stop;
    }

    if allof (
        header :contains "subject" ["App Update Available", "New Feature Alert",
            "Version Update", "Feature Release", "App Enhancement", "Bug Fix Update",
            "Performance Improvement", "New Workout Added", "Feature Announcement",
            "Platform Update", "System Upgrade"],
        size :under 500K
    ) {
        expire "day" "10";

        stop;
    }

    if allof (
        header :contains "subject" ["Test Results", "Lab Results", "Blood Work",
            "Health Screening", "Medical Report", "Genetic Results",
            "Health Assessment", "Diagnostic Results", "Biomarker Results",
            "Health Score", "Risk Assessment", "Health Analysis"],
        size :under 2M
    ) {
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Subscription Renewal", "Payment Confirmation",
            "Invoice", "Billing Statement", "Payment Receipt", "Membership Renewed",
            "Auto-renewal Notice", "Payment Failed", "Card Expired",
            "Subscription Cancelled", "Refund Processed"],
        size :under 500K
    ) {
        expire "day" "365";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "5";

    stop;
}

# End of Health & Fitness filter
