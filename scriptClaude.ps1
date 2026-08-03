#Requires -Version 5.1

<#
.SYNOPSIS
  Instala una seleccion verificada de plugins y skills para Claude Code,
  orientada a desarrollo full stack.

.DESCRIPTION
  - No intenta leer ni interpretar el cache local de marketplaces.
  - Usa identificadores oficiales verificados: plugin@marketplace.
  - Actualiza cada marketplace y reintenta una vez si una instalacion falla.
  - Puede ejecutarse varias veces sin romper instalaciones existentes.
  - Instala dependencias LSP de TypeScript y Python mediante npm cuando existe.

.EXAMPLE
  .\Install-Claude-FullStack-v4.ps1

.EXAMPLE
  .\Install-Claude-FullStack-v4.ps1 -SkipCommunity -SkipIntegrations
#>

[CmdletBinding()]
param(
    [ValidateSet('user', 'project', 'local')]
    [string]$Scope = 'user',

    [switch]$SkipCommunity,
    [switch]$SkipIntegrations,
    [switch]$SkipLspDependencies
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:ClaudeExe = $null
$script:NpmExe = $null
$script:Installed = [System.Collections.Generic.List[string]]::new()
$script:AlreadyPresent = [System.Collections.Generic.List[string]]::new()
$script:Failed = [System.Collections.Generic.List[string]]::new()

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Title)

    Write-Host ''
    Write-Host ('=' * 78) -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host ('=' * 78) -ForegroundColor DarkCyan
}

function Refresh-ProcessPath {
    $machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

    $paths = @()
    foreach ($value in @($machinePath, $userPath, $env:Path)) {
        if (-not [string]::IsNullOrWhiteSpace($value)) {
            $paths += $value -split ';'
        }
    }

    $paths += @(
        (Join-Path $env:APPDATA 'npm'),
        (Join-Path $env:ProgramFiles 'nodejs'),
        (Join-Path $env:LOCALAPPDATA 'Programs\nodejs'),
        (Join-Path $HOME '.local\bin')
    )

    $env:Path = (($paths |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        Select-Object -Unique) -join ';')
}

function Resolve-Executable {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [string[]]$Candidates = @()
    )

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($null -ne $command) {
        return $command.Source
    }

    foreach ($candidate in $Candidates) {
        if (-not [string]::IsNullOrWhiteSpace($candidate) -and
            (Test-Path -LiteralPath $candidate)) {
            return $candidate
        }
    }

    return $null
}

function Invoke-External {
    param(
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Description
    )

    Write-Host "`n>> $Description" -ForegroundColor Yellow

    $lines = @(& $Executable @Arguments 2>&1)
    $exitCode = $LASTEXITCODE
    $text = ($lines | ForEach-Object { [string]$_ }) -join [Environment]::NewLine

    if (-not [string]::IsNullOrWhiteSpace($text)) {
        Write-Host $text
    }

    return [pscustomobject]@{
        Success = ($exitCode -eq 0)
        ExitCode = $exitCode
        Output = $text
    }
}

function Invoke-Claude {
    param(
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Description
    )

    return Invoke-External `
        -Executable $script:ClaudeExe `
        -Arguments $Arguments `
        -Description $Description
}

function Test-AlreadyConfiguredMessage {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return $false
    }

    return $Text -match '(?i)(already installed|already added|already exists|already configured|already present|is installed)'
}

function Backup-ClaudeSettings {
    $claudeHome = Join-Path $HOME '.claude'
    if (-not (Test-Path -LiteralPath $claudeHome)) {
        return
    }

    $backupRoot = Join-Path $claudeHome 'backups'
    $backupPath = Join-Path $backupRoot (Get-Date -Format 'yyyyMMdd-HHmmss')
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    $copied = $false
    foreach ($name in @('settings.json', 'settings.local.json')) {
        $source = Join-Path $claudeHome $name
        if (Test-Path -LiteralPath $source) {
            Copy-Item -LiteralPath $source -Destination $backupPath -Force
            $copied = $true
        }
    }

    if ($copied) {
        Write-Host "Respaldo de configuracion: $backupPath" -ForegroundColor Green
    }
}

function Ensure-Marketplace {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Name
    )

    # Primero intenta actualizar. Esto cubre marketplaces integrados o ya registrados.
    $update = Invoke-Claude `
        -Arguments @('plugin', 'marketplace', 'update', $Name) `
        -Description "Actualizar marketplace $Name"

    if ($update.Success) {
        return
    }

    # Si todavia no existe, lo registra y vuelve a actualizar.
    $add = Invoke-Claude `
        -Arguments @('plugin', 'marketplace', 'add', $Source, '--scope', $Scope) `
        -Description "Registrar marketplace $Name"

    if (-not $add.Success -and -not (Test-AlreadyConfiguredMessage -Text $add.Output)) {
        throw "No se pudo registrar el marketplace '$Name'.`n$($add.Output)"
    }

    $retryUpdate = Invoke-Claude `
        -Arguments @('plugin', 'marketplace', 'update', $Name) `
        -Description "Actualizar marketplace $Name despues de registrarlo"

    if (-not $retryUpdate.Success) {
        throw "No se pudo actualizar el marketplace '$Name'.`n$($retryUpdate.Output)"
    }
}

function Install-ClaudePlugin {
    param(
        [Parameter(Mandatory = $true)][string]$Plugin,
        [Parameter(Mandatory = $true)][string]$Marketplace
    )

    $identifier = "$Plugin@$Marketplace"

    $first = Invoke-Claude `
        -Arguments @('plugin', 'install', $identifier, '--scope', $Scope) `
        -Description "Instalar $identifier"

    if ($first.Success) {
        $script:Installed.Add($identifier)
        return
    }

    if (Test-AlreadyConfiguredMessage -Text $first.Output) {
        $script:AlreadyPresent.Add($identifier)
        return
    }

    Write-Host "Reintentando $identifier despues de actualizar el marketplace..." -ForegroundColor DarkYellow

    $refresh = Invoke-Claude `
        -Arguments @('plugin', 'marketplace', 'update', $Marketplace) `
        -Description "Refrescar marketplace $Marketplace"

    if (-not $refresh.Success) {
        $script:Failed.Add($identifier)
        Write-Warning "No se pudo actualizar '$Marketplace'. Se omite '$identifier'."
        return
    }

    $second = Invoke-Claude `
        -Arguments @('plugin', 'install', $identifier, '--scope', $Scope) `
        -Description "Segundo intento: instalar $identifier"

    if ($second.Success) {
        $script:Installed.Add($identifier)
    }
    elseif (Test-AlreadyConfiguredMessage -Text $second.Output) {
        $script:AlreadyPresent.Add($identifier)
    }
    else {
        $script:Failed.Add($identifier)
        Write-Warning "No se pudo instalar '$identifier'. El instalador continuara."
    }
}

Write-Section 'INSTALADOR CLAUDE CODE FULL STACK V4'
Write-Host "Ambito: $Scope" -ForegroundColor Cyan
Write-Host 'Esta version instala directamente desde los marketplaces, sin validar caches locales.' -ForegroundColor Cyan

Write-Section '1. RECUPERAR PATH Y LOCALIZAR CLAUDE CODE'

Refresh-ProcessPath

$npmCandidates = @(
    (Join-Path $env:ProgramFiles 'nodejs\npm.cmd'),
    (Join-Path $env:APPDATA 'npm\npm.cmd')
)

$claudeCandidates = @(
    (Join-Path $env:APPDATA 'npm\claude.cmd'),
    (Join-Path $env:APPDATA 'npm\claude.exe'),
    (Join-Path $env:APPDATA 'npm\node_modules\@anthropic-ai\claude-code\bin\claude.exe'),
    (Join-Path $HOME '.local\bin\claude.exe'),
    (Join-Path $HOME '.local\bin\claude')
)

$script:NpmExe = Resolve-Executable -Name 'npm' -Candidates $npmCandidates
$script:ClaudeExe = Resolve-Executable -Name 'claude' -Candidates $claudeCandidates

if ($null -eq $script:ClaudeExe) {
    if ($null -eq $script:NpmExe) {
        throw @"
No se encontro Claude Code ni npm.
Instala Node.js LTS con la opcion Add to PATH, cierra todas las terminales y ejecuta de nuevo el archivo CMD.
"@
    }

    $installClaude = Invoke-External `
        -Executable $script:NpmExe `
        -Arguments @('install', '--global', '@anthropic-ai/claude-code@latest') `
        -Description 'Instalar Claude Code'

    if (-not $installClaude.Success) {
        throw "No se pudo instalar Claude Code.`n$($installClaude.Output)"
    }

    Refresh-ProcessPath
    $script:ClaudeExe = Resolve-Executable -Name 'claude' -Candidates $claudeCandidates

    if ($null -eq $script:ClaudeExe) {
        throw 'Claude Code se instalo, pero no aparece en PATH. Cierra y vuelve a abrir PowerShell.'
    }
}

Write-Host "Claude Code: $(& $script:ClaudeExe --version)" -ForegroundColor Green
Write-Host "Ejecutable: $script:ClaudeExe" -ForegroundColor DarkGreen

if ($null -ne $script:NpmExe) {
    Write-Host "npm: $(& $script:NpmExe --version)" -ForegroundColor Green
}

Backup-ClaudeSettings

$doctor = Invoke-Claude `
    -Arguments @('doctor') `
    -Description 'Ejecutar diagnostico de Claude Code'

if (-not $doctor.Success) {
    Write-Warning 'Claude doctor devolvio observaciones, pero la instalacion continuara.'
}

Write-Section '2. PREPARAR MARKETPLACES'

Ensure-Marketplace `
    -Source 'anthropics/claude-plugins-official' `
    -Name 'claude-plugins-official'

Ensure-Marketplace `
    -Source 'anthropics/skills' `
    -Name 'anthropic-agent-skills'

if (-not $SkipCommunity) {
    Ensure-Marketplace `
        -Source 'jeffallan/claude-skills' `
        -Name 'fullstack-dev-skills'
}

Write-Section '3. DEPENDENCIAS LSP'

if (-not $SkipLspDependencies -and $null -ne $script:NpmExe) {
    $lsp = Invoke-External `
        -Executable $script:NpmExe `
        -Arguments @('install', '--global', 'typescript@latest', 'typescript-language-server@latest', 'pyright@latest') `
        -Description 'Instalar TypeScript Language Server y Pyright'

    if (-not $lsp.Success) {
        Write-Warning 'Las dependencias LSP no pudieron instalarse. Los demas plugins continuaran.'
    }
}
else {
    Write-Host 'Dependencias LSP omitidas.' -ForegroundColor DarkYellow
}

Write-Section '4. PLUGINS OFICIALES ESENCIALES'

$officialPlugins = @(
    'claude-code-setup',
    'claude-md-management',
    'feature-dev',
    'code-review',
    'code-simplifier',
    'frontend-design',
    'security-guidance',
    'claude-security',
    'skill-creator',
    'plugin-dev',
    'commit-commands',
    'typescript-lsp',
    'pyright-lsp'
)

foreach ($plugin in $officialPlugins) {
    Install-ClaudePlugin `
        -Plugin $plugin `
        -Marketplace 'claude-plugins-official'
}

if (-not $SkipIntegrations) {
    Write-Section '5. INTEGRACIONES FULL STACK'

    foreach ($plugin in @('github', 'context7', 'playwright')) {
        Install-ClaudePlugin `
            -Plugin $plugin `
            -Marketplace 'claude-plugins-official'
    }
}
else {
    Write-Host 'Integraciones externas omitidas.' -ForegroundColor DarkYellow
}

Write-Section '6. AGENT SKILLS OFICIALES DE ANTHROPIC'

foreach ($plugin in @('document-skills', 'example-skills', 'claude-api')) {
    Install-ClaudePlugin `
        -Plugin $plugin `
        -Marketplace 'anthropic-agent-skills'
}

if (-not $SkipCommunity) {
    Write-Section '7. PAQUETE FULL STACK COMUNITARIO'

    Install-ClaudePlugin `
        -Plugin 'fullstack-dev-skills' `
        -Marketplace 'fullstack-dev-skills'
}
else {
    Write-Host 'Paquete comunitario omitido.' -ForegroundColor DarkYellow
}

Write-Section '8. VERIFICACION FINAL'

$marketplaces = Invoke-Claude `
    -Arguments @('plugin', 'marketplace', 'list') `
    -Description 'Mostrar marketplaces registrados'

if (-not $marketplaces.Success) {
    Write-Warning 'No se pudo mostrar la lista de marketplaces.'
}

$plugins = Invoke-Claude `
    -Arguments @('plugin', 'list') `
    -Description 'Mostrar plugins instalados'

if (-not $plugins.Success) {
    Write-Warning 'No se pudo mostrar la lista final de plugins.'
}

Write-Section 'RESULTADO'

Write-Host "Instalados en esta ejecucion: $($script:Installed.Count)" -ForegroundColor Green
foreach ($item in $script:Installed) {
    Write-Host "  [OK] $item" -ForegroundColor Green
}

Write-Host "`nYa instalados: $($script:AlreadyPresent.Count)" -ForegroundColor DarkGreen
foreach ($item in $script:AlreadyPresent) {
    Write-Host "  [EXISTENTE] $item" -ForegroundColor DarkGreen
}

if ($script:Failed.Count -gt 0) {
    Write-Host "`nFallidos: $($script:Failed.Count)" -ForegroundColor Red
    foreach ($item in $script:Failed) {
        Write-Host "  [FALLO] $item" -ForegroundColor Red
    }

    Write-Host ''
    Write-Host 'Alguno de los plugins no pudo instalarse. Revisa el mensaje exacto mostrado encima.' -ForegroundColor Yellow
}
else {
    Write-Host ''
    Write-Host 'Todos los plugins solicitados quedaron instalados o ya estaban presentes.' -ForegroundColor Green
}

Write-Host ''
Write-Host 'Siguiente paso:' -ForegroundColor Cyan
Write-Host '  1. Abre Claude Code con: claude' -ForegroundColor Cyan
Write-Host '  2. Ejecuta: /reload-plugins' -ForegroundColor Cyan
Write-Host '  3. Revisa: /plugin' -ForegroundColor Cyan
Write-Host ''