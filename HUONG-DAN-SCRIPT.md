# 🚀 HƯỚNG DẪN SỬ DỤNG SCRIPT API TESTING

## 📋 Tổng Quan

Tôi đã tạo cho bạn **3 script** để chạy API testing một cách dễ dàng và hiệu quả:

1. **`chay-api-test.sh`** - Script tương tác với menu đầy đủ (macOS/Linux)
2. **`test-nhanh.sh`** - Script chạy nhanh tất cả tests (macOS/Linux)  
3. **`chay-api-test.ps1`** - Script PowerShell cho Windows

---

## 🖥️ SCRIPT CHO macOS/Linux

### 1. Script Tương Tác Đầy Đủ - `chay-api-test.sh`

**Tính năng:**
- ✅ Menu tương tác thân thiện
- ✅ Kiểm tra tự động Newman và dependencies
- ✅ Kiểm tra kết nối API server
- ✅ Chạy từng test suite riêng lẻ hoặc tất cả
- ✅ Tạo báo cáo HTML chi tiết
- ✅ Mở báo cáo trong trình duyệt

**Cách sử dụng:**
```bash
# Cấp quyền thực thi
chmod +x chay-api-test.sh

# Chạy script
./chay-api-test.sh
```

**Menu lựa chọn:**
```
╔══════════════════════════════════════════════════════════════╗
║                    ⚙️ MENU LỰA CHỌN ⚙️                         ║
╠══════════════════════════════════════════════════════════════╣
║  1. Chạy tất cả test suites                                 ║
║  2. Chạy test Brands API                                    ║
║  3. Chạy test Users API                                     ║
║  4. Chạy test Favorites API                                 ║
║  5. Kiểm tra kết nối API server                             ║
║  6. Xem báo cáo trong trình duyệt                           ║
║  0. Thoát                                                   ║
╚══════════════════════════════════════════════════════════════╝
```

### 2. Script Chạy Nhanh - `test-nhanh.sh`

**Tính năng:**
- ⚡ Chạy nhanh tất cả test suites
- ⚡ Tự động tạo báo cáo HTML
- ⚡ Không cần tương tác

**Cách sử dụng:**
```bash
# Cấp quyền thực thi
chmod +x test-nhanh.sh

# Chạy script
./test-nhanh.sh
```

---

## 🪟 SCRIPT CHO WINDOWS

### Script PowerShell - `chay-api-test.ps1`

**Tính năng:**
- ✅ Giao diện đẹp với màu sắc
- ✅ Menu tương tác đầy đủ
- ✅ Tự động mở thư mục báo cáo
- ✅ Hỗ trợ đầy đủ cho Windows

**Cách sử dụng:**
```powershell
# Mở PowerShell với quyền Administrator
# Chạy script
.\chay-api-test.ps1
```

**Nếu gặp lỗi Execution Policy:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\chay-api-test.ps1
```

---

## 📊 KẾT QUẢ VÀ BÁO CÁO

### Thư Mục Báo Cáo
Tất cả báo cáo HTML sẽ được lưu trong thư mục:
```
reports/
├── brands-test-report.html     # Báo cáo test Brands API
├── users-test-report.html      # Báo cáo test Users API  
└── favorites-test-report.html  # Báo cáo test Favorites API
```

### Xem Báo Cáo
- **macOS/Linux**: Double-click file `.html` hoặc dùng tùy chọn 6 trong menu
- **Windows**: Double-click file `.html` hoặc dùng tùy chọn 6 trong menu PowerShell

---

## 🛠️ YÊU CẦU HỆ THỐNG

### Trước Khi Chạy
1. **Node.js** đã được cài đặt
2. **npm** có sẵn
3. Các file test collection và data trong thư mục `tests/`

### Tự Động Cài Đặt
Script sẽ tự động cài đặt:
- ✅ Newman CLI
- ✅ newman-reporter-htmlextra

---

## 🚨 XỬ LÝ SỰ CỐ

### Lỗi Thường Gặp

**1. Permission denied (macOS/Linux)**
```bash
chmod +x *.sh
```

**2. Newman not found**
```bash
npm install -g newman newman-reporter-htmlextra
```

**3. Execution Policy (Windows)**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**4. API server không khả dụng**
- Kiểm tra API server có đang chạy không
- Kiểm tra file `tests/environment.json`
- Sử dụng tùy chọn 5 để test kết nối

---

## 📈 DEMO CHẠY SCRIPT

### Ví Dụ Output
```
🚀 API TESTING AUTOMATION 🚀
Script Tiếng Việt

⚙️ Kiểm tra Newman...
✅ Newman đã sẵn sàng!

🚀 CHẠY TEST: Brands API
════════════════════════════════════════
📊 Đang chạy 10 test cases...
✅ Test Brands API hoàn thành thành công!
📊 Báo cáo HTML: reports/brands-test-report.html

📊 TÓM TẮT KẾT QUẢ TEST
════════════════════════════════════════
Tổng số test suites: 3
Test suites thành công: 3  
Test suites có lỗi: 0
✅ Tất cả test suites đã chạy thành công!
```

---

## 🎯 KHUYẾN NGHỊ SỬ DỤNG

### Cho Người Mới Bắt Đầu
👉 Sử dụng **`chay-api-test.sh`** (macOS/Linux) hoặc **`chay-api-test.ps1`** (Windows)
- Có menu tương tác dễ sử dụng
- Kiểm tra hệ thống tự động
- Hướng dẫn chi tiết

### Cho Automation/CI/CD  
👉 Sử dụng **`test-nhanh.sh`**
- Chạy nhanh không cần tương tác
- Phù hợp với script tự động
- Tích hợp dễ dàng vào pipeline

### Cho Windows Users
👉 Sử dụng **`chay-api-test.ps1`**
- Giao diện đẹp với PowerShell
- Tự động mở thư mục báo cáo
- Hỗ trợ đầy đủ tính năng

---

## 🆘 HỖ TRỢ

Nếu gặp vấn đề, hãy:
1. Kiểm tra phần **🚨 XỬ LÝ SỰ CỐ** ở trên
2. Chạy với tùy chọn 5 để kiểm tra kết nối API
3. Kiểm tra file log trong terminal/PowerShell

**Happy Testing! 🚀** 