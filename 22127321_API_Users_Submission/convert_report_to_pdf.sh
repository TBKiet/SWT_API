#!/bin/bash

# Convert API Testing Report to PDF
# Student ID: 22127321

echo "📄 Converting API Testing Report to PDF..."
echo "Student ID: 22127321"
echo ""

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "❌ Pandoc is not installed. Please install pandoc first:"
    echo "On macOS: brew install pandoc"
    echo "On Ubuntu: sudo apt-get install pandoc"
    exit 1
fi

# Create CSS for styling
cat > api_report_style.css << 'EOF'
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

h1 {
    color: #2c3e50;
    border-bottom: 3px solid #3498db;
    padding-bottom: 10px;
}

h2 {
    color: #34495e;
    border-bottom: 2px solid #ecf0f1;
    padding-bottom: 5px;
}

h3 {
    color: #7f8c8d;
}

table {
    border-collapse: collapse;
    width: 100%;
    margin: 20px 0;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #3498db;
    color: white;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

code {
    background-color: #f8f9fa;
    padding: 2px 4px;
    border-radius: 3px;
    font-family: 'Courier New', monospace;
}

pre {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
    overflow-x: auto;
}

blockquote {
    border-left: 4px solid #3498db;
    margin: 0;
    padding-left: 15px;
    color: #7f8c8d;
}

.success {
    color: #27ae60;
    font-weight: bold;
}

.fail {
    color: #e74c3c;
    font-weight: bold;
}

.warning {
    color: #f39c12;
    font-weight: bold;
}
EOF

# Convert markdown to PDF
echo "🔄 Converting markdown to PDF..."
pandoc 22127321_API_AI_Report_Users.md \
    -o 22127321_API_AI_Report_Users.pdf \
    --pdf-engine=wkhtmltopdf \
    --css=api_report_style.css \
    --metadata title="API Testing with AI Tools - Individual Report" \
    --metadata author="Student ID: 22127321" \
    --metadata date="January 13, 2025"

if [ $? -eq 0 ]; then
    echo "✅ PDF report generated successfully: 22127321_API_AI_Report_Users.pdf"
else
    echo "⚠️  Error generating PDF. Trying HTML alternative..."
    pandoc 22127321_API_AI_Report_Users.md \
        -o 22127321_API_AI_Report_Users.html \
        --css=api_report_style.css \
        --metadata title="API Testing with AI Tools - Individual Report" \
        --metadata author="Student ID: 22127321" \
        --metadata date="January 13, 2025"
    
    if [ $? -eq 0 ]; then
        echo "✅ HTML report generated: 22127321_API_AI_Report_Users.html"
        echo "📝 You can open this file in a browser and print to PDF"
    else
        echo "❌ Error generating HTML report"
    fi
fi

echo ""
echo "🎯 Report conversion completed!" 