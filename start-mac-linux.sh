#!/bin/bash
# Squan Quick Start Script for macOS/Linux

echo "🚀 Starting Squan Setup..."
echo ""

# Download docker-compose.yml
echo "📥 Downloading docker-compose.yml..."
curl -O https://raw.githubusercontent.com/tarvitave/squan-release/main/docker-compose.yml

# Download .env.example
echo "📥 Downloading .env.example..."
curl -O https://raw.githubusercontent.com/tarvitave/squan-release/main/.env.example

# Create .env from example
echo ""
echo "⚙️  Creating .env configuration..."
cp .env.example .env

# Prompt for API key
echo ""
echo "🔑 You need at least one AI provider API key:"
echo "   - Anthropic (Claude): https://console.anthropic.com/"
echo "   - OpenAI (GPT): https://platform.openai.com/"
echo "   - Google (Gemini): https://aistudio.google.com/"
echo ""

# Detect editor
if command -v nano &> /dev/null; then
    EDITOR="nano"
elif command -v vim &> /dev/null; then
    EDITOR="vim"
elif command -v vi &> /dev/null; then
    EDITOR="vi"
else
    EDITOR="cat"
fi

read -p "Do you want to edit .env now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    $EDITOR .env
    echo ""
    echo "Please add at least one API key and save the file."
    read -p "Press Enter when done editing..."
fi

# Check if Docker is running
echo ""
echo "🐳 Checking Docker..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running!"
    echo "Please start Docker and run this script again."
    exit 1
fi
echo "✅ Docker is running!"

# Start Squan
echo ""
echo "🚀 Starting Squan..."
docker compose up -d

# Show status
echo ""
echo "✅ Squan is starting!"
echo ""
echo "📍 Access Squan at: http://localhost:3000"
echo ""
echo "💡 Useful commands:"
echo "   View logs:    docker compose logs -f"
echo "   Stop Squan:   docker compose down"
echo "   Restart:      docker compose restart"
echo ""
