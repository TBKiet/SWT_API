# API Testing with AI Tools - Products API

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  
**API Tested:** Products API (https://api-with-bugs.practicesoftwaretesting.com/products)

---

## 📋 Project Overview

This project demonstrates comprehensive API testing using AI tools and data-driven testing methodologies. The focus is on testing the Products API with various parameters including pagination, filtering, and search functionality.

### Key Features:
- ✅ **Data-Driven Testing** with CSV files
- ✅ **AI-Assisted Test Generation** using Postman AI
- ✅ **Automated Testing** with Newman
- ✅ **CI/CD Integration** with GitHub Actions
- ✅ **Comprehensive Bug Reporting**
- ✅ **Performance Analysis**

---

## 📁 Files Generated

### Core Testing Files:
1. **`collection.json`** - Postman Collection for Products API
2. **`environment.json`** - Postman Environment variables
3. **`user-accounts.csv`** - Data-driven test data (pagination parameters)
4. **`run-api-tests.sh`** - Shell script for Newman execution
5. **`run-api-tests.ps1`** - PowerShell script for Windows users

### GitHub Actions:
6. **`.github/workflows/api-test.yml`** - Automated testing workflow
7. **`.env.ci`** - CI/CD environment variables

### Test Reports & Documentation:
8. **`22127223_API_Test_Cases_Products.csv`** - 10 comprehensive test cases
9. **`22127223_API_Bug_Report_Products.csv`** - 10 detailed bug reports
10. **`22127223_API_AI_Report_Products.md`** - Individual report (Markdown)
11. **`22127223_API_AI_Report_Products.html`** - Individual report (HTML)
12. **`convert_report_to_pdf.sh`** - Script to convert report to PDF

---

## 🚀 How to Use

### 1. **Data-Driven Testing with Postman**
```bash
# Import into Postman:
# 1. Import collection.json
# 2. Import environment.json
# 3. Run collection with user-accounts.csv
```

### 2. **Automated Testing with Newman**
```bash
# Linux/Mac:
chmod +x run-api-tests.sh
./run-api-tests.sh

# Windows:
.\run-api-tests.ps1
```

### 3. **GitHub Actions CI/CD**
```bash
# 1. Push code to GitHub repository
# 2. Workflow runs automatically when changes are made to this folder
# 3. Check Actions tab for results
# 4. Download test reports from Artifacts
```

---

## 📊 Test Results Summary

### Test Execution:
- **Total Test Cases:** 10
- **Passed:** 7 (70%)
- **Failed:** 3 (30%)
- **Data-Driven Iterations:** 5
- **Average Response Time:** 14.4 seconds

### Critical Issues Found:
1. **High Response Time** (14+ seconds) - Performance issue
2. **Missing Input Validation** - Security concern
3. **Inconsistent Error Handling** - Developer experience issue

### Test Coverage:
- ✅ Pagination functionality
- ✅ Category filtering
- ✅ Product search
- ✅ Individual product retrieval
- ✅ Error handling scenarios
- ✅ Performance testing

---

## 🤖 AI Tools Integration

### Postman AI Assistant:
- **Automated Test Generation:** Created comprehensive test scenarios
- **Response Validation:** Automated validation of response structure
- **Data-Driven Setup:** Assisted with CSV-based test data
- **Error Detection:** Identified potential issues in test scripts

### Newman Automation:
- **Command-Line Execution:** Enables CI/CD integration
- **Multiple Reporters:** JSON and HTML reports
- **Batch Testing:** Efficient execution of multiple scenarios
- **Error Handling:** Comprehensive error reporting

### GitHub Actions:
- **Automated Testing:** Runs on code changes to this folder
- **Artifact Management:** Stores test reports for 30 days
- **Workflow Monitoring:** Real-time status tracking
- **Team Collaboration:** Shared access to test results

---

## 📈 Data-Driven Testing

### CSV Test Data:
```csv
page,limit,product_id,category,search_term
1,10,1,electronics,
2,5,2,clothing,
0,10,3,books,
1,0,4,electronics,
1,100,5,clothing,
,,1,,laptop
,,2,,phone
,,99999,,nonexistent
,,3,,book
,,4,,invalid
```

### Benefits:
- **Scalability:** Easy to add new test scenarios
- **Maintainability:** Centralized test data management
- **Reusability:** Same test logic with different data sets
- **Coverage:** Comprehensive parameter testing

---

## 🐛 Bug Analysis

### High Priority Issues:
1. **BUG001:** High Response Time (14+ seconds)
2. **BUG002:** Invalid Page Parameter Not Handled
3. **BUG003:** Invalid Limit Parameter Not Handled

### Medium Priority Issues:
4. **BUG004:** Missing Error Handling for Invalid Product ID
5. **BUG006:** Missing Rate Limiting
6. **BUG007:** Inconsistent Response Structure

### Low Priority Issues:
7. **BUG005:** Search Functionality Limited
8. **BUG008:** Missing CORS Headers
9. **BUG009:** No API Versioning
10. **BUG010:** Missing Documentation

---

## 📋 Recommendations

### Immediate Actions:
1. **Performance Optimization:** Fix 14+ second response time
2. **Input Validation:** Implement proper validation
3. **Error Handling:** Standardize error responses

### Long-term Improvements:
1. **API Versioning:** Implement versioning
2. **Rate Limiting:** Add rate limiting
3. **Caching:** Implement response caching
4. **Documentation:** Improve API documentation

---

## 🎯 Key Achievements

- ✅ **Comprehensive Test Coverage:** 10 test cases covering all major functionality
- ✅ **Data-Driven Implementation:** CSV-based testing with 5 iterations
- ✅ **Automated Testing:** Newman integration with multiple reporters
- ✅ **CI/CD Integration:** GitHub Actions workflow
- ✅ **AI-Assisted Testing:** Postman AI integration
- ✅ **Detailed Bug Reporting:** 10 comprehensive bug reports
- ✅ **Performance Analysis:** Identified critical performance issues
- ✅ **Professional Documentation:** Complete individual report

---

## 📞 Contact Information

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  
**Date:** January 13, 2025  
**API Tested:** Products API  
**Testing Tools:** Postman, Newman, GitHub Actions, AI Assistant

---

*This project demonstrates comprehensive API testing automation using AI tools and data-driven testing methodologies.* 