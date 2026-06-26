# 🤖 Create Kiro Agentes

> **Generador automático de agentes Kiro personalizados por rol**

¿Cansado de configurar agentes desde cero? Este proyecto genera agentes Kiro completos y listos para usar en minutos. El agente generador te entrevista, investiga tus repos, y crea un compañero de trabajo adaptado a tu stack y flujo de trabajo.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Kiro CLI](https://img.shields.io/badge/Kiro%20CLI-2.2.1%2B-blue)](https://kiro.dev)
[![Node.js](https://img.shields.io/badge/Node.js-22%2B-green)](https://nodejs.org)

---

## ✨ Características

- 🎯 **8 roles predefinidos**: Backend, Frontend, Full Stack, DevOps, Data Engineer, Product Manager, QA, UI/UX
- 🔍 **Investigación automática**: Lee tus repos para detectar el stack real
- 📚 **Knowledge base completa**: Wiki estructurada con auto-indexing
- 🛠️ **Skills específicos por rol**: Code review, deploy, testing, planning
- 🔌 **MCP servers integrados**: Jira, AWS Docs, búsqueda web (AWS Documentation)
- 🚀 **Listo en minutos**: Entrevista de 4 bloques y genera todo automáticamente

---

## 🎭 Roles Soportados

| Rol | Archivo de perfil | Especialización |
|-----|-------------------|-----------------|
| Backend | `perfiles/backend.md` | AWS (Lambda, DynamoDB, SAM) |
| Frontend | `perfiles/frontend.md` | Angular (Material, RxJS, NgRx) |
| Full Stack | `perfiles/fullstack.md` | Frontend + Backend + DevOps básico |
| DevOps / SRE | `perfiles/devops.md` | AWS IaC (CDK, SAM, Terraform) |
| Data Engineer | `perfiles/data.md` | Pipelines, warehouses, analytics |
| Product Manager | `perfiles/product-manager.md` | Specs, priorización, métricas |
| QA Engineer | `perfiles/qa.md` | Testing manual y automatizado |
| Diseñador UI/UX | `perfiles/disenador-ux.md` | Figma, design systems, handoff |

> Los perfiles son guías, no restricciones. Si tu rol es híbrido, el agente adapta.

### Qué incluye cada perfil
- **Scope Exclusions**: Qué NO hace el rol (previene drift en sesiones largas)
- **Forbidden Phrases**: Frases prohibidas con alternativa correcta (refuerza identidad)
- **Tools diferenciados**: Roles técnicos tienen acceso completo; PM y Diseñador sin shell/code

## Cómo funciona

```
┌──────────────┐     ┌───────────────┐     ┌─────────────────────────────┐
│  Tú inicias  │────▶│  Entrevista   │────▶│  Genera agente-{rol}-{nombre} │
│  kiro-cli    │     │  (4 bloques)  │     │  con todo listo para usar    │
└──────────────┘     └───────────────┘     └─────────────────────────────┘
```

1. **Entrevista**: Te pregunta nombre, rol, stack, repos, documentación existente, herramientas, preferencias
2. **Investigación**: Lee tus repos y documentación para detectar stack real
3. **Generación**: Crea carpeta completa con .kiro/, wiki/, docs
4. **Documento de uso**: Genera USO.md con comandos y casos de uso

## 🚀 Inicio Rápido

```powershell
# 1. Clonar el repositorio
git clone https://github.com/MichelChacon/create-kiro-agentes.git
cd create-kiro-agentes

# 2. Configurar variables de entorno (opcional)
cp .env.example .env
# Editar .env con tus tokens de Jira, AWS Docs, etc.

# 3. Iniciar el generador
kiro-cli chat --agent generador
```

El agente te saluda y empieza la entrevista. Al terminar, tendrás un agente completo en:

```
C:\Users\TU_USUARIO\Projects\agente-{rol}-{nombre}\
├── .kiro/          # Configuración completa del agente
├── wiki/           # Knowledge base lista para usar
├── README.md       # Qué es este agente
├── INSTALACION.md  # Prerequisitos de tu stack
└── USO.md          # Cómo usarlo día a día
```

---

## Estructura del proyecto

```
kiro-agentes/
├── .kiro/
│   ├── agents/generador.json           # Agente generador
│   ├── skills/crear-agente/SKILL.md    # Skill de onboarding
│   └── steering/identity.md            # Identidad del generador
├── plantilla/                          # Template base (se copia)
│   ├── .kiro/steering/                 # 5 steering genéricos
│   ├── .kiro/skills/                   # 2 skills genéricos
│   ├── .kiro/scripts/                  # gitflow.ps1, gitflow-finish.ps1
│   ├── .kiro/hooks/                    # prompt-context.ps1
│   └── wiki/SCHEMA.md                  # Schema de wiki
├── perfiles/                           # Guías por rol (8 perfiles)
├── .env.example                        # Variables de entorno necesarias
├── README.md                           # Este archivo
└── INSTALACION.md                      # Prerequisitos
```

## 📦 Qué Incluye Cada Agente Generado

### Siempre (todos los roles):
- Wiki con estructura completa (SCHEMA, index, log, carpetas)
- Steering: confirmation-policy, wiki-policy, commit-conventions, sub-agent, workflow-gates
- Skills: flywheel (auto-mejora), post-mortem (documentar incidentes)
- Scripts: gitflow.ps1, gitflow-finish.ps1
- Hooks: prompt-context.ps1 (continuidad entre sesiones)
- Knowledge base con auto-indexing de wiki/
- Búsqueda web (AWS Documentation)

### Según el rol:
- Skills específicos (investigate-ticket, deploy, code-review, test-plan, etc.)
- MCP servers del stack (Jira, AWS Docs, DynamoDB, etc.)
- Steering adaptados (verification-checklist, error-patterns, domain-routing)
- Wiki con contenido inicial relevante al rol

## 🔧 Prerequisitos

Ver [INSTALACION.md](INSTALACION.md) para la guía completa.

Mínimo:
- Windows, macOS o Linux
- Kiro CLI 2.2.1+
- Node.js 22+
- AWS CLI v2

---

## 📝 Licencia

MIT License

---

## 🤝 Contribuciones

¿Tienes un perfil de rol que falta? ¿Mejoras al generador? ¡Pull requests bienvenidos!

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 👤 Autor

**Michael Espinoza D.**
- GitHub: [@MichelChacon](https://github.com/MichelChacon)
- Email: michelesp1981@gmail.com

---

## ⭐ ¿Te gustó?

Si este proyecto te ayudó, dale una ⭐ en GitHub!

---

**Hecho con ❤️ para la comunidad Kiro**
