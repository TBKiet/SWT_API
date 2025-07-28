#!/usr/bin/env python3
"""
Data Generation Tool for Sign In and Sign Up Features
Generates 500 test data rows for comprehensive testing
"""

import csv
import random
import string
from datetime import datetime, timedelta
import re

class TestDataGenerator:
    def __init__(self):
        self.test_data_id = 1
        self.first_names = [
            "John", "Jane", "Michael", "Sarah", "David", "Emily", "Robert", "Lisa",
            "James", "Jennifer", "William", "Jessica", "Richard", "Amanda", "Thomas",
            "Nicole", "Christopher", "Stephanie", "Daniel", "Melissa", "Matthew",
            "Ashley", "Anthony", "Elizabeth", "Mark", "Megan", "Donald", "Lauren",
            "Steven", "Rachel", "Paul", "Kayla", "Andrew", "Amber", "Joshua",
            "Brittany", "Kenneth", "Danielle", "Kevin", "Rebecca", "Brian", "Michelle"
        ]
        
        self.last_names = [
            "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller",
            "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez",
            "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin",
            "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark",
            "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King",
            "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green"
        ]
        
        self.domains = [
            "gmail.com", "yahoo.com", "hotmail.com", "outlook.com", "aol.com",
            "icloud.com", "protonmail.com", "mail.com", "live.com", "msn.com"
        ]
        
        self.cities = [
            "New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia",
            "San Antonio", "San Diego", "Dallas", "San Jose", "Austin", "Jacksonville",
            "Fort Worth", "Columbus", "Charlotte", "San Francisco", "Indianapolis",
            "Seattle", "Denver", "Washington", "Boston", "El Paso", "Nashville",
            "Detroit", "Oklahoma City", "Portland", "Las Vegas", "Memphis", "Louisville"
        ]
        
        self.states = [
            "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID",
            "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS",
            "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK",
            "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
        ]
        
        self.countries = [
            "United States", "Canada", "United Kingdom", "Germany", "France",
            "Australia", "Japan", "Italy", "Spain", "Brazil", "Mexico", "India",
            "China", "South Korea", "Netherlands", "Sweden", "Switzerland", "Norway"
        ]

    def generate_test_data_id(self):
        """Generate unique test data ID"""
        return f"TD{self.test_data_id:03d}"

    def generate_scenario(self):
        """Generate test scenario"""
        scenarios = [
            "Valid Sign Up", "Valid Sign In", "Empty Field", "Invalid Format",
            "Password Too Short", "Password Too Long", "Boundary Value",
            "Special Characters", "Unicode Characters", "SQL Injection",
            "XSS Attack", "Very Long Input", "Whitespace Only",
            "Leading/Trailing Spaces", "Null Values", "Duplicate Email",
            "Invalid Email Format", "Invalid Name Format", "Invalid Phone Format",
            "Password Boundary", "Security Attack", "Data Quality", "Performance Test"
        ]
        return random.choice(scenarios)

    def generate_field_name(self):
        """Generate field name"""
        fields = [
            "first_name", "last_name", "email", "password", "phone", "dob",
            "address", "city", "state", "country", "postcode"
        ]
        return random.choice(fields)

    def generate_valid_first_name(self):
        """Generate valid first name"""
        return random.choice(self.first_names)

    def generate_valid_last_name(self):
        """Generate valid last name"""
        return random.choice(self.last_names)

    def generate_valid_email(self):
        """Generate valid email"""
        first_name = random.choice(self.first_names).lower()
        last_name = random.choice(self.last_names).lower()
        domain = random.choice(self.domains)
        number = random.randint(1, 999)
        return f"{first_name}.{last_name}{number}@{domain}"

    def generate_valid_password(self):
        """Generate valid password"""
        length = random.randint(9, 40)
        chars = string.ascii_letters + string.digits + "!@#$%^&*"
        return ''.join(random.choice(chars) for _ in range(length))

    def generate_valid_phone(self):
        """Generate valid phone number"""
        return str(random.randint(1000000000, 9999999999))

    def generate_valid_dob(self):
        """Generate valid date of birth"""
        start_date = datetime(1950, 1, 1)
        end_date = datetime(2005, 12, 31)
        time_between_dates = end_date - start_date
        days_between_dates = time_between_dates.days
        random_number_of_days = random.randrange(days_between_dates)
        random_date = start_date + timedelta(days=random_number_of_days)
        return random_date.strftime("%Y-%m-%d")

    def generate_valid_address(self):
        """Generate valid address"""
        number = random.randint(1, 9999)
        streets = ["Main St", "Oak Ave", "Pine Rd", "Elm St", "Maple Dr", "Cedar Ln"]
        street = random.choice(streets)
        return f"{number} {street}"

    def generate_valid_city(self):
        """Generate valid city"""
        return random.choice(self.cities)

    def generate_valid_state(self):
        """Generate valid state"""
        return random.choice(self.states)

    def generate_valid_country(self):
        """Generate valid country"""
        return random.choice(self.countries)

    def generate_valid_postcode(self):
        """Generate valid postcode"""
        return str(random.randint(10000, 99999))

    def generate_invalid_data(self, field_name):
        """Generate invalid data based on field"""
        if field_name == "first_name":
            invalid_types = [
                "",  # Empty
                "John123",  # Contains numbers
                "John-Doe",  # Contains special chars
                "José",  # Unicode
                "   ",  # Whitespace only
                " John ",  # Leading/trailing spaces
                "<script>alert('xss')</script>",  # XSS
                "' OR '1'='1",  # SQL injection
                "VeryLongFirstNameThatExceedsNormalLengthLimits",  # Too long
                None  # Null
            ]
            return random.choice(invalid_types)
        
        elif field_name == "last_name":
            invalid_types = [
                "",  # Empty
                "Doe456",  # Contains numbers
                "O'Connor",  # Contains special chars
                "Schröder",  # Unicode
                "   ",  # Whitespace only
                " Doe ",  # Leading/trailing spaces
                "<script>alert('xss')</script>",  # XSS
                "' OR '1'='1",  # SQL injection
                "VeryLongLastNameThatExceedsNormalLengthLimits",  # Too long
                None  # Null
            ]
            return random.choice(invalid_types)
        
        elif field_name == "email":
            invalid_types = [
                "",  # Empty
                "invalid-email",  # Invalid format
                " john@example.com ",  # Leading/trailing spaces
                "   ",  # Whitespace only
                "<script>alert('xss')</script>@example.com",  # XSS
                "' OR '1'='1",  # SQL injection
                "verylongemailaddress@verylongdomainname.com",  # Very long
                "existing@example.com",  # Duplicate
                None  # Null
            ]
            return random.choice(invalid_types)
        
        elif field_name == "password":
            invalid_types = [
                "",  # Empty
                "short",  # Too short
                "verylongpasswordthatiswaytoolongandshouldfailvalidation",  # Too long
                "12345678",  # Boundary min-1
                "12345678901234567890123456789012345678901",  # Boundary max+1
                "<script>alert('xss')</script>",  # XSS
                "' OR '1'='1",  # SQL injection
                "   ",  # Whitespace only
                None  # Null
            ]
            return random.choice(invalid_types)
        
        elif field_name == "phone":
            invalid_types = [
                "",  # Empty
                "abc123def",  # Contains letters
                "   ",  # Whitespace only
                " 1234567890 ",  # Leading/trailing spaces
                None  # Null
            ]
            return random.choice(invalid_types)
        
        else:  # Other fields
            invalid_types = [
                "",  # Empty
                "   ",  # Whitespace only
                " value ",  # Leading/trailing spaces
                None  # Null
            ]
            return random.choice(invalid_types)

    def generate_test_data(self, field_name, scenario):
        """Generate test data based on field and scenario"""
        if "Valid" in scenario:
            if field_name == "first_name":
                return self.generate_valid_first_name()
            elif field_name == "last_name":
                return self.generate_valid_last_name()
            elif field_name == "email":
                return self.generate_valid_email()
            elif field_name == "password":
                return self.generate_valid_password()
            elif field_name == "phone":
                return self.generate_valid_phone()
            elif field_name == "dob":
                return self.generate_valid_dob()
            elif field_name == "address":
                return self.generate_valid_address()
            elif field_name == "city":
                return self.generate_valid_city()
            elif field_name == "state":
                return self.generate_valid_state()
            elif field_name == "country":
                return self.generate_valid_country()
            elif field_name == "postcode":
                return self.generate_valid_postcode()
        else:
            return self.generate_invalid_data(field_name)

    def get_data_type(self, field_name):
        """Get data type for field"""
        return "String"

    def get_validation_rule(self, field_name):
        """Get validation rule for field"""
        rules = {
            "first_name": "Required + Letters only",
            "last_name": "Required + Letters only",
            "email": "Required + Email format",
            "password": "Required + 9-40 chars",
            "phone": "Required + Numbers only",
            "dob": "Required",
            "address": "Required",
            "city": "Required",
            "state": "Required",
            "country": "Required",
            "postcode": "Required"
        }
        return rules.get(field_name, "Required")

    def get_expected_result(self, scenario, field_name):
        """Get expected result based on scenario and field"""
        if "Valid" in scenario:
            return "Valid"
        else:
            return "Invalid"

    def get_notes(self, scenario, field_name, test_data):
        """Get notes for test data"""
        if "Valid" in scenario:
            return "Standard valid input"
        elif "Empty" in scenario:
            return "Empty required field"
        elif "Invalid Format" in scenario:
            return "Invalid format"
        elif "Password Too Short" in scenario:
            return "Below minimum length"
        elif "Password Too Long" in scenario:
            return "Above maximum length"
        elif "Boundary" in scenario:
            return "Boundary value testing"
        elif "Special Characters" in scenario:
            return "Contains special characters"
        elif "Unicode" in scenario:
            return "Contains unicode characters"
        elif "SQL Injection" in scenario:
            return "SQL injection attempt"
        elif "XSS" in scenario:
            return "XSS attack attempt"
        elif "Very Long" in scenario:
            return "Exceeds reasonable length"
        elif "Whitespace" in scenario:
            return "Only whitespace"
        elif "Leading/Trailing" in scenario:
            return "Contains spaces"
        elif "Null" in scenario:
            return "Null value"
        elif "Duplicate" in scenario:
            return "Duplicate email in system"
        else:
            return "Test case"

    def generate_500_rows(self):
        """Generate 500 test data rows"""
        rows = []
        
        # Generate distribution of scenarios
        scenario_distribution = {
            "Valid Sign Up": 100,  # 20%
            "Valid Sign In": 50,   # 10%
            "Empty Field": 75,     # 15%
            "Invalid Format": 75,  # 15%
            "Password Too Short": 25,  # 5%
            "Password Too Long": 25,   # 5%
            "Boundary Value": 25,      # 5%
            "Special Characters": 25,  # 5%
            "Unicode Characters": 25,  # 5%
            "SQL Injection": 15,       # 3%
            "XSS Attack": 15,          # 3%
            "Very Long Input": 15,     # 3%
            "Whitespace Only": 15,     # 3%
            "Leading/Trailing Spaces": 15,  # 3%
            "Null Values": 15,         # 3%
            "Duplicate Email": 10      # 2%
        }
        
        # Generate rows based on distribution
        for scenario, count in scenario_distribution.items():
            for _ in range(count):
                field_name = self.generate_field_name()
                test_data = self.generate_test_data(field_name, scenario)
                
                # Handle None values for CSV
                if test_data is None:
                    test_data = "null"
                
                row = [
                    self.generate_test_data_id(),
                    scenario,
                    field_name,
                    test_data,
                    self.get_data_type(field_name),
                    self.get_validation_rule(field_name),
                    self.get_expected_result(scenario, field_name),
                    self.get_notes(scenario, field_name, test_data)
                ]
                rows.append(row)
                self.test_data_id += 1
        
        # Add remaining rows to reach 500
        remaining = 500 - len(rows)
        for _ in range(remaining):
            scenario = self.generate_scenario()
            field_name = self.generate_field_name()
            test_data = self.generate_test_data(field_name, scenario)
            
            if test_data is None:
                test_data = "null"
            
            row = [
                self.generate_test_data_id(),
                scenario,
                field_name,
                test_data,
                self.get_data_type(field_name),
                self.get_validation_rule(field_name),
                self.get_expected_result(scenario, field_name),
                self.get_notes(scenario, field_name, test_data)
            ]
            rows.append(row)
            self.test_data_id += 1
        
        return rows

def main():
    """Main function to generate and save test data"""
    print("Generating 500 test data rows for Sign In and Sign Up features...")
    
    generator = TestDataGenerator()
    rows = generator.generate_500_rows()
    
    # Write to CSV file
    filename = "500_test_data_rows.csv"
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        
        # Write header
        writer.writerow([
            'Test Data ID', 'Scenario', 'Field Name', 'Test Data', 
            'Data Type', 'Validation Rule', 'Expected Result', 'Notes'
        ])
        
        # Write data rows
        writer.writerows(rows)
    
    print(f"Successfully generated {len(rows)} test data rows!")
    print(f"File saved as: {filename}")
    
    # Print summary
    scenarios = {}
    fields = {}
    for row in rows:
        scenario = row[1]
        field = row[2]
        scenarios[scenario] = scenarios.get(scenario, 0) + 1
        fields[field] = fields.get(field, 0) + 1
    
    print("\n=== SUMMARY ===")
    print(f"Total rows generated: {len(rows)}")
    print(f"Unique scenarios: {len(scenarios)}")
    print(f"Unique fields: {len(fields)}")
    
    print("\n=== SCENARIO DISTRIBUTION ===")
    for scenario, count in sorted(scenarios.items()):
        percentage = (count / len(rows)) * 100
        print(f"{scenario}: {count} rows ({percentage:.1f}%)")
    
    print("\n=== FIELD DISTRIBUTION ===")
    for field, count in sorted(fields.items()):
        percentage = (count / len(rows)) * 100
        print(f"{field}: {count} rows ({percentage:.1f}%)")

if __name__ == "__main__":
    main() 