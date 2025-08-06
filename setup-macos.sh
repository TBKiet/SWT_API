#!/bin/bash

# ==============================================================================
# Setup Script cho API Automation Tests trên macOS M3 Pro
# ==============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================${NC}"
echo -e "${CYAN}Setup API Automation Tests cho macOS M3 Pro${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}[INSTALL] Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${GREEN}[INFO] Homebrew already installed${NC}"
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}[INSTALL] Installing Node.js...${NC}"
    brew install node
else
    echo -e "${GREEN}[INFO] Node.js already installed${NC}"
    echo -e "${GRAY}  Version: $(node --version)${NC}"
fi

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo -e "${RED}[ERROR] npm not found. Please install Node.js first.${NC}"
    exit 1
fi

# Install Newman and HTML reporter
echo -e "${YELLOW}[INSTALL] Installing Newman and HTML reporter...${NC}"
npm install -g newman newman-reporter-htmlextra

# Verify Newman installation
if command -v newman &> /dev/null; then
    echo -e "${GREEN}[SUCCESS] Newman installed successfully${NC}"
    echo -e "${GRAY}  Version: $(newman --version)${NC}"
else
    echo -e "${RED}[ERROR] Newman installation failed${NC}"
    exit 1
fi

# Create necessary directories
echo -e "${YELLOW}[SETUP] Creating directories...${NC}"
mkdir -p reports
mkdir -p tests/collection
mkdir -p tests/data
mkdir -p tests/environments

# Make script executable
echo -e "${YELLOW}[SETUP] Making scripts executable...${NC}"
chmod +x run-api-tests.sh

# Check if test files exist
echo -e "${YELLOW}[VERIFY] Checking test files...${NC}"

test_files=(
    "tests/collection/totp-tests.postman_collection.json"
    "tests/collection/reports-tests.postman_collection.json"
    "tests/collection/cart-tests.postman_collection.json"
    "tests/data/totp-data.csv"
    "tests/data/reports-data.csv"
    "tests/data/cart-data.csv"
    "tests/environments/environment.json"
)

all_files_exist=true
for file in "${test_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}  ✓ $file${NC}"
    else
        echo -e "${RED}  ✗ $file (missing)${NC}"
        all_files_exist=false
    fi
done

echo ""
echo -e "${BLUE}============================================${NC}"
if [[ "$all_files_exist" == true ]]; then
    echo -e "${GREEN}[SUCCESS] Setup completed successfully!${NC}"
    echo -e "${CYAN}[INFO] You can now run: ./run-api-tests.sh${NC}"
else
    echo -e "${YELLOW}[WARNING] Setup completed but some test files are missing${NC}"
    echo -e "${CYAN}[INFO] Please ensure all test files are in place before running tests${NC}"
fi
echo -e "${BLUE}============================================${NC}"
echo ""
echo -e "${CYAN}[NEXT STEPS]${NC}"
echo -e "${GRAY}1. Start your API server on http://localhost:8091${NC}"
echo -e "${GRAY}2. Run: ./run-api-tests.sh${NC}"
echo -e "${GRAY}3. Check reports in the reports/ directory${NC}"
echo "" 