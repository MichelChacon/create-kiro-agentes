# Kiro Agentes — Generador de Agentes por Rol

Genera agentes Kiro personalizados para cualquier rol técnico. El agente generador te entrevista, investiga tus repos, y crea un compañero de trabajo adaptado a tu día a día.

## Roles soportados

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

## Uso rápido

```powershell
cd C:\Users\TU_USUARIO\Projects\kiro-agentes
kiro-cli chat --agent generador
```

El agente te saluda y empieza la entrevista. Al terminar, tendrás:

```
C:\Users\TU_USUARIO\Projects\agente-{rol}-{nombre}\
├── .kiro/          # Configuración completa del agente
├── wiki/           # Knowledge base lista para usar
├── README.md       # Qué es este agente
├── INSTALACION.md  # Prerequisitos de tu stack
└── USO.md          # Cómo usarlo día a día
```

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

## Qué incluye cada agente generado

### Siempre (todos los roles):
- Wiki con estructura completa (SCHEMA, index, log, carpetas)
- Steering: confirmation-policy, wiki-policy, commit-conventions, sub-agent, workflow-gates
- Skills: flywheel (auto-mejora), post-mortem (documentar incidentes)
- Scripts: gitflow.ps1, gitflow-finish.ps1
- Hooks: prompt-context.ps1 (continuidad entre sesiones)
- Knowledge base con auto-indexing de wiki/
- Búsqueda web (Exa)

### Según el rol:
- Skills específicos (investigate-ticket, deploy, code-review, test-plan, etc.)
- MCP servers del stack (Jira, AWS Docs, DynamoDB, etc.)
- Steering adaptados (verification-checklist, error-patterns, domain-routing)
- Wiki con contenido inicial relevante al rol

## Prerequisitos

Ver [INSTALACION.md](INSTALACION.md) para la guía completa.

Mínimo:
- Windows 11
- Kiro CLI 2.2.1+
- Node.js 22+
- uv (para MCP servers Python)
