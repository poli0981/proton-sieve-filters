# Proton Sieve Filters

[![CI](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml/badge.svg)](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml)
[![MIT License](https://img.shields.io/badge/Code-MIT-green.svg)](../LICENSE)
[![Data CC0](https://img.shields.io/badge/Data-CC0--1.0-green.svg)](../LICENSES/CC0-1.0.txt)
[![Version](https://img.shields.io/badge/Version-0.3.0-blue.svg)](../CHANGELOG.md)
[![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/issues)

22 script Sieve giúp sắp xếp hộp thư Proton Mail vào các thư mục — mua sắm, du lịch, công
việc, bảo mật, chống giả mạo tên miền và mười bảy danh mục khác. Sieve là ngôn ngữ lọc thư
phía máy chủ mà Proton mở cho các tài khoản trả phí.

**Ngôn ngữ:** [English](../README.md) · Tiếng Việt — cả hai đều được bảo trì.
Bản dịch cộng đồng, hiện đã lỗi thời:
[日本語](community/README.ja.md) ·
[简体中文](community/README.zh.md)

> [!WARNING]
> **Các bộ lọc này xoá thư.** Chúng dùng extension `expire` của Proton để đặt hẹn giờ tự
> động xoá cho những thư mà chúng khớp — một bản tin do `news.sieve` lọc sẽ biến mất sau
> 1–14 ngày, một hoá đơn do `invoice.sieve` lọc sau 365 ngày. Hãy đọc
> [Thời gian lưu trữ & tự động xoá](#-thời-gian-lưu-trữ--tự-động-xoá) trước khi cài bất kỳ
> bộ lọc nào, và đọc [CHANGELOG.md](../CHANGELOG.md) nếu bạn đã cài **v0.2.0 trở về
> trước** — trong đó có cảnh báo về một lỗi từng đặt lịch xoá cho gần như toàn bộ hộp thư.

> [!IMPORTANT]
> **Cần gói Proton trả phí để dùng nhiều hơn một bộ lọc.** Gói miễn phí chỉ cho phép
> **đúng một bộ lọc hoạt động** tại một thời điểm. Gói trả phí cho phép tạo không giới hạn
> và bật tối đa **250 bộ lọc**.

---

## 📧 Đây là gì

Mỗi script khớp theo tên miền người gửi và dòng tiêu đề, chuyển thư vào một thư mục, đánh
dấu đã đọc, và đặt thời hạn lưu trữ. Bạn dán chúng vào trình soạn Sieve của Proton; không
có gì được cài lên máy bạn và không có gì gửi dữ liệu đi đâu cả.

**Sieve trên Proton thấy được gì và không thấy được gì.** Do cơ chế mã hoá zero-access,
máy chủ Proton **không bao giờ** đọc được *nội dung* thư của bạn. Bộ lọc chỉ có thể kiểm
tra header, envelope và *kích thước đã mã hoá* — chỉ vậy thôi. Không có test `body`, nên
không bộ lọc nào ở đây khớp được theo nội dung thư thực sự viết gì.

**🤖 Phần lớn dự án này do AI viết.** GitHub Copilot (Claude Sonnet 4) và Grok 4 tạo ra các
bộ lọc và dữ liệu ban đầu năm 2025; Claude Opus 5 thực hiện phần rà soát, xây dựng lại và
toàn bộ công cụ kiểm tra cho v0.2.1–v0.3.0 năm 2026.
[@poli0981](https://github.com/poli0981) định hướng và rà soát.

Điều đó quan trọng với dữ liệu: danh sách domain và từ khoá **chưa được kiểm chứng từng
mục**. Đợt rà soát v0.2.1 tìm thấy 13 domain mà chính chú thích của nó ghi "(defunct)", hai
domain bị gán nhầm công ty, và một mục không phải hostname hợp lệ. Nhiều khả năng vẫn còn
những lỗi tương tự. Xem [AI disclosure](../docs/AI-Disclosure.md) và
[DISCLAIMER.md](../DISCLAIMER.md).

---

## 📂 Các bộ lọc hiện có (v0.3.0)

**Hãy cài theo đúng thứ tự này.** Proton áp dụng **mọi** bộ lọc khớp với một thư, và khi
hai bộ lọc xung đột thì **hành động cuối cùng thắng**. Vì vậy thứ tự chạy các danh mục
rộng trước, cụ thể sau — để bộ lọc cụ thể nhất có tiếng nói cuối cùng.

| # | Bộ lọc | Mục đích | Thư mục gốc | Số thư mục |
|---|--------|----------|-------------|------------|
| 1 | [`spam.sieve`](../filter/spam.sieve) | Heuristic chống spam bổ sung | `Spam` | 1 |
| 2 | [`shopping.sieve`](../filter/shopping.sieve) | Thương mại điện tử, đơn hàng, khuyến mãi | `Shopping` | 13 |
| 3 | [`work.sieve`](../filter/work.sieve) | Công việc, doanh nghiệp | `Work` | 10 |
| 4 | [`food.sieve`](../filter/food.sieve) | Giao đồ ăn, đặt món | `Food` | 1 |
| 5 | [`devtools.sieve`](../filter/devtools.sieve) | Package registry, CI, hosting, giám sát | `Dev` | 1 |
| 6 | [`ai.sieve`](../filter/ai.sieve) | Trợ lý AI, nhà cung cấp mô hình | `AI` | 1 |
| 7 | [`social.sieve`](../filter/social.sieve) | Thông báo mạng xã hội | `Social Account` | 2 |
| 8 | [`news.sieve`](../filter/news.sieve) | Tin tức và bản tin | `News` | 9 |
| 9 | [`entertainment.sieve`](../filter/entertainment.sieve) | Streaming, âm nhạc, podcast, sự kiện | `Entertainment` | 9 |
| 10 | [`gaming.sieve`](../filter/gaming.sieve) | Cửa hàng game, nhà phát hành, esports | `Gaming` | 1 |
| 11 | [`recruiting.sieve`](../filter/recruiting.sieve) | Hệ thống tuyển dụng, thư nhà tuyển dụng | `Recruiting` | 1 |
| 12 | [`study.sieve`](../filter/study.sieve) | Khoá học, đại học, nghiên cứu | `Study` | 19 |
| 13 | [`shipping.sieve`](../filter/shipping.sieve) | Theo dõi vận chuyển, giao hàng | `Shipping` | 1 |
| 14 | [`travel.sieve`](../filter/travel.sieve) | Chuyến bay, khách sạn, thuê xe | `Travel` | 10 |
| 15 | [`health.sieve`](../filter/health.sieve) | Y tế, thể hình, sức khoẻ | `Health` | 1 |
| 16 | [`legal.sieve`](../filter/legal.sieve) | Điều khoản, chính sách riêng tư, EULA | `Legal` | 2 |
| 17 | [`bills.sieve`](../filter/bills.sieve) | Viễn thông, điện nước, bảo hiểm | `Bills` | 1 |
| 18 | [`government.sieve`](../filter/government.sieve) | Cơ quan thuế, dịch vụ công | `Government` | 1 |
| 19 | [`invoice.sieve`](../filter/invoice.sieve) | Biên lai, hoá đơn, cổng thanh toán | `Payments` | 2 |
| 20 | [`proton.sieve`](../filter/proton.sieve) | Thư từ chính dịch vụ Proton | `Proton` | 2 |
| 21 | [`security.sieve`](../filter/security.sieve) | Cảnh báo tài khoản, đăng nhập, 2FA | `Security` | 10 |
| 22 | [`phishing.sieve`](../filter/phishing.sieve) | Tên miền giả mạo các dịch vụ ở trên | `Phishing` | 1 |

`phishing.sieve` đặt cuối là có chủ đích: thư từ một tên miền giả dạng PayPal phải bị gắn
cờ lừa đảo, bất kể bộ lọc nào khác đã nhận nó.

> [!NOTE]
> Trước đây 109 tên miền bị nhiều bộ lọc cùng nhận — riêng `apple.com` bị bảy bộ lọc — nên
> thư vào thư mục nào phụ thuộc vào thứ tự bạn tình cờ cài. Giờ mỗi tên miền có đúng một
> danh mục sở hữu, ghi trong [`data/`](../data/) và được CI kiểm tra.

---

## 📦 Bundle — một bộ lọc thay vì 22

Gói miễn phí của Proton chỉ cho phép **một bộ lọc hoạt động**, khiến 22 bộ lọc riêng lẻ
không dùng được. Bundle gộp nhiều danh mục vào một script duy nhất.

| Bundle | Gồm | Kích thước |
|--------|-----|------------|
| [`bundles/essentials.sieve`](../bundles/essentials.sieve) | phishing, security, invoice, government, shipping | ~26 KB |
| [`bundles/everything.sieve`](../bundles/everything.sieve) | cả 22 danh mục | ~190 KB |

**Nên dùng `essentials`.** Nó phủ phần chống lừa đảo cùng những danh mục mà mất thư là mất
thật. `everything` có đủ mọi thứ, nhưng Proton không công bố giới hạn kích thước bộ lọc và
190 KB là rất lớn để dán vào trình soạn web — hãy thử lưu trước khi tin dùng.

Bên trong bundle thứ tự bị đảo: vì là một script nên `stop;` khiến **cái đầu tiên** khớp
thắng. Generator sinh bundle theo thứ tự cài đặt ngược lại để kết quả định tuyến giống hệt
khi cài riêng lẻ. Sửa [`data/bundles.yml`](../data/bundles.yml) để tự tạo bundle riêng.

---

## 🌍 Từ khoá đa ngôn ngữ

Bộ lọc khớp tiêu đề bằng **tiếng Anh, Việt, Trung và Nhật**. 989 từ khoá không phải tiếng
Anh từng được ghi trong danh sách tham khảo cũ nhưng triển khai trong **0** bộ lọc — mọi
file `.sieve` đều thuần ASCII trong khi README quảng cáo hỗ trợ đa ngôn ngữ. Giờ chúng đã
được sinh ra thật.

Việc thêm chúng không làm xáo trộn gì: 23.027 message thử nghiệm định tuyến y hệt trước và
sau, trong khi số message đa ngữ được phân loại đi từ 2 lên 496.

Muốn bản chỉ tiếng Anh, đặt `languages: [en]` trong file danh mục rồi chạy lại generator.

---

## 📥 Cài đặt

### Bước 1 — tạo thư mục trước

**Script sẽ âm thầm thất bại nếu thư mục đích chưa tồn tại.** Tạo chúng tại
**Cài đặt → Thư mục và nhãn → Thêm thư mục**.

Bắt đầu với 22 thư mục gốc:

```
AI          Entertainment   Government   Phishing     Shipping         Study
Bills       Food            Health       Proton       Shopping         Travel
Dev         Gaming          Legal        Recruiting   Social Account   Work
                            News         Security     Spam
                            Payments
```

Chú ý đúng tên: **`Payments`** (không phải "Invoices"), **`News`** (không phải
"Newsletters"), **`Social Account`** (có dấu cách), **`Spam`**, **`Legal`** (không phải
"EULA") và **`Dev`**.

Sau đó tạo thư mục con cho những bộ lọc bạn cài. Mỗi script tự liệt kê thư mục của nó
ngay trong phần chú thích đầu file — mở file và đọc khối `# Folders:`. Tổng cộng 22 bộ lọc
nhắm tới **94 thư mục khác nhau**. Ví dụ `work.sieve` cần:

```
Work/Career    Work/HR         Work/Meetings   Work/Reminders   Work/Sales
Work/Finance   Work/IT         Work/Projects   Work/Reports
```

### Bước 2 — cài các bộ lọc

1. **Cài đặt → Bộ lọc → Thêm bộ lọc Sieve**
2. Mở một file `.sieve` trong [`filter/`](../filter/) và sao chép toàn bộ script
3. Dán vào, đặt tên dễ nhận biết (ví dụ `01 — Security`)
4. Lưu lại, rồi **cài tiếp bộ lọc kế theo đúng thứ tự ở trên**

Hãy đánh số ở đầu tên bộ lọc. Proton liệt kê bộ lọc theo thứ tự bạn tạo, và chính thứ tự
đó quyết định khi có xung đột.

### Bước 3 — tuỳ chỉnh (không bắt buộc)

Domain, từ khoá và thời hạn lưu trữ nằm trong [`data/categories/`](../data/categories/),
không phải trong file `.sieve`. Xem
[Tuỳ chỉnh nâng cao](#-tuỳ-chỉnh-nâng-cao) bên dưới.

---

## ⏰ Thời gian lưu trữ & tự động xoá

Hầu hết bộ lọc đều đặt thời hạn cho thư mà nó xử lý, thông qua extension
`vnd.proton.expire` của Proton. **Proton sẽ xoá thư khi hết hạn.**

Các giá trị mặc định:

| Danh mục | Thời hạn |
|----------|----------|
| Biên lai, hoá đơn, xác nhận đơn hàng | 365 ngày |
| Cập nhật vận chuyển, giao hàng | 60 ngày |
| Thông báo bảo mật và tài khoản | 14–30 ngày |
| Thư dịch vụ Proton | 10–90 ngày |
| Bản tin, khuyến mãi, thông báo mạng xã hội | 1–14 ngày |
| Thư khớp heuristic spam | 7 ngày |

Để giữ một danh mục vĩnh viễn, hãy xoá `expire_days` trong
[`data/categories/`](../data/categories/) rồi chạy lại generator. Để tìm mọi thời
hạn trong một script:

```bash
grep -n 'expire "day"' filter/shopping.sieve
```

Thư từ những người có trong sổ địa chỉ Proton của bạn được mọi bộ lọc bỏ qua trước khi bất
kỳ điều gì ở trên được áp dụng.

---

## 🗂️ Cấu trúc dự án

```
proton-sieve-filters/
├── filter/            # 14 script Sieve
├── domain/            # Danh sách domain tham khảo theo danh mục (xem ghi chú)
├── keyword/           # Danh sách từ khoá tham khảo theo danh mục (xem ghi chú)
├── tools/             # Kiểm tra và lint
│   ├── validate_sieve.py    # parse mọi bộ lọc bằng parser Sieve thật
│   ├── lint_proton.py       # kiểm tra theo dialect Proton và các lớp lỗi đã biết
│   ├── proton_dialect.py    # extension, test và giới hạn Proton hỗ trợ
│   └── sieve_eval.py        # bộ thông dịch cho tập con Sieve được dùng ở đây
├── tests/
│   └── test_regressions.py  # mỗi lỗi đã sửa ở v0.2.1 có một test hành vi
├── README/            # Bản dịch
├── CHANGELOG.md
├── DISCLAIMER.md
└── LICENSE
```

> [!NOTE]
> `domain/` và `keyword/` là **tài liệu tham khảo đã lệch khỏi các script** — chúng không
> phải nguồn để sinh ra bộ lọc. Hơn 700 từ khoá tiếng Việt, tiếng Trung và tiếng Nhật được
> ghi trong đó nhưng được triển khai trong **0** bộ lọc. Việc biến các danh sách này thành
> nguồn dữ liệu duy nhất là thay đổi được lên kế hoạch kế tiếp.

---

## 🛠️ Tuỳ chỉnh nâng cao

### Thêm một domain

Hãy thêm nó vào danh sách `address :domain :matches "from" [...]` ở **cổng lọc ngoài cùng**
của script, chứ không chỉ vào một khối con. Một domain chỉ xuất hiện trong khối lồng nhau
sẽ không bao giờ khớp được, vì cổng ngoài cùng đã loại thư đó ra trước:

```sieve
address :domain :matches "from" ["*yourshop.com", "*anothershop.com"],
```

### Điều chỉnh thời hạn lưu trữ

```sieve
expire "day" "30";   # 30 ngày
expire "day" "365";  # 1 năm
```

Xoá hẳn dòng này để giữ thư vô thời hạn.

### Danh sách trắng cho liên hệ

Mọi bộ lọc đều đã bắt đầu bằng đoạn này, nên thư từ sổ địa chỉ của bạn không bao giờ bị
động đến:

```sieve
if header :list "from" ":addrbook:personal" {
    stop;
}
```

### Lưu ý về `anyof`

`anyof` là phép OR. Một test `size` đặt bên trong nó sẽ tự mình thoả mãn cả cổng lọc, khiến
mọi thư nhỏ hơn (hoặc lớn hơn) ngưỡng đó đều khớp và biến các khối bên dưới thành code
chết. Lỗi này xuất hiện 36 lần ở v0.2.0. Hãy dùng `allof` khi bạn muốn AND:

```sieve
if allof (
    header :contains "subject" ["Invoice"],
    size :under 500K
) { ... }
```

`tools/lint_proton.py` sẽ báo lỗi khi gặp mẫu này.

---

## 🧪 Kiểm tra thay đổi của bạn

```bash
python -m pip install -r tools/requirements.txt
python tools/validate_sieve.py    # mọi bộ lọc có parse được không?
python tools/lint_proton.py       # dialect Proton + các lớp lỗi đã biết
python tests/test_regressions.py  # test hành vi
```

Cả ba đều chạy trong CI ở mỗi lần push và pull request. `validate_sieve.py` dùng parser
Sieve thật, đã được dạy thêm match-type `:list` của `extlists` và lệnh `vnd.proton.expire`.

Chạy được ở máy chưa phải là kết luận cuối cùng — **trình soạn thảo của Proton mới là nơi
quyết định về dialect của chính nó.** Hãy dán script vào và xác nhận nó lưu được.

---

## 🚨 Xử lý sự cố

**Proton từ chối lưu bộ lọc.** Kiểm tra dòng `require`. Proton chỉ chấp nhận `fileinto`,
`imap4flags`, `reject`, `vacation`, `date`, `envelope`, `variables`, `relational`, `regex`,
`comparator-i;ascii-numeric`, `extlists`, `include`, `vnd.proton.eval` và
`vnd.proton.expire`. Bất cứ thứ gì khác — kể cả lệnh lõi như `discard`, vốn không cần
`require` — đều khiến Proton từ chối toàn bộ script.

**Bộ lọc lưu được nhưng không có gì xảy ra.** Nhiều khả năng thư mục đích chưa tồn tại,
hoặc tên không khớp chính xác với script (`Social Account`, không phải `Social`).

**Thư vào sai thư mục.** Hai bộ lọc đang tranh nhau. Hãy kiểm tra thứ tự cài đặt — bộ lọc
khớp sau cùng sẽ thắng.

**Thư quan trọng bị lọc mất.** Thêm người gửi vào sổ địa chỉ Proton; mọi bộ lọc đều bỏ qua
người gửi có trong sổ địa chỉ trước khi làm bất cứ điều gì.

**Thư biến mất.** Xem bảng thời hạn lưu trữ ở trên. Các bộ lọc có đặt hẹn giờ xoá.

---

## 🤝 Đóng góp

Phần lớn đóng góp chỉ là một dòng trong file YAML. Xem
[CONTRIBUTING.md](../CONTRIBUTING.md) để biết dòng đó đặt ở đâu và build sẽ kiểm tra gì.
Dự án tuân theo [Contributor Covenant](../CODE_OF_CONDUCT.md).

---

## ⚠️ Giới hạn

- **Chỉ dành cho Proton.** Dùng `vnd.proton.expire` và `extlists`; các script này không
  chạy được nguyên trạng trên máy chủ Sieve khác.
- **Cần gói trả phí.** Gói miễn phí chỉ cho phép một bộ lọc hoạt động.
- **Chỉ áp dụng cho thư mới.** Bộ lọc không sắp xếp lại thư đã có sẵn trong hộp thư.
- **Chỉ đọc được header.** Không thể khớp theo nội dung — xem [Đây là gì](#-đây-là-gì).
- **Không bảo hành, và các bộ lọc này xoá thư.** Đọc [DISCLAIMER.md](../DISCLAIMER.md)
  và [Retention & auto-delete](../docs/Retention-and-Auto-Delete.md) trước khi cài.

---

## 📄 Giấy phép

Ba giấy phép, vì đây là ba loại nội dung khác nhau.

| Đường dẫn | Giấy phép |
| --- | --- |
| `filter/`, `bundles/`, `tools/`, `tests/`, `data/schema/`, `data/bundles.yml` | **MIT** |
| `data/categories/`, `data/shared/` | **CC0-1.0** — thuộc phạm vi công cộng, không cần ghi công |
| Tài liệu (`README*`, `docs/`, `CHANGELOG.md`, `DISCLAIMER.md`, …) | **CC-BY-4.0** |

Các file `.sieve` được sinh ra là MIT, do công cụ MIT tạo từ dữ liệu CC0. CC0 không đặt
ràng buộc nào nên không có gì được kế thừa — nếu bạn chỉ lấy danh sách domain thì bạn
không nợ gì cả.

Chi tiết trong [LICENSES/README.md](../LICENSES/README.md); thông tin trích dẫn trong
[CITATION.cff](../CITATION.cff).

## 👨‍💻 Liên hệ

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Email**: coding201913@hotmail.com

Trước khi mở issue, hãy xem [các issue hiện có](https://github.com/poli0981/proton-sieve-filters/issues)
và [tài liệu Sieve của Proton](https://proton.me/support/sieve-advanced-custom-filters).

## 📚 Tài liệu

Tài liệu đầy đủ nằm trong [`docs/`](../docs/) (tiếng Anh), được đồng bộ sang
[Wiki](https://github.com/poli0981/proton-sieve-filters/wiki).

| Trang | |
| --- | --- |
| [Installation](../docs/Installation.md) | Thư mục, thứ tự cài, bundle |
| [Filter reference](../docs/Filter-Reference.md) | Từng bộ lọc làm gì — sinh tự động từ dữ liệu |
| [Retention & auto-delete](../docs/Retention-and-Auto-Delete.md) | **Thư nào bị xoá, sau bao lâu** |
| [Customization](../docs/Customization.md) | Đổi domain, từ khoá, thư mục, thời hạn |
| [Troubleshooting](../docs/Troubleshooting.md) | Khi có gì đó không chạy |
| [Proton's Sieve dialect](../docs/Proton-Sieve-Dialect.md) | Ngôn ngữ hỗ trợ gì và bẫy ở đâu |
| [AI disclosure](../docs/AI-Disclosure.md) | Ai viết phần nào, và điều đó nghĩa là gì |
| [FAQ](../docs/FAQ.md) | |

Chính sách dự án: [Disclaimer](../DISCLAIMER.md) · [Privacy](../PRIVACY.md) ·
[Security](../SECURITY.md) · [Contributing](../CONTRIBUTING.md) ·
[Code of conduct](../CODE_OF_CONDUCT.md) · [Giấy phép](../LICENSES/README.md)

## 🔗 Tài nguyên ngoài

- [Proton — Sieve advanced custom filters](https://proton.me/support/sieve-advanced-custom-filters)
- [Proton — How to use email filters](https://proton.me/support/email-inbox-filters)
- [RFC 5228 — Sieve](https://datatracker.ietf.org/doc/html/rfc5228)
- [RFC 5232 — Imap4flags](https://datatracker.ietf.org/doc/html/rfc5232)
- [RFC 6134 — Extlists](https://datatracker.ietf.org/doc/html/rfc6134)

---

**Kho mã**: https://github.com/poli0981/proton-sieve-filters
**Phiên bản**: 0.3.0 · **Cập nhật lần cuối**: 28-08-2026

*Dự án này không liên kết với, không được chứng thực hay tài trợ bởi Proton AG. Proton và
Proton Mail là thương hiệu của Proton AG.*
