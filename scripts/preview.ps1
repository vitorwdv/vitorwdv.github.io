[CmdletBinding()]
param(
    [int]$Port = 4000
)

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root "index.html"

if (-not (Test-Path -LiteralPath $indexPath)) {
    throw "Could not find index.html at $indexPath"
}

$pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($pythonLauncher) {
    Write-Host "Serving $root at http://localhost:$Port/"
    & py -m http.server $Port --directory $root
    exit $LASTEXITCODE
}

$pythonBinary = Get-Command python -ErrorAction SilentlyContinue
if ($pythonBinary) {
    Write-Host "Serving $root at http://localhost:$Port/"
    & python -m http.server $Port --directory $root
    exit $LASTEXITCODE
}

throw "Python was not found. Install Python or serve $root with another static file server."
