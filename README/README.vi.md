# Proton Sieve Filters

## Mô tả
Kho lưu trữ này cung cấp các script Sieve sẵn dùng cho người dùng Proton Mail. Sieve là ngôn ngữ miền cụ thể (DSL) để lọc email phía server, cho phép di chuyển email, đánh dấu đã đọc, hoặc hết hạn. Bộ lọc mạng xã hội là bộ lọc đầu tiên, với phần mở rộng cho các loại khác như hóa đơn, quảng cáo.

**Lưu ý về Domains**: Danh sách các domain cho các bộ lọc khác nhau (ví dụ: mạng xã hội, hóa đơn) được lưu trong file 'domains.txt'. Bạn có thể chỉnh sửa file này để thêm hoặc xóa domain mà không cần thay đổi script.

## Hạn chế
- Các script này được tối ưu cho Proton Mail và có thể cần chỉnh sửa cho dịch vụ email khác (ví dụ: xóa extension đặc thù của Proton như "vnd.proton.expire").
- Khuyến nghị có kiến thức lập trình cơ bản về Sieve (hoặc scripting tương tự) để tùy chỉnh, vì lỗi có thể dẫn đến bỏ sót hoặc từ chối email.
- Bộ lọc chỉ áp dụng cho email đến; không sắp xếp lại email cũ.
- Rủi ro tiềm ẩn: Quy tắc quá rộng có thể gây false positives (ví dụ: từ chối email quan trọng); luôn test kỹ.
- Không bảo hành: Sử dụng dưới rủi ro cá nhân, theo chuẩn open source.

## Hướng dẫn sử dụng
1. Đăng nhập vào Proton Mail → Cài đặt → Bộ lọc → Thêm Bộ lọc Sieve.
2. Sao chép script từ tệp .sieve (ví dụ: filters/social_media.sieve) và dán vào.
3. Tùy chỉnh tên miền trong 'domains.txt' nếu cần.
4. Kiểm tra với các email mẫu.

**Các Bộ lọc Có sẵn**:
- Mạng Xã hội: Lọc thông báo từ X, Facebook, v.v. (bộ lọc đầu tiên trong kho lưu trữ).
- Hóa đơn: Di chuyển email hóa đơn từ PayPal, Amazon, v.v.
- Quảng cáo: Xử lý email khuyến mãi.
- Sẽ có thêm...


## Đóng góp
Fork kho lưu trữ, thêm bộ lọc hoặc tên miền mới, và gửi pull request. Tuân theo Semantic Versioning cho các cập nhật (ví dụ: v0.1.0).


## Giấy phép
Giấy phép MIT - Tự do sử dụng và chỉnh sửa.