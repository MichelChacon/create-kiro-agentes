# Instalacion — Kiro Agentes para AWS

Prerequisitos para usar el generador de agentes Kiro.

---

## Sistema operativo

Compatible con Windows, macOS y Linux.

Los scripts de la plantilla son PowerShell (.ps1). Si usas macOS o Linux, necesitas PowerShell instalado (ver abajo) o el agente generado adaptara los scripts segun tu OS.

---

## Prerequisitos obligatorios

### 1. Kiro CLI

```powershell
kiro-cli --version   # debe ser 2.2.1+
```

Descarga desde https://kiro.dev/downloads/

Autenticarse:
```powershell
kiro-cli auth login
```

### 2. Node.js 22+

```powershell
node --version   # debe ser v22.x o superior
```

Descarga desde https://nodejs.org/ (LTS)

### 3. Git

```powershell
git --version
```

### 4. AWS CLI v2

El generador usa servicios y documentacion AWS. Requiere AWS CLI configurado.

```powershell
aws --version

# SSO (recomendado para empresas)
aws configure sso --profile tu-perfil

# O con credenciales directas
aws configure
```

Descarga desde https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

---

## Prerequisitos opcionales

### uv (para MCP servers Python)

Solo necesario si el agente generado usara MCP servers Python.

**Windows:**
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
uv --version   # debe ser 0.4+
```

**macOS/Linux:**
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### PowerShell en macOS/Linux

Si quieres usar los scripts de la plantilla en macOS o Linux:

```bash
# macOS
brew install powershell

# Ubuntu/Debian
sudo apt-get install -y powershell
```

### Jira / gestor de tickets (opcional)

Si usas Jira, el agente generado necesita un API Token:
1. Ve a https://id.atlassian.com/manage-profile/security/api-tokens
2. Crea un token
3. Configura en tu entorno:

```powershell
# Windows - agregar a tu $PROFILE
$env:JIRA_URL = "https://tu-instancia.atlassian.net"
$env:JIRA_USERNAME = "tu.email@empresa.com"
$env:JIRA_API_TOKEN = "tu-api-token"
```

```bash
# macOS/Linux - agregar a .bashrc o .zshrc
export JIRA_URL="https://tu-instancia.atlassian.net"
export JIRA_USERNAME="tu.email@empresa.com"
export JIRA_API_TOKEN="tu-api-token"
```

---

## Iniciar el generador

```powershell
# Windows
cd C:\Users\TU_USUARIO\Projects\kiro-agentes
kiro-cli chat --agent generador

# macOS/Linux
cd ~/Projects/kiro-agentes
kiro-cli chat --agent generador
```

El agente te guia con el cuestionario de configuracion.

---

## Despues de generar tu agente

El agente generado incluye su propio `INSTALACION.md` con los prerequisitos especificos de tu stack.

Para iniciarlo:
```powershell
# Windows
cd C:\Users\TU_USUARIO\Projects\agente-{rol}-{nombre}
kiro-cli chat --agent {rol}

# macOS/Linux
cd ~/Projects/agente-{rol}-{nombre}
kiro-cli chat --agent {rol}
```
