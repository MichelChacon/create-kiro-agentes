# Contribuir a create-kiro-agentes

Gracias por aportar! Este proyecto ayuda a profesionales que trabajan en AWS a configurar agentes Kiro personalizados en minutos.

## Principio rector: generacion real, no inventada

Todo perfil, hook y skill debe probarse en un caso real. Lo que no se pueda verificar con una ejecucion real del generador se marca [verificar en produccion].

## Como aportar

- **Agregar un perfil nuevo:** crea perfiles/{rol}.md siguiendo la estructura existente (Scope Exclusions, Forbidden Phrases, MCP Servers, Tools, Skills, Steering, Hooks, Wiki).
- **Mejorar el cuestionario:** modifica .kiro/agents/generador-prompt.md. Cada pregunta nueva debe cambiar algo concreto en el agente generado.
- **Agregar un hook:** crea el .ps1 o .kiro.hook en plantilla/.kiro/hooks/. Documenta cuando se activa. Verifica que no rompa los hooks existentes.
- **Mejorar la plantilla base:** cualquier cambio en plantilla/ afecta a TODOS los agentes generados. Testear con al menos 2 roles.
- **Mejorar un skill:** los skills en plantilla/.kiro/skills/ deben ser genericos. Sin referencias a stacks especificos.

## Flujo de trabajo (git)

1. Forkea el repo.
2. Crea una rama descriptiva: tipo/descripcion-corta (ej. feat/perfil-ml-engineer, fix/hook-flywheel).
3. Conventional Commits en espanol: tipo(scope): descripcion (fix, feat, docs, refactor, chore).
4. Abre un Pull Request contra main describiendo el cambio y como lo probaste.
5. Espera al menos una revision. No se commitea directo a main.

## Que hace un buen perfil

Un perfil es util cuando:
- Define claramente que NO hace ese rol (Scope Exclusions)
- Tiene Forbidden Phrases reales
- Los MCP servers son los que ese rol realmente usa dia a dia
- Los skills reflejan las tareas mas frecuentes
- El verification-checklist tiene items concretos

## Estilo

- Contenido en espanol.
- Sin referencias a empresas, personas o proyectos especificos.
- Los ejemplos de prompts en USO.md deben ser casos de uso reales.
- Placeholders genericos: {tu-empresa}, {tu-proyecto}, {tu-usuario}.

## Aviso

Este proyecto genera configuraciones de agentes. La calidad del agente generado depende de las respuestas del cuestionario. Las contribuciones se publican bajo la licencia MIT.
