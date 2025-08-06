# ==============================================================================
# New API Tests Script - 3 APIs Testing
# ==============================================================================
# Script này chạy tests cho 3 API endpoints:
# - GET /users/me - User information retrieval
# - GET /brands - Brands list retrieval  
# - POST /favorites - Add product to favorites
# ==============================================================================

Write-Host "[START] Starting New API Tests..." -ForegroundColor Green

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

# Test basic endpoints accessibility
Write-Host "[TEST] Testing brands endpoint accessibility..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/brands" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] Brands endpoint accessible: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "[WARNING] Brands endpoint issue: $($_.Exception.Message)" -ForegroundColor Yellow
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

# Run Individual Tests (Static test cases)
Write-Host "`n[NEWMAN] Running Individual API Tests..." -ForegroundColor Yellow
Write-Host "Collection: tests/collection.json" -ForegroundColor White
Write-Host "Environment: tests/environment.json" -ForegroundColor White
Write-Host "Description: Individual test cases for all 3 APIs" -ForegroundColor White

try {
    newman run "tests/collection.json" `
        --environment "tests/environment.json" `
        --reporters "cli,htmlextra,junit" `
        --reporter-htmlextra-export "reports/individual-api-test-report.html" `
        --reporter-junit-export "reports/individual-api-test-report.xml" `
        --timeout-request 10000 `
        --delay-request 1000 `
        --disable-unicode
    
    Write-Host "[SUCCESS] Individual API tests completed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Individual API tests failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Run Data-Driven Tests (CSV-based test cases)
Write-Host "`n[NEWMAN] Running Data-Driven API Tests..." -ForegroundColor Yellow
Write-Host "Collection: tests/data-driven-collection.json" -ForegroundColor White
Write-Host "Environment: tests/environment.json" -ForegroundColor White
Write-Host "Data: tests/test-data.csv" -ForegroundColor White
Write-Host "Description: Data-driven tests with various scenarios from CSV" -ForegroundColor White

try {
    newman run "tests/data-driven-collection.json" `
        --environment "tests/environment.json" `
        --iteration-data "tests/test-data.csv" `
        --reporters "cli,htmlextra,junit" `
        --reporter-htmlextra-export "reports/data-driven-api-test-report.html" `
        --reporter-junit-export "reports/data-driven-api-test-report.xml" `
        --timeout-request 10000 `
        --delay-request 1000 `
        --disable-unicode
    
    Write-Host "[SUCCESS] Data-driven API tests completed" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Data-driven API tests failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Summary
Write-Host "`n" + "="*80 -ForegroundColor Cyan
Write-Host "API TESTS SUMMARY" -ForegroundColor Cyan
Write-Host "="*80 -ForegroundColor Cyan
Write-Host "APIs Tested:" -ForegroundColor White
Write-Host "  1. GET /users/me - User information retrieval" -ForegroundColor Green
Write-Host "  2. GET /brands - Brands list retrieval" -ForegroundColor Green
Write-Host "  3. POST /favorites - Add product to favorites" -ForegroundColor Green
Write-Host ""
Write-Host "Test Suites:" -ForegroundColor White
Write-Host "  1. Individual Tests - Static test cases" -ForegroundColor Yellow
Write-Host "  2. Data-Driven Tests - CSV-based scenarios" -ForegroundColor Yellow
Write-Host ""
Write-Host "Reports Generated:" -ForegroundColor White
Write-Host "  - reports/individual-api-test-report.html" -ForegroundColor Cyan
Write-Host "  - reports/individual-api-test-report.xml" -ForegroundColor Cyan
Write-Host "  - reports/data-driven-api-test-report.html" -ForegroundColor Cyan
Write-Host "  - reports/data-driven-api-test-report.xml" -ForegroundColor Cyan
Write-Host ""
Write-Host "Test Data:" -ForegroundColor White
Write-Host "  - Admin credentials: admin@practicesoftwaretesting.com" -ForegroundColor Gray
Write-Host "  - User credentials: customer@practicesoftwaretesting.com" -ForegroundColor Gray
Write-Host "  - Test scenarios: 6 different test cases from CSV" -ForegroundColor Gray
Write-Host ""
Write-Host "[COMPLETED] All API tests finished!" -ForegroundColor Green
Write-Host "="*80 -ForegroundColor Cyan
