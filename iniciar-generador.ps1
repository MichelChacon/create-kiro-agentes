# Script para iniciar el generador de agentes Kiro
# Version simplificada sin MCP servers externos

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Iniciando Generador de Agentes Kiro" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Cargar variables de entorno
$env:JIRA_URL = "https://defontana.atlassian.net"
$env:JIRA_USERNAME = "mespinoza@defontana.com"
$env:JIRA_API_TOKEN = "ATATT3xFfGF0kE3Gr53mXO7cOeYzc2QrsGdN5Jr0mv50doi3UhMtM81gDlx_XfGwWqLtCdf7E-9Qkf7J302oukMj9pDiKAmYxqRJwVQC7d1VQYWeboWZi7Qg4_9PBt4ivAxpTJHeLZaa7OLzl_HOTxkNjV7oQdEQkQgWXlA0pwPwxmfDJslvt90=6F325769"
$env:EXA_API_KEY = "e72c9867-d442-4fec-9952-e33a5bdb7587"
$env:Path = "C:\Users\mespinoza\.local\bin;$env:Path"

Write-Host "Variables de entorno cargadas" -ForegroundColor Green
Write-Host ""
Write-Host "Iniciando agente generador-simple (sin MCP externo)..." -ForegroundColor Yellow
Write-Host ""

# Iniciar Kiro con el agente simplificado
kiro-cli chat --agent generador-simple
