#!/bin/bash

echo "🐳 Building Docker images for Practice Software Testing..."

# Build API image
echo "📦 Building Laravel API image..."
docker build -t practice-software-testing-api:latest ./API

if [ $? -eq 0 ]; then
    echo "✅ API image built successfully"
else
    echo "❌ Failed to build API image"
    exit 1
fi

# Build UI image
echo "📦 Building Angular UI image..."
docker build -t practice-software-testing-ui:latest ./UI

if [ $? -eq 0 ]; then
    echo "✅ UI image built successfully"
else
    echo "❌ Failed to build UI image"
    exit 1
fi

echo "🎉 All images built successfully!"
echo ""
echo "🚀 To start the application:"
echo "   docker-compose up -d"
echo ""
echo "🌐 Access URLs:"
echo "   - Frontend: http://localhost:4200"
echo "   - API: http://localhost:8091"
echo "   - Swagger: http://localhost:8091/api/documentation"
echo "   - MailCatcher: http://localhost:1080"
echo "   - PHPMyAdmin: http://localhost:8000 (root/password)" 