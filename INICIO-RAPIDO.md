# 🚀 Inicio Rápido — Generador de Agentes Kiro

## ✅ Estado de Prerequisitos

- ✅ Kiro CLI 2.2.0 instalado
- ✅ Node.js 24.15.0 instalado
- ✅ Git 2.49.0 instalado
- ✅ uv 0.11.16 instalado
- ⚠️ **Falta configurar**: API Key de Exa (opcional pero recomendado)

---

## Paso 1: Configurar API Key de Exa (Opcional)

El agente generador puede buscar en internet para obtener mejores prácticas del stack. Para habilitarlo:

1. **Obtener API Key**:
   - Ve a https://exa.ai/
   - Regístrate y obtén tu API key

2. **Configurar en PowerShell**:
   ```powershell
   # Abrir tu perfil de PowerShell
   notepad $PROFILE
   
   # Agregar esta línea al final:
   $env:EXA_API_KEY = "tu-api-key-aqui"
   
   # Guardar y recargar
   . $PROFILE
   ```

> **Nota**: Si no configuras Exa, el generador funcionará igual pero sin búsqueda web.

---

## Paso 2: Iniciar el Generador

Desde esta carpeta, ejecuta:

```powershell
kiro-cli chat --agent generador
```

El agente te saludará y comenzará la entrevista:

```
¡Hola! Soy el generador de agentes Kiro. Voy a crear un agente personalizado para ti.

¿Empezamos? Dime: ¿cuál es tu nombre y qué rol desempeñas? 
(backend, frontend, fullstack, devops, data, PM, QA, diseñador UI/UX, u otro)
```

---

## Paso 3: Responder la Entrevista

El agente te hará preguntas en **4 bloques**:

### Bloque 1 (Básico):
- Tu nombre
- Tu rol (backend, frontend, etc.)
- Stack que usas (lenguajes, frameworks, cloud, bases de datos)

### Bloque 2 (Proyectos):
- Repos que manejas (nombre, ruta, descripción)
- Gestor de tareas (Jira, etc.)
- Tareas frecuentes (bugs, features, deploys, etc.)

### Bloque 3 (Específico del rol):
- Según tu rol, preguntará sobre herramientas específicas
- Ejemplo: Si eres backend → AWS, Lambda, DynamoDB
- Ejemplo: Si eres frontend → Angular, testing, design system

### Bloque 4 (Personalidad):
- Cómo prefieres que te hable el agente
- Qué sueles olvidar (tests, docs, commits, etc.)

---

## Paso 4: El Agente Investiga

Si proporcionaste rutas de repos, el agente:
- Leerá archivos de configuración (package.json, template.yaml, etc.)
- Detectará el stack real
- Buscará mejores prácticas en internet (si configuraste Exa)

---

## Paso 5: Generación del Agente

El agente creará una carpeta completa en:

```
C:\Users\mespinoza\Projects\agente-{rol}-{nombre}\
```

Con esta estructura:

```
agente-{rol}-{nombre}/
├── .kiro/
│   ├── agents/              # Configuración del agente
│   ├── steering/            # Reglas y políticas
│   ├── skills/              # Habilidades especializadas
│   ├── scripts/             # Scripts de automatización
│   └── hooks/               # Hooks de eventos
├── wiki/                    # Knowledge base
│   ├── SCHEMA.md
│   ├── index.md
│   └── log.md
├── README.md                # Qué es este agente
├── INSTALACION.md           # Prerequisitos específicos
└── USO.md                   # Cómo usarlo día a día
```

---

## Paso 6: Usar tu Agente Generado

```powershell
cd C:\Users\mespinoza\Projects\agente-{rol}-{nombre}
kiro-cli chat --agent {rol}
```

El agente estará listo para ayudarte con:
- Desarrollo de features
- Debugging
- Code reviews
- Documentación
- Y todo lo específico de tu rol

---

## 🎯 Ejemplo de Uso

```powershell
# 1. Iniciar generador
cd "C:\Users\mespinoza\OneDrive - DEFONTANA\Documentos\Agente Personalizado\kiro-agentes"
kiro-cli chat --agent generador

# 2. Responder entrevista
# (El agente te guía)

# 3. Usar tu agente generado
cd C:\Users\mespinoza\Projects\agente-backend-miguel
kiro-cli chat --agent backend
```

---

## 📚 Recursos

- **Perfiles disponibles**: Ver carpeta `perfiles/` para ejemplos de cada rol
- **Plantilla base**: Ver carpeta `plantilla/` para archivos que se copian
- **Documentación completa**: Ver `README.md` y `INSTALACION.md`

---

## 🆘 Solución de Problemas

### Error: "uv no se reconoce"
```powershell
# Agregar al PATH de esta sesión
$env:Path = "C:\Users\mespinoza\.local\bin;$env:Path"

# O reiniciar PowerShell
```

### Error: "EXA_API_KEY no configurado"
- Es opcional, el generador funcionará sin búsqueda web
- Para habilitarlo, sigue el Paso 1

### Error: "kiro-cli no encontrado"
```powershell
# Instalar Kiro CLI
curl -fsSL https://cli.kiro.dev/install | bash
```

---

## ✨ ¡Listo para Empezar!

Ejecuta:
```powershell
kiro-cli chat --agent generador
```

Y deja que el agente te guíe. 🚀
