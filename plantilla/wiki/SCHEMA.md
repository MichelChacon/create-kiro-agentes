---
title: Schema de la Wiki
updated: 2026-05-08
tags: [meta, schema]
---

# Wiki de Conocimiento — Schema

## Propósito
Esta wiki es la memoria persistente del agente. Acumula conocimiento de dominio, decisiones técnicas, lecciones aprendidas, patrones reutilizables y procesos.

## Estructura

```
wiki/
├── SCHEMA.md          ← Este archivo (cómo mantener la wiki)
├── index.md           ← Índice maestro de todas las páginas
├── log.md             ← Cronología de cambios (append-only)
├── domains/           ← Un archivo por módulo/sistema/proyecto
├── patterns/          ← Patrones técnicos reutilizables
├── decisions/         ← Architecture Decision Records
├── lessons/           ← Lecciones aprendidas y post-mortems
├── processes/         ← Flujos de trabajo del equipo
└── entities/          ← Catálogos (tablas, funciones, servicios, APIs)
```

## Convenciones

### Frontmatter obligatorio
```yaml
---
title: Nombre descriptivo
updated: YYYY-MM-DD
tags: [categoria, dominio]
sources: [TICKET-XXX, nombre-fuente]
---
```

### Cross-references
Usar [[wikilinks]] para conectar páginas:
- `[[domains/mi-proyecto]]` → página del módulo
- `[[lessons/bugs-comunes]]` → lecciones
- `[[decisions/2026-01-mi-decision]]` → decisión

### Naming
- Archivos: kebab-case.md
- Títulos: descriptivos en español

## Operaciones

### Ingest (cuando se aprende algo nuevo)
1. Buscar si ya existe una página relevante
2. Si existe → actualizar
3. Si no existe → crear en la categoría correcta
4. Actualizar index.md con la nueva entrada
5. Agregar entrada a log.md

### Query (cuando se necesita contexto)
1. Leer index.md para encontrar páginas relevantes
2. Leer las páginas necesarias
3. Seguir [[wikilinks]] para contexto adicional
