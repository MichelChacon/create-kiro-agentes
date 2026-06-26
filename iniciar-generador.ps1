# iniciar-generador.ps1
# Script para iniciar el generador de agentes Kiro para AWS
# Uso: .\iniciar-generador.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Generador de Agentes Kiro para AWS" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que kiro-cli esta instalado
if (-not (Get-Command kiro-cli -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] kiro-cli no esta instalado." -ForegroundColor Red
    Write-Host "Instala desde: https://kiro.dev/downloads/" -ForegroundColor Yellow
    exit 1
}

# Verificar AWS CLI
if (-not (Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "[WARN] AWS CLI no encontrado. Algunos MCP servers no funcionaran." -ForegroundColor Yellow
    Write-Host "Instala desde: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html" -ForegroundColor Yellow
    Write-Host ""
}

# Variables de entorno opcionales - configurar si las tienes
# $env:JIRA_URL = "https://tu-instancia.atlassian.net"
# $env:JIRA_USERNAME = "tu.email@empresa.com"
# $env:JIRA_API_TOKEN = "tu-api-token"

Write-Host "[OK] Iniciando agente generador..." -ForegroundColor Green
Write-Host ""
Write-Host "El agente te guiara con el cuestionario de configuracion."
Write-Host ""

kiro-cli chat --agent generador
