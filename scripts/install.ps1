param([switch]$System)

$ErrorActionPreference = 'Stop'
$refresh = $null

if (Get-Command tlmgr -ErrorAction SilentlyContinue) {
    $scope = if ($System) { 'TEXMFLOCAL' } else { 'TEXMFHOME' }
    $texmf = @(kpsewhich "-var-value=$scope")
    if ($LASTEXITCODE -ne 0) { throw "Could not locate $scope." }
    if ($System) {
        Get-Command mktexlsr | Out-Null
        $refresh = { mktexlsr $texmf }
    }
} elseif (Get-Command miktex -ErrorAction SilentlyContinue) {
    $root = if ($System) { 'CommonInstall' } else { 'UserInstall' }
    $report = @(initexmf --report)
    if ($LASTEXITCODE -ne 0) { throw 'Could not read MiKTeX settings.' }
    $texmf = @($report -match "^${root}: " -replace "^${root}: ", '')
    $refresh = if ($System) { { miktex --admin fndb refresh } } else { { miktex fndb refresh } }
} else {
    throw 'TeX Live or MiKTeX is required.'
}

if ($texmf.Count -ne 1 -or $texmf[0] -match '[;{}]' -or -not [IO.Path]::IsPathRooted($texmf[0])) {
    throw 'Expected one absolute TeX installation directory.'
}
$texmf = $texmf[0]

$workdir = Join-Path ([IO.Path]::GetTempPath()) ('enlp-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $workdir | Out-Null
try {
    $archive = Join-Path $workdir 'source.zip'
    curl.exe -fsSL https://github.com/EhimeNLP/enlp-thesis-template/archive/refs/heads/main.zip -o $archive
    if ($LASTEXITCODE -ne 0) { throw 'Could not download the template.' }
    Expand-Archive -LiteralPath $archive -DestinationPath $workdir

    $src = Join-Path $workdir 'enlp-thesis-template-main/src'
    $files = Get-ChildItem -LiteralPath $src -File
    $latexExtensions = '.cls', '.sty', '.bbx', '.cbx'
    foreach ($ext in ($latexExtensions + '.bst')) {
        if ($ext -notin $files.Extension) { throw "Missing template files for $ext." }
    }

    $texDir = Join-Path $texmf 'tex/latex/enlp'
    $bstDir = Join-Path $texmf 'bibtex/bst/enlp'
    New-Item -ItemType Directory -Force -Path $texDir, $bstDir | Out-Null
    $latex = $files | Where-Object { $_.Extension -in $latexExtensions }
    $bst = $files | Where-Object { $_.Extension -eq '.bst' }
    Copy-Item -LiteralPath $latex.FullName -Destination $texDir -Force
    Copy-Item -LiteralPath $bst.FullName -Destination $bstDir -Force

    if ($refresh) {
        & $refresh
        if ($LASTEXITCODE -ne 0) { throw 'Could not refresh the TeX file database.' }
    }
    Write-Output "Installed enlp in $texmf"
} finally {
    Remove-Item -LiteralPath $workdir -Recurse -Force
}
