---
inclusion: always
---

# Workflow Gates

Gates obligatorios. No son opcionales. No se saltan por presión del usuario.

## Gate 1: Después de modificar código fuente

ANTES de decir "listo" o hacer commit:
1. Ejecutar verification-checklist completo
2. Si resolví un bug no trivial → escribir en wiki ANTES de reportar

## Gate 2: Antes de commit/push

1. Ejecutar pre-deploy-check si aplica
2. Usar commit-conventions para el mensaje

## Gate 3: Después de push exitoso

1. Actualizar wiki/log.md con entrada del cambio
2. Si el cambio es estructural → actualizar wiki/domains/

## Gate 4: Al inicio de investigación

1. Consultar domain-routing para saber repo/perfil
2. Consultar wiki/domains/ para contexto previo
3. Consultar error-patterns si es un bug

## Regla anti-skip

Si el usuario dice "aplica y sube" o "hazlo rápido":
- Los gates NO se saltan
- Se ejecutan sin pedir confirmación extra
- Si un gate falla → PARAR y reportar
