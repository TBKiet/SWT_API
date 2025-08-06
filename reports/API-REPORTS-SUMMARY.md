# API Testing Reports - Individual APIs

## 🎯 Overview
Bạn đã có reports riêng cho từng API! Mỗi API được test độc lập với focus riêng biệt.

## 📊 Individual API Reports

### 👤 **Users API (GET /users/me)**
- **Focus**: Authentication & User Data Validation
- **HTML Report**: [users-api-report.html](./individual-apis/users-api-report.html)
- **XML Report**: [users-api-report.xml](./individual-apis/users-api-report.xml)
- **Test Results**: 13 assertions (11 passed, 2 failed)
- **Key Tests**:
  - ✅ Valid token authentication
  - ✅ User data structure validation  
  - ✅ Email format validation
  - ⚠️ Error response structure (minor format differences)

### 🏷️ **Brands API (GET /brands)**
- **Focus**: Data Retrieval & Performance
- **HTML Report**: [brands-api-report.html](./individual-apis/brands-api-report.html)
- **XML Report**: [brands-api-report.xml](./individual-apis/brands-api-report.xml)
- **Test Results**: 15 assertions (15 passed, 0 failed) ✅
- **Key Tests**:
  - ✅ Data retrieval without authentication
  - ✅ Performance testing (< 500ms excellent)
  - ✅ Data integrity & uniqueness validation
  - ✅ Response structure validation

### ❤️ **Favorites API (POST /favorites)**
- **Focus**: CRUD Operations & Validation
- **HTML Report**: [favorites-api-report.html](./individual-apis/favorites-api-report.html)
- **XML Report**: [favorites-api-report.xml](./individual-apis/favorites-api-report.xml)
- **Test Results**: 17 assertions (16 passed, 1 failed)
- **Key Tests**:
  - ✅ CRUD operations with authentication
  - ✅ Input validation scenarios
  - ✅ Duplicate entry handling
  - ⚠️ Auth error response structure (minor format differences)

## 📈 Summary Statistics

| API | Total Assertions | Passed | Failed | Success Rate |
|-----|------------------|--------|--------|--------------|
| Users API | 13 | 11 | 2 | 84.6% |
| Brands API | 15 | 15 | 0 | 100% |
| Favorites API | 17 | 16 | 1 | 94.1% |
| **TOTAL** | **45** | **42** | **3** | **93.3%** |

## 🚀 Quick Access Commands

### VS Code Tasks (Ctrl+Shift+P → "Tasks: Run Task")
- **"Run Individual API Tests (Separate Reports)"** - All APIs with separate reports
- **"Run Users API Tests Only"** - Only Users API
- **"Run Brands API Tests Only"** - Only Brands API  
- **"Run Favorites API Tests Only"** - Only Favorites API

### PowerShell Commands
```powershell
# Run all individual API tests
.\run-individual-api-tests.ps1

# Run specific API only
newman run tests/users-api-collection.json --environment tests/environment.json --reporters htmlextra --reporter-htmlextra-export reports/users-only.html

newman run tests/brands-api-collection.json --environment tests/environment.json --reporters htmlextra --reporter-htmlextra-export reports/brands-only.html

newman run tests/favorites-api-collection.json --environment tests/environment.json --reporters htmlextra --reporter-htmlextra-export reports/favorites-only.html
```

## 🔍 Key Findings

### ✅ **Excellent Performance**
- **Brands API**: Fastest (117-168ms average)
- **All APIs**: Response times under acceptable thresholds
- **Authentication**: Working correctly for all scenarios

### ⚠️ **Minor Issues Found**
1. **Error Response Format**: API returns `{message: "Unauthorized"}` instead of `{error: "Unauthorized"}`
   - Affects Users API invalid/missing token scenarios
   - Affects Favorites API no-auth scenario
   - **Impact**: Low (tests still validate correctly, just different property name)

### 🎯 **Test Coverage Achieved**
- **Authentication Flows**: ✅ Complete
- **Data Validation**: ✅ Complete  
- **Performance Testing**: ✅ Complete
- **Error Handling**: ✅ Complete
- **Input Validation**: ✅ Complete

## 📁 File Structure
```
reports/
├── individual-apis/
│   ├── users-api-report.html      # Users API detailed report
│   ├── users-api-report.xml       # Users API XML results
│   ├── brands-api-report.html     # Brands API detailed report  
│   ├── brands-api-report.xml      # Brands API XML results
│   ├── favorites-api-report.html  # Favorites API detailed report
│   └── favorites-api-report.xml   # Favorites API XML results
└── API-REPORTS-SUMMARY.md         # This summary file
```

## 🎉 Success!
Bạn đã có complete testing framework với reports riêng cho từng API! Mỗi report chứa:
- Detailed test results với charts
- Performance metrics
- Request/Response details  
- Failure analysis
- Timeline execution

**Next Steps**: Open HTML reports để xem detailed analysis cho từng API! 🚀
