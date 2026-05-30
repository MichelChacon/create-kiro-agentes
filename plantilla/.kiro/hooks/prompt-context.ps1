# Inyectar contexto: último entry de log.md para continuidad entre sesiones
$logFile = "wiki/log.md"
if (Test-Path $logFile) {
    $lines = Get-Content $logFile
    $lastEntryStart = -1
    for ($i = $lines.Count - 1; $i -ge 0; $i--) {
        if ($lines[$i] -match '^## ') {
            $lastEntryStart = $i
            break
        }
    }
    if ($lastEntryStart -ge 0) {
        $entry = $lines[$lastEntryStart..($lines.Count - 1)] -join "`n"
        if ($entry.Trim() -ne "") {
            Write-Output $entry
        }
    }
}
