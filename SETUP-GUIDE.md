# Setup và Chạy API Tests - 3 API Endpoints

## 🎯 Mục tiêu
Testing 3 API endpoints:
1. **GET /users/me** - Lấy thông tin user hiện tại
2. **GET /brands** - Lấy danh sách brands  
3. **POST /favorites** - Thêm sản phẩm vào yêu thích

## 🚀 Quick Start

### 1. Kiểm tra API Server
```powershell
# Trong VS Code: Ctrl+Shift+P → "Tasks: Run Task" → "Check API Server Status"
# Hoặc chạy manual:
Invoke-WebRequest -Uri "http://localhost:8091/status" -Headers @{"Accept"="application/json"}
```

### 2. Cài đặt Newman (nếu chưa có)
```powershell
# Trong VS Code: Ctrl+Shift+P → "Tasks: Run Task" → "Install Newman"
# Hoặc chạy manual:
npm install -g newman newman-reporter-htmlextra
```

### 3. Chạy All Tests
```powershell
# Trong VS Code: Ctrl+Shift+P → "Tasks: Run Task" → "Run New API Tests - Complete"
# Hoặc chạy manual:
.\run-new-api-tests.ps1
```

## 📋 Các Task VS Code Có Sẵn

### Chạy Tests
- **"Run New API Tests - Complete"** - Chạy tất cả tests (Individual + Data-driven)
- **"Run Individual API Tests Only"** - Chỉ chạy static test cases
- **"Run Data-Driven API Tests Only"** - Chỉ chạy CSV-based test cases

### Utilities
- **"Check API Server Status"** - Kiểm tra server có chạy không
- **"Install Newman"** - Cài đặt Newman tools

## 📁 Cấu trúc Files

```
tests/
├── collection.json              # Individual test cases (static)
├── data-driven-collection.json  # Data-driven test cases (CSV)
├── environment.json             # Environment variables
└── test-data.csv               # Test data cho data-driven tests

reports/                        # Auto-generated reports
├── individual-api-test-report.html
├── individual-api-test-report.xml
├── data-driven-api-test-report.html
└── data-driven-api-test-report.xml
```

## 🧪 Test Scenarios

### Individual Tests (collection.json)
- Setup Admin Login
- Setup User Login  
- GET /users/me với valid token
- GET /users/me với invalid token
- GET /users/me without token
- GET /brands (no auth required)
- POST /favorites với valid data
- POST /favorites với invalid product ID
- POST /favorites without auth

### Data-Driven Tests (test-data.csv)
6 scenarios từ CSV:
1. **admin_valid** - Admin login success → test all APIs
2. **user_valid** - User login success → test all APIs
3. **user_invalid_email** - Invalid email → 401 errors
4. **user_invalid_password** - Wrong password → 401 errors  
5. **user_valid_invalid_product** - Valid user + invalid product → 422 error
6. **user_valid_empty_product** - Valid user + empty product → 422 error

## 🔧 Environment Variables

File `tests/environment.json`:
```json
{
  "values": [
    { "key": "base_url", "value": "http://localhost:8091" },
    { "key": "admin_email", "value": "admin@practicesoftwaretesting.com" },
    { "key": "admin_password", "value": "welcome01" },
    { "key": "user_email", "value": "customer@practicesoftwaretesting.com" },
    { "key": "user_password", "value": "welcome01" },
    { "key": "valid_product_id", "value": "1" }
  ]
}
```

## 📊 Expected Results

### ✅ Success Scenarios
- **Admin/User Login**: 200 + access_token
- **GET /users/me**: 200 + user object (id, email, first_name, last_name, role)
- **GET /brands**: 200 + brands array với unique IDs
- **POST /favorites**: 201 + favorite object

### ❌ Error Scenarios  
- **Invalid Login**: 401 + error message
- **GET /users/me với invalid token**: 401 + error message
- **POST /favorites với invalid product_id**: 422 + validation error
- **POST /favorites without auth**: 401 + auth error

## 🔍 Validations

### GET /users/me
- Status code validation
- Response structure (id, email, first_name, last_name, role)
- Data types validation
- Email format validation
- Response time < 1000ms

### GET /brands
- Status code 200
- Response is array
- Array not empty
- Brand structure (id, name, slug)
- Unique IDs validation
- Response time < 2000ms

### POST /favorites
- Status codes (201, 422, 401)
- Response structure cho success case
- Validation error messages
- Product ID matching
- Response time < 2000ms

## 🚨 Troubleshooting

### API Server không chạy
```powershell
# Check Docker containers
docker ps

# Start API server
docker-compose up -d
```

### Newman không tìm thấy
```powershell
# Install Newman
npm install -g newman newman-reporter-htmlextra

# Verify installation
newman --version
```

### Tests fail với 401 errors
- Kiểm tra credentials trong `environment.json`
- Đảm bảo API server có user accounts
- Check database có được seed không

### Response time quá chậm
- Tăng timeout trong Newman commands
- Kiểm tra Docker resources
- Check network connectivity

## 📈 Performance Tips

- **Delay between requests**: 1000ms để tránh rate limiting
- **Request timeout**: 10000ms cho các API calls
- **Parallel execution**: Không recommend cho test này vì có dependencies
- **Reports**: HTML + XML formats cho integration với CI/CD

## 🔄 Next Steps

1. **CI/CD Integration**: Thêm tests vào pipeline
2. **More API Coverage**: Thêm tests cho DELETE, PUT endpoints
3. **Performance Testing**: Thêm load testing với Newman
4. **Security Testing**: Thêm authentication và authorization tests
5. **Data Validation**: Thêm schema validation cho responses
