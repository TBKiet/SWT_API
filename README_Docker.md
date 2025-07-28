# Docker Setup for Practice Software Testing

This Docker setup is based on the [practice-software-testing](https://github.com/testsmith-io/practice-software-testing/) repository and provides a complete environment for API testing.

## 🐳 Quick Start

### 1. Build and Start Application
```bash
# Build Docker images
./build-images.sh

# Start the application
./start-app.sh
```

### 2. Access URLs
- **Frontend:** http://localhost:4200
- **API:** http://localhost:8091
- **Swagger Documentation:** http://localhost:8091/api/documentation
- **MailCatcher:** http://localhost:1080
- **PHPMyAdmin:** http://localhost:8000 (root/password)

## 📊 Default Accounts

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@practicesoftwaretesting.com | welcome01 |
| Customer | customer@practicesoftwaretesting.com | welcome01 |
| Customer | customer2@practicesoftwaretesting.com | welcome01 |
| Customer | customer3@practicesoftwaretesting.com | pass123 |

## 🏗️ Architecture

### Services
- **Laravel API** (Port 8091): REST API with Swagger documentation
- **Angular Frontend** (Port 4200): User interface
- **MySQL Database** (Port 3306): Data storage
- **MailCatcher** (Port 1080): Email testing
- **PHPMyAdmin** (Port 8000): Database management

### Network
All services communicate through the `practice-network` bridge network.

## 🔧 Docker Commands

### Build Images
```bash
# Build all images
./build-images.sh

# Build individual images
docker build -t practice-software-testing-api:latest ./API
docker build -t practice-software-testing-ui:latest ./UI
```

### Manage Containers
```bash
# Start application
docker-compose up -d

# Stop application
docker-compose down

# View logs
docker-compose logs -f

# Restart specific service
docker-compose restart laravel-api

# Access container shell
docker-compose exec laravel-api bash
docker-compose exec mysql mysql -u root -p
```

### Database Operations
```bash
# Run migrations
docker-compose exec laravel-api php artisan migrate

# Seed database
docker-compose exec laravel-api php artisan db:seed

# Fresh migration with seeding
docker-compose exec laravel-api php artisan migrate:fresh --seed
```

## 🧪 API Testing

### Update Test Collections
The API test collections have been updated to use the local Docker API:

- **Products API:** `22127223_API_Products_Submission/`
- **Users API:** `22127321_API_Users_Submission/`

### Run Tests
```bash
# Using Newman
npx newman run 22127223_API_Products_Submission/collection.json \
  --environment 22127223_API_Products_Submission/environment.json \
  --iteration-data 22127223_API_Products_Submission/user-accounts.csv

# Using GitHub Actions
# Push changes to trigger CI/CD workflows
```

## 📁 Project Structure

```
├── docker-compose.yml          # Main Docker Compose configuration
├── build-images.sh            # Script to build Docker images
├── start-app.sh              # Script to start the application
├── API/                      # Laravel API
│   ├── Dockerfile            # API Docker image
│   └── docker/               # Docker configurations
├── UI/                       # Angular Frontend
│   ├── Dockerfile            # UI Docker image
│   └── docker/               # Docker configurations
├── 22127223_API_Products_Submission/  # Student 22127223 submission
├── 22127321_API_Users_Submission/     # Student 22127321 submission
└── .github/workflows/        # CI/CD workflows
```

## 🔍 Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using the port
   lsof -i :8091
   # Kill the process or change port in docker-compose.yml
   ```

2. **Database Connection Issues**
   ```bash
   # Restart MySQL container
   docker-compose restart mysql
   
   # Check MySQL logs
   docker-compose logs mysql
   ```

3. **API Not Responding**
   ```bash
   # Check API logs
   docker-compose logs laravel-api
   
   # Restart API container
   docker-compose restart laravel-api
   ```

4. **Build Failures**
   ```bash
   # Clean Docker cache
   docker system prune -a
   
   # Rebuild images
   ./build-images.sh
   ```

### Logs
```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f laravel-api
docker-compose logs -f angular-app
docker-compose logs -f mysql
```

## 🚀 Development

### Adding New Features
1. Make changes to the API code in `API/`
2. Rebuild the API image: `docker build -t practice-software-testing-api:latest ./API`
3. Restart the API container: `docker-compose restart laravel-api`

### Database Changes
1. Create new migration: `docker-compose exec laravel-api php artisan make:migration create_new_table`
2. Run migration: `docker-compose exec laravel-api php artisan migrate`

### Frontend Changes
1. Make changes to the UI code in `UI/`
2. Rebuild the UI image: `docker build -t practice-software-testing-ui:latest ./UI`
3. Restart the UI container: `docker-compose restart angular-app`

## 📚 Resources

- [Practice Software Testing Repository](https://github.com/testsmith-io/practice-software-testing/)
- [Laravel Documentation](https://laravel.com/docs)
- [Angular Documentation](https://angular.io/docs)
- [Docker Documentation](https://docs.docker.com/)

## 🎯 Testing Goals

This Docker setup enables:
- ✅ **Local API Testing** with Newman
- ✅ **CI/CD Integration** with GitHub Actions
- ✅ **Database Testing** with seeded data
- ✅ **Email Testing** with MailCatcher
- ✅ **Frontend Testing** with Angular app
- ✅ **API Documentation** with Swagger

---

**Last Updated:** January 13, 2025  
**Based on:** [practice-software-testing](https://github.com/testsmith-io/practice-software-testing/)  
**Students:** 22127223, 22127321 