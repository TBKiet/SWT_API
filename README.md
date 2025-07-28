# API Automation Practice - Postman, Newman & GitHub Actions

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  

## 📋 Mục tiêu

- Làm quen với kiểm thử API bằng Postman
- Thực hiện kiểm thử data-driven với file CSV
- Tích hợp kiểm thử tự động với Newman và GitHub Actions

## 📁 Cấu trúc thư mục

```
api-automation-practice/
├── .github/
│   └── workflows/
│       └── api-test.yml         # GitHub Actions workflow
├── sprint5-with-bugs/
│   └── API/
│       └── .env.ci              # Environment variables cho CI
├── tests/
│   └── api/
│       ├── collection.json      # Postman Collection
│       ├── environment.json     # Postman Environment
│       └── user-accounts.csv    # Data-driven testing file
├── run-api-tests.sh             # Script chạy Newman (Linux/Mac)
├── run-api-tests.ps1            # Script chạy Newman (Windows)
└── README.md                    # File hướng dẫn này
```

## 🚀 Hướng dẫn sử dụng

### Bước 1: Data-driven Testing với Postman

1. **Import Collection và Environment:**
   - Mở Postman
   - Import file `tests/api/collection.json`
   - Import file `tests/api/environment.json`

2. **File CSV Data:**
   - File `tests/api/user-accounts.csv` đã được tạo sẵn
   - Chứa các test cases với email, password, expected_status

3. **Chạy Collection với Data:**
   - Trong Postman, chọn "Run Collection"
   - Chọn file CSV `user-accounts.csv`
   - Chạy để test data-driven approach

### Bước 2: Chạy Newman Local

#### Trên Linux/Mac:
```bash
# Cấp quyền thực thi
chmod +x run-api-tests.sh

# Chạy script
./run-api-tests.sh
```

#### Trên Windows (PowerShell):
```powershell
# Cho phép thực thi script (nếu cần)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Chạy script
.\run-api-tests.ps1
```

### Bước 3: GitHub Actions CI/CD

1. **Tạo Repository mới trên GitHub**
2. **Push code lên repository**
3. **Thiết lập Secrets (nếu cần):**
   - `APP_KEY`
   - `DB_DATABASE`
   - `DB_USERNAME`
   - `DB_PASSWORD`
   - `JWT_SECRET`
4. **Workflow sẽ tự động chạy khi push code**

## 📊 Test Cases

### Data-driven Test Cases (user-accounts.csv):
| email | password | expected_status |
|-------|----------|-----------------|
| admin@practicesoftwaretesting.com | welcome01 | 200 |
| customer@practicesoftwaretesting.com | welcome01 | 200 |
| invalid@practicesoftwaretesting.com | wrongpass | 401 |
| testuser@practicesoftwaretesting.com | welcome01 | 200 |
| empty@practicesoftwaretesting.com | | 401 |
| wrongemail@test.com | welcome01 | 401 |

### API Endpoints Tested:
- **Authentication:** POST /users/login
- **Products:** GET /products, GET /products/{id}
- **Brands:** GET /brands
- **Categories:** GET /categories

## 🤖 AI Tools Integration

### Postman AI Assistant:
- Automated test case generation
- Response validation
- Data-driven testing setup

### Newman Automation:
- Command-line test execution
- Multiple reporter formats (CLI, JSON, HTML)
- CI/CD integration

### GitHub Actions:
- Automated testing on push/PR
- Artifact upload for test reports
- Workflow status monitoring

## 📈 Reports

Sau khi chạy tests, các reports sẽ được tạo:

- **CLI Report:** Console output
- **JSON Report:** `reports/api-test-results.json`
- **HTML Report:** `reports/api-test-report.html`

## 🔧 Cài đặt Prerequisites

### Newman:
```bash
npm install -g newman
```

### Node.js:
- Version 18+ recommended
- Download từ [nodejs.org](https://nodejs.org/)

### Postman:
- Download từ [postman.com](https://www.postman.com/)

## 🎯 Kết quả mong đợi

- ✅ Collection chạy được với data từ file CSV
- ✅ Newman thực thi tests thành công
- ✅ Báo cáo kiểm thử được sinh ra
- ✅ GitHub Actions workflow hoạt động
- ✅ Artifacts được upload thành công

## 📞 Contact Information

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  
**Date:** January 13, 2025

---

*This project demonstrates comprehensive API testing automation using Postman, Newman, and GitHub Actions with data-driven testing capabilities.* 