param(
    [switch]$Yes,
    [switch]$NoPush
)

function Invoke-Git {
    $output = & git @args 2>&1
    if ($LASTEXITCODE -ne 0) {
        $stderr = ($output | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }) -join "`n"
        throw "git $($args -join ' ') falló (exit $LASTEXITCODE): $stderr"
    }
    $output | Where-Object { $_ -isnot [System.Management.Automation.ErrorRecord] }
}

$currentBranch = git branch --show-current
if ($currentBranch -notmatch '^(release|hotfix)/') {
    Write-Host "ERROR: No estas en una rama release/* o hotfix/*. Rama actual: $currentBranch" -ForegroundColor Red
    exit 1
}

$type = $currentBranch.Split('/')[0]
$tag = $currentBranch.Split('/')[1]

Write-Host "=== Git Flow: Finalizar $type ===" -ForegroundColor Green
Write-Host "  Rama:   $currentBranch"
Write-Host "  Tag:    $tag"

if (-not $Yes) {
    $confirm = Read-Host "Continuar? (s/N)"
    if ($confirm -notmatch '^[sS]$') { exit 0 }
}

Write-Host "-> Merge a master..." -ForegroundColor Green
Invoke-Git checkout master
Invoke-Git pull origin master
Invoke-Git merge --no-ff $currentBranch -m "$type $tag"

Write-Host "-> Creando tag $tag..." -ForegroundColor Green
Invoke-Git tag -a $tag -m "$type $tag"

Write-Host "-> Merge a develop..." -ForegroundColor Green
Invoke-Git checkout develop
Invoke-Git pull origin develop
Invoke-Git merge --no-ff master -m "merge: master -> develop ($type $tag)"

Write-Host "-> Eliminando rama $currentBranch..." -ForegroundColor Green
Invoke-Git branch -d $currentBranch

if (-not $NoPush) {
    Write-Host "-> Pusheando cambios..." -ForegroundColor Green
    Invoke-Git push origin master develop --follow-tags
    & git push origin --delete $currentBranch 2>$null
    Write-Host "$type $tag completado y pusheado." -ForegroundColor Green
} else {
    Write-Host "$type $tag completado localmente." -ForegroundColor Green
    Write-Host "No se hizo push (--NoPush). Ejecuta manualmente:" -ForegroundColor Yellow
    Write-Host "  git push origin master develop --follow-tags" -ForegroundColor Yellow
}
