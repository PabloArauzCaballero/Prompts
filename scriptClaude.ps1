#Requires -Version 5.1

# Este archivo debe ejecutarse como archivo .ps1.
# No copies y pegues su contenido linea por linea dentro de PowerShell.
# Usa el archivo Ejecutar-Claude-FullStack-v3.cmd incluido.

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:Installed = @()
$script:Skipped = @()
$script:Failed = @()
$script:Catalogs = @()
$script:ClaudeExe = $null
$script:NpmExe = $null

function Write-Section {
    param([Parameter(Mandatory = $true)][string]$Title)

    Write-Host ''
    Write-Host ('=' * 76) -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host ('=' * 76) -ForegroundColor DarkCyan
}

function Refresh-ProcessPath {
    $machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

    $extraPaths = @(
        (Join-Path $env:APPDATA 'npm'),
        (Join-Path $env:ProgramFiles 'nodejs'),
        (Join-Path $env:LOCALAPPDATA 'Programs\nodejs'),
        (Join-Path $HOME '.local\bin')
    )

    $allPaths = @()
    foreach ($pathGroup in @($machinePath, $userPath)) {
        if (-not [string]::IsNullOrWhiteSpace($pathGroup)) {
            $allPaths += $pathGroup -split ';'
        }
    }
    $allPaths += $extraPaths

    $env:Path = (($allPaths |
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
        if (-not [string]::IsNullOrWhiteSpace($candidate) -and (Test-Path -LiteralPath $candidate)) {
            return $candidate
        }
    }

    return $null
}

function Invoke-Native {
    param(
        [Parameter(Mandatory = $true)][string]$Executable,
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Description,
        [switch]$AllowFailure
    )

    Write-Host "`n>> $Description" -ForegroundColor Yellow

    $captured = @(& $Executable @Arguments 2>&1)
    $exitCode = $LASTEXITCODE
    $text = ($captured | ForEach-Object { [string]$_ }) -join [Environment]::NewLine

    if (-not [string]::IsNullOrWhiteSpace($text)) {
        Write-Host $text
    }

    $alreadyPresent = $text -match '(?i)(already installed|already added|already exists|already configured|is already present)'

    if ($exitCode -eq 0 -or $alreadyPresent) {
        return [pscustomobject]@{
            Success = $true
            ExitCode = $exitCode
            Output = $text
        }
    }

    if ($AllowFailure) {
        Write-Warning "$Description fallo con codigo $exitCode. Se continuara."
        return [pscustomobject]@{
            Success = $false
            ExitCode = $exitCode
            Output = $text
        }
    }

    throw "$Description fallo con codigo $exitCode.`n$text"
}

function Invoke-Claude {
    param(
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [Parameter(Mandatory = $true)][string]$Description,
        [switch]$AllowFailure
    )

    return Invoke-Native `
        -Executable $script:ClaudeExe `
        -Arguments $Arguments `
        -Description $Description `
        -AllowFailure:$AllowFailure
}

function Add-Marketplace {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Label
    )

    $result = Invoke-Claude `
        -Arguments @('plugin', 'marketplace', 'add', $Source, '--scope', 'user') `
        -Description "Registrar marketplace: $Label" `
        -AllowFailure

    if (-not $result.Success) {
        Write-Warning "No se pudo agregar '$Source'. Puede que ya exista con otro estado; se verificara despues."
    }
}

function Load-LocalMarketplaceCatalogs {
    $marketplaceRoot = Join-Path $HOME '.claude\plugins\marketplaces'

    if (-not (Test-Path -LiteralPath $marketplaceRoot)) {
        throw "No existe el directorio local de marketplaces: $marketplaceRoot"
    }

    $catalogFiles = @(Get-ChildItem `
        -LiteralPath $marketplaceRoot `
        -Filter 'marketplace.json' `
        -File `
        -Recurse `
        -ErrorAction SilentlyContinue)

    if ($catalogFiles.Count -eq 0) {
        throw "No se encontro ningun marketplace.json dentro de $marketplaceRoot"
    }

    $loaded = @()

    foreach ($file in $catalogFiles) {
        try {
            $catalog = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json

            $hasName = $catalog.PSObject.Properties.Name -contains 'name'
            $hasPlugins = $catalog.PSObject.Properties.Name -contains 'plugins'

            if (-not $hasName -or -not $hasPlugins) {
                continue
            }

            $pluginNames = @($catalog.plugins | ForEach-Object { [string]$_.name })

            $loaded += [pscustomobject]@{
                Name = [string]$catalog.name
                Plugins = $pluginNames
                Path = $file.FullName
            }
        }
        catch {
            Write-Warning "No se pudo leer el catalogo $($file.FullName): $($_.Exception.Message)"
        }
    }

    if ($loaded.Count -eq 0) {
        throw 'Se encontraron archivos marketplace.json, pero ninguno tenia una estructura valida.'
    }

    $script:Catalogs = $loaded

    Write-Host ''
    Write-Host 'Catalogos locales detectados:' -ForegroundColor Green
    foreach ($catalog in $script:Catalogs | Sort-Object Name -Unique) {
        Write-Host "  - $($catalog.Name): $($catalog.Plugins.Count) plugins" -ForegroundColor Green
    }
}

function Find-PluginMarketplace {
    param(
        [Parameter(Mandatory = $true)][string]$PluginName,
        [string[]]$PreferredMarketplaces = @()
    )

    $matches = @($script:Catalogs | Where-Object { $_.Plugins -contains $PluginName })

    if ($matches.Count -eq 0) {
        return $null
    }

    foreach ($preferred in $PreferredMarketplaces) {
        $preferredMatch = @($matches | Where-Object { $_.Name -eq $preferred })
        if ($preferredMatch.Count -gt 0) {
            return $preferredMatch[0]
        }
    }

    return $matches[0]
}

function Install-CatalogPlugin {
    param(
        [Parameter(Mandatory = $true)][string]$PluginName,
        [string[]]$PreferredMarketplaces = @()
    )

    $catalog = Find-PluginMarketplace `
        -PluginName $PluginName `
        -PreferredMarketplaces $PreferredMarketplaces

    if ($null -eq $catalog) {
        Write-Warning "El plugin '$PluginName' no aparece en los catalogos actuales. Se omite."
        $script:Skipped += $PluginName
        return
    }

    $identifier = "$PluginName@$($catalog.Name)"

    $result = Invoke-Claude `
        -Arguments @('plugin', 'install', $identifier, '--scope', 'user') `
        -Description "Instalar $identifier" `
        -AllowFailure

    if ($result.Success) {
        $script:Installed += $identifier
    }
    else {
        $script:Failed += $identifier
    }
}

function Backup-ClaudeSettings {
    $claudeHome = Join-Path $HOME '.claude'
    if (-not (Test-Path -LiteralPath $claudeHome)) {
        return
    }

    $backupRoot = Join-Path $claudeHome 'backups'
    $backupPath = Join-Path $backupRoot (Get-Date -Format 'yyyyMMdd-HHmmss')
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    foreach ($name in @('settings.json', 'settings.local.json')) {
        $source = Join-Path $claudeHome $name
        if (Test-Path -LiteralPath $source) {
            Copy-Item -LiteralPath $source -Destination $backupPath -Force
        }
    }

    Write-Host "Respaldo de configuracion: $backupPath" -ForegroundColor Green
}

Write-Section 'INSTALADOR CLAUDE CODE FULL STACK V3'
Write-Host 'Este instalador se ejecuta como archivo y detecta los nombres reales desde los catalogos locales.' -ForegroundColor Cyan

Write-Section '1. RECUPERAR PATH Y VERIFICAR HERRAMIENTAS'

Refresh-ProcessPath

$nodeCandidates = @(
    (Join-Path $env:ProgramFiles 'nodejs\node.exe'),
    (Join-Path $env:LOCALAPPDATA 'Programs\nodejs\node.exe')
)

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

$nodeExe = Resolve-Executable -Name 'node' -Candidates $nodeCandidates
$script:NpmExe = Resolve-Executable -Name 'npm' -Candidates $npmCandidates
$script:ClaudeExe = Resolve-Executable -Name 'claude' -Candidates $claudeCandidates

if ($null -eq $script:ClaudeExe) {
    if ($null -eq $script:NpmExe) {
        throw @"
No se encontro Claude Code ni npm.

Node.js parecia estar instalado en tu ejecucion anterior, pero esta consola no lo tiene en PATH.
Cierra todas las ventanas de PowerShell, abre una nueva y vuelve a ejecutar el archivo CMD.
Si continua igual, reinstala Node.js LTS marcando la opcion 'Add to PATH'.
"@
    }

    Invoke-Native `
        -Executable $script:NpmExe `
        -Arguments @('install', '--global', '@anthropic-ai/claude-code@latest') `
        -Description 'Instalar o actualizar Claude Code'

    Refresh-ProcessPath
    $script:ClaudeExe = Resolve-Executable -Name 'claude' -Candidates $claudeCandidates

    if ($null -eq $script:ClaudeExe) {
        throw 'Claude Code se instalo, pero no pudo localizarse. Cierra y abre PowerShell y ejecuta nuevamente el CMD.'
    }
}

if ($null -ne $nodeExe) {
    $nodeVersion = & $nodeExe --version
    Write-Host "Node.js: $nodeVersion" -ForegroundColor Green
}
else {
    Write-Warning 'Node.js no esta disponible. Claude puede funcionar, pero se omitiran las dependencias LSP de npm.'
}

if ($null -ne $script:NpmExe) {
    $npmVersion = & $script:NpmExe --version
    Write-Host "npm: $npmVersion" -ForegroundColor Green
}
else {
    Write-Warning 'npm no esta disponible; se omitiran TypeScript Language Server y Pyright.'
}

$claudeVersion = & $script:ClaudeExe --version
Write-Host "Claude Code: $claudeVersion" -ForegroundColor Green
Write-Host "Ejecutable Claude: $script:ClaudeExe" -ForegroundColor DarkGreen

Backup-ClaudeSettings

Invoke-Claude `
    -Arguments @('doctor') `
    -Description 'Ejecutar diagnostico de Claude Code' `
    -AllowFailure | Out-Null

Write-Section '2. REGISTRAR Y ACTUALIZAR MARKETPLACES'

Add-Marketplace -Source 'anthropics/claude-plugins-official' -Label 'Plugins oficiales de Anthropic'
Add-Marketplace -Source 'anthropics/skills' -Label 'Agent Skills oficiales de Anthropic'
Add-Marketplace -Source 'jeffallan/claude-skills' -Label 'Full Stack Skills de Jeff Allan'

Invoke-Claude `
    -Arguments @('plugin', 'marketplace', 'update') `
    -Description 'Actualizar todos los marketplaces' `
    -AllowFailure | Out-Null

Write-Section '3. LEER LOS CATALOGOS LOCALES REALES'
Load-LocalMarketplaceCatalogs

Write-Section '4. INSTALAR DEPENDENCIAS LSP'

if ($null -ne $script:NpmExe) {
    Invoke-Native `
        -Executable $script:NpmExe `
        -Arguments @('install', '--global', 'typescript@latest', 'typescript-language-server@latest', 'pyright@latest') `
        -Description 'Instalar TypeScript Language Server y Pyright' `
        -AllowFailure | Out-Null
}
else {
    Write-Warning 'Dependencias LSP omitidas porque npm no esta disponible.'
}

Write-Section '5. INSTALAR PLUGINS OFICIALES PARA DESARROLLO'

$corePlugins = @(
    'claude-code-setup',
    'claude-md-management',
    'feature-dev',
    'code-review',
    'code-simplifier',
    'frontend-design',
    'security-guidance',
    'skill-creator',
    'typescript-lsp',
    'pyright-lsp'
)

foreach ($plugin in $corePlugins) {
    Install-CatalogPlugin `
        -PluginName $plugin `
        -PreferredMarketplaces @('claude-plugins-official')
}

Write-Section '6. INSTALAR INTEGRACIONES UTILES'

$integrationPlugins = @(
    'github',
    'context7',
    'playwright'
)

foreach ($plugin in $integrationPlugins) {
    Install-CatalogPlugin `
        -PluginName $plugin `
        -PreferredMarketplaces @('claude-plugins-official')
}

Write-Section '7. INSTALAR AGENT SKILLS OFICIALES'

$skillPlugins = @(
    'document-skills',
    'example-skills',
    'claude-api'
)

foreach ($plugin in $skillPlugins) {
    Install-CatalogPlugin `
        -PluginName $plugin `
        -PreferredMarketplaces @('anthropic-agent-skills')
}

Write-Section '8. INSTALAR PAQUETE FULL STACK COMUNITARIO'

Install-CatalogPlugin `
    -PluginName 'fullstack-dev-skills' `
    -PreferredMarketplaces @('fullstack-dev-skills', 'jeffallan')

Write-Section '9. VERIFICACION FINAL'

Invoke-Claude `
    -Arguments @('plugin', 'marketplace', 'list') `
    -Description 'Mostrar marketplaces registrados' `
    -AllowFailure | Out-Null

Invoke-Claude `
    -Arguments @('plugin', 'list') `
    -Description 'Mostrar plugins instalados' `
    -AllowFailure | Out-Null

Write-Section 'RESULTADO'

Write-Host "Instalados o ya presentes: $($script:Installed.Count)" -ForegroundColor Green
foreach ($item in $script:Installed) {
    Write-Host "  [OK] $item" -ForegroundColor Green
}

if ($script:Skipped.Count -gt 0) {
    Write-Host "`nOmitidos porque no aparecen en los catalogos actuales: $($script:Skipped.Count)" -ForegroundColor Yellow
    foreach ($item in $script:Skipped) {
        Write-Host "  [OMITIDO] $item" -ForegroundColor Yellow
    }
}

if ($script:Failed.Count -gt 0) {
    Write-Host "`nFallos que no detuvieron el instalador: $($script:Failed.Count)" -ForegroundColor Red
    foreach ($item in $script:Failed) {
        Write-Host "  [FALLO] $item" -ForegroundColor Red
    }
}

Write-Host ''
Write-Host 'Instalacion finalizada.' -ForegroundColor Cyan
Write-Host 'Abre Claude Code con: claude' -ForegroundColor Cyan
Write-Host 'Dentro de Claude ejecuta: /reload-plugins' -ForegroundColor Cyan
Write-Host 'Luego revisa: /plugin' -ForegroundColor Cyan
Write-Host ''
Write-Host 'IMPORTANTE: no pegues este script linea por linea dentro de PowerShell.' -ForegroundColor Yellow
Write-Host 'Ejecutalo siempre mediante Ejecutar-Claude-FullStack-v3.cmd.' -ForegroundColor Yellow