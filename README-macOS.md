# API Automation Tests cho macOS M3 Pro

## Tổng quan

Script này được thiết kế đặc biệt cho macOS M3 Pro để chạy các API tests sử dụng Newman với dynamic validation và CSV data.

## Tính năng mới

### 🆕 Test Collections mới:
1. **TOTP Tests** - Two-factor authentication validation
   - 10 test cases x 5 assertions = 50 assertions
   - Authentication, token validation, QR code generation
   - File: `tests/collection/totp-tests.postman_collection.json`

2. **Reports Tests** - Admin reports and analytics validation
   - 10 test cases x 4 assertions = 40 assertions
   - Role-based access, admin privileges, data analytics
   - File: `tests/collection/reports-tests.postman_collection.json`

3. **Cart Tests** - Shopping cart functionality validation
   - 10 test cases x 3 assertions = 30 assertions
   - Coordinate validation, cart creation, boundary testing
   - File: `tests/collection/cart-tests.postman_collection.json`

### 📊 Tổng cộng: 120 assertions across 30 test cases

## Cài đặt và chạy

### 1. Cài đặt dependencies
```bash
# Cài đặt Node.js (nếu chưa có)
brew install node

# Cài đặt Newman và HTML reporter
npm install -g newman newman-reporter-htmlextra
```

### 2. Chạy tests
```bash
# Chạy tất cả test suites
./run-api-tests.sh

# Hoặc chạy với quyền admin nếu cần
sudo ./run-api-tests.sh
```

## Cấu trúc thư mục

```
├── run-api-tests.sh              # Script chính cho macOS
├── tests/
│   ├── collection/               # Postman collections
│   │   ├── totp-tests.postman_collection.json
│   │   ├── reports-tests.postman_collection.json
│   │   └── cart-tests.postman_collection.json
│   ├── data/                    # CSV test data
│   │   ├── totp-data.csv
│   │   ├── reports-data.csv
│   │   └── cart-data.csv
│   └── environments/            # Environment variables
│       └── environment.json
└── reports/                     # HTML reports (tự động tạo)
    ├── totp-tests.html
    ├── reports-tests.html
    └── cart-tests.html
```

## API Endpoints được test

### 🔐 TOTP API (`/totp/setup`)
- **POST** `/totp/setup` - Setup two-factor authentication
- Authentication required
- Returns: `secret`, `qrCodeUrl`

### 📊 Reports API (`/reports/top10-purchased-products`)
- **GET** `/reports/top10-purchased-products` - Get top 10 purchased products
- Admin authentication required
- Returns: Array of products with `name` and `count`

### 🛒 Cart API (`/carts`)
- **POST** `/carts` - Create shopping cart
- Optional coordinates: `lat`, `lng`
- Returns: Cart `id`

## Test Data Structure

### TOTP Data (`totp-data.csv`)
```csv
test_case,user_email,user_password,invalid_token,description,expected_status
TC001_Valid_Setup,user@toolshop.com,user123,invalid_token_here,Valid user setup TOTP,200
TC002_No_Token,user@toolshop.com,user123,invalid_token_here,No authentication token,401
...
```

### Reports Data (`reports-data.csv`)
```csv
test_case,admin_email,admin_password,user_email,user_password,invalid_token,description,expected_status
TC001_Admin_Success,admin@toolshop.com,admin123,user@toolshop.com,user123,invalid_token_here,Admin login and access reports,200
TC002_User_Forbidden,admin@toolshop.com,admin123,user@toolshop.com,user123,invalid_token_here,User login but forbidden access,403
...
```

### Cart Data (`cart-data.csv`)
```csv
test_case,lat,lng,invalid_lat,invalid_lng,boundary_lat,boundary_lng,description,expected_status
TC001_Valid_Amsterdam,52.3676,4.9041,invalid_coordinate,not_a_number,90.0,180.0,Valid coordinates Amsterdam,201
TC002_Valid_London,51.5074,-0.1278,abc,xyz,89.999,179.999,Valid coordinates London,201
...
```

## Environment Variables

File `tests/environments/environment.json` chứa:
- `base_url`: `http://localhost:8091`
- `admin_email`: `admin@toolshop.com`
- `user_email`: `user@toolshop.com`
- Test coordinates và tokens

## Reports

Script tự động tạo HTML reports trong thư mục `reports/`:
- `reports/totp-tests.html`
- `reports/reports-tests.html`
- `reports/cart-tests.html`

## Troubleshooting

### Lỗi thường gặp:

1. **Newman not found**
   ```bash
   npm install -g newman newman-reporter-htmlextra
   ```

2. **Permission denied**
   ```bash
   chmod +x run-api-tests.sh
   ```

3. **API server not running**
   - Đảm bảo API server đang chạy trên `http://localhost:8091`
   - Kiểm tra Docker containers nếu sử dụng

4. **CSV file not found**
   - Kiểm tra đường dẫn file trong script
   - Đảm bảo file CSV tồn tại trong `tests/data/`

## Performance cho macOS M3 Pro

- Script được tối ưu cho Apple Silicon
- Sử dụng native bash commands thay vì PowerShell
- Color-coded output cho dễ đọc
- Parallel test execution support

## Chạy từng test suite riêng lẻ

```bash
# Chỉ chạy TOTP tests
newman run tests/collection/totp-tests.postman_collection.json --iteration-data tests/data/totp-data.csv --environment tests/environments/environment.json

# Chỉ chạy Reports tests
newman run tests/collection/reports-tests.postman_collection.json --iteration-data tests/data/reports-data.csv --environment tests/environments/environment.json

# Chỉ chạy Cart tests
newman run tests/collection/cart-tests.postman_collection.json --iteration-data tests/data/cart-data.csv --environment tests/environments/environment.json
``` 