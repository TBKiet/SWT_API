# GitFlow CI/CD Pipeline Guide

## Overview

This repository implements a comprehensive GitFlow branching strategy with automated CI/CD pipeline using GitHub Actions. The workflow follows GitFlow methodology with proper environment separation and automated testing.

## GitFlow Branching Strategy

### Main Branches

- **`main`** - Production-ready code
- **`develop`** - Integration branch for features

### Supporting Branches

- **`feature/*`** - New features (branch from `develop`)
- **`release/*`** - Release preparation (branch from `develop`)
- **`hotfix/*`** - Critical production fixes (branch from `main`)

## Workflow Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Feature       │    │   Release       │    │   Hotfix        │
│   Branches      │    │   Branches      │    │   Branches      │
│                 │    │                 │    │                 │
│ feature/login   │    │ release/v1.0.0  │    │ hotfix/critical │
│ feature/payment │    │ release/v1.1.0  │    │ hotfix/security │
│ feature/api     │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│    Develop      │    │    Develop      │    │     Main        │
│   (Staging)     │    │   (Staging)     │    │  (Production)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     Main        │    │     Main        │    │     Main        │
│  (Production)   │    │  (Production)   │    │  (Production)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Pipeline Stages

### 1. Code Quality & Security Checks
- **Trigger**: Pull requests, pushes to `develop` or `main`
- **Jobs**:
  - Linting and code style checks
  - Security vulnerability scanning
  - Code coverage analysis

### 2. Build & Test
- **Trigger**: Pull requests, pushes to `develop` or `main`
- **Jobs**:
  - Docker container setup
  - Laravel application setup
  - API testing with Newman
  - Test report generation

### 3. Staging Deployment
- **Trigger**: Push to `develop` branch
- **Environment**: Staging
- **Jobs**:
  - Deploy to staging environment
  - Health checks
  - Integration testing

### 4. Production Deployment
- **Trigger**: Push to `main` branch
- **Environment**: Production
- **Jobs**:
  - Deploy to production
  - Health checks
  - Release tagging

### 5. Hotfix Deployment
- **Trigger**: Push to `hotfix/*` branches
- **Environment**: Production
- **Jobs**:
  - Critical fix deployment
  - Health checks

### 6. Release Notes
- **Trigger**: Push to `main` branch
- **Jobs**:
  - Generate release notes
  - Upload artifacts

### 7. Notifications
- **Trigger**: All deployments
- **Jobs**:
  - Team notifications
  - Status reporting

## Usage Guide

### Starting a New Feature

```bash
# 1. Ensure you're on develop branch
git checkout develop
git pull origin develop

# 2. Create feature branch
git checkout -b feature/new-feature-name

# 3. Make your changes and commit
git add .
git commit -m "feat: add new feature"

# 4. Push feature branch
git push origin feature/new-feature-name

# 5. Create Pull Request to develop
# GitHub will automatically run CI/CD pipeline
```

### Creating a Release

```bash
# 1. Ensure develop is ready for release
git checkout develop
git pull origin develop

# 2. Create release branch
git checkout -b release/v1.0.0

# 3. Make release-specific changes (version bump, etc.)
# Edit version files, update changelog

# 4. Commit release changes
git add .
git commit -m "chore: prepare release v1.0.0"

# 5. Push release branch
git push origin release/v1.0.0

# 6. Create Pull Request to main
# After approval and merge, create tag
```

### Hotfix Process

```bash
# 1. Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-fix

# 2. Make critical fix
git add .
git commit -m "fix: critical production issue"

# 3. Push hotfix branch
git push origin hotfix/critical-fix

# 4. Create Pull Request to main
# After approval and merge, also merge to develop
```

## Environment Configuration

### Required Secrets

Configure these secrets in your GitHub repository:

```yaml
# Database Configuration
DB_DATABASE: toolshop
DB_USERNAME: user
DB_PASSWORD: root

# Laravel Configuration
APP_KEY: base64:YourAppKeyHere
JWT_SECRET: your_jwt_secret_key_here

# Deployment Configuration (if using external services)
STAGING_HOST: staging.yourapp.com
PRODUCTION_HOST: yourapp.com
DEPLOY_KEY: your_deploy_key
```

### Environment Protection

The workflow uses GitHub Environments for deployment protection:

1. **Staging Environment**: Requires approval for staging deployments
2. **Production Environment**: Requires approval for production deployments

## Test Suites

The pipeline runs the following test suites:

### Available Tests
- **Brands Tests**: `tests/brands-data-driven-collection.json`
- **Favorites Tests**: `tests/favorites-data-driven-collection.json`
- **Users Tests**: `tests/users-data-driven-collection.json`

### Test Reports
- HTML reports are generated for each test suite
- Reports are uploaded as artifacts
- Reports are retained for 30 days

## Manual Workflow Triggers

You can manually trigger the workflow with custom parameters:

### Manual Deployment
1. Go to Actions tab in GitHub
2. Select "GitFlow CI/CD Pipeline"
3. Click "Run workflow"
4. Choose environment (staging/production)
5. Optionally force deployment (bypass tests)

### Parameters
- **Environment**: Target environment for deployment
- **Force Deploy**: Bypass tests for emergency deployments

## Monitoring & Notifications

### Health Checks
- Automatic health checks after deployment
- Configurable health check endpoints
- Failure notifications

### Notifications
- Build status notifications
- Deployment success/failure alerts
- Test result summaries

## Best Practices

### Branch Naming
- Features: `feature/descriptive-name`
- Releases: `release/v1.0.0`
- Hotfixes: `hotfix/critical-description`

### Commit Messages
- Use conventional commit format
- Prefix with type: `feat:`, `fix:`, `chore:`, `docs:`
- Include issue numbers: `feat: add login #123`

### Code Quality
- All code must pass linting
- Security vulnerabilities must be addressed
- Test coverage should be maintained

### Deployment Safety
- Always test in staging first
- Use feature flags for risky changes
- Monitor deployments closely
- Have rollback procedures ready

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Check linting errors
   - Verify test failures
   - Review security audit results

2. **Deployment Failures**
   - Verify environment secrets
   - Check Docker container logs
   - Validate health check endpoints

3. **Test Failures**
   - Review test reports
   - Check API endpoint availability
   - Verify test data files

### Debugging Steps

1. **Check Workflow Logs**
   - Go to Actions tab
   - Click on failed workflow
   - Review step-by-step logs

2. **Verify Environment**
   - Check Docker containers
   - Validate database connection
   - Test API endpoints manually

3. **Local Testing**
   - Run tests locally first
   - Use `docker compose` for local environment
   - Verify all dependencies

## Advanced Configuration

### Custom Deployment Scripts

You can customize deployment logic by modifying the workflow:

```yaml
- name: Deploy to Staging 🚀
  run: |
    # Add your custom deployment logic here
    echo "🚀 Deploying to staging environment..."
    # Example: docker compose -f docker-compose.staging.yml up -d
```

### Environment-Specific Configurations

Create environment-specific Docker Compose files:

- `docker-compose.staging.yml`
- `docker-compose.production.yml`

### Custom Health Checks

Modify health check endpoints:

```yaml
- name: Run Health Check 🏥
  run: |
    curl -f https://staging.yourapp.com/health
    curl -f https://staging.yourapp.com/api/status
```

## Security Considerations

### Secrets Management
- Never commit secrets to repository
- Use GitHub Secrets for sensitive data
- Rotate secrets regularly

### Access Control
- Limit who can approve deployments
- Use branch protection rules
- Require pull request reviews

### Security Scanning
- Regular dependency vulnerability scans
- Code security analysis
- Container security scanning

## Performance Optimization

### Caching
- Docker layer caching
- npm dependency caching
- Composer dependency caching

### Parallel Jobs
- Independent jobs run in parallel
- Optimized job dependencies
- Efficient resource usage

### Resource Management
- Cleanup after each job
- Proper Docker container management
- Efficient artifact handling

## Support

For issues or questions:

1. Check the workflow logs
2. Review this documentation
3. Create an issue in the repository
4. Contact the development team

---

**Note**: This GitFlow implementation is designed for Laravel applications with Docker containerization. Adjust the configuration based on your specific technology stack and requirements. 