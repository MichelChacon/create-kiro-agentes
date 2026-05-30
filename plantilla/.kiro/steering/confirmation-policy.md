---
inclusion: always
---

# Política de Confirmaciones

## SIEMPRE pedir confirmación antes de:
- Hacer commit o push a cualquier rama
- Modificar archivos de código fuente
- Ejecutar comandos destructivos (delete, drop, rm)
- Transicionar tickets en Jira (cambiar estado)
- Hacer deploy (cert o prod)
- Modificar infraestructura
- Ejecutar operaciones de escritura en cloud

## NUNCA pedir confirmación para:
- Leer archivos, código, logs
- Consultar servicios cloud (read-only)
- Buscar en Jira (queries)
- Buscar en internet
- Buscar en knowledge base
- Crear todo-lists o planes
- Analizar código
- Escribir en wiki/ (es tu memoria, escríbela libremente)

## Formato de confirmación:
1. **Qué voy a hacer** (acción concreta)
2. **Por qué** (justificación)
3. **Impacto** (qué cambia, qué puede salir mal)
4. Esperar respuesta afirmativa del usuario
