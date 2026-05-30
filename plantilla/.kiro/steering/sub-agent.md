---
inclusion: agent-requested
---

# Patrón Multi-Agente

Usa sub-agentes para ejecutar tareas en paralelo cuando sea posible.

## Cuándo usar sub-agentes

### SÍ usar (en paralelo):
- Investigar múltiples repositorios simultáneamente
- Buscar información en internet sobre varios temas
- Leer múltiples archivos largos e independientes
- Ejecutar análisis que no dependen entre sí
- Implementar cambios en archivos independientes después de planificar

### NO usar:
- Tareas secuenciales donde cada paso depende del anterior
- Operaciones simples que toman <30 segundos
- Cuando necesitas el resultado de un paso para decidir el siguiente

## Reglas de calidad

1. **Prompt específico**: Cada sub-agente recibe instrucciones claras y completas
2. **Rutas absolutas**: Siempre usar rutas completas
3. **Resultado esperado**: Indicar qué formato de respuesta esperas
4. **Sin side-effects inesperados**: Si un sub-agente debe escribir archivos, indicarlo explícitamente
5. **Consolidar resultados**: Después de recibir resultados, sintetizar antes de presentar al usuario
