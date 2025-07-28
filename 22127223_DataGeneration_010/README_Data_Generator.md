# Data Generation Tool for Sign In and Sign Up Features

This tool generates 500 test data rows for comprehensive testing of the sign in and sign up features in the sprint5-with-bugs application.

## Features

- **500 Test Data Rows**: Comprehensive coverage of all testing scenarios
- **Multiple Scenarios**: Valid data, invalid data, security testing, boundary testing
- **All Input Fields**: Covers all 11 fields in the sign up form and 2 fields in sign in
- **Realistic Data**: Uses realistic names, emails, addresses, and phone numbers
- **Security Testing**: Includes SQL injection and XSS attack test data
- **CSV Output**: Generates a properly formatted CSV file

## Files Included

- `data_generator.py` - Main Python script
- `run_generator.bat` - Windows batch script (double-click to run)
- `run_generator.sh` - macOS/Linux shell script
- `README_Data_Generator.md` - This instruction file

## Requirements

- Python 3.6 or higher
- No additional packages required (uses only standard library)

## How to Use

### Option 1: Using the Script Files (Recommended)

**Windows:**
1. Double-click `run_generator.bat`
2. The tool will run automatically and generate the CSV file

**macOS/Linux:**
1. Open terminal in the project directory
2. Run: `chmod +x run_generator.sh`
3. Run: `./run_generator.sh`

### Option 2: Direct Python Execution

1. Open terminal/command prompt in the project directory
2. Run: `python data_generator.py` (Windows) or `python3 data_generator.py` (macOS/Linux)

## Output

The tool generates a file called `500_test_data_rows.csv` with the following columns:

- **Test Data ID**: Unique identifier (TD001, TD002, etc.)
- **Scenario**: Test scenario type
- **Field Name**: Input field being tested
- **Test Data**: Actual test data value
- **Data Type**: Data type (String)
- **Validation Rule**: Validation rules for the field
- **Expected Result**: Expected outcome (Valid/Invalid)
- **Notes**: Description of the test case

## Test Data Distribution

The tool generates data with the following distribution:

- **Valid Sign Up**: 100 rows (20%)
- **Valid Sign In**: 50 rows (10%)
- **Empty Field**: 75 rows (15%)
- **Invalid Format**: 75 rows (15%)
- **Password Testing**: 50 rows (10%)
- **Boundary Value**: 25 rows (5%)
- **Special Characters**: 25 rows (5%)
- **Unicode Characters**: 25 rows (5%)
- **Security Testing**: 30 rows (6%)
- **Data Quality**: 45 rows (9%)

## Scenarios Covered

### Happy Path Testing
- Valid user registration with all fields
- Valid user login with correct credentials

### Negative Testing
- Empty required fields
- Invalid email formats
- Invalid name formats (numbers, special characters)
- Invalid phone formats
- Password length violations

### Security Testing
- SQL injection attempts
- XSS attack payloads
- Malicious input patterns

### Boundary Testing
- Password length at minimum and maximum boundaries
- Input length limits

### Data Quality Testing
- Special characters in names
- Unicode characters
- Whitespace handling
- Leading/trailing spaces
- Null values
- Very long inputs

## Input Fields Covered

### Sign Up Form (11 fields)
1. first_name
2. last_name
3. email
4. password
5. phone
6. dob (date of birth)
7. address
8. city
9. state
10. country
11. postcode

### Sign In Form (2 fields)
1. email
2. password

## Validation Rules

- **first_name**: Required + Letters only
- **last_name**: Required + Letters only
- **email**: Required + Email format
- **password**: Required + 9-40 characters
- **phone**: Required + Numbers only
- **Other fields**: Required

## Example Output

```csv
Test Data ID,Scenario,Field Name,Test Data,Data Type,Validation Rule,Expected Result,Notes
TD001,Valid Sign Up,first_name,John,String,Required + Letters only,Valid,Standard valid input
TD002,Valid Sign Up,last_name,Smith,String,Required + Letters only,Valid,Standard valid input
TD003,Valid Sign Up,email,john.smith123@gmail.com,String,Required + Email format,Valid,Standard valid email
TD004,Empty Field,first_name,,String,Required,Invalid,Empty required field
TD005,Invalid Format,email,invalid-email,String,Required + Email format,Invalid,Invalid email format
```

## Customization

You can modify the `data_generator.py` file to:

- Change the number of rows generated
- Adjust the distribution of scenarios
- Add new test scenarios
- Modify the test data values
- Change the output format

## Troubleshooting

**Python not found:**
- Make sure Python is installed and in your PATH
- Try using `python3` instead of `python`

**Permission denied (macOS/Linux):**
- Run: `chmod +x run_generator.sh`

**File not found:**
- Make sure you're in the correct directory
- Check that all files are present

## Support

This tool is designed specifically for the sprint5-with-bugs application's sign in and sign up features. The generated data follows the validation rules and testing scenarios identified in the application's source code.

---

**Generated for:** Data Generation and Scenario Testing Homework  
**Application:** sprint5-with-bugs  
**Features:** Sign In and Sign Up 