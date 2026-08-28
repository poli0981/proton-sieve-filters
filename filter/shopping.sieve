# Shopping filter -- filter/shopping.sieve
#
# GENERATED FILE -- do not edit. Edit data/categories/shopping.yml and run:
#     python tools/generate.py
#
# For Proton Mail only. A paid plan is required to run this alongside other
# filters: the free plan allows just one active filter at a time.
#
# E-commerce, orders, shipping and deals.
#
# Folders: Shopping, Shopping/Account, Shopping/Cart, Shopping/Deals, Shopping/Orders,
#          Shopping/Recommendations, Shopping/Returns, Shopping/Reviews,
#          Shopping/Rewards, Shopping/Shipping, Shopping/Subscriptions,
#          Shopping/Wishlist, Spam
#
# WARNING: this filter sets auto-delete timers on matched mail via
#          vnd.proton.expire. Read CHANGELOG.md before installing.
#
# Install position 2 of 22. Filters run in the order you install them,
# and on conflicting actions the last one wins -- see README.md for the
# full order.
#
# Version: 0.3.0

require ["fileinto", "imap4flags", "vnd.proton.expire", "extlists"];

# Never touch mail from people you know.
if header :list "from" ":addrbook:personal" {
    stop;
}

# Known typosquats of the services this filter handles. These are lookalike
# domains, not the real senders -- flag them instead of filing them away.
if address :domain :matches "from" ["amazcn.com", "*.amazcn.com", "ebay-inc.com",
    "*.ebay-inc.com", "paypai.com", "*.paypai.com", "target-store.com",
    "*.target-store.com", "wallmart.com", "*.wallmart.com"] {
    addflag "\\Flagged";
    fileinto "Spam";

    stop;
}

if anyof (
    address :domain :matches "from" ["abebooks.com", "*.abebooks.com",
        "abercrombie.com", "*.abercrombie.com", "academy.com", "*.academy.com",
        "acer.com", "*.acer.com", "ae.com", "*.ae.com", "aeropostale.com",
        "*.aeropostale.com", "ajio.com", "*.ajio.com", "albertsons.com",
        "*.albertsons.com", "alibaba.com", "*.alibaba.com", "aliexpress.com",
        "*.aliexpress.com", "amazon.ca", "*.amazon.ca", "amazon.co.jp",
        "*.amazon.co.jp", "amazon.co.uk", "*.amazon.co.uk", "amazon.com",
        "*.amazon.com", "amazon.com.au", "*.amazon.com.au", "amazon.de", "*.amazon.de",
        "amazon.es", "*.amazon.es", "amazon.fr", "*.amazon.fr", "amazon.in",
        "*.amazon.in", "amazon.it", "*.amazon.it", "amazonfresh.com",
        "*.amazonfresh.com", "anthropologie.com", "*.anthropologie.com", "artfire.com",
        "*.artfire.com", "asics.com", "*.asics.com", "asus.com", "*.asus.com",
        "athleta.com", "*.athleta.com", "backcountry.com", "*.backcountry.com",
        "bananarepublic.com", "*.bananarepublic.com", "banggood.com", "*.banggood.com",
        "barnesandnoble.com", "*.barnesandnoble.com", "bathandbodyworks.com",
        "*.bathandbodyworks.com", "beautybrands.com", "*.beautybrands.com",
        "bedbathandbeyond.com", "*.bedbathandbeyond.com", "belk.com", "*.belk.com",
        "bhphotovideo.com", "*.bhphotovideo.com", "birkenstock.com",
        "*.birkenstock.com", "bjs.com", "*.bjs.com", "bloomingdales.com",
        "*.bloomingdales.com", "bonanza.com", "*.bonanza.com", "bookdepository.com",
        "*.bookdepository.com", "booksamillion.com", "*.booksamillion.com",
        "boscovs.com", "*.boscovs.com", "cabelas.com", "*.cabelas.com", "cafepress.com",
        "*.cafepress.com", "champssports.com", "*.champssports.com", "clarks.com",
        "*.clarks.com", "clinique.com", "*.clinique.com", "columbia.com",
        "*.columbia.com", "containerstore.com", "*.containerstore.com", "converse.com",
        "*.converse.com", "costco.com", "*.costco.com", "crateandbarrel.com",
        "*.crateandbarrel.com", "crocs.com", "*.crocs.com", "customink.com",
        "*.customink.com", "dell.com", "*.dell.com", "dermstore.com", "*.dermstore.com",
        "dhgate.com", "*.dhgate.com", "dickssportinggoods.com",
        "*.dickssportinggoods.com", "dillards.com", "*.dillards.com", "discovery.com",
        "*.discovery.com", "disney.com", "*.disney.com", "dji.com", "*.dji.com",
        "dsw.com", "*.dsw.com", "eastbay.com", "*.eastbay.com", "ebay.ca", "*.ebay.ca",
        "ebay.co.uk", "*.ebay.co.uk", "ebay.de", "*.ebay.de", "ebay.es", "*.ebay.es",
        "ebay.fr", "*.ebay.fr", "express.com", "*.express.com", "famousfootwear.com",
        "*.famousfootwear.com", "fashionphile.com", "*.fashionphile.com",
        "finishline.com", "*.finishline.com", "flipkart.com", "*.flipkart.com",
        "footaction.com", "*.footaction.com", "footlocker.com", "*.footlocker.com",
        "forever21.com", "*.forever21.com", "freepeople.com", "*.freepeople.com",
        "gap.com", "*.gap.com", "gopro.com", "*.gopro.com", "hbomax.com",
        "*.hbomax.com", "hm.com", "*.hm.com", "hollisterco.com", "*.hollisterco.com",
        "homedepot.com", "*.homedepot.com", "homegoods.com", "*.homegoods.com",
        "hp.com", "*.hp.com", "ikea.com", "*.ikea.com", "jcpenney.com",
        "*.jcpenney.com", "jcrew.com", "*.jcrew.com", "jd.com", "*.jd.com",
        "kiehls.com", "*.kiehls.com", "kohls.com", "*.kohls.com", "kroger.com",
        "*.kroger.com", "lazada.com", "*.lazada.com", "lenovo.com", "*.lenovo.com",
        "lg.com", "*.lg.com", "lordandtaylor.com", "*.lordandtaylor.com", "lowes.com",
        "*.lowes.com", "lululemon.com", "*.lululemon.com", "lushusa.com",
        "*.lushusa.com", "maccosmetics.com", "*.maccosmetics.com", "macys.com",
        "*.macys.com", "madewell.com", "*.madewell.com", "menards.com", "*.menards.com",
        "mercari.com", "*.mercari.com", "moosejaw.com", "*.moosejaw.com", "myntra.com",
        "*.myntra.com", "neimanmarcus.com", "*.neimanmarcus.com", "newbalance.com",
        "*.newbalance.com", "nordstrom.com", "*.nordstrom.com", "nordstromrack.com",
        "*.nordstromrack.com", "nykaa.com", "*.nykaa.com", "oldnavy.com",
        "*.oldnavy.com", "overstock.com", "*.overstock.com", "patagonia.com",
        "*.patagonia.com", "pier1.com", "*.pier1.com", "poshmark.com", "*.poshmark.com",
        "potterybarn.com", "*.potterybarn.com", "powells.com", "*.powells.com",
        "printful.com", "*.printful.com", "publix.com", "*.publix.com", "puma.com",
        "*.puma.com", "quadpay.com", "*.quadpay.com", "rakuten.co.jp",
        "*.rakuten.co.jp", "rakuten.com", "*.rakuten.com", "rebag.com", "*.rebag.com",
        "redbubble.com", "*.redbubble.com", "rei.com", "*.rei.com", "safeway.com",
        "*.safeway.com", "saksfifthavenue.com", "*.saksfifthavenue.com",
        "sallybeauty.com", "*.sallybeauty.com", "samsclub.com", "*.samsclub.com",
        "sephora.com", "*.sephora.com", "shein.com", "*.shein.com", "shopee.com",
        "*.shopee.com", "shutterfly.com", "*.shutterfly.com", "skechers.com",
        "*.skechers.com", "skinstore.com", "*.skinstore.com", "snapdeal.com",
        "*.snapdeal.com", "snapfish.com", "*.snapfish.com", "society6.com",
        "*.society6.com", "sony.com", "*.sony.com", "sportsmans.com",
        "*.sportsmans.com", "spreadshirt.com", "*.spreadshirt.com", "square.com",
        "*.square.com", "taobao.com", "*.taobao.com", "teespring.com",
        "*.teespring.com", "temu.com", "*.temu.com", "tesla.com", "*.tesla.com",
        "thebodyshop.com", "*.thebodyshop.com", "thenorthface.com",
        "*.thenorthface.com", "therealreal.com", "*.therealreal.com", "threadless.com",
        "*.threadless.com", "thredup.com", "*.thredup.com", "thriftbooks.com",
        "*.thriftbooks.com", "tigerdirect.com", "*.tigerdirect.com", "timberland.com",
        "*.timberland.com", "tjmaxx.com", "*.tjmaxx.com", "tmall.com", "*.tmall.com",
        "ugg.com", "*.ugg.com", "ulta.com", "*.ulta.com", "underarmour.com",
        "*.underarmour.com", "uniqlo.com", "*.uniqlo.com", "urbanoutfitters.com",
        "*.urbanoutfitters.com", "vans.com", "*.vans.com", "vestiairecollective.com",
        "*.vestiairecollective.com", "vistaprint.com", "*.vistaprint.com",
        "wayfair.com", "*.wayfair.com", "wegmans.com", "*.wegmans.com", "westelm.com",
        "*.westelm.com", "whatgoesaroundnyc.com", "*.whatgoesaroundnyc.com",
        "wholefoodsmarket.com", "*.wholefoodsmarket.com", "williams-sonoma.com",
        "*.williams-sonoma.com", "wish.com", "*.wish.com", "worldmarket.com",
        "*.worldmarket.com", "zappos.com", "*.zappos.com", "zara.com", "*.zara.com",
        "zazzle.com", "*.zazzle.com"],
    header :contains "subject" ["Order Confirmation", "Purchase Confirmation",
        "Your Cart", "Abandoned Cart", "Checkout", "Order Shipped", "Out for Delivery",
        "Tracking Number", "Flash Sale", "Black Friday", "Cyber Monday", "Holiday Sale",
        "Limited Time Offer", "Clearance Sale", "Promo Code", "Xác nhận đơn hàng",
        "Hóa đơn mua hàng", "Thanh toán thành công", "Đơn hàng đã đặt", "Giao hàng",
        "Theo dõi đơn hàng", "Đã giao hàng", "Khuyến mãi", "Giảm giá", "Mã giảm giá",
        "Ưu đãi đặc biệt", "Thời gian có hạn", "Giỏ hàng bỏ quên", "Hoàn trả",
        "Hoàn tiền", "Trao đổi", "Điểm thưởng", "Chương trình khách hàng thân thiết",
        "Đánh giá sản phẩm", "Đăng ký định kỳ", "Danh sách yêu thích",
        "Cập nhật tài khoản", "Phương thức thanh toán", "Cảnh báo bảo mật", "订单确认",
        "购买确认", "交易完成", "付款成功", "已下订单", "感谢您的订单", "发货", "跟踪号码", "正在配送", "已送达", "包裹到达",
        "配送更新", "促销", "限时优惠", "闪购", "价格下跌", "清仓销售", "黑色星期五", "网购星期一", "购物车提醒", "完成购买",
        "退货", "退款", "换货", "积分奖励", "会员福利", "产品评价", "订阅", "自动配送", "愿望清单", "价格下跌提醒",
        "账户更新", "付款方式", "安全警报", "注文確認", "購入確認", "取引完了", "お支払い完了", "ご注文ありがとうございます",
        "発送済み", "追跡番号", "配送中", "配達完了", "荷物到着", "セール", "限定オファー", "タイムセール", "価格下落",
        "在庫処分", "ブラックフライデー", "サイバーマンデー", "カートリマインダー", "購入を完了", "返品", "返金", "交換",
        "ポイント獲得", "会員特典", "商品レビュー", "サブスクリプション", "定期配送", "ウィッシュリスト", "価格下落通知",
        "アカウント更新", "支払い方法", "セキュリティ警告"]
) {
    addflag "\\Seen";
    fileinto "Shopping";

    if allof (
        header :contains "subject" ["Order Confirmation", "Purchase Confirmation",
            "Order Receipt", "Purchase Receipt", "Transaction Complete",
            "Payment Received", "Order Placed Successfully", "Thank You for Your Order",
            "Order Summary", "Invoice", "Receipt", "Transaction Summary",
            "Payment Confirmation"],
        size :under 1M
    ) {
        fileinto "Shopping/Orders";
        expire "day" "365";

        stop;
    }

    if allof (
        header :contains "subject" ["Shipped", "Tracking Number", "On the Way",
            "Out for Delivery", "Delivered", "Package Arrived", "Delivery Update",
            "Shipment Notification", "In Transit", "Delivery Attempt",
            "Ready for Pickup", "Package Delayed", "Delivery Rescheduled",
            "Signature Required"],
        size :under 500K
    ) {
        fileinto "Shopping/Shipping";
        expire "day" "60";

        stop;
    }

    if allof (
        header :contains "subject" ["Flash Sale", "Daily Deal", "Limited Time Offer",
            "Sale Alert", "Price Drop", "Clearance Sale", "Black Friday",
            "Cyber Monday", "Holiday Sale", "Weekend Sale", "Exclusive Deal",
            "Member Sale", "VIP Sale", "Early Access", "Presale", "Special Offer",
            "Discount Alert", "Coupon Inside", "Promo Code", "% Off", "Free Shipping",
            "Buy One Get One"],
        size :under 500K,
        not header :contains "subject" ["Order", "Confirmation", "Receipt"]
    ) {
        fileinto "Shopping/Deals";

        if header :contains "subject" ["Flash Sale", "Today Only", "Ends Tonight",
            "Last Hours", "Final Hours", "Midnight Sale"] {
            expire "day" "1";
        }

        stop;
    }

    if allof (
        header :contains "subject" ["Abandoned Cart", "Items in Your Cart",
            "Complete Your Purchase", "Forgot Something", "Cart Reminder",
            "Don't Miss Out", "Still Interested", "Your Cart Expires", "Items Reserved",
            "Checkout Now", "Return to Cart", "Save Your Cart"],
        size :under 300K
    ) {
        fileinto "Shopping/Cart";
        expire "day" "2";

        stop;
    }

    if allof (
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

    if allof (
        header :contains "subject" ["Return", "Refund", "Exchange", "Credit Issued",
            "Returned Item", "Refund Processed", "Return Label", "RMA Number",
            "Return Authorized", "Exchange Approved", "Store Credit", "Refund Status"],
        size :under 500K
    ) {
        fileinto "Shopping/Returns";
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Rewards Points", "Loyalty Program",
            "Member Benefits", "Points Earned", "Cashback", "Reward Balance",
            "VIP Status", "Tier Update", "Member Exclusive", "Points Expiring",
            "Redeem Points", "Reward Available"],
        size :under 300K
    ) {
        fileinto "Shopping/Rewards";
        expire "day" "30";

        stop;
    }

    if allof (
        header :contains "subject" ["Review Your Purchase", "Rate Your Order",
            "How Was Your Experience", "Product Review", "Share Your Thoughts",
            "Tell Us About", "Feedback Request", "Review Reminder", "Rate This Item"],
        size :under 300K
    ) {
        fileinto "Shopping/Reviews";
        expire "day" "14";

        stop;
    }

    if allof (
        header :contains "subject" ["Subscription", "Auto-delivery", "Recurring Order",
            "Subscription Renewal", "Auto-renewal", "Subscribe & Save",
            "Monthly Delivery", "Subscription Update", "Pause Subscription",
            "Cancel Subscription"],
        size :under 500K
    ) {
        fileinto "Shopping/Subscriptions";
        expire "day" "90";

        stop;
    }

    if allof (
        header :contains "subject" ["Wishlist", "Saved Items", "Price Drop on Saved",
            "Item Back in Stock", "Saved for Later", "Favorites Update", "Watch List"],
        size :under 300K
    ) {
        fileinto "Shopping/Wishlist";
        expire "day" "21";

        stop;
    }

    if allof (
        header :contains "subject" ["Account Update", "Password Changed",
            "Payment Method", "Billing Address", "Security Alert", "Login Alert",
            "Account Verification", "Profile Update", "Settings Changed",
            "Two-Factor Authentication"],
        size :under 500K
    ) {
        fileinto "Shopping/Account";
        expire "day" "60";

        stop;
    }

    if allof (
        header :contains "subject" ["Newsletter", "Company News", "Brand Update",
            "New Collection", "Season Preview", "Style Guide", "Trend Report"],
        size :under 500K,
        not header :contains "subject" ["Sale", "Deal", "Offer", "Discount"]
    ) {
        expire "day" "7";

        stop;
    }

    if allof (
        header :contains "subject" ["Sale", "Deal", "Discount", "Coupon", "Promo",
            "Offer", "Clearance", "Save ", "% Off", "Newsletter", "New Arrivals",
            "Recommended", "Just for You", "Back in Stock"],
        size :under 500K,
        not header :contains "subject" ["Order", "Shipping", "Delivery", "Return",
            "Refund"]
    ) {
        expire "day" "10";

        stop;
    }

    # Default retention for anything that reached none of the rules above.
    expire "day" "14";

    stop;
}

# End of Shopping filter
