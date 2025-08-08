# ==============================================================================
# Script PowerShell Chạy API Testing - Phiên bản Windows
# ==============================================================================
# Tác giả: API Testing Team
# Mô tả: Script tự động chạy các test suite API với Newman trên Windows
# Hỗ trợ: Brands, Users, Favorites APIs
# ==============================================================================

# Thiết lập màu sắc
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    🚀 API TESTING AUTOMATION 🚀                    ║" -ForegroundColor Cyan
Write-Host "║                     Script PowerShell - Windows                   ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Hàm kiểm tra Newman
function Check-Newman {
    Write-Host "⚙️ Kiểm tra Newman..." -ForegroundColor Blue
    
    try {
        $newmanVersion = newman --version 2>$null
        if ($newmanVersion) {
            Write-Host "✅ Newman đã sẵn sàng! Phiên bản: $newmanVersion" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "⚠️ Newman chưa được cài đặt!" -ForegroundColor Yellow
        Write-Host "⚙️ Đang cài đặt Newman và HTML reporter..." -ForegroundColor Cyan
        npm install -g newman newman-reporter-htmlextra
        Write-Host "✅ Newman đã được cài đặt thành công!" -ForegroundColor Green
    }
    Write-Host ""
}

# Hàm tạo thư mục reports
function Create-ReportsDir {
    if (!(Test-Path "reports")) {
        New-Item -ItemType Directory -Path "reports" | Out-Null
        Write-Host "✅ Đã tạo thư mục reports/" -ForegroundColor Green
    }
}

# Hàm kiểm tra API server
function Check-ApiServer {
    Write-Host "⚙️ Kiểm tra kết nối API server..." -ForegroundColor Blue
    
    if (Test-Path "tests\environment.json") {
        $envContent = Get-Content "tests\environment.json" -Raw
        $baseUrl = ($envContent | ConvertFrom-Json).values | Where-Object { $_.key -eq "baseUrl" } | Select-Object -ExpandProperty value
        
        if ($baseUrl) {
            Write-Host "API Base URL: $baseUrl" -ForegroundColor Cyan
            
            $endpoints = @("/status", "/products", "/brands")
            
            foreach ($endpoint in $endpoints) {
                try {
                    $response = Invoke-WebRequest -Uri "$baseUrl$endpoint" -Method GET -UseBasicParsing -ErrorAction SilentlyContinue
                    $statusCode = $response.StatusCode
                    
                    if ($statusCode -eq 200) {
                        Write-Host "✅ $endpoint : $statusCode" -ForegroundColor Green
                    }
                    elseif ($statusCode -eq 401 -or $statusCode -eq 404) {
                        Write-Host "⚠️ $endpoint : $statusCode (Yêu cầu xác thực hoặc không tìm thấy)" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Host "❌ $endpoint : Lỗi kết nối" -ForegroundColor Red
                }
            }
        }
    }
    else {
        Write-Host "❌ Không tìm thấy file environment.json" -ForegroundColor Red
    }
    Write-Host ""
}

# Hàm chạy test suite
function Run-TestSuite {
    param(
        [string]$Collection,
        [string]$DataFile,
        [string]$ReportName,
        [string]$Description
    )
    
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Magenta
    Write-Host "🚀 CHẠY TEST: $Description" -ForegroundColor Magenta
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Magenta
    
    if (!(Test-Path $Collection)) {
        Write-Host "❌ Không tìm thấy collection: $Collection" -ForegroundColor Red
        return $false
    }
    
    if (!(Test-Path $DataFile)) {
        Write-Host "❌ Không tìm thấy data file: $DataFile" -ForegroundColor Red
        return $false
    }
    
    # Chạy Newman
    $cmd = "newman run `"$Collection`" -e `"tests\environment.json`" -d `"$DataFile`" --reporters cli,htmlextra --reporter-htmlextra-export `"reports\$ReportName.html`" --reporter-htmlextra-title `"Báo Cáo Test API - $Description`" --reporter-htmlextra-logs --color on"
    
    try {
        Invoke-Expression $cmd
        $exitCode = $LASTEXITCODE
        
        if ($exitCode -eq 0) {
            Write-Host "✅ Test $Description hoàn thành thành công!" -ForegroundColor Green
        }
        else {
            Write-Host "⚠️ Test $Description hoàn thành với một số lỗi!" -ForegroundColor Yellow
        }
        
        Write-Host "📊 Báo cáo HTML: reports\$ReportName.html" -ForegroundColor Cyan
        Write-Host ""
        
        return ($exitCode -eq 0)
    }
    catch {
        Write-Host "❌ Lỗi khi chạy test: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Hàm hiển thị menu
function Show-Menu {
    Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    ⚙️ MENU LỰA CHỌN ⚙️                         ║" -ForegroundColor Cyan
    Write-Host "╠══════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
    Write-Host "║  1. Chạy tất cả test suites                                 ║" -ForegroundColor Cyan
    Write-Host "║  2. Chạy test Brands API                                    ║" -ForegroundColor Cyan
    Write-Host "║  3. Chạy test Users API                                     ║" -ForegroundColor Cyan
    Write-Host "║  4. Chạy test Favorites API                                 ║" -ForegroundColor Cyan
    Write-Host "║  5. Kiểm tra kết nối API server                             ║" -ForegroundColor Cyan
    Write-Host "║  6. Mở thư mục báo cáo                                      ║" -ForegroundColor Cyan
    Write-Host "║  0. Thoát                                                   ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

# Hàm chạy tất cả tests
function Run-AllTests {
    Write-Host "🚀 CHẠY TẤT CẢ TEST SUITES" -ForegroundColor Green
    Write-Host ""
    
    $totalTests = 0
    $failedTests = 0
    
    # Test Brands API
    $totalTests++
    if (!(Run-TestSuite "tests\brands-data-driven-collection.json" "tests\brands-test-data.csv" "brands-test-report" "Brands API")) {
        $failedTests++
    }
    
    # Test Users API
    $totalTests++
    if (!(Run-TestSuite "tests\users-data-driven-collection.json" "tests\users-test-data.csv" "users-test-report" "Users API")) {
        $failedTests++
    }
    
    # Test Favorites API
    $totalTests++
    if (!(Run-TestSuite "tests\favorites-data-driven-collection.json" "tests\favorites-test-data.csv" "favorites-test-report" "Favorites API")) {
        $failedTests++
    }
    
    # Tóm tắt kết quả
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Magenta
    Write-Host "📊 TÓM TẮT KẾT QUẢ TEST" -ForegroundColor Magenta
    Write-Host "════════════════════════════════════════════════════════════════" -ForegroundColor Magenta
    Write-Host "Tổng số test suites: $totalTests" -ForegroundColor Cyan
    Write-Host "Test suites thành công: $($totalTests - $failedTests)" -ForegroundColor Green
    Write-Host "Test suites có lỗi: $failedTests" -ForegroundColor Red
    
    if ($failedTests -eq 0) {
        Write-Host "✅ Tất cả test suites đã chạy thành công!" -ForegroundColor Green
    }
    else {
        Write-Host "⚠️ Có $failedTests test suite(s) gặp lỗi. Vui lòng kiểm tra báo cáo chi tiết." -ForegroundColor Yellow
    }
    
    Write-Host ""
    Write-Host "📊 Các báo cáo HTML đã được tạo trong thư mục reports\" -ForegroundColor Cyan
}

# Hàm mở thư mục báo cáo
function Open-Reports {
    Write-Host "📊 Mở thư mục báo cáo..." -ForegroundColor Blue
    
    if (Test-Path "reports") {
        Start-Process "reports"
        Write-Host "✅ Đã mở thư mục reports/" -ForegroundColor Green
    }
    else {
        Write-Host "❌ Thư mục reports không tồn tại!" -ForegroundColor Red
    }
}

# Hàm main
function Main {
    Check-Newman
    Create-ReportsDir
    
    while ($true) {
        Show-Menu
        $choice = Read-Host "Vui lòng chọn một tùy chọn (0-6)"
        Write-Host ""
        
        switch ($choice) {
            "1" { Run-AllTests }
            "2" { Run-TestSuite "tests\brands-data-driven-collection.json" "tests\brands-test-data.csv" "brands-test-report" "Brands API" }
            "3" { Run-TestSuite "tests\users-data-driven-collection.json" "tests\users-test-data.csv" "users-test-report" "Users API" }
            "4" { Run-TestSuite "tests\favorites-data-driven-collection.json" "tests\favorites-test-data.csv" "favorites-test-report" "Favorites API" }
            "5" { Check-ApiServer }
            "6" { Open-Reports }
            "0" {
                Write-Host "✅ Cảm ơn bạn đã sử dụng API Testing Script!" -ForegroundColor Green
                Write-Host "🚀 Chúc bạn có một ngày tốt lành!" -ForegroundColor Cyan
                exit
            }
            default {
                Write-Host "❌ Lựa chọn không hợp lệ! Vui lòng chọn từ 0-6." -ForegroundColor Red
            }
        }
        
        Write-Host "Nhấn Enter để tiếp tục..." -ForegroundColor Gray
        Read-Host
        Clear-Host
    }
}

# Chạy script
Main 