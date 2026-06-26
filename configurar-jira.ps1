# Script de Configuracion de Jira para Kiro Agentes
# Este script agrega las variables de entorno necesarias a tu perfil de PowerShell

Write-Host "Configurando Jira para Kiro Agentes..." -ForegroundColor Cyan
Write-Host ""

# Variables de configuracion
$JIRA_URL = "https://tu-empresa.atlassian.net"
$JIRA_USERNAME = "tu-email@empresa.com"
$JIRA_API_TOKEN = "TU_JIRA_API_TOKEN_AQUI"

# Configuracion de uv (necesario para MCP servers)
$UV_PATH = "C:\Users\mespinoza\.local\bin"

# Verificar si el perfil de PowerShell existe
if (-not (Test-Path $PROFILE)) {
    Write-Host "Creando perfil de PowerShell..." -ForegroundColor Yellow
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

# Leer el contenido actual del perfil
$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue

# Verificar si ya existen las configuraciones
$needsUpdate = $false

if ($profileContent -notmatch "JIRA_URL") {
    $needsUpdate = $true
}

if ($needsUpdate) {
    Write-Host "Agregando configuracion al perfil de PowerShell..." -ForegroundColor Yellow
    
    # Agregar configuracion al perfil
    $configBlock = @"

# ============================================
# Kiro Agentes - Configuracion
# ============================================

# Agregar uv al PATH
`$env:Path = "$UV_PATH;`$env:Path"

# Configuracion de Jira
`$env:JIRA_URL = "$JIRA_URL"
`$env:JIRA_USERNAME = "$JIRA_USERNAME"
`$env:JIRA_API_TOKEN = "$JIRA_API_TOKEN"

# Configuracion de Exa (opcional - agregar tu API key aqui)
# `$env:EXA_API_KEY = "tu-api-key-aqui"

"@
    
    Add-Content -Path $PROFILE -Value $configBlock
    Write-Host "Configuracion agregada a $PROFILE" -ForegroundColor Green
} else {
    Write-Host "La configuracion ya existe en el perfil" -ForegroundColor Cyan
}

# Cargar las variables en la sesion actual
Write-Host ""
Write-Host "Cargando variables en la sesion actual..." -ForegroundColor Yellow
$env:Path = "$UV_PATH;$env:Path"
$env:JIRA_URL = $JIRA_URL
$env:JIRA_USERNAME = $JIRA_USERNAME
$env:JIRA_API_TOKEN = $JIRA_API_TOKEN

Write-Host ""
Write-Host "Configuracion completada!" -ForegroundColor Green
Write-Host ""
Write-Host "Variables configuradas:" -ForegroundColor Cyan
Write-Host "   JIRA_URL: $env:JIRA_URL"
Write-Host "   JIRA_USERNAME: $env:JIRA_USERNAME"
Write-Host "   JIRA_API_TOKEN: ****...$(($env:JIRA_API_TOKEN).Substring(($env:JIRA_API_TOKEN).Length - 8))"
Write-Host "   UV_PATH: $UV_PATH"
Write-Host ""
Write-Host "Ahora puedes iniciar el generador:" -ForegroundColor Green
Write-Host "   kiro-cli chat --agent generador" -ForegroundColor White
Write-Host ""
Write-Host "Tip: Las variables estaran disponibles automaticamente en nuevas sesiones de PowerShell" -ForegroundColor Yellow
