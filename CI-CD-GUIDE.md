# SWT API Testing - CI/CD Setup Guide

This guide provides comprehensive instructions for using the SWT API testing framework with GitHub Actions CI/CD pipeline.

## 🚀 Quick Start

### Prerequisites
- Node.js and npm installed
- Newman CLI: `npm install -g newman newman-reporter-html`
- Git configured with GitHub repository access

### Running Tests Locally

**Windows (PowerShell):**
```powershell
.\test-workflow-local.ps1
```

**Linux/macOS (Bash):**
```bash
chmod +x test-workflow-local.sh
./test-workflow-local.sh
```

## 📋 CI/CD Pipeline Overview

### Automated Triggers
- **Push to main branch**: Full test suite execution
- **Pull requests**: Validation testing
- **Daily schedule**: 6 AM UTC automated testing
- **Manual trigger**: On-demand testing via GitHub Actions

### GitHub Actions Workflows

#### 1. Main API Testing (`api-testing.yml`)
- Triggers: push, pull_request, schedule, manual
- Runs all test suites sequentially
- Generates HTML reports
- Archives test artifacts

#### 2. Manual Test Suite (`manual-test.yml`)
- Manual trigger only
- Allows selection of specific test suite:
  - `users` - Users API testing
  - `brands` - Brands API testing
  - `favorites` - Favorites API testing
  - `all` - Complete test suite

## 🧪 Test Suites

### Users API Tests (`users-data-driven-collection.json`)
- **Test Scenarios**: 10 data-driven test cases
- **Data Source**: `users-test-data.csv`
- **Coverage**:
  - Authentication validation
  - Token verification
  - User data retrieval
  - Error handling

### Brands API Tests (`brands-data-driven-collection.json`)
- **Test Scenarios**: 10 data-driven test cases
- **Data Source**: `brands-test-data.csv`
- **Coverage**:
  - Brand data retrieval
  - Parameter validation
  - Error responses
  - Data filtering

### Favorites API Tests (`favorites-data-driven-collection.json`)
- **Test Scenarios**: 12 data-driven test cases
- **Data Source**: `favorites-test-data.csv`
- **Coverage**:
  - Favorites management
  - Authentication requirements
  - Data validation
  - CRUD operations

## 📊 Test Reports

### HTML Reports
Generated for each test suite:
- `reports/users-test-report.html`
- `reports/brands-test-report.html`
- `reports/favorites-test-report.html`

### Test Summary
- Automated `test-summary.md` generation
- Execution status tracking
- Coverage metrics
- Known issues documentation

## 🐛 Expected Test Failures

The test suite includes strict validation that may result in expected failures:

1. **Status Code Mismatches**
   - Expected: 422 (Unprocessable Entity)
   - Actual: 401 (Unauthorized)

2. **Parameter Validation**
   - Missing API parameter validation
   - Inconsistent error responses

3. **Token Handling**
   - Case sensitivity issues
   - Token format variations

These are documented in `Bug_Report_Final_22127188.csv`

## 🔧 Configuration

### Environment Variables
Set in `tests/environment.json`:
```json
{
  "id": "environment-id",
  "name": "SWT API Testing Environment",
  "values": [
    {
      "key": "baseUrl",
      "value": "http://localhost:8091/api",
      "enabled": true
    },
    {
      "key": "token",
      "value": "your-auth-token",
      "enabled": true
    }
  ]
}
```

### Test Data
CSV files in `tests/` directory:
- `users-test-data.csv` - User authentication scenarios
- `brands-test-data.csv` - Brand API test data
- `favorites-test-data.csv` - Favorites API test data

## 🚀 Deployment Instructions

### 1. Initial Setup
```bash
# Clone repository
git clone https://github.com/TBKiet/SWT_API.git
cd SWT_API

# Install dependencies
npm install -g newman newman-reporter-html
```

### 2. Local Testing
```bash
# Run complete workflow test
./test-workflow-local.sh  # Linux/macOS
# or
.\test-workflow-local.ps1  # Windows
```

### 3. GitHub Integration
```bash
# Add GitHub repository
git remote add origin https://github.com/TBKiet/SWT_API.git

# Push changes
git add .
git commit -m "Add CI/CD pipeline with Newman API testing"
git push origin main
```

### 4. GitHub Actions Setup
1. Navigate to GitHub repository
2. Go to **Actions** tab
3. Enable workflows if prompted
4. Monitor first workflow execution

## 📈 Monitoring & Maintenance

### GitHub Actions Monitoring
- Check **Actions** tab for workflow status
- Review test artifacts and reports
- Monitor failure patterns

### Manual Testing
```bash
# Run specific test suite
newman run tests/users-data-driven-collection.json \
  -e tests/environment.json \
  -d tests/users-test-data.csv \
  -r html \
  --reporter-html-export reports/manual-test.html
```

### Updating Test Data
1. Modify CSV files in `tests/` directory
2. Commit and push changes
3. Automatic CI/CD execution

## 🔒 Security Considerations

### Sensitive Data
- No real credentials in test files
- Use environment variables for tokens
- Regular security scanning included

### Access Control
- GitHub repository access required
- Actions permissions managed via GitHub

## 📞 Support & Troubleshooting

### Common Issues
1. **Newman Command Not Found**
   ```bash
   npm install -g newman newman-reporter-html
   ```

2. **File Path Issues**
   - Ensure forward slashes in GitHub Actions
   - Use proper escaping in Windows

3. **API Server Not Running**
   - Start Docker services: `docker-compose up -d`
   - Verify API endpoint: `http://localhost:8091/api`

### Logs & Debugging
- Check GitHub Actions logs
- Review Newman output
- Validate JSON collections

## 📋 Checklist

### Pre-deployment
- [ ] Newman CLI installed
- [ ] Test collections validated
- [ ] CSV data files present
- [ ] Environment configuration set
- [ ] Local testing successful

### Post-deployment
- [ ] GitHub Actions enabled
- [ ] First workflow execution successful
- [ ] Test reports generated
- [ ] Artifacts archived
- [ ] Monitoring configured

---

**Repository**: https://github.com/TBKiet/SWT_API
**CI/CD Status**: [![API Tests](https://github.com/TBKiet/SWT_API/actions/workflows/api-testing.yml/badge.svg)](https://github.com/TBKiet/SWT_API/actions/workflows/api-testing.yml)
