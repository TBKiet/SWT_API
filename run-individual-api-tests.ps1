# ==============================================================================
# Individual API Tests Script - Updated for Data-Driven Collections
# ==============================================================================
# Script này chạy data-driven tests cho từng API riêng biệt:
# - Users API: POST /users/login với authentication scenarios
# - Brands API: GET /brands với validation scenarios
# - Favorites API: POST /favorites với security and validation scenarios
# ==============================================================================

Write-Host "[START] Starting Updated Individual API Tests with Data-Driven Collections..." -ForegroundColor Green

# Test if API server is running
Write-Host "[TEST] Checking API server status..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/status" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] API server is running: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] API server is not running: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "[INFO] Please start the API server first using docker-compose" -ForegroundColor Yellow
    exit 1
}

# Check if Newman is installed
Write-Host "[CHECK] Checking Newman installation..." -ForegroundColor Cyan
if (-not (Get-Command newman -ErrorAction SilentlyContinue)) {
    Write-Host "[INSTALL] Installing Newman and HTML reporter..." -ForegroundColor Yellow
    try {
        npm install -g newman newman-reporter-htmlextra
        Write-Host "[SUCCESS] Newman installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to install Newman: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "[SUCCESS] Newman is already installed" -ForegroundColor Green
}

# Create reports directory if it doesn't exist
if (!(Test-Path "reports")) {
    New-Item -ItemType Directory -Path "reports" | Out-Null
    Write-Host "[INFO] Created reports directory" -ForegroundColor Cyan
}

# Create individual API reports subdirectory
if (!(Test-Path "reports/individual-apis")) {
    New-Item -ItemType Directory -Path "reports/individual-apis" | Out-Null
    Write-Host "[INFO] Created individual APIs reports directory" -ForegroundColor Cyan
}

Write-Host "`n" + "="*80 -ForegroundColor Yellow
Write-Host "RUNNING UPDATED DATA-DRIVEN API TESTS" -ForegroundColor Yellow
Write-Host "="*80 -ForegroundColor Yellow

# Count test cases first
$usersTestCount = (Import-Csv "tests/users-test-data.csv").Count
$brandsTestCount = (Import-Csv "tests/brands-test-data.csv").Count
$favoritesTestCount = (Import-Csv "tests/favorites-test-data.csv").Count
$totalTestCount = $usersTestCount + $brandsTestCount + $favoritesTestCount

Write-Host "Total Test Cases to Execute: $totalTestCount" -ForegroundColor Magenta
Write-Host "  - Users API: $usersTestCount test scenarios" -ForegroundColor Gray
Write-Host "  - Brands API: $brandsTestCount test scenarios" -ForegroundColor Gray
Write-Host "  - Favorites API: $favoritesTestCount test scenarios" -ForegroundColor Gray

# 1. Users API Data-Driven Tests
Write-Host "`n[API 1/3] Testing Users API - Data-Driven ($usersTestCount scenarios)..." -ForegroundColor Cyan
Write-Host "Collection: tests/users-data-driven-collection.json" -ForegroundColor White
Write-Host "Data: tests/users-test-data.csv" -ForegroundColor White
Write-Host "Focus: Authentication scenarios with edge cases and security testing" -ForegroundColor White

try {
    newman run "tests/users-data-driven-collection.json" `
        --environment "tests/environment.json" `
        --iteration-data "tests/users-test-data.csv" `
        --reporters "cli,htmlextra,junit" `
        --reporter-htmlextra-export "reports/individual-apis/users-data-driven-report.html" `
        --reporter-junit-export "reports/individual-apis/users-data-driven-report.xml" `
        --timeout-request 10000 `
        --delay-request 1000 `
        --disable-unicode
    
    Write-Host "[SUCCESS] Users API data-driven tests completed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Users API data-driven tests failed: $($_.Exception.Message)" -ForegroundColor Red
}

# 2. Brands API Data-Driven Tests
Write-Host "`n[API 2/3] Testing Brands API - Data-Driven ($brandsTestCount scenarios)..." -ForegroundColor Cyan
Write-Host "Collection: tests/brands-data-driven-collection.json" -ForegroundColor White
Write-Host "Data: tests/brands-test-data.csv" -ForegroundColor White
Write-Host "Focus: Data validation with various brand ID scenarios" -ForegroundColor White

try {
    newman run "tests/brands-data-driven-collection.json" `
        --environment "tests/environment.json" `
        --iteration-data "tests/brands-test-data.csv" `
        --reporters "cli,htmlextra,junit" `
        --reporter-htmlextra-export "reports/individual-apis/brands-data-driven-report.html" `
        --reporter-junit-export "reports/individual-apis/brands-data-driven-report.xml" `
        --timeout-request 10000 `
        --delay-request 1000 `
        --disable-unicode
    
    Write-Host "[SUCCESS] Brands API data-driven tests completed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Brands API data-driven tests failed: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. Favorites API Data-Driven Tests
Write-Host "`n[API 3/3] Testing Favorites API - Data-Driven ($favoritesTestCount scenarios)..." -ForegroundColor Cyan
Write-Host "Collection: tests/favorites-data-driven-collection.json" -ForegroundColor White
Write-Host "Data: tests/favorites-test-data.csv" -ForegroundColor White
Write-Host "Focus: Security testing, validation, and authentication scenarios" -ForegroundColor White

try {
    newman run "tests/favorites-data-driven-collection.json" `
        --environment "tests/environment.json" `
        --iteration-data "tests/favorites-test-data.csv" `
        --reporters "cli,htmlextra,junit" `
        --reporter-htmlextra-export "reports/individual-apis/favorites-data-driven-report.html" `
        --reporter-junit-export "reports/individual-apis/favorites-data-driven-report.xml" `
        --timeout-request 10000 `
        --delay-request 1000 `
        --disable-unicode
    
    Write-Host "[SUCCESS] Favorites API data-driven tests completed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Favorites API data-driven tests failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Summary
Write-Host "`n" + "="*80 -ForegroundColor Cyan
Write-Host "DATA-DRIVEN API TESTS SUMMARY" -ForegroundColor Cyan
Write-Host "="*80 -ForegroundColor Cyan

Write-Host "APIs Tested with Data-Driven Approach:" -ForegroundColor White
Write-Host "  1. 👤 Users API (POST /users/login) - $usersTestCount scenarios" -ForegroundColor Green
Write-Host "     - Valid/Invalid credentials testing" -ForegroundColor Gray
Write-Host "     - Edge cases: empty fields, malformed emails" -ForegroundColor Gray
Write-Host "     - Security: SQL injection, special characters" -ForegroundColor Gray
Write-Host ""
Write-Host "  2. 🏷️  Brands API (GET /brands/{id}) - $brandsTestCount scenarios" -ForegroundColor Green
Write-Host "     - Valid brand ID retrieval" -ForegroundColor Gray
Write-Host "     - Invalid ID types: negative, zero, string, float" -ForegroundColor Gray
Write-Host "     - Boundary testing: missing ID, very large numbers" -ForegroundColor Gray
Write-Host ""
Write-Host "  3. ❤️  Favorites API (POST /favorites) - $favoritesTestCount scenarios" -ForegroundColor Green
Write-Host "     - Authentication and authorization testing" -ForegroundColor Gray
Write-Host "     - Product ID validation with various data types" -ForegroundColor Gray
Write-Host "     - Security: SQL injection, XSS attempts" -ForegroundColor Gray
Write-Host ""

Write-Host "Enhanced Data-Driven Reports Generated:" -ForegroundColor White
Write-Host "  📊 HTML Reports:" -ForegroundColor Cyan
Write-Host "     - reports/individual-apis/users-data-driven-report.html" -ForegroundColor Gray
Write-Host "     - reports/individual-apis/brands-data-driven-report.html" -ForegroundColor Gray
Write-Host "     - reports/individual-apis/favorites-data-driven-report.html" -ForegroundColor Gray
Write-Host ""
Write-Host "  📋 XML Reports:" -ForegroundColor Cyan
Write-Host "     - reports/individual-apis/users-data-driven-report.xml" -ForegroundColor Gray
Write-Host "     - reports/individual-apis/brands-data-driven-report.xml" -ForegroundColor Gray
Write-Host "     - reports/individual-apis/favorites-data-driven-report.xml" -ForegroundColor Gray
Write-Host ""

Write-Host "Enhanced Test Coverage:" -ForegroundColor White
Write-Host "  ✅ Authentication & Authorization (Multiple scenarios)" -ForegroundColor Green
Write-Host "  ✅ Data Validation & Type Checking" -ForegroundColor Green
Write-Host "  ✅ Edge Case Testing" -ForegroundColor Green
Write-Host "  ✅ Security Testing (SQL Injection, XSS)" -ForegroundColor Green
Write-Host "  ✅ Boundary Value Testing" -ForegroundColor Green
Write-Host "  ✅ Error Handling Validation" -ForegroundColor Green
Write-Host ""

Write-Host "Total Test Executions: $totalTestCount scenarios" -ForegroundColor Magenta
Write-Host "[COMPLETED] All Enhanced Data-Driven API tests finished!" -ForegroundColor Green
Write-Host "="*80 -ForegroundColor Cyan

Write-Host "`nEnhanced Testing Benefits:" -ForegroundColor Yellow
Write-Host "1. Security Testing: SQL injection & XSS attack prevention" -ForegroundColor White
Write-Host "2. Edge Case Coverage: Invalid data types, empty fields, boundaries" -ForegroundColor White
Write-Host "3. Comprehensive Validation: Multiple scenarios per API endpoint" -ForegroundColor White
Write-Host "4. Scalable Testing: Easy to add new test scenarios via CSV" -ForegroundColor White
Write-Host "5. Detailed Reporting: Individual reports with scenario breakdown" -ForegroundColor White
