# Proton Sieve Filters - Bộ Lọc Email Thông Minh

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GitHub contributors](https://img.shields.io/badge/Contributors-Welcome-brightgreen.svg)](https://github.com/poli0981/proton-sieve-filters/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/poli0981/proton-sieve-filters.svg)](https://github.com/poli0981/proton-sieve-filters/issues)
[![Version](https://img.shields.io/badge/Version-0.2.0-blue.svg)](https://github.com/poli0981/proton-sieve-filters/releases)

## 📧 Mô Tả

Dự án này cung cấp bộ sưu tập script Sieve toàn diện, được thiết kế đặc biệt cho người dùng Proton Mail. Sieve là ngôn ngữ chuyên dụng (DSL) để lọc email phía server, cho phép tự động phân loại email, đánh dấu đã đọc, đặt thời hạn hết hạn và tổ chức hộp thư một cách hiệu quả.

**🤖 Phát Triển Có Hỗ Trợ AI**: Dự án này được phát triển với sự hỗ trợ của AI trong việc nghiên cứu, viết script, sửa lỗi và dịch thuật. Sản phẩm cuối cùng được xem xét và hoàn thiện bởi [@poli0981](https://github.com/poli0981).

**Tỷ Lệ Đóng Góp Phát Triển:**
- **👨‍💻 Con Người (@poli0981): 35%** - Ý tưởng dự án, kiến trúc script, kỹ thuật prompt AI, sửa lỗi, nội dung tiếng Việt, đảm bảo chất lượng
- **🤖 AI (GitHub Copilot/Claude Sonnet 4 & Grok 4): 65%** - Triển khai script, dịch thuật, nghiên cứu, tài liệu, biên soạn domain/từ khóa

## ⚠️ Yêu Cầu Thiết Lập Quan Trọng

**🚨 QUAN TRỌNG**: Trước khi sử dụng các bộ lọc này, bạn PHẢI tạo các thư mục đích trong tài khoản Proton Mail trước. **Các script sẽ KHÔNG hoạt động nếu không có thư mục.**

### Các Thư Mục Cần Tạo:
```
📁 Shopping      (Mua sắm)
📁 Travel        (Du lịch)  
📁 Work          (Công việc)
📁 Security      (Bảo mật)
📁 Entertainment (Giải trí)
📁 Gaming        (Game)
📁 Social        (Mạng xã hội)
📁 Invoices      (Hóa đơn)
📁 Newsletters   (Bản tin)
📁 Health        (Sức khỏe)
📁 Study         (Học tập)
📁 Proton        (Dịch vụ Proton)
📁 Spam_Filter   (Lọc spam)
📁 EULA          (Điều khoản)
```

**Cách Tạo Thư Mục Trong Proton Mail:**
1. Vào **Cài đặt** → **Thư mục và nhãn**
2. Nhấp **Thêm thư mục**
3. Tạo từng thư mục được liệt kê ở trên
4. **Chỉ sau đó** mới cài đặt các bộ lọc Sieve

## 🚀 Tính Năng Chính

- **🎯 15+ Bộ Lọc Chuyên Biệt**: Phân loại email toàn diện cho mọi khía cạnh của cuộc sống số
- **📱 Cài Đặt Dễ Dàng**: Copy-paste script trực tiếp vào Proton Mail
- **⚙️ Hoàn Toàn Tùy Chỉnh**: Chỉnh sửa domain, từ khóa và thời gian lưu trữ
- **🌍 Hỗ Trợ Đa Ngôn Ngữ**: Từ khóa bằng tiếng Anh, Việt, Trung và Nhật
- **⏰ Lưu Trữ Thông Minh**: Tự động hết hạn email dựa trên tầm quan trọng
- **🔒 Tập Trung Bảo Mật**: Tăng cường phát hiện spam và ưu tiên cảnh báo bảo mật

## 📂 Các Bộ Lọc Có Sẵn (Phiên Bản 0.2.0)

| Bộ Lọc | Mục Đích | Từ Khóa | Domain | Lưu Trữ |
|---------|----------|---------|--------|---------|
| **🛒 Shopping** | Thương mại điện tử, ưu đãi, mua sắm | 200+ | 200+ | 1-365 ngày |
| **✈️ Travel** | Đặt chỗ, máy bay, khách sạn | 150+ | 200+ | 1-90 ngày |
| **💼 Work** | Chuyên nghiệp, kinh doanh | 200+ | 150+ | 1-365 ngày |
| **🔐 Security** | Cảnh báo tài khoản, 2FA, vi phạm | 200+ | - | 1-365 ngày |
| **🎮 Gaming** | Game, nền tảng, tin tức | 150+ | 100+ | 1-30 ngày |
| **📺 Entertainment** | Streaming, truyền thông, sự kiện | 120+ | 80+ | 1-14 ngày |
| **📱 Social Media** | Mạng xã hội, thông báo | 100+ | 60+ | 1-7 ngày |
| **💰 Invoices** | Hóa đơn, thanh toán, biên lai | 80+ | 70+ | 30-365 ngày |
| **📰 Newsletters** | Tin tức, cập nhật, đăng ký | 60+ | 50+ | 1-30 ngày |
| **🏥 Health** | Y tế, thể dục, sức khỏe | 100+ | 60+ | 7-90 ngày |
| **📚 Study** | Giáo dục, khóa học, học tập | 80+ | 40+ | 7-180 ngày |
| **⚗️ Proton** | Thông báo dịch vụ Proton | 40+ | - | 30-90 ngày |
| **🚫 Spam** | Phát hiện spam nâng cao | 150+ | - | Xóa ngay lập tức |
| **📜 EULA** | Điều khoản, chính sách, cập nhật pháp lý | 30+ | - | 90 ngày |

## 📥 Hướng Dẫn Cài Đặt

### Bước 1: Tạo Các Thư Mục Cần Thiết
1. Đăng nhập vào tài khoản **Proton Mail**
2. Đi tới **Cài đặt** → **Thư mục và nhãn**
3. Tạo tất cả thư mục được liệt kê trong phần "Thư mục cần tạo" ở trên

### Bước 2: Cài Đặt Bộ Lọc
1. Vào **Cài đặt** → **Bộ lọc** → **Thêm bộ lọc Sieve**
2. Chọn một bộ lọc từ thư mục `filter/` (ví dụ: `shopping.sieve`)
3. Copy toàn bộ nội dung script
4. Paste vào trình chỉnh sửa bộ lọc Sieve của Proton Mail
5. Đặt tên mô tả (ví dụ: "Bộ lọc mua sắm v0.2.0")
6. **Kiểm tra trước** với một vài email trước khi kích hoạt hoàn toàn
7. Lưu và kích hoạt bộ lọc

### Bước 3: Tùy Chỉnh (Tùy Chọn)
- Chỉnh sửa danh sách domain trong các file script
- Sửa đổi từ khóa cho ngôn ngữ/khu vực của bạn
- Điều chỉnh thời gian lưu trữ theo nhu cầu
- Thêm địa chỉ email cá nhân vào danh sách trắng

## 🧪 Kiểm Tra Bộ Lọc

### Trước Khi Triển Khai Production:
1. **Bắt Đầu Nhỏ**: Kích hoạt từng bộ lọc một
2. **Theo Dõi Hoạt Động**: Kiểm tra nhật ký bộ lọc trong 24-48 giờ
3. **Xác Minh Thư Mục**: Đảm bảo email được sắp xếp đúng
4. **Kiểm Tra False Positive**: Xem xét email đã lọc hàng ngày ban đầu
5. **Điều Chỉnh Quy Tắc**: Tinh chỉnh domain và từ khóa khi cần

## 🚨 Khắc Phục Sự Cố

### Vấn Đề Thường Gặp:

**Bộ Lọc Không Hoạt Động**
- ✅ Xác minh tất cả thư mục đích đã tồn tại
- ✅ Kiểm tra cú pháp Sieve có lỗi không
- ✅ Đảm bảo bộ lọc đã được kích hoạt
- ✅ Kiểm tra với email mẫu

**Email Quan Trọng Bị Lọc**
- ✅ Thêm người gửi vào sổ địa chỉ cá nhân (danh sách trắng)
- ✅ Xem xét và tinh chỉnh danh sách domain/từ khóa
- ✅ Kiểm tra thứ tự ưu tiên bộ lọc

## 📄 Giấy Phép

Dự án này được cấp phép theo **Giấy phép MIT** - xem file [LICENSE](LICENSE) để biết chi tiết.

## 👨‍💻 Liên Hệ & Hỗ Trợ

- **GitHub**: [@poli0981](https://github.com/poli0981)
- **X (Twitter)**: [@SkullMute0011](https://x.com/SkullMute0011)
- **Facebook**: [skull.loro](https://www.facebook.com/skull.loro)
- **Email**: coding201913@hotmail.com

## 🙏 Ghi Nhận

- **🤖 Hỗ Trợ AI**: GitHub Copilot (Claude Sonnet 4) & Grok 4 cho hỗ trợ phát triển
- **📧 Cảm Hứng**: Nhu cầu lọc email nâng cao của cộng đồng Proton Mail
- **🌐 Cộng Đồng**: Các contributor, tester và người dùng cải thiện các bộ lọc này

---

**🔗 Repository**: https://github.com/poli0981/proton-sieve-filters  
**📊 Phiên bản**: 0.2.0  
**📅 Cập nhật lần cuối**: 17 tháng 8, 2025

---

*Chúc bạn lọc email vui vẻ! 📧✨*