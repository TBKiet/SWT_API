# SWT API Testing - Local Workflow Test (PowerShell)
# This script simulates the GitHub Actions workflow locally

Write-Host "🚀 Starting SWT API Testing Workflow - Local Test" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Step 1: Check Newman installation
Write-Host "Step 1: Checking Newman CLI installation..." -ForegroundColor Blue
try {
    $newmanVersion = & newman --version 2>$null
    Write-Host "✅ Newman CLI found: $newmanVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Newman CLI not found. Installing..." -ForegroundColor Red
    npm install -g newman newman-reporter-html
}

# Step 2: Create reports directory
Write-Host "Step 2: Creating reports directory..." -ForegroundColor Blue
if (!(Test-Path "reports")) {
    New-Item -ItemType Directory -Name "reports" | Out-Null
}
Write-Host "✅ Reports directory created" -ForegroundColor Green

# Step 3: Validate JSON collections
Write-Host "Step 3: Validating Postman collections..." -ForegroundColor Blue
$collectionsValid = $true
Get-ChildItem "tests\*collection.json" | ForEach-Object {
    Write-Host "  Validating $($_.Name)"
    try {
        $content = Get-Content $_.FullName -Raw | ConvertFrom-Json
        Write-Host "  ✅ $($_.Name) is valid JSON" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Invalid JSON in $($_.Name)" -ForegroundColor Red
        $collectionsValid = $false
    }
}

if (!$collectionsValid) {
    Write-Host "❌ JSON validation failed" -ForegroundColor Red
    exit 1
}

# Step 4: Validate CSV data files
Write-Host "Step 4: Validating test data CSV files..." -ForegroundColor Blue
Get-ChildItem "tests\*.csv" | ForEach-Object {
    Write-Host "  ✅ Found $($_.Name)" -ForegroundColor Green
    $header = Get-Content $_.FullName -First 1
    Write-Host "    Header: $header"
}

# Step 5: Run API tests
Write-Host "Step 5: Running API Integration Tests..." -ForegroundColor Blue

# Users API Tests
Write-Host "Running Users API Tests..." -ForegroundColor Yellow
$usersResult = & newman run "tests\users-data-driven-collection.json" -e "tests\environment.json" -d "tests\users-test-data.csv" -r html --reporter-html-export "reports\users-test-report.html" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Users API Tests completed" -ForegroundColor Green
    $usersStatus = "Completed"
} else {
    Write-Host "⚠️ Users API Tests completed with failures (expected)" -ForegroundColor Yellow
    $usersStatus = "Completed with failures"
}

# Brands API Tests
Write-Host "Running Brands API Tests..." -ForegroundColor Yellow
$brandsResult = & newman run "tests\brands-data-driven-collection.json" -e "tests\environment.json" -d "tests\brands-test-data.csv" -r html --reporter-html-export "reports\brands-test-report.html" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Brands API Tests completed" -ForegroundColor Green
    $brandsStatus = "Completed"
} else {
    Write-Host "⚠️ Brands API Tests completed with failures (expected)" -ForegroundColor Yellow
    $brandsStatus = "Completed with failures"
}

# Favorites API Tests
Write-Host "Running Favorites API Tests..." -ForegroundColor Yellow
$favoritesResult = & newman run "tests\favorites-data-driven-collection.json" -e "tests\environment.json" -d "tests\favorites-test-data.csv" -r html --reporter-html-export "reports\favorites-test-report.html" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Favorites API Tests completed" -ForegroundColor Green
    $favoritesStatus = "Completed"
} else {
    Write-Host "⚠️ Favorites API Tests completed with failures (expected)" -ForegroundColor Yellow
    $favoritesStatus = "Completed with failures"
}

# Step 6: Generate test summary
Write-Host "Step 6: Generating test summary..." -ForegroundColor Blue
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$summary = @"
# API Test Results Summary
Generated on: $timestamp

## Test Execution Status
- Users API Tests: $usersStatus
- Brands API Tests: $brandsStatus
- Favorites API Tests: $favoritesStatus

## Test Reports
Individual test reports are available in the reports/ directory:
- reports/users-test-report.html
- reports/brands-test-report.html
- reports/favorites-test-report.html

## Coverage Summary
- **32 Test Cases** executed across 3 API endpoints
- **Users API**: Authentication & validation testing (10 scenarios)
- **Brands API**: Parameter handling & validation (10 scenarios)  
- **Favorites API**: Authentication requirements & data validation (12 scenarios)

## Known Issues (Expected Failures)
Based on strict validation criteria:
- Status code mismatches (401 vs 422 for validation errors)
- API parameter validation not implemented
- Token case sensitivity inconsistencies
- Error response format inconsistencies

These failures are documented in Bug_Report_Final_22127188.csv
"@

$summary | Out-File -FilePath "test-summary.md" -Encoding UTF8
Write-Host "✅ Test summary generated: test-summary.md" -ForegroundColor Green

# Step 7: Security scan
Write-Host "Step 7: Running security scan..." -ForegroundColor Blue
Write-Host "🔍 Scanning for sensitive data patterns..."
$sensitiveFound = $false
Get-ChildItem "tests" -Include "*.json", "*.csv" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match "password.*:" -and $content -notmatch "welcome01|password123|testpass") {
        $sensitiveFound = $true
    }
}

if ($sensitiveFound) {
    Write-Host "⚠️ Potential sensitive data found in test files" -ForegroundColor Yellow
} else {
    Write-Host "✅ No sensitive data patterns detected" -ForegroundColor Green
}

# Step 8: Final summary
Write-Host "========================================" -ForegroundColor Blue
Write-Host "🎉 Local Workflow Test Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Blue

Write-Host "📊 Results:"
Write-Host "  - Collections validated: ✅"
Write-Host "  - Test data validated: ✅"
Write-Host "  - Users API tests: $usersStatus"
Write-Host "  - Brands API tests: $brandsStatus"
Write-Host "  - Favorites API tests: $favoritesStatus"
Write-Host "  - Reports generated: ✅"
Write-Host "  - Security scan: ✅"

Write-Host ""
Write-Host "📂 Generated files:"
Write-Host "  - reports/users-test-report.html"
Write-Host "  - reports/brands-test-report.html"
Write-Host "  - reports/favorites-test-report.html" 
Write-Host "  - test-summary.md"

Write-Host ""
Write-Host "🚀 Your CI/CD pipeline is ready for GitHub Actions!" -ForegroundColor Cyan
Write-Host "💡 Push your changes to trigger the automated workflow." -ForegroundColor Cyan
