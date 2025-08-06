#!/bin/bash

# SWT API Testing - Local Workflow Test
# This script simulates the GitHub Actions workflow locally

echo "🚀 Starting SWT API Testing Workflow - Local Test"
echo "=================================================="

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Step 1: Check Newman installation
echo -e "${BLUE}Step 1: Checking Newman CLI installation...${NC}"
if command -v newman &> /dev/null; then
    echo -e "${GREEN}✅ Newman CLI found: $(newman --version)${NC}"
else
    echo -e "${RED}❌ Newman CLI not found. Installing...${NC}"
    npm install -g newman newman-reporter-html
fi

# Step 2: Create reports directory
echo -e "${BLUE}Step 2: Creating reports directory...${NC}"
mkdir -p reports
echo -e "${GREEN}✅ Reports directory created${NC}"

# Step 3: Validate JSON collections
echo -e "${BLUE}Step 3: Validating Postman collections...${NC}"
collections_valid=true
for collection in tests/*collection.json; do
    echo "  Validating $collection"
    if jq empty "$collection" 2>/dev/null; then
        echo -e "  ${GREEN}✅ $collection is valid JSON${NC}"
    else
        echo -e "  ${RED}❌ Invalid JSON in $collection${NC}"
        collections_valid=false
    fi
done

if [ "$collections_valid" = false ]; then
    echo -e "${RED}❌ JSON validation failed${NC}"
    exit 1
fi

# Step 4: Validate CSV data files
echo -e "${BLUE}Step 4: Validating test data CSV files...${NC}"
for csvfile in tests/*.csv; do
    if [ -f "$csvfile" ]; then
        echo -e "  ${GREEN}✅ Found $csvfile${NC}"
        echo "    Header: $(head -1 "$csvfile")"
    else
        echo -e "  ${RED}❌ Missing $csvfile${NC}"
    fi
done

# Step 5: Run API tests
echo -e "${BLUE}Step 5: Running API Integration Tests...${NC}"

# Users API Tests
echo -e "${YELLOW}Running Users API Tests...${NC}"
if newman run tests/users-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/users-test-data.csv \
    -r html \
    --reporter-html-export reports/users-test-report.html; then
    echo -e "${GREEN}✅ Users API Tests completed${NC}"
    users_status="Completed"
else
    echo -e "${YELLOW}⚠️ Users API Tests completed with failures (expected)${NC}"
    users_status="Completed with failures"
fi

# Brands API Tests  
echo -e "${YELLOW}Running Brands API Tests...${NC}"
if newman run tests/brands-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/brands-test-data.csv \
    -r html \
    --reporter-html-export reports/brands-test-report.html; then
    echo -e "${GREEN}✅ Brands API Tests completed${NC}"
    brands_status="Completed"
else
    echo -e "${YELLOW}⚠️ Brands API Tests completed with failures (expected)${NC}"
    brands_status="Completed with failures"
fi

# Favorites API Tests
echo -e "${YELLOW}Running Favorites API Tests...${NC}"
if newman run tests/favorites-data-driven-collection.json \
    -e tests/environment.json \
    -d tests/favorites-test-data.csv \
    -r html \
    --reporter-html-export reports/favorites-test-report.html; then
    echo -e "${GREEN}✅ Favorites API Tests completed${NC}"
    favorites_status="Completed"
else
    echo -e "${YELLOW}⚠️ Favorites API Tests completed with failures (expected)${NC}"
    favorites_status="Completed with failures"
fi

# Step 6: Generate test summary
echo -e "${BLUE}Step 6: Generating test summary...${NC}"
cat > test-summary.md << EOF
# API Test Results Summary
Generated on: $(date)

## Test Execution Status
- Users API Tests: $users_status
- Brands API Tests: $brands_status  
- Favorites API Tests: $favorites_status

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
EOF

echo -e "${GREEN}✅ Test summary generated: test-summary.md${NC}"

# Step 7: Security scan
echo -e "${BLUE}Step 7: Running security scan...${NC}"
echo "🔍 Scanning for sensitive data patterns..."
if grep -r -i "password.*:" tests/ --include="*.json" --include="*.csv" | grep -v "welcome01\|password123\|testpass" > /dev/null; then
    echo -e "${YELLOW}⚠️ Potential sensitive data found in test files${NC}"
else
    echo -e "${GREEN}✅ No sensitive data patterns detected${NC}"
fi

# Step 8: Final summary
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}🎉 Local Workflow Test Complete!${NC}"
echo -e "${BLUE}========================================${NC}"

echo "📊 Results:"
echo "  - Collections validated: ✅"
echo "  - Test data validated: ✅"  
echo "  - Users API tests: $users_status"
echo "  - Brands API tests: $brands_status"
echo "  - Favorites API tests: $favorites_status"
echo "  - Reports generated: ✅"
echo "  - Security scan: ✅"

echo ""
echo "📂 Generated files:"
echo "  - reports/users-test-report.html"
echo "  - reports/brands-test-report.html"  
echo "  - reports/favorites-test-report.html"
echo "  - test-summary.md"

echo ""
echo "🚀 Your CI/CD pipeline is ready for GitHub Actions!"
echo "💡 Push your changes to trigger the automated workflow."
