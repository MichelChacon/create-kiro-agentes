---
inclusion: agent-requested
---

# Convenciones de Commits

Conventional Commits en español.

## Formato
```
<tipo>(<módulo>): <descripción>
```

## Tipos
| Tipo | Cuándo |
|------|--------|
| `fix` | Corrección de bug |
| `feat` | Funcionalidad nueva |
| `refactor` | Cambio de código sin cambiar comportamiento |
| `chore` | Mantenimiento, config, dependencias |
| `docs` | Solo documentación |
| `test` | Agregar o corregir tests |
| `style` | Formato, linting (sin cambio de lógica) |

## Reglas
- Descripción en español, imperativo, minúsculas
- Módulo = nombre del dominio o componente
- Si hay ticket, incluir al final: `fix(modulo): corregir cálculo PROJ-450`
- Máximo 72 caracteres en la primera línea
