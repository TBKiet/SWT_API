# API Testing Script with Newman (PowerShell)
# Student ID: 22127223
# Course: Software Testing

Write-Host "🚀 Starting API Testing with Newman..." -ForegroundColor Green
Write-Host "Student ID: 22127223" -ForegroundColor Yellow
Write-Host "Date: $(Get-Date)" -ForegroundColor Yellow
Write-Host ""

# Check if Newman is installed
try {
    $newmanVersion = newman --version
    Write-Host "✅ Newman is installed: $newmanVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Newman is not installed. Please install Newman first:" -ForegroundColor Red
    Write-Host "npm install -g newman" -ForegroundColor Yellow
    exit 1
}

# Check if required files exist
$collectionFile = "tests/api/collection.json"
$environmentFile = "tests/api/environment.json"
$csvFile = "tests/api/user-accounts.csv"

if (-not (Test-Path $collectionFile)) {
    Write-Host "❌ Collection file not found: $collectionFile" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $environmentFile)) {
    Write-Host "❌ Environment file not found: $environmentFile" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $csvFile)) {
    Write-Host "❌ CSV data file not found: $csvFile" -ForegroundColor Red
    exit 1
}

Write-Host "✅ All required files found" -ForegroundColor Green
Write-Host ""

# Create reports directory
if (-not (Test-Path "reports")) {
    New-Item -ItemType Directory -Path "reports" | Out-Null
}

# TODO (Bạn thêm code ở dưới đây)
# Run Newman with collection, environment, and CSV data
Write-Host "📊 Running API tests with Newman..." -ForegroundColor Cyan

$newmanCommand = @(
    "newman", "run", $collectionFile,
    "--environment", $environmentFile,
    "--iteration-data", $csvFile,
    "--reporters", "cli,json,html",
    "--reporter-json-export", "reports/api-test-results.json",
    "--reporter-html-export", "reports/api-test-report.html",
    "--bail"
)

try {
    & $newmanCommand[0] $newmanCommand[1..($newmanCommand.Length-1)]
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -eq 0) {
        Write-Host ""
        Write-Host "✅ All tests passed successfully!" -ForegroundColor Green
        Write-Host "📁 Test reports generated:" -ForegroundColor Yellow
        Write-Host "   - JSON: reports/api-test-results.json" -ForegroundColor White
        Write-Host "   - HTML: reports/api-test-report.html" -ForegroundColor White
    } else {
        Write-Host ""
        Write-Host "❌ Some tests failed. Check the reports for details." -ForegroundColor Red
        Write-Host "📁 Test reports generated:" -ForegroundColor Yellow
        Write-Host "   - JSON: reports/api-test-results.json" -ForegroundColor White
        Write-Host "   - HTML: reports/api-test-report.html" -ForegroundColor White
    }
} catch {
    Write-Host "❌ Error running Newman: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🎯 Test execution completed!" -ForegroundColor Green
Write-Host "📊 Reports available in the 'reports' directory" -ForegroundColor Yellow 