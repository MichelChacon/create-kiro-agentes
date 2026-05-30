---
name: post-mortem
description: Documentar un incidente o bug no trivial. Activar con "post-mortem", "documentar incidente", "registrar lección", "qué aprendí".
---

# Post-Mortem

## Flujo

### 1. Recopilar hechos
- ¿Qué falló? (síntoma visible)
- ¿Cuál fue la causa raíz?
- ¿Qué impacto tuvo?
- ¿Cómo se detectó?
- ¿Cómo se resolvió?

### 2. Identificar lecciones
- ¿Qué asumimos mal?
- ¿Qué regla nueva se deriva?
- ¿Hay patrón de error que agregar a error-patterns.md?

### 3. Escribir en wiki
- Crear `wiki/lessons/YYYY-MM-DD-nombre-descriptivo.md`
- Estructura: Contexto → Error(es) → Regla → Fix aplicado
- Actualizar `wiki/index.md` con link
- Append a `wiki/log.md`

### 4. Actualizar error-patterns.md si aplica
- Si el error es reconocible por un síntoma → agregar fila a la tabla

### 5. Confirmar con usuario
- Mostrar borrador antes de escribir
- Preguntar si falta algo
