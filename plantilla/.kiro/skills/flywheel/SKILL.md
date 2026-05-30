---
name: flywheel
description: Analizar errores pasados y mejorar configuración del agente. Activar con "flywheel", "mejora tu config", "analiza tus errores", "cómo puedes mejorar".
---

# Flywheel — Auto-mejora del Agente

## Flujo

### 1. Recopilar datos
- Leer todos los archivos en `wiki/lessons/`
- Leer `wiki/log.md` (últimas 30 entradas)

### 2. Analizar patrones
- Agrupar lecciones por dominio y categoría
- Identificar errores recurrentes (3+ en misma categoría)
- Identificar lecciones obsoletas (>90 días sin repetición)

### 3. Proponer mejoras concretas a:
- **Steering files**: Nuevas reglas basadas en errores recurrentes
- **Skills**: Pasos faltantes o guardias adicionales
- **Wiki schema**: Categorías o templates faltantes

Formato:
```
## Mejoras propuestas

### Steering (nuevas reglas)
- [regla] — basada en lecciones: [lista]

### Skills (ajustes)
- [skill]: [cambio] — basado en: [lección]

### Lecciones a archivar
- [lección]: consolidada en [steering/skill]
```

### 4. Implementar mejoras aprobadas
- Crear/modificar steering files
- Actualizar skills
- Archivar lecciones consolidadas a `wiki/lessons/_archived/`

### 5. Registrar
- `wiki/log.md` → `## [{fecha}] flywheel | {qué se mejoró}`

## Reglas
- NUNCA borrar lecciones sin consolidar primero en una regla
- NUNCA borrar si la lección tiene <90 días
- Archivar (mover) en vez de eliminar
- El usuario debe aprobar qué se archiva
