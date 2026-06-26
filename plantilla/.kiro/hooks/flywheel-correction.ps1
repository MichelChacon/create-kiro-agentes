# Hook: flywheel-correction
# Detecta cuando el usuario corrige al agente y lo registra en wiki/log.md
# Activado en: userPromptSubmit

# Palabras clave que indican una correccion del usuario
$correctionPatterns = @(
    'no.*correcto', 'esta.*mal', 'te.*equivocas', 'error', 'incorrecto',
    'eso.*no', 'no era', 'no es eso', 'no sirve', 'esta.*roto',
    'te equivocaste', 'lo hiciste mal', 'no funciona'
)

# Leer el prompt del usuario (viene por stdin o variable de entorno)
$userInput = $env:KIRO_USER_PROMPT

if ($userInput) {
    $isCorrection = $correctionPatterns | Where-Object { $userInput -match $_ }
    if ($isCorrection) {
        $logFile = "wiki/log.md"
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        if (Test-Path $logFile) {
            $entry = "`n<!-- correction-signal: $timestamp - '$($userInput.Substring(0, [Math]::Min(80, $userInput.Length)))' -->"
            Add-Content -Path $logFile -Value $entry
        }
    }
}
