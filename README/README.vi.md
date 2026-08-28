# Proton Sieve Filters

[![CI](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml/badge.svg)](https://github.com/poli0981/proton-sieve-filters/actions/workflows/ci.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)
[![Version](https://img.shields.io/badge/Version-0.2.1-blue.svg)](../CHANGELOG.md)
[![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/issues)

14 script Sieve giúp sắp xếp hộp thư Proton Mail vào các thư mục — mua sắm, du lịch, công
việc, bảo mật và mười danh mục khác. Sieve là ngôn ngữ lọc thư phía máy chủ mà Proton mở
cho các tài khoản trả phí.

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

**🤖 Phát triển với hỗ trợ của AI.** Dự án này được phát triển với sự hỗ trợ của AI cho
việc nghiên cứu, viết script và dịch thuật, sau đó được
[@poli0981](https://github.com/poli0981) rà soát lại.

- **👨‍💻 Con người (@poli0981): 35%** — ý tưởng, kiến trúc, prompt engineering, sửa lỗi,
  nội dung tiếng Việt, kiểm thử
- **🤖 AI (GitHub Copilot/Claude Sonnet 4 & Grok 4): 65%** — triển khai, dịch thuật,
  nghiên cứu, tài liệu, tổng hợp danh sách domain/từ khoá

Danh sách domain và từ khoá được tổng hợp theo cách này và **chưa được kiểm chứng từng
mục**. Chúng có chứa dịch vụ đã ngừng hoạt động và ít nhất hai tên miền bị gán nhầm công
ty. Xem [DISCLAIMER.md](../DISCLAIMER.md).

---

## 📂 Các bộ lọc hiện có (v0.2.1)

Hãy cài theo đúng thứ tự này. Proton chạy các bộ lọc **tuần tự**, và khi hai bộ lọc cùng
muốn tác động lên một thư thì **hành động cuối cùng thắng** — nên thứ tự không phải chuyện
hình thức. Thứ tự dưới đây đặt bộ lọc cụ thể trước, bộ lọc rộng sau.

| # | Bộ lọc | Mục đích | Thư mục gốc | Số thư mục |
|---|--------|----------|-------------|------------|
| 1 | [`security.sieve`](../filter/security.sieve) | Cảnh báo tài khoản, 2FA, rò rỉ dữ liệu | `Security` | 10 |
| 2 | [`proton.sieve`](../filter/proton.sieve) | Thông báo dịch vụ Proton | `Proton` | 1 |
| 3 | [`invoice.sieve`](../filter/invoice.sieve) | Hoá đơn, thanh toán, biên lai | `Payments` | 1 |
| 4 | [`legal.sieve`](../filter/legal.sieve) | Điều khoản, chính sách, thông báo pháp lý | `Legal` | 2 |
| 5 | [`health.sieve`](../filter/health.sieve) | Y tế, thể hình, sức khoẻ | `Health` | 1 |
| 6 | [`travel.sieve`](../filter/travel.sieve) | Đặt chỗ, chuyến bay, khách sạn | `Travel` | 9 |
| 7 | [`study.sieve`](../filter/study.sieve) | Giáo dục, khoá học, học tập | `Study` | 19 |
| 8 | [`gaming.sieve`](../filter/gaming.sieve) | Game, nền tảng, tin tức game | `Gaming` | 1 |
| 9 | [`entertainment.sieve`](../filter/entertainment.sieve) | Streaming, giải trí, sự kiện | `Entertainment` | 9 |
| 10 | [`news.sieve`](../filter/news.sieve) | Tin tức và bản tin | `News` | 9 |
| 11 | [`social.sieve`](../filter/social.sieve) | Thông báo mạng xã hội | `Social Account` | 1 |
| 12 | [`work.sieve`](../filter/work.sieve) | Công việc, doanh nghiệp | `Work` | 10 |
| 13 | [`shopping.sieve`](../filter/shopping.sieve) | Thương mại điện tử, khuyến mãi | `Shopping` | 12 |
| 14 | [`spam.sieve`](../filter/spam.sieve) | Heuristic chống spam bổ sung | `Spam` | 1 |

`work.sieve`, `shopping.sieve` và `spam.sieve` được đặt cuối một cách có chủ đích: điều
kiện lọc của chúng rộng nhất, nên nếu chạy sớm chúng sẽ giành mất những thư mà các bộ lọc
cụ thể hơn xử lý tốt hơn.

> [!NOTE]
> **Hiện có 109 tên miền bị nhiều bộ lọc cùng nhận** — riêng `*apple.com` bị bảy bộ lọc
> nhận. Thứ tự ở trên quyết định bộ lọc nào thắng. Việc hợp nhất chúng được lên kế hoạch
> cho bản phát hành sau; xem [CHANGELOG.md](../CHANGELOG.md).

---

## 📥 Cài đặt

### Bước 1 — tạo thư mục trước

**Script sẽ âm thầm thất bại nếu thư mục đích chưa tồn tại.** Tạo chúng tại
**Cài đặt → Thư mục và nhãn → Thêm thư mục**.

Bắt đầu với 14 thư mục gốc:

```
Entertainment    News             Shopping
Gaming           Payments         Social Account
Health           Proton           Spam
Legal            Security         Study
                                  Travel
                                  Work
```

Chú ý đúng tên: **`Payments`** (không phải "Invoices"), **`News`** (không phải
"Newsletters"), **`Social Account`** (có dấu cách), **`Spam`**, và **`Legal`** (không phải
"EULA").

Sau đó tạo thư mục con cho những bộ lọc bạn cài. Mỗi script tự liệt kê thư mục của nó
ngay trong phần chú thích đầu file — mở file và đọc khối `# Folders:`. Tổng cộng 14 bộ lọc
nhắm tới **86 thư mục khác nhau**. Ví dụ `work.sieve` cần:

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

Domain, từ khoá và thời hạn lưu trữ đều là văn bản thuần nằm gần đầu mỗi script. Xem
[Tuỳ chỉnh nâng cao](#-tuỳ-chỉnh-nâng-cao) bên dưới.

---

## ⏰ Thời gian lưu trữ & tự động xoá

Mọi bộ lọc trừ `study.sieve` đều đặt thời hạn cho thư mà nó xử lý, thông qua extension
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

Để giữ một danh mục vĩnh viễn, hãy xoá dòng `expire "day" "N";` của nó. Để tìm mọi thời
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

1. Fork và tạo nhánh: `git checkout -b feature/amazing-feature`
2. Thực hiện thay đổi, rồi chạy ba lệnh ở mục
   [Kiểm tra thay đổi của bạn](#-kiểm-tra-thay-đổi-của-bạn)
3. Thêm một test vào `tests/test_regressions.py` nếu bạn sửa lỗi
4. Mở pull request mô tả rõ đã thay đổi gì và vì sao

Hãy theo phong cách code hiện có, và tôn trọng
[Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html).

---

## ⚠️ Giới hạn

- **Chỉ dành cho Proton.** Dùng `vnd.proton.expire` và `extlists`; các script này không
  chạy được nguyên trạng trên máy chủ Sieve khác.
- **Cần gói trả phí.** Gói miễn phí chỉ cho phép một bộ lọc hoạt động.
- **Chỉ áp dụng cho thư mới.** Bộ lọc không sắp xếp lại thư đã có sẵn trong hộp thư.
- **Chỉ đọc được header.** Không thể khớp theo nội dung — xem [Đây là gì](#-đây-là-gì).
- **Không bảo hành.** Đọc [DISCLAIMER.md](../DISCLAIMER.md) trước khi cài.

---

## 📄 Giấy phép

MIT — xem [LICENSE](../LICENSE).

## 👨‍💻 Liên hệ

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Email**: coding201913@hotmail.com

Trước khi mở issue, hãy xem [các issue hiện có](https://github.com/poli0981/proton-sieve-filters/issues)
và [tài liệu Sieve của Proton](https://proton.me/support/sieve-advanced-custom-filters).

## 🔗 Tài nguyên

- [Proton — Sieve advanced custom filters](https://proton.me/support/sieve-advanced-custom-filters)
- [Proton — How to use email filters](https://proton.me/support/email-inbox-filters)
- [RFC 5228 — Sieve](https://datatracker.ietf.org/doc/html/rfc5228)
- [RFC 5232 — Imap4flags](https://datatracker.ietf.org/doc/html/rfc5232)
- [RFC 6134 — Extlists](https://datatracker.ietf.org/doc/html/rfc6134)

---

**Kho mã**: https://github.com/poli0981/proton-sieve-filters
**Phiên bản**: 0.2.1 · **Cập nhật lần cuối**: 28-08-2026

*Dự án này không liên kết với, không được chứng thực hay tài trợ bởi Proton AG. Proton và
Proton Mail là thương hiệu của Proton AG.*
