# Guía de Instalación — Kiro Agentes

Prerequisitos para usar el generador de agentes.

**Sistema operativo**: Windows 11

---

## Prerequisitos obligatorios

### 1. Kiro CLI

```powershell
# Instalar
curl -fsSL https://cli.kiro.dev/install | bash

# Verificar
kiro-cli --version   # debe ser 2.2.1+

# Autenticarse
kiro-cli auth login
```

### 2. Node.js 22+

```powershell
node --version   # debe ser v22.x o superior
# Instalar desde https://nodejs.org/ (LTS)
```

### 3. Python + uv

```powershell
# Instalar uv
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Verificar
uv --version   # debe ser 0.8+
```

### 4. Git

```powershell
git --version
```

---

## Prerequisitos opcionales (según tu rol)

> Todas las variables de entorno están documentadas en [`.env.example`](.env.example).

### Si usas AWS (backend, devops, data)

```powershell
# AWS CLI v2
aws --version

# Configurar SSO
aws configure sso --profile tu-perfil
```

### Si usas Jira (casi todos)

Necesitas un API Token:
1. Ve a https://id.atlassian.com/manage-profile/security/api-tokens
2. Crea un nuevo token

Configura en tu `$PROFILE` de PowerShell:
```powershell
$env:JIRA_URL = "https://tu-instancia.atlassian.net"
$env:JIRA_USERNAME = "tu.email@empresa.com"
$env:JIRA_API_TOKEN = "tu-api-token"
```

### Búsqueda web (Exa) — recomendado para todos

1. Registrarte en https://exa.ai
2. Obtener API key
3. Agregar a `$PROFILE`:
```powershell
$env:EXA_API_KEY = "tu-exa-api-key"
```

### Obsidian (opcional, como viewer de wiki)

Descargar desde https://obsidian.md — útil para visualizar la wiki con graph view.

---

## Iniciar el generador

```powershell
cd C:\Users\TU_USUARIO\Projects\kiro-agentes
kiro-cli chat --agent generador
```

El agente te guiará desde ahí.

---

## Después de generar tu agente

El agente generado incluye su propio `INSTALACION.md` con los prerequisitos específicos de tu stack. Sigue esas instrucciones para configurar los MCP servers que necesites.

Para iniciar tu agente:
```powershell
cd C:\Users\TU_USUARIO\Projects\agente-{rol}-{nombre}
kiro-cli chat --agent {rol}
```
