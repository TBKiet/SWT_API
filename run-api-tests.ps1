# ==============================================================================
# API Automation Tests Script với Dynamic Collections và CSV Data
# ==============================================================================
# Script này chạy các API tests sử dụng Newman với dynamic validation
# - Cart Tests: Testing POST /carts endpoint với coordinate validation
# - Reports Tests: Testing GET /reports/top10-purchased-products với authentication
# - TOTP Tests: Testing POST /totp/setup với 2FA setup và validation
# ==============================================================================

Write-Host "[START] Starting API Dynamic Tests với CSV Data..." -ForegroundColor Green

# # Start Docker services
# Write-Host "[DOCKER] Starting Docker containers..." -ForegroundColor Yellow
# docker compose -f docker-compose.yml up -d --force-recreate

# # Wait for services
# Write-Host "[WAIT] Waiting for services to be ready..." -ForegroundColor Yellow
# Start-Sleep -Seconds 30

# # Setup database
# Write-Host "[DATABASE] Setting up database..." -ForegroundColor Yellow
# docker compose exec laravel-api php artisan migrate --force
# docker compose exec laravel-api php artisan db:seed --force

# # Check if Newman is installed
# if (-not (Get-Command newman -ErrorAction SilentlyContinue)) {
#     Write-Host "[INSTALL] Installing Newman..." -ForegroundColor Cyan
#     npm install -g newman newman-reporter-htmlextra
# }

# Test basic endpoints first
Write-Host "[TEST] Testing API status endpoint..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/status" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] Status endpoint: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Status endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test products endpoint
Write-Host "[TEST] Testing products endpoint..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/products" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] Products endpoint: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Products endpoint failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Test reports endpoint
Write-Host "[TEST] Testing reports endpoint..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/reports/top10-purchased-products" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] Reports endpoint: $($response.StatusCode)" -ForegroundColor Green
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 401) {
        Write-Host "[INFO] Reports endpoint requires authentication (401) - This is expected" -ForegroundColor Yellow
    } else {
        Write-Host "[WARNING] Reports endpoint returned: $statusCode - $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Test TOTP endpoint
Write-Host "[TEST] Testing TOTP endpoint..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8091/totp/setup" -Headers @{"Accept"="application/json"} -ErrorAction Stop
    Write-Host "[SUCCESS] TOTP endpoint: $($response.StatusCode)" -ForegroundColor Green
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 401) {
        Write-Host "[INFO] TOTP endpoint requires authentication (401) - This is expected" -ForegroundColor Yellow
    } else {
        Write-Host "[WARNING] TOTP endpoint returned: $statusCode - $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Run Newman tests with dynamic collections and CSV data
Write-Host "[INFO] Preparing to run 3 test suites..." -ForegroundColor Cyan
Write-Host "  1. Products Tests - GET /products endpoint validation" -ForegroundColor White
Write-Host "  2. Reports Tests - GET /reports/top10-purchased-products validation" -ForegroundColor White  
Write-Host "  3. TOTP Tests - POST /totp/setup 2FA validation" -ForegroundColor White
Write-Host ""

$testSuites = @(
    @{
        Collection = "tests/collection/products-tests.postman_collection.json"
        Data = "tests/data/products-data.csv"
        Name = "products-tests"
        Description = "Products API tests - Testing GET /products endpoint with pagination scenarios"
    },
    @{
        Collection = "tests/collection/reports-tests.postman_collection.json"
        Data = "tests/data/reports-data.csv"
        Name = "reports-tests"
        Description = "Reports API tests - Testing GET /reports/top10-purchased-products with authentication"
    },
    @{
        Collection = "tests/collection/totp-tests.postman_collection.json"
        Data = "tests/data/totp-data.csv"
        Name = "totp-tests"
        Description = "TOTP API tests - Testing POST /totp/setup with authentication and 2FA setup"
    }
)

foreach ($testSuite in $testSuites) {
    $collectionFile = $testSuite.Collection
    $dataFile = $testSuite.Data
    $testName = $testSuite.Name
    $description = $testSuite.Description
    $environmentFile = "tests/environments/environment.json"
    
    Write-Host "[SUITE] Starting: $testName" -ForegroundColor Magenta
    Write-Host "[DESC] $description" -ForegroundColor Gray
    
    if ((Test-Path $collectionFile) -and (Test-Path $dataFile)) {
        Write-Host "[NEWMAN] Running test collection: $collectionFile with data: $dataFile" -ForegroundColor Cyan
        
        # Run Newman with CSV data, environment, and CLI reporter
        Write-Host "[TEST] Executing tests with iteration data and environment..." -ForegroundColor Yellow
        if (Test-Path $environmentFile) {
            newman run $collectionFile --iteration-data $dataFile --environment $environmentFile --reporters cli
        } else {
            newman run $collectionFile --iteration-data $dataFile --reporters cli
        }
        
        # Generate HTML report if htmlextra reporter is available
        Write-Host "[REPORT] Generating HTML report for $testName..." -ForegroundColor Cyan
        if (Test-Path $environmentFile) {
            $htmlResult = newman run $collectionFile --iteration-data $dataFile --environment $environmentFile --reporters htmlextra --reporter-htmlextra-export "reports/$testName.html" 2>$null
        } else {
            $htmlResult = newman run $collectionFile --iteration-data $dataFile --reporters htmlextra --reporter-htmlextra-export "reports/$testName.html" 2>$null
        }
        
        if (Test-Path "reports/$testName.html") {
            Write-Host "[SUCCESS] HTML report generated: reports/$testName.html" -ForegroundColor Green
        } else {
            Write-Host "[WARNING] HTML report generation failed for $testName" -ForegroundColor Yellow
        }
        
        Write-Host "[INFO] Test suite '$testName' completed" -ForegroundColor Magenta
        Write-Host "----------------------------------------" -ForegroundColor Gray
    } else {
        if (-not (Test-Path $collectionFile)) {
            Write-Host "[SKIP] Collection file not found: $collectionFile" -ForegroundColor Yellow
        }
        if (-not (Test-Path $dataFile)) {
            Write-Host "[SKIP] Data file not found: $dataFile" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Blue
Write-Host "[COMPLETE] All API test suites finished!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Blue
Write-Host ""
Write-Host "[REPORTS] Check the following HTML reports:" -ForegroundColor Cyan
Write-Host "  • reports/products-tests.html" -ForegroundColor White
Write-Host "  • reports/reports-tests.html" -ForegroundColor White
Write-Host "  • reports/totp-tests.html" -ForegroundColor White
Write-Host ""
Write-Host "[INFO] Test Summary:" -ForegroundColor Yellow
Write-Host "  - Products Tests: GET /products endpoint validation" -ForegroundColor Green
Write-Host "  - Reports Tests: GET /reports/top10-purchased-products validation" -ForegroundColor Green
Write-Host "  - TOTP Tests: POST /totp/setup 2FA validation" -ForegroundColor Green 