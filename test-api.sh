#!/bin/bash

echo "🧪 Testing Practice Software Testing API"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0

# Function to test API endpoint
test_endpoint() {
    local name="$1"
    local url="$2"
    local expected_status="$3"
    
    echo -e "\n${YELLOW}Testing: $name${NC}"
    echo "URL: $url"
    
    # Make request
    response=$(curl -s -w "%{http_code}" -o /tmp/response.json "$url")
    status_code="${response: -3}"
    response_body=$(cat /tmp/response.json)
    
    echo "Status Code: $status_code"
    
    # Check status code
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}✅ Status code test PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ Status code test FAILED (Expected: $expected_status, Got: $status_code)${NC}"
        ((FAILED++))
    fi
    
    # Check if response is valid JSON
    if echo "$response_body" | jq . >/dev/null 2>&1; then
        echo -e "${GREEN}✅ JSON response test PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ JSON response test FAILED${NC}"
        ((FAILED++))
    fi
    
    # Specific tests for products endpoint
    if [[ "$url" == *"/products"* ]] && [ "$status_code" = "200" ]; then
        # Check if response has data property
        if echo "$response_body" | jq -e '.data' >/dev/null 2>&1; then
            echo -e "${GREEN}✅ Data structure test PASSED${NC}"
            ((PASSED++))
        else
            echo -e "${RED}❌ Data structure test FAILED${NC}"
            ((FAILED++))
        fi
        
        # Check if data is an array
        if echo "$response_body" | jq -e '.data | type == "array"' >/dev/null 2>&1; then
            echo -e "${GREEN}✅ Data array test PASSED${NC}"
            ((PASSED++))
        else
            echo -e "${RED}❌ Data array test FAILED${NC}"
            ((FAILED++))
        fi
    fi
}

# Test endpoints
echo "Starting API tests..."

# Test 1: Get all products
test_endpoint "Get All Products" "http://localhost:8091/products" "200"

# Test 2: Get product by ID
test_endpoint "Get Product by ID" "http://localhost:8091/products/1" "200"

# Test 3: Search products
test_endpoint "Search Products" "http://localhost:8091/products?search=hammer" "200"

# Test 4: Get products with pagination
test_endpoint "Get Products with Pagination" "http://localhost:8091/products?page=1&limit=5" "200"

# Test 5: Get products by category
test_endpoint "Get Products by Category" "http://localhost:8091/products?category=pliers" "200"

# Test 6: Test non-existent product
test_endpoint "Get Non-existent Product" "http://localhost:8091/products/99999" "404"

# Test 7: Test API documentation
test_endpoint "API Documentation" "http://localhost:8091/api/documentation" "200"

# Summary
echo -e "\n${YELLOW}========================================"
echo "TEST SUMMARY"
echo "========================================"
echo -e "Total Tests: $((PASSED + FAILED))"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo -e "Success Rate: $((PASSED * 100 / (PASSED + FAILED)))%${NC}"

# Cleanup
rm -f /tmp/response.json

echo -e "\n${YELLOW}🌐 Access URLs:${NC}"
echo "Frontend: http://localhost:4200"
echo "API: http://localhost:8091"
echo "Swagger: http://localhost:8091/api/documentation"
echo "MailCatcher: http://localhost:1080"
echo "PHPMyAdmin: http://localhost:8000 (root/password)" 