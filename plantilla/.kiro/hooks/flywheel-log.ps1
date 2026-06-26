# Hook: flywheel-log
# Registra resumen del turno en wiki/log.md para auto-mejora continua
# Activado en: stop (despues de cada respuesta del agente)

$logFile = "wiki/log.md"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"

# Agregar entry minimo de actividad para trazabilidad
if (Test-Path $logFile) {
    $entry = "`n<!-- flywheel-log: $timestamp -->"
    Add-Content -Path $logFile -Value $entry
}
