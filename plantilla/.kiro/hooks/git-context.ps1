# Hook: git-context
# Inyecta estado de git en el contexto del agente en cada prompt
# Activado en: userPromptSubmit

$status = git status --short 2>$null
$branch = git branch --show-current 2>$null
$lastCommit = git log --oneline -3 2>$null

if ($branch) {
    Write-Output "=== Git Context ==="
    Write-Output "Rama: $branch"
    if ($status) {
        Write-Output "Cambios pendientes:"
        Write-Output $status
    } else {
        Write-Output "Working tree limpio"
    }
    if ($lastCommit) {
        Write-Output "Ultimos commits:"
        Write-Output $lastCommit
    }
    Write-Output "==================="
}
