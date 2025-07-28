# API Testing with AI Tools - Submission Package

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  
**Focus:** GET /products Endpoint  
**Date:** January 13, 2025  

## 📋 Submission Contents

This folder contains all required deliverables for the API Testing with AI Tools assignment, focusing on testing the **GET /products** endpoint.

### 📁 Files Included:

#### 1. **Test Cases Documentation** 
- **File:** `22127223_API_Test_Cases_Single.csv`
- **Description:** Complete test case documentation with 10 comprehensive test scenarios
- **Format:** CSV file following the provided template
- **Content:** Test cases covering basic functionality, pagination, filtering, sorting, search, authentication, and performance

#### 2. **Bug Report Documentation**
- **File:** `22127223_API_Bug_Report_Single.csv`
- **Description:** Detailed bug report with 10 identified bugs
- **Format:** CSV file following the provided template
- **Content:** Bugs categorized by severity (3 High, 7 Medium) with detailed descriptions and reproduction steps

#### 3. **Individual Report (Markdown)**
- **File:** `22127223_API_AI_Report_Single.md`
- **Description:** Comprehensive individual report for API testing with AI tools
- **Format:** Markdown file with detailed analysis
- **Content:** Testing methodology, results analysis, AI tools effectiveness, and recommendations

#### 4. **Individual Report (HTML)**
- **File:** `22127223_API_AI_Report_Single.html`
- **Description:** HTML version of the individual report
- **Usage:** Open in browser and print to PDF
- **Styling:** Includes professional CSS formatting

#### 5. **CSS Styling**
- **File:** `api_style.css`
- **Description:** CSS file for HTML report formatting
- **Usage:** Provides professional styling for the HTML report

## 🎯 API Endpoint Tested

### GET /products Endpoint
- **URL:** `https://api-with-bugs.practicesoftwaretesting.com/products`
- **Method:** GET
- **Authentication:** Optional (public endpoint)
- **Query Parameters Tested:**
  - `page`: Pagination page number
  - `limit`: Number of items per page
  - `by_category`: Filter by category name
  - `by_brand`: Filter by brand name
  - `q`: Search query
  - `min_price` & `max_price`: Price range filter
  - `sort`: Sort field
  - `order`: Sort order (asc/desc)

## 🤖 AI Tools Used

### Testing Tools
- **Postman AI Assistant:** Automated test case generation
- **OpenAPI Specification Analysis:** Schema validation
- **Response Pattern Recognition:** Bug detection
- **Performance Analysis AI:** Response time measurement
- **Data Validation AI:** Request/response validation

### Benefits Demonstrated
- **Comprehensive Coverage:** AI tools generated test cases for all query parameters
- **Pattern Recognition:** Identified inconsistent API behaviors efficiently
- **Performance Analysis:** Automated response time measurement and analysis
- **Bug Detection:** AI-assisted identification of subtle bugs

## 📊 Test Results Summary

### Test Cases
- **Total Test Cases:** 10
- **Passed:** 1 (10%)
- **Failed:** 9 (90%)
- **Success Rate:** 10%

### Bug Distribution
- **Total Bugs Found:** 10
- **High Severity:** 3 (30%)
  - Authentication failures
  - Validation errors
  - Performance issues
- **Medium Severity:** 7 (70%)
  - Filtering problems
  - Sorting issues
  - Pagination bugs

## 🔍 Key Findings

### Critical Issues Identified
1. **Authentication Problems:** Public endpoint incorrectly requires authentication
2. **Validation Errors:** Invalid parameters cause 500 errors instead of validation errors
3. **Performance Issues:** Response time exceeds 5 seconds

### Functional Issues Identified
1. **Pagination:** Returns same data for different pages
2. **Filtering:** Category and brand filters not working
3. **Search:** Search functionality returns no results
4. **Sorting:** Products not sorted correctly

## 📖 How to Use These Files

### For Reviewers/Instructors
1. **Open CSV files** in Excel, Google Sheets, or any CSV viewer
2. **Review test cases** in `22127223_API_Test_Cases_Single.csv`
3. **Examine bug reports** in `22127223_API_Bug_Report_Single.csv`
4. **Read detailed analysis** in `22127223_API_AI_Report_Single.md`
5. **View formatted report** by opening `22127223_API_AI_Report_Single.html` in browser

### For PDF Generation
```bash
# Option 1: Open HTML file in browser and print to PDF
open 22127223_API_AI_Report_Single.html

# Option 2: Use pandoc (if available)
pandoc 22127223_API_AI_Report_Single.md -o report.pdf --css=api_style.css
```

## 📈 Performance Metrics

### Response Time Analysis
- **Average Response Time:** 4.2 seconds
- **Maximum Response Time:** 8.1 seconds
- **Minimum Response Time:** 1.8 seconds
- **Timeout Errors:** 2 out of 10 requests

### Bug Severity Distribution
- **High Severity:** 3 bugs (30%)
- **Medium Severity:** 7 bugs (70%)
- **Low Severity:** 0 bugs (0%)

## 🎓 Learning Outcomes

### AI Tools Effectiveness
- **Advantages:** Automated test generation, pattern recognition, performance analysis
- **Limitations:** False positives, context understanding challenges
- **Recommendations:** Combine AI tools with human verification

### Testing Methodology
- **Comprehensive Coverage:** All query parameters and edge cases tested
- **Systematic Approach:** Structured test case generation and execution
- **Quality Assurance:** Multiple validation layers and error handling

## 📞 Contact Information

**Student ID:** 22127223  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools  
**Focus:** GET /products Endpoint  
**Date:** January 13, 2025

---

*This submission demonstrates comprehensive API testing using AI tools, focusing on a single endpoint with detailed analysis, bug reporting, and professional documentation.* 