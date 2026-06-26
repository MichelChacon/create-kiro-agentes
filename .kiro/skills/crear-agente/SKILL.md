---
name: crear-agente
description: Crear un agente Kiro personalizado por rol. Activar cuando el usuario diga "quiero crear mi agente", "crear agente", "generar agente", "empezar", o al inicio de la conversación.
---

# Crear Agente Personalizado

## Flujo completo

### Fase 1: Entrevista

Hacer preguntas en bloques. Esperar respuesta antes de pasar al siguiente.

#### Bloque 1 — Identidad (OBLIGATORIO)
```
1. ¿Cuál es tu nombre?
2. ¿Cuál es tu rol?
   - Backend developer
   - Frontend developer
   - Full Stack developer
   - DevOps / SRE
   - Data Engineer
   - Product Manager
   - QA Engineer
   - Diseñador UI/UX
   - Otro (describir)
3. ¿Qué stack usas día a día?
   (lenguajes, frameworks, cloud provider, bases de datos, herramientas)
```

#### Bloque 2 — Contexto de trabajo
```
4. ¿Qué proyectos/repos manejas?
   (nombre, ruta local en tu PC, qué hace cada uno)
5. ¿Usas Jira u otro gestor de tickets?
   - Si sí: ¿URL, proyecto, tu usuario/email?
6. ¿Qué tareas haces más seguido?
   (bugs, features, deploys, code review, diseño, specs, testing, etc.)
```

#### Bloque 2.5 — Documentación existente
```
9. ¿Tienes documentación que el agente debería conocer?
   (wikis, Confluence, Notion, docs internos, diagramas, ADRs, runbooks, Swagger/OpenAPI, READMEs de docs)
   - Para cada uno: nombre descriptivo + ruta local o URL
   - Ejemplos: "Wiki del equipo → C:\docs\wiki", "API docs → https://confluence.empresa.com/api-docs"
10. ¿Hay repos de documentación (no código) que debería indexar?
    (mono-repos de docs, repos de arquitectura, etc.)
```

Si el usuario proporciona documentación:
- Rutas locales → se copiarán/indexarán en `wiki/` del agente generado
- URLs → se agregarán como referencias en `wiki/index.md` y steering `domain-routing.md`
- Contenido relevante se usará para pre-poblar `wiki/domains/` y `wiki/patterns/`

#### Bloque 3 — Condicional según rol
Preguntar SOLO las relevantes:

| Condición | Preguntas |
|-----------|-----------|
| Usa cloud (AWS/GCP/Azure) | ¿Perfiles/cuentas? ¿Servicios principales? ¿Región? |
| Frontend | ¿Design system? ¿Testing (Cypress, Playwright, Jest)? ¿SSR/SSG? |
| DevOps | ¿CI/CD (Jenkins, GitHub Actions, CodePipeline)? ¿IaC? ¿Monitoreo? |
| Data | ¿Pipelines (Airflow, Step Functions)? ¿Warehouse? ¿Formato datos? |
| PM | ¿Metodología (Scrum, Kanban)? ¿Docs (Confluence, Notion)? |
| QA | ¿Manual, automatizado, ambos? ¿Herramientas? ¿Tipos de testing? |
| Diseñador | ¿Figma? ¿Design tokens? ¿Cómo haces handoff a devs? |

#### Bloque 4 — Personalidad
```
7. ¿Cómo prefieres que te hable el agente?
   (directo y conciso / detallado / con humor / formal)
8. ¿Hay algo que SIEMPRE olvidas o te cuesta?
   (tests, documentación, commits descriptivos, estimar, etc.)
```

**NO avanzar a Fase 2 sin tener al menos: nombre, rol, stack, y al menos 1 repo o proyecto.**

---

### Fase 2: Investigación de repos

Para cada repo que el usuario proporcionó:

1. **Verificar que existe**: `Test-Path <ruta>`
2. **Leer configuración**:
   - Node.js: `package.json` (scripts, dependencies, devDependencies)
   - Python: `pyproject.toml`, `requirements.txt`
   - Java: `pom.xml`, `build.gradle`
   - .NET: `*.csproj`, `*.sln`
   - Angular: `angular.json`, `tsconfig.json`
   - AWS SAM: `template.yaml`, `samconfig.yaml`
   - Terraform: `main.tf`, `variables.tf`
   - General: `Makefile`, `Dockerfile`, `.github/workflows/`
3. **Detectar**:
   - Runtime y versión
   - Framework principal
   - Test runner
   - Linter/formatter
   - Build tool
   - Deploy method
4. **Estructura**: `read` con mode Directory, depth 2
5. **Documentación proporcionada**:
   - Rutas locales: verificar existencia, leer estructura, extraer contenido clave
   - URLs: intentar leer con `web_fetch`, extraer estructura y temas principales
   - Clasificar: ¿es referencia de API? ¿arquitectura? ¿procesos? ¿decisiones?

Si necesita info del stack que no conoce → buscar con `@aws-documentation`.

---

### Fase 3: Selección de perfil

1. Leer el perfil correspondiente en `perfiles/{rol}.md`
2. Cruzar con la info de la entrevista
3. Determinar:
   - Skills a incluir (compartidos + específicos del rol)
   - MCP servers necesarios
   - Steering adicionales
   - Contenido de verification-checklist

---

### Fase 4: Generación

#### Ruta de output
```
C:\Users\{usuario-windows}\Projects\agente-{rol}-{nombre}\
```
- `{usuario-windows}`: inferir de las rutas de repos (ej: `claudio.uribe`)
- `{rol}`: kebab-case (backend, frontend, devops, data, product-manager, qa, disenador-ux)
- `{nombre}`: primer nombre en minúsculas (ej: claudio, maria)

#### Archivos a COPIAR de plantilla/ (leer y escribir tal cual):
```
plantilla/.kiro/steering/confirmation-policy.md
plantilla/.kiro/steering/wiki-policy.md
plantilla/.kiro/steering/commit-conventions.md
plantilla/.kiro/steering/sub-agent.md
plantilla/.kiro/steering/workflow-gates.md
plantilla/.kiro/skills/flywheel/SKILL.md
plantilla/.kiro/skills/post-mortem/SKILL.md
plantilla/.kiro/scripts/gitflow.ps1
plantilla/.kiro/scripts/gitflow-finish.ps1
plantilla/.kiro/hooks/prompt-context.ps1
plantilla/wiki/SCHEMA.md
```

#### Archivos a GENERAR dinámicamente:

| Archivo | Fuente de datos |
|---------|----------------|
| `.kiro/agents/{rol}.json` | Stack → MCP servers, tools, hooks |
| `.kiro/agents/{rol}-prompt.md` | Entrevista completa + perfil |
| `.kiro/steering/identity.md` | Nombre, rol, dominios, personalidad |
| `.kiro/steering/verification-checklist.md` | Stack (qué verificar) |
| `.kiro/steering/domain-routing.md` | Repos + perfiles cloud |
| `.kiro/steering/error-patterns.md` | Tabla vacía con headers |
| `.kiro/hooks/agent-spawn.ps1` | Perfiles cloud (o mínimo sin cloud) |
| `.kiro/skills/review-board/SKILL.md` | Proyecto Jira + usuario |
| `.kiro/skills/investigate-ticket/SKILL.md` | Stack + repos |
| `wiki/index.md` | Dominios del usuario |
| `wiki/log.md` | Entry: "Agente creado" |
| `wiki/domains/{nombre-doc}.md` | Documentación proporcionada por usuario (resumen + referencia) |
| `README.md` | Resumen del agente |
| `INSTALACION.md` | Prerequisitos de SU stack |
| `USO.md` | Casos de uso del rol |

#### Skills adicionales según rol (generar si aplica):
- **Todos los devs** (backend, frontend, devops, data): plan-feature, deploy-cert, deploy-prod, pre-deploy-check, add-domain, code-review, write-tests, estimate-effort
- **PM**: refine-requirements, write-specs, estimate-effort, plan-feature
- **QA**: code-review, write-tests, refine-requirements, write-specs, test-plan, bug-report
- **Diseñador**: refine-requirements, write-specs, design-review

---

### Fase 5: Documento USO.md

Generar con esta estructura:

```markdown
# Cómo usar tu agente — {Nombre} ({Rol})

## Iniciar
\`\`\`powershell
cd C:\Users\{usuario}\Projects\agente-{rol}-{nombre}
kiro-cli chat --agent {rol}
\`\`\`

## Skills disponibles

| Skill | Cómo activarlo | Qué hace |
|-------|---------------|----------|
| ... | ... | ... |

## Casos de uso

### [Caso 1 relevante al rol]
> "prompt de ejemplo"
Descripción de qué hace el agente.

### [Caso 2]
...

## Tips
- [tip 1 relevante al rol]
- [tip 2]
```

Los casos de uso deben ser REALES para el rol, no genéricos.

---

### Fase 6: Resumen final

Presentar al usuario:
1. Ruta donde se creó el agente
2. Cantidad de archivos generados
3. Comando para iniciar
4. Contenido resumido de USO.md
5. Sugerencia: "Puedes agregar más dominios después con el skill `add-domain`"

---

## Herramientas a usar

| Herramienta | Para qué |
|-------------|----------|
| `read` | Leer repos del usuario, leer plantillas |
| `write` | Crear todos los archivos del agente |
| `glob` | Explorar estructura de repos |
| `grep` | Buscar patterns en repos |
| `@aws-documentation` | Buscar mejores prácticas del stack |
| `knowledge` | Consultar perfiles de rol |
| `todo_list` | Trackear progreso de generación |

## Reglas críticas

1. **No generar sin entrevista completa** — Mínimo: nombre, rol, stack, 1 repo
2. **Naming**: `{rol}.json`, `{rol}-prompt.md` — SIN "-engineer"
3. **Windows por defecto. Si el usuario usa Linux/Mac, adaptar rutas y scripts** — Hooks en .ps1, rutas con backslash
4. **Leer perfil antes de generar** — `perfiles/{rol}.md` tiene la guía
5. **Output autónomo** — El agente generado no depende de kiro-agentes/
6. **USO.md obligatorio** — Es el onboarding del usuario con su agente
