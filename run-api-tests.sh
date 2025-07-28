#!/bin/bash

# API Testing Script with Newman
# Student ID: 22127223
# Course: Software Testing

echo "🚀 Starting API Testing with Newman..."
echo "Student ID: 22127223"
echo "Date: $(date)"
echo ""

# Check if Newman is installed
if ! command -v newman &> /dev/null; then
    echo "❌ Newman is not installed. Please install Newman first:"
    echo "npm install -g newman"
    exit 1
fi

# Check if required files exist
if [ ! -f "tests/api/collection.json" ]; then
    echo "❌ Collection file not found: tests/api/collection.json"
    exit 1
fi

if [ ! -f "tests/api/environment.json" ]; then
    echo "❌ Environment file not found: tests/api/environment.json"
    exit 1
fi

if [ ! -f "tests/api/user-accounts.csv" ]; then
    echo "❌ CSV data file not found: tests/api/user-accounts.csv"
    exit 1
fi

echo "✅ All required files found"
echo ""

# Create reports directory
mkdir -p reports

# TODO (Bạn thêm code ở dưới đây)
# Run Newman with collection, environment, and CSV data
echo "📊 Running API tests with Newman..."
newman run tests/api/collection.json \
    --environment tests/api/environment.json \
    --iteration-data tests/api/user-accounts.csv \
    --reporters cli,json,html \
    --reporter-json-export reports/api-test-results.json \
    --reporter-html-export reports/api-test-report.html \
    --bail

# Check exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All tests passed successfully!"
    echo "📁 Test reports generated:"
    echo "   - JSON: reports/api-test-results.json"
    echo "   - HTML: reports/api-test-report.html"
else
    echo ""
    echo "❌ Some tests failed. Check the reports for details."
    echo "📁 Test reports generated:"
    echo "   - JSON: reports/api-test-results.json"
    echo "   - HTML: reports/api-test-report.html"
fi

echo ""
echo "🎯 Test execution completed!"
echo "📊 Reports available in the 'reports' directory" 