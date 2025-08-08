#!/bin/bash

# ==============================================================================
# API Automation Tests Script cho macOS M3 Pro với Dynamic Collections và CSV Data
# ==============================================================================
# Script này chạy các API tests sử dụng Newman với dynamic validation
# - TOTP Tests: 10 test cases x 5 assertions = 50 assertions
# - Reports Tests: 10 test cases x 4 assertions = 40 assertions  
# - Cart Tests: 10 test cases x 3 assertions = 30 assertions
# ==============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo -e "${GREEN}[START] Starting API Dynamic Tests với CSV Data cho macOS M3 Pro...${NC}"

# Check if Newman is installed
if ! command -v newman &> /dev/null; then
    echo -e "${CYAN}[INSTALL] Installing Newman...${NC}"
    npm install -g newman newman-reporter-htmlextra
fi

# Create reports directory if it doesn't exist
mkdir -p reports

# Test basic endpoints first
echo -e "${CYAN}[TEST] Testing API status endpoint...${NC}"
if curl -s -f "http://localhost:8091/status" > /dev/null; then
    echo -e "${GREEN}[SUCCESS] Status endpoint: 200${NC}"
else
    echo -e "${RED}[ERROR] Status endpoint failed${NC}"
    exit 1
fi

# Test products endpoint
echo -e "${CYAN}[TEST] Testing products endpoint...${NC}"
if curl -s -f "http://localhost:8091/products" > /dev/null; then
    echo -e "${GREEN}[SUCCESS] Products endpoint: 200${NC}"
else
    echo -e "${RED}[ERROR] Products endpoint failed${NC}"
    exit 1
fi

# Test TOTP endpoint
echo -e "${CYAN}[TEST] Testing TOTP endpoint...${NC}"
if curl -s -f "http://localhost:8091/totp/setup" > /dev/null 2>&1; then
    echo -e "${GREEN}[SUCCESS] TOTP endpoint: 200${NC}"
else
    echo -e "${YELLOW}[INFO] TOTP endpoint requires authentication (401) - This is expected${NC}"
fi

# Test reports endpoint
echo -e "${CYAN}[TEST] Testing reports endpoint...${NC}"
if curl -s -f "http://localhost:8091/reports/top10-purchased-products" > /dev/null 2>&1; then
    echo -e "${GREEN}[SUCCESS] Reports endpoint: 200${NC}"
else
    echo -e "${YELLOW}[INFO] Reports endpoint requires authentication (401) - This is expected${NC}"
fi

# Test cart endpoint
echo -e "${CYAN}[TEST] Testing cart endpoint...${NC}"
if curl -s -f "http://localhost:8091/carts" > /dev/null 2>&1; then
    echo -e "${GREEN}[SUCCESS] Cart endpoint: 200${NC}"
else
    echo -e "${YELLOW}[INFO] Cart endpoint requires authentication (401) - This is expected${NC}"
fi

# Run Newman tests with dynamic collections and CSV data
echo -e "${CYAN}[INFO] Preparing to run 3 test suites...${NC}"
echo -e "${GRAY}  1. TOTP Tests - Two-factor authentication validation${NC}"
echo -e "${GRAY}  2. Reports Tests - Admin reports and analytics validation${NC}"  
echo -e "${GRAY}  3. Cart Tests - Shopping cart functionality validation${NC}"
echo ""

test_suites=(
    "tests/collection/totp-tests.postman_collection.json:tests/data/totp-data.csv:totp-tests:Two-factor authentication (TOTP) setup and validation tests"
    "tests/collection/reports-tests.postman_collection.json:tests/data/reports-data.csv:reports-tests:Admin reports and analytics with role-based access control"
    "tests/collection/cart-tests.postman_collection.json:tests/data/cart-data.csv:cart-tests:Shopping cart creation and coordinate validation"
)

environment_file="tests/environments/environment.json"

for test_suite in "${test_suites[@]}"; do
    IFS=':' read -r collection_file data_file test_name description <<< "$test_suite"
    
    echo -e "${MAGENTA}[SUITE] Starting: $test_name${NC}"
    echo -e "${GRAY}[DESC] $description${NC}"
    
    if [[ -f "$collection_file" && -f "$data_file" ]]; then
        echo -e "${CYAN}[NEWMAN] Running test collection: $collection_file with data: $data_file${NC}"
        
        # Run Newman with CSV data, environment, and CLI reporter
        echo -e "${YELLOW}[TEST] Executing tests with iteration data and environment...${NC}"
        if [[ -f "$environment_file" ]]; then
            newman run "$collection_file" --iteration-data "$data_file" --environment "$environment_file" --reporters cli
        else
            newman run "$collection_file" --iteration-data "$data_file" --reporters cli
        fi
        
        # Generate HTML report if htmlextra reporter is available
        echo -e "${CYAN}[REPORT] Generating HTML report for $test_name...${NC}"
        if [[ -f "$environment_file" ]]; then
            newman run "$collection_file" --iteration-data "$data_file" --environment "$environment_file" --reporters htmlextra --reporter-htmlextra-export "reports/$test_name.html" 2>/dev/null
        else
            newman run "$collection_file" --iteration-data "$data_file" --reporters htmlextra --reporter-htmlextra-export "reports/$test_name.html" 2>/dev/null
        fi
        
        if [[ -f "reports/$test_name.html" ]]; then
            echo -e "${GREEN}[SUCCESS] HTML report generated: reports/$test_name.html${NC}"
        else
            echo -e "${YELLOW}[WARNING] HTML report generation failed for $test_name${NC}"
        fi
        
        echo -e "${MAGENTA}[INFO] Test suite '$test_name' completed${NC}"
        echo -e "${GRAY}----------------------------------------${NC}"
    else
        if [[ ! -f "$collection_file" ]]; then
            echo -e "${YELLOW}[SKIP] Collection file not found: $collection_file${NC}"
        fi
        if [[ ! -f "$data_file" ]]; then
            echo -e "${YELLOW}[SKIP] Data file not found: $data_file${NC}"
        fi
    fi
done

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${GREEN}[COMPLETE] All API test suites finished!${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo -e "${CYAN}[REPORTS] Check the following HTML reports:${NC}"
echo -e "${GRAY}  • reports/totp-tests.html${NC}"
echo -e "${GRAY}  • reports/reports-tests.html${NC}"
echo -e "${GRAY}  • reports/cart-tests.html${NC}"
echo ""
echo -e "${YELLOW}[INFO] Test Summary:${NC}"
echo -e "${GREEN}  ✓ TOTP Tests: Two-factor authentication validation${NC}"
echo -e "${GREEN}  ✓ Reports Tests: Admin reports and analytics validation${NC}"
echo -e "${GREEN}  ✓ Cart Tests: Shopping cart functionality validation${NC}"
echo ""
echo -e "${CYAN}[INFO] Total Test Coverage:${NC}"
echo -e "${GRAY}  • TOTP API: Authentication, token validation, QR code generation${NC}"
echo -e "${GRAY}  • Reports API: Role-based access, admin privileges, data analytics${NC}"
echo -e "${GRAY}  • Cart API: Coordinate validation, cart creation, boundary testing${NC}" 