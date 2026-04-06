# Squan Quick Start Script for Windows
# Run this in PowerShell

Write-Host "🚀 Starting Squan Setup..." -ForegroundColor Cyan

# Download docker-compose.yml
Write-Host "`n📥 Downloading docker-compose.yml..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tarvitave/squan-release/main/docker-compose.yml" -OutFile "docker-compose.yml"

# Download .env.example
Write-Host "📥 Downloading .env.example..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tarvitave/squan-release/main/.env.example" -OutFile ".env.example"

# Create .env from example
Write-Host "`n⚙️  Creating .env configuration..." -ForegroundColor Yellow
Copy-Item .env.example .env

# Prompt for API key
Write-Host "`n🔑 You need at least one AI provider API key:" -ForegroundColor Green
Write-Host "   - Anthropic (Claude): https://console.anthropic.com/" -ForegroundColor Gray
Write-Host "   - OpenAI (GPT): https://platform.openai.com/" -ForegroundColor Gray
Write-Host "   - Google (Gemini): https://aistudio.google.com/" -ForegroundColor Gray

$editNow = Read-Host "`nDo you want to edit .env now? (y/n)"
if ($editNow -eq "y" -or $editNow -eq "Y") {
    notepad .env
    Write-Host "`nPlease add at least one API key and save the file." -ForegroundColor Yellow
    Read-Host "Press Enter when done editing"
}

# Check if Docker is running
Write-Host "`n🐳 Checking Docker..." -ForegroundColor Yellow
try {
    docker info | Out-Null
    Write-Host "✅ Docker is running!" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker is not running!" -ForegroundColor Red
    Write-Host "Please start Docker Desktop and run this script again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit
}

# Start Squan
Write-Host "`n🚀 Starting Squan..." -ForegroundColor Cyan
docker compose up -d

# Show status
Write-Host "`n✅ Squan is starting!" -ForegroundColor Green
Write-Host "`n📍 Access Squan at: http://localhost:3000" -ForegroundColor Cyan
Write-Host "`n💡 Useful commands:" -ForegroundColor Yellow
Write-Host "   View logs:    docker compose logs -f" -ForegroundColor Gray
Write-Host "   Stop Squan:   docker compose down" -ForegroundColor Gray
Write-Host "   Restart:      docker compose restart" -ForegroundColor Gray

Read-Host "`nPress Enter to exit"
