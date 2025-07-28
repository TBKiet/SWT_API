# CI/CD Setup for API Testing

This repository contains GitHub Actions workflows for automated API testing using Newman.

## 📋 Overview

Two separate workflows are configured for different students:

1. **Student 22127223** - Products API Testing
2. **Student 22127321** - Users API Testing

## 🚀 Workflows

### 1. API Testing - 22127223 (Products API)
- **File:** `.github/workflows/api-test.yml`
- **Triggers:** Changes in `22127223_API_Products_Submission/` folder
- **Working Directory:** `22127223_API_Products_Submission/`
- **Artifacts:** `api-test-reports-22127223`

### 2. API Testing - 22127321 (Users API)
- **File:** `.github/workflows/api-test-22127321.yml`
- **Triggers:** Changes in `22127321_API_Users_Submission/` folder
- **Working Directory:** `22127321_API_Users_Submission/`
- **Artifacts:** `api-test-reports-22127321`

## 🔧 How It Works

### Automatic Triggers
- **Push to main/master:** Runs when code is pushed to main or master branch
- **Pull Request:** Runs when a PR is created or updated
- **Manual Dispatch:** Can be triggered manually from GitHub Actions tab

### Workflow Steps
1. **Checkout Code:** Downloads the repository
2. **Setup Node.js:** Installs Node.js 18
3. **Install Newman:** Installs Newman CLI tool
4. **Create Reports Directory:** Creates directory for test reports
5. **Run API Tests:** Executes Newman with collection, environment, and CSV data
6. **Upload Artifacts:** Saves test reports as downloadable artifacts
7. **Display Results:** Shows test summary in logs

## 📊 Test Reports

Each workflow generates:
- **JSON Report:** `reports/api-test-results.json`
- **HTML Report:** `reports/api-test-report.html`
- **CLI Output:** Real-time test results in GitHub Actions logs

## 🎯 How to Use

### For Students
1. **Push Changes:** Any changes to your submission folder will trigger the workflow
2. **Check Actions:** Go to GitHub Actions tab to see test results
3. **Download Reports:** Click on workflow run → Artifacts → Download

### For Manual Testing
1. Go to **Actions** tab on GitHub
2. Select your workflow (22127223 or 22127321)
3. Click **Run workflow** → **Run workflow**

## 📁 File Structure

```
.github/
└── workflows/
    ├── api-test.yml              # 22127223 - Products API
    └── api-test-22127321.yml    # 22127321 - Users API

22127223_API_Products_Submission/
├── collection.json
├── environment.json
├── user-accounts.csv
└── ... (other files)

22127321_API_Users_Submission/
├── collection.json
├── environment.json
├── user-accounts.csv
└── ... (other files)
```

## 🔍 Monitoring

### GitHub Actions Dashboard
- **Status:** Green = Pass, Red = Fail
- **Duration:** How long tests took to run
- **Logs:** Detailed output for debugging

### Artifacts
- **Retention:** 30 days
- **Download:** Available from Actions tab
- **Format:** ZIP files containing test reports

## 🛠️ Troubleshooting

### Common Issues
1. **File Not Found:** Ensure all required files exist in submission folder
2. **Newman Not Installed:** Workflow automatically installs Newman
3. **Test Failures:** Check logs for specific error messages

### Debugging
1. **Check Logs:** View detailed output in Actions tab
2. **Verify Files:** Ensure collection.json, environment.json, user-accounts.csv exist
3. **Test Locally:** Run `./run-api-tests.sh` locally first

## 📈 Benefits

- **Automated Testing:** No manual intervention required
- **Consistent Results:** Same environment every time
- **Artifact Storage:** Test reports saved for 30 days
- **Parallel Execution:** Both students' workflows run independently
- **Real-time Monitoring:** Immediate feedback on test results

---

**Last Updated:** January 13, 2025  
**Students:** 22127223, 22127321  
**Course:** Software Testing  
**Assignment:** API Testing with AI Tools 