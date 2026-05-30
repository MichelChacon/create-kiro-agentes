param(
    [Parameter(Mandatory)][ValidateSet("release","hotfix")][string]$Type,
    [switch]$Yes,
    [switch]$DryRun
)

function Invoke-Git {
    $output = & git @args 2>&1
    if ($LASTEXITCODE -ne 0) {
        $stderr = ($output | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }) -join "`n"
        throw "git $($args -join ' ') falló (exit $LASTEXITCODE): $stderr"
    }
    $output | Where-Object { $_ -isnot [System.Management.Automation.ErrorRecord] }
}

$dirty = git status --porcelain
if ($dirty) {
    Write-Host "ERROR: Hay cambios sin commitear. Commitea o stashea primero." -ForegroundColor Red
    git status --short
    exit 1
}

Write-Host "Actualizando master y develop..." -ForegroundColor Green
Invoke-Git checkout master
Invoke-Git pull origin master
Invoke-Git checkout develop
Invoke-Git pull origin develop

$allTags = git tag -l | Where-Object { $_ -match '^\d+\.\d+\.\d+$' }
$lastTag = $allTags | Sort-Object { [version]$_ } | Select-Object -Last 1
if (-not $lastTag) { $lastTag = "0.0.0" }
$parts = $lastTag.Split('.')
$major = [int]$parts[0]; $minor = [int]$parts[1]; $patch = [int]$parts[2]

if ($Type -eq "release") {
    $newMinor = $minor + 1
    $newTag = "$major.$newMinor.0"
    while ($allTags -contains $newTag) { $newMinor++; $newTag = "$major.$newMinor.0" }
    $baseBranch = "develop"
} else {
    $newPatch = $patch + 1
    $newTag = "$major.$minor.$newPatch"
    while ($allTags -contains $newTag) { $newPatch++; $newTag = "$major.$minor.$newPatch" }
    $baseBranch = "master"
}

$branchName = "$Type/$newTag"

Write-Host "=== Git Flow: Iniciar $Type ===" -ForegroundColor Green
Write-Host "  Ultimo tag:  $lastTag"
Write-Host "  Nuevo tag:   $newTag"
Write-Host "  Rama base:   $baseBranch"
Write-Host "  Rama nueva:  $branchName"

if ($DryRun) { Write-Host "[dry-run] No se ejecutaron cambios."; exit 0 }

if (-not $Yes) {
    $confirm = Read-Host "Continuar? (s/N)"
    if ($confirm -notmatch '^[sS]$') { exit 0 }
}

Invoke-Git checkout $baseBranch
Invoke-Git checkout -b $branchName

Write-Host "Rama '$branchName' creada desde '$baseBranch'" -ForegroundColor Green
