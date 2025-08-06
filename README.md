# SWT API TESTING PROJECT WITH CI/CD

[![API Testing CI/CD Pipeline](https://github.com/TBKiet/SWT_API/actions/workflows/api-testing.yml/badge.svg)](https://github.com/TBKiet/SWT_API/actions/workflows/api-testing.yml)
[![Quick API Tests](https://github.com/TBKiet/SWT_API/actions/workflows/manual-test.yml/badge.svg)](https://github.com/TBKiet/SWT_API/actions/workflows/manual-test.yml)

## 🎯 Mục tiêu
- Làm quen với kiểm thử API bằng Postman.
- Thực hiện kiểm thử data-driven với file CSV.
- Tích hợp kiểm thử tự động với Newman và GitHub Actions.
- Thiết lập CI/CD pipeline cho automated testing.

---

## 🚀 CI/CD Pipeline Features

### 🔄 Automated Testing
- **Continuous Integration**: Tests run on every push/PR to main branch
- **Scheduled Testing**: Daily automated test runs at 6 AM UTC  
- **Manual Triggers**: On-demand test execution with custom parameters
- **Multi-environment Support**: Tests can run against different API environments

### 📊 Reporting & Documentation
- **HTML Test Reports**: Generated for each test suite
- **Artifacts Upload**: Test reports stored for 30 days
- **PR Comments**: Automatic test result comments on pull requests
- **GitHub Pages**: Documentation automatically deployed

### 🛡️ Quality Assurance
- **JSON Validation**: Postman collection integrity checks
- **Security Scanning**: Sensitive data detection in test files
- **Code Quality**: Automated quality checks on test artifacts

---

## 1. Cấu trúc thư mục

```
api-automation-practice/
├── .github/
│   └── workflows/
│       └── api-test.yml         # File workflow GitHub Actions
├── sprint5-with-bugs/
│   └── API/
│       └── .env.ci              # Mẫu file môi trường cho CI
├── tests/
│   └── api/
│       ├── collection.json      # Collection Postman (bạn sẽ cập nhật)
│       ├── environment.json     # Environment Postman
│       └── user-accounts.csv    # File dữ liệu kiểm thử data-driven
├── run-api-tests.sh             # Script chạy newman local
├── run-api-tests.ps1            # Script chạy newman local (powershell)
└── README.md                    # File hướng dẫn này
```

---


## 2. Đề bài & Yêu cầu

### Yêu cầu 1: Data-driven testing với Postman

**Lưu ý quan trọng:** Trước khi bắt đầu, bạn cần khởi động ứng dụng và tạo dữ liệu:

```bash
# Khởi động các container Docker
docker-compose up -d

# Chờ khoảng 60 giây để các service khởi động hoàn tất

# Tạo database và dữ liệu mẫu
docker compose exec laravel-api php artisan migrate:fresh --seed --force

# Kiểm tra ứng dụng: http://localhost:8091 (API), http://localhost:8092 (UI)
```

1. Import collection và environment có sẵn từ `tests/api` vào Postman.
2. Tạo file `user-accounts.csv` trong `tests/api` chứa các trường: `email`, `password`, `expected_status`.

   **Ví dụ mẫu tài khoản:**

   | email                                | password   | expected_status |
   |--------------------------------------|------------|-----------------|
   | admin@practicesoftwaretesting.com    | welcome01  | 200             |
   | customer@practicesoftwaretesting.com | welcome01  | 200             |
   | invalid@practicesoftwaretesting.com  | wrongpass  | 401             |

3. Chỉnh sửa collection để sử dụng biến từ file CSV trong các request (ví dụ: `{{email}}`, `{{password}}`).
4. Chạy thử collection với file CSV trên Postman bằng chức năng "Run Collection" và chọn data file.
5. Export lại collection đã chỉnh sửa, thay thế file cũ trong `tests/api`.

---

### Bước 2: Chạy Newman local

**Lưu ý**: trước khi chạy nhớ đóng docker (docker compose down)

1. Mở file `run-api-tests.sh` (hoặc `run-api-tests.ps1` - nếu bạn sử dụng PowerShell của hệ điều hành windowns) và tìm dòng có chú thích:
    ```
    # TODO (Bạn thêm code ở dưới đây)
    ```
    Bổ sung lệnh chạy newman để thực hiện kiểm thử với collection, environment và file CSV ngay dưới dòng này.
2. Chạy script local để kiểm tra kết quả và sinh ra báo cáo kiểm thử.

    **Hướng dẫn chạy script:**

    Mở terminal, di chuyển đến thư mục gốc của project và chạy lệnh sau:

    ```bash
    chmod +x run-api-tests.sh
    ./run-api-tests.sh
    ```

    Nếu gặp lỗi "Permission denied", bạn cần cấp quyền thực thi cho script bằng lệnh `chmod +x run-api-tests.sh` trước khi chạy.

    Sau khi chạy xong, kiểm tra kết quả kiểm thử và báo cáo được sinh ra trong thư mục hiện tại (hoặc theo đường dẫn được script chỉ định).

    ---

    ✅ **Cách chạy PowerShell script trên Windows:**

    1. Lưu file script với tên `run-api-tests.ps1`.
    2. Mở PowerShell với quyền admin (nếu cần).
    3. Nếu bị chặn khi chạy script, cho phép thực thi bằng lệnh:

        ```powershell
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        ```

    4. Chạy script:

        ```powershell
        .\run-api-tests.ps1
        ```

    Sau khi chạy xong, kiểm tra kết quả kiểm thử và báo cáo được sinh ra trong thư mục hiện tại (hoặc theo đường dẫn được script chỉ định).

---

### Yêu cầu 3: Tích hợp GitHub Actions

1. **Tạo repository mới trên GitHub** và push toàn bộ code của bạn lên repository này.

2. **Thiết lập các secrets cần thiết trên GitHub repository.**  
    > **Lưu ý:** Các secrets này chính là các giá trị tương ứng trong file `.env` của thư mục `API`.  
    > Ví dụ, nếu file `.env` có các dòng:
    > ```
    > APP_KEY=base64:xxxxxxx
    > DB_DATABASE=practice_software_testing
    > DB_USERNAME=root
    > DB_PASSWORD=password
    > JWT_SECRET=your-jwt-secret
    > ```
    > Thì bạn cần tạo các secrets trên GitHub với tên và giá trị tương ứng:
    > - `APP_KEY`
    > - `DB_DATABASE`
    > - `DB_USERNAME`
    > - `DB_PASSWORD`
    > - `JWT_SECRET`

---

## 🔧 CI/CD Setup & Usage

### Quick Start with GitHub Actions

1. **Fork/Clone this repository** to your GitHub account
2. **Enable GitHub Actions** in your repository settings
3. **Configure secrets** (if needed for your API endpoints)
4. **Push changes** to trigger the CI/CD pipeline

### Manual Test Execution

You can manually trigger tests through GitHub Actions:

1. Go to **Actions** tab in your GitHub repository
2. Select **"Quick API Tests"** workflow
3. Click **"Run workflow"**
4. Choose your test suite:
   - `all`: Run all API test suites
   - `users`: Run only user authentication tests
   - `brands`: Run only brand API tests  
   - `favorites`: Run only favorites API tests

### Viewing Test Results

- **Real-time Logs**: Check the Actions tab for live test execution
- **Test Reports**: Download HTML reports from workflow artifacts
- **PR Comments**: Automatic test summaries on pull requests
- **Documentation**: View at `https://yourusername.github.io/SWT_API`

### Local Development

```bash
# Install Newman CLI
npm install -g newman newman-reporter-html

# Run tests locally
./run-api-tests.ps1  # Windows PowerShell
# or
./run-api-tests.sh   # Linux/macOS

# Run specific test suite
newman run tests/collection/users-data-driven-collection.json \
  --environment tests/environments/environment.json \
  --data tests/data/users-test-data.csv \
  --reporters cli,html \
  --reporter-html-export reports/users-report.html
```

### Pipeline Triggers

The CI/CD pipeline runs automatically on:
- **Push** to `main` or `develop` branches
- **Pull Requests** to `main` branch  
- **Daily Schedule** at 6 AM UTC
- **Manual Trigger** via GitHub Actions UI

### Artifacts & Reports

Each pipeline run generates:
- **Test Reports**: HTML reports for each API test suite
- **Test Documentation**: CSV files with test cases and bug reports
- **Summary Reports**: Markdown summaries of test execution
- **Quality Reports**: Code quality and security scan results

---

## 📁 Project Structure

```
SWT_API/
├── .github/
│   └── workflows/
│       ├── api-testing.yml      # Main CI/CD pipeline
│       └── manual-test.yml      # Manual test triggers
├── sprint5-with-bugs/          # API application source
├── tests/
│   ├── collection/             # Postman collections
│   ├── data/                   # Test data CSV files
│   └── environments/           # Environment configurations
├── reports/                    # Generated test reports
├── *.csv                      # Test documentation
├── *.md                       # Project documentation
└── run-api-tests.*            # Local test scripts
```

---

## 🏆 Test Coverage

Current test suite covers:
- **32 Test Cases** across 3 API endpoints
- **User Authentication**: Login, validation, security testing
- **Brand Management**: CRUD operations, parameter handling
- **Favorites**: Authentication requirements, data validation
- **Security Testing**: SQL injection, XSS, token validation
- **Error Handling**: Status codes, response formats

---

## 🐛 Bug Tracking

- **20 Bugs Identified** through comprehensive testing
- **5 Critical Security Issues** requiring immediate attention
- **Bug Report**: `Bug_Report_Final_22127188.csv`
- **Test Cases**: `Test_Case_Report_Updated_22127188.csv`

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-tests`
3. Add your test cases to appropriate collections
4. Update test data CSV files as needed
5. Commit changes: `git commit -m "Add new API tests"`
6. Push to branch: `git push origin feature/new-tests`
7. Submit a Pull Request

The CI/CD pipeline will automatically run tests on your PR!

---

## 📞 Support

For questions about this project or CI/CD setup:
- Create an issue in this repository
- Check the GitHub Actions logs for troubleshooting
- Review the test reports in workflow artifacts

3. **Mở file workflow [`api-test.yml`](.github/workflows/api-test.yml)** và tìm bước có chú thích:
    ```yaml
    # TODO (Bạn thêm code ở dưới đây)
    ```
    Thêm lệnh chạy Newman vào vị trí này để thực hiện kiểm thử tự động.

4. **Đảm bảo workflow có bước upload báo cáo kiểm thử lên mục Artifacts** để lưu trữ và tải về sau khi kiểm thử hoàn thành.

5. **Push code lên GitHub và kiểm tra quá trình chạy trên GitHub Actions.**  
    Sau khi workflow hoàn thành, tải về file báo cáo kiểm thử từ mục Artifacts để xem kết quả.


---

## 3. Kết quả mong đợi

- Collection chạy được với data từ file CSV trên cả Postman và Newman.
- Báo cáo kiểm thử được sinh ra và upload thành công lên GitHub Actions.
- Toàn bộ quá trình kiểm thử tự động hóa được thực hiện qua CI/CD.

---

**Chúc các bạn hoàn thành tốt bài tập!**
