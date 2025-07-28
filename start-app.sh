#!/bin/bash

echo "🚀 Starting Practice Software Testing Application..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Check if images exist
if ! docker image inspect practice-software-testing-api:latest > /dev/null 2>&1; then
    echo "📦 API image not found. Building images first..."
    ./build-images.sh
fi

if ! docker image inspect practice-software-testing-ui:latest > /dev/null 2>&1; then
    echo "📦 UI image not found. Building images first..."
    ./build-images.sh
fi

# Start the application
echo "🐳 Starting containers..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Application started successfully!"
    echo ""
    echo "🌐 Access URLs:"
    echo "   - Frontend: http://localhost:4200"
    echo "   - API: http://localhost:8091"
    echo "   - Swagger: http://localhost:8091/api/documentation"
    echo "   - MailCatcher: http://localhost:1080"
    echo "   - PHPMyAdmin: http://localhost:8000 (root/password)"
    echo ""
    echo "📊 Default accounts:"
    echo "   - Admin: admin@practicesoftwaretesting.com / welcome01"
    echo "   - Customer: customer@practicesoftwaretesting.com / welcome01"
    echo ""
    echo "🔧 Useful commands:"
    echo "   - View logs: docker-compose logs -f"
    echo "   - Stop app: docker-compose down"
    echo "   - Restart: docker-compose restart"
else
    echo "❌ Failed to start application"
    exit 1
fi 