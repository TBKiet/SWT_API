#!/bin/bash

# ==============================================================================
# Script Chạy API Testing Tự Động - Phiên bản Tiếng Việt
# ==============================================================================
# Tác giả: API Testing Team
# Mô tả: Script tự động chạy các test suite API với Newman
# Hỗ trợ: Brands, Users, Favorites APIs
# ==============================================================================

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Biểu tượng
CHECK_MARK="✅"
CROSS_MARK="❌"
WARNING="⚠️"
ROCKET="🚀"
GEAR="⚙️"
REPORT="📊"
BUG="🐛"

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                    ${ROCKET} API TESTING AUTOMATION ${ROCKET}                    ║${NC}"
echo -e "${CYAN}║                        Script Tiếng Việt                      ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Kiểm tra Newman
check_newman() {
    echo -e "${BLUE}${GEAR} Kiểm tra Newman...${NC}"
    if ! command -v newman &> /dev/null; then
        echo -e "${YELLOW}${WARNING} Newman chưa được cài đặt!${NC}"
        echo -e "${CYAN}${GEAR} Đang cài đặt Newman và HTML reporter...${NC}"
        npm install -g newman newman-reporter-htmlextra
        echo -e "${GREEN}${CHECK_MARK} Newman đã được cài đặt thành công!${NC}"
    else
        echo -e "${GREEN}${CHECK_MARK} Newman đã sẵn sàng!${NC}"
    fi
    echo ""
}

# Tạo thư mục reports
create_reports_dir() {
    if [ ! -d "reports" ]; then
        mkdir -p reports
        echo -e "${GREEN}${CHECK_MARK} Đã tạo thư mục reports/${NC}"
    fi
}

# Kiểm tra API server
check_api_server() {
    echo -e "${BLUE}${GEAR} Kiểm tra kết nối API server...${NC}"
    
    # Đọc URL từ environment.json
    if [ -f "tests/environment.json" ]; then
        API_BASE_URL=$(grep -o '"baseUrl": "[^"]*"' tests/environment.json | grep -o 'http[^"]*')
        echo -e "${CYAN}API Base URL: ${API_BASE_URL}${NC}"
        
        # Test các endpoint chính
        endpoints=("/status" "/products" "/brands")
        
        for endpoint in "${endpoints[@]}"; do
            response=$(curl -s -o /dev/null -w "%{http_code}" "${API_BASE_URL}${endpoint}" 2>/dev/null || echo "000")
            if [ "$response" = "200" ]; then
                echo -e "${GREEN}${CHECK_MARK} ${endpoint}: ${response}${NC}"
            elif [ "$response" = "401" ] || [ "$response" = "404" ]; then
                echo -e "${YELLOW}${WARNING} ${endpoint}: ${response} (Yêu cầu xác thực hoặc không tìm thấy)${NC}"
            else
                echo -e "${RED}${CROSS_MARK} ${endpoint}: ${response} (Lỗi kết nối)${NC}"
            fi
        done
    else
        echo -e "${RED}${CROSS_MARK} Không tìm thấy file environment.json${NC}"
    fi
    echo ""
}

# Chạy test suite
run_test_suite() {
    local collection=$1
    local data_file=$2
    local report_name=$3
    local description=$4
    
    echo -e "${MAGENTA}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}${ROCKET} CHẠY TEST: ${description}${NC}"
    echo -e "${MAGENTA}════════════════════════════════════════════════════════════════${NC}"
    
    if [ ! -f "$collection" ]; then
        echo -e "${RED}${CROSS_MARK} Không tìm thấy collection: $collection${NC}"
        return 1
    fi
    
    if [ ! -f "$data_file" ]; then
        echo -e "${RED}${CROSS_MARK} Không tìm thấy data file: $data_file${NC}"
        return 1
    fi
    
    # Chạy Newman với báo cáo HTML
    newman run "$collection" \
        -e "tests/environment.json" \
        -d "$data_file" \
        --reporters cli,htmlextra \
        --reporter-htmlextra-export "reports/${report_name}.html" \
        --reporter-htmlextra-title "Báo Cáo Test API - ${description}" \
        --reporter-htmlextra-logs \
        --color on
    
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}${CHECK_MARK} Test ${description} hoàn thành thành công!${NC}"
    else
        echo -e "${YELLOW}${WARNING} Test ${description} hoàn thành với một số lỗi!${NC}"
    fi
    
    echo -e "${CYAN}${REPORT} Báo cáo HTML: reports/${report_name}.html${NC}"
    echo ""
    
    return $exit_code
}

# Hiển thị menu
show_menu() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    ${GEAR} MENU LỰA CHỌN ${GEAR}                         ║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║  1. Chạy tất cả test suites                                 ║${NC}"
    echo -e "${CYAN}║  2. Chạy test Brands API                                    ║${NC}"
    echo -e "${CYAN}║  3. Chạy test Users API                                     ║${NC}"
    echo -e "${CYAN}║  4. Chạy test Favorites API                                 ║${NC}"
    echo -e "${CYAN}║  5. Kiểm tra kết nối API server                             ║${NC}"
    echo -e "${CYAN}║  6. Xem báo cáo trong trình duyệt                           ║${NC}"
    echo -e "${CYAN}║  0. Thoát                                                   ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Chạy tất cả tests
run_all_tests() {
    echo -e "${GREEN}${ROCKET} CHẠY TẤT CẢ TEST SUITES${NC}"
    echo ""
    
    local total_tests=0
    local failed_tests=0
    
    # Test Brands API
    if run_test_suite "tests/brands-data-driven-collection.json" "tests/brands-test-data.csv" "brands-test-report" "Brands API"; then
        ((total_tests++))
    else
        ((total_tests++))
        ((failed_tests++))
    fi
    
    # Test Users API
    if run_test_suite "tests/users-data-driven-collection.json" "tests/users-test-data.csv" "users-test-report" "Users API"; then
        ((total_tests++))
    else
        ((total_tests++))
        ((failed_tests++))
    fi
    
    # Test Favorites API
    if run_test_suite "tests/favorites-data-driven-collection.json" "tests/favorites-test-data.csv" "favorites-test-report" "Favorites API"; then
        ((total_tests++))
    else
        ((total_tests++))
        ((failed_tests++))
    fi
    
    # Tóm tắt kết quả
    echo -e "${MAGENTA}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}${REPORT} TÓM TẮT KẾT QUẢ TEST${NC}"
    echo -e "${MAGENTA}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}Tổng số test suites: ${total_tests}${NC}"
    echo -e "${GREEN}Test suites thành công: $((total_tests - failed_tests))${NC}"
    echo -e "${RED}Test suites có lỗi: ${failed_tests}${NC}"
    
    if [ $failed_tests -eq 0 ]; then
        echo -e "${GREEN}${CHECK_MARK} Tất cả test suites đã chạy thành công!${NC}"
    else
        echo -e "${YELLOW}${WARNING} Có ${failed_tests} test suite(s) gặp lỗi. Vui lòng kiểm tra báo cáo chi tiết.${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}${REPORT} Các báo cáo HTML đã được tạo trong thư mục reports/${NC}"
}

# Mở báo cáo trong trình duyệt
open_reports() {
    echo -e "${BLUE}${REPORT} Mở báo cáo trong trình duyệt...${NC}"
    
    if [ -d "reports" ]; then
        echo -e "${CYAN}Các báo cáo có sẵn:${NC}"
        ls -la reports/*.html 2>/dev/null || echo -e "${YELLOW}${WARNING} Chưa có báo cáo nào được tạo!${NC}"
        
        # Mở báo cáo gần nhất
        latest_report=$(ls -t reports/*.html 2>/dev/null | head -1)
        if [ -n "$latest_report" ]; then
            echo -e "${GREEN}${CHECK_MARK} Đang mở báo cáo: $latest_report${NC}"
            open "$latest_report" 2>/dev/null || echo -e "${YELLOW}${WARNING} Không thể mở trình duyệt tự động. Vui lòng mở file báo cáo thủ công.${NC}"
        fi
    else
        echo -e "${RED}${CROSS_MARK} Thư mục reports không tồn tại!${NC}"
    fi
}

# Main function
main() {
    check_newman
    create_reports_dir
    
    while true; do
        show_menu
        echo -ne "${YELLOW}Vui lòng chọn một tùy chọn (0-6): ${NC}"
        read -r choice
        echo ""
        
        case $choice in
            1)
                run_all_tests
                ;;
            2)
                run_test_suite "tests/brands-data-driven-collection.json" "tests/brands-test-data.csv" "brands-test-report" "Brands API"
                ;;
            3)
                run_test_suite "tests/users-data-driven-collection.json" "tests/users-test-data.csv" "users-test-report" "Users API"
                ;;
            4)
                run_test_suite "tests/favorites-data-driven-collection.json" "tests/favorites-test-data.csv" "favorites-test-report" "Favorites API"
                ;;
            5)
                check_api_server
                ;;
            6)
                open_reports
                ;;
            0)
                echo -e "${GREEN}${CHECK_MARK} Cảm ơn bạn đã sử dụng API Testing Script!${NC}"
                echo -e "${CYAN}${ROCKET} Chúc bạn có một ngày tốt lành!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}${CROSS_MARK} Lựa chọn không hợp lệ! Vui lòng chọn từ 0-6.${NC}"
                ;;
        esac
        
        echo -e "${GRAY}Nhấn Enter để tiếp tục...${NC}"
        read -r
        clear
    done
}

# Chạy script
main 