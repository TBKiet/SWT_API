#!/bin/bash

# ==============================================================================
# Script Chạy API Test Nhanh - Quick Test Runner
# ==============================================================================

echo "🚀 BẮT ĐẦU CHẠY API TESTS..."
echo "=================================="

# Kiểm tra Newman
if ! command -v newman &> /dev/null; then
    echo "⚙️ Cài đặt Newman..."
    npm install -g newman newman-reporter-htmlextra
fi

# Tạo thư mục báo cáo
mkdir -p reports

echo ""
echo "📊 CHẠY TEST BRANDS API..."
newman run tests/brands-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/brands-test-data.csv \
    --reporters cli,htmlextra \
    --reporter-htmlextra-export reports/brands-report.html \
    --reporter-htmlextra-title "Báo Cáo Test Brands API" \
    --color on

echo ""
echo "📊 CHẠY TEST USERS API..."
newman run tests/users-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/users-test-data.csv \
    --reporters cli,htmlextra \
    --reporter-htmlextra-export reports/users-report.html \
    --reporter-htmlextra-title "Báo Cáo Test Users API" \
    --color on

echo ""
echo "📊 CHẠY TEST FAVORITES API..."
newman run tests/favorites-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/favorites-test-data.csv \
    --reporters cli,htmlextra \
    --reporter-htmlextra-export reports/favorites-report.html \
    --reporter-htmlextra-title "Báo Cáo Test Favorites API" \
    --color on

echo ""
echo "✅ HOÀN THÀNH TẤT CẢ TESTS!"
echo "📁 Các báo cáo đã được lưu trong thư mục: reports/"
echo "🌐 Mở báo cáo trong trình duyệt bằng cách double-click vào file .html" 