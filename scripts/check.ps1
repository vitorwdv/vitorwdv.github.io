[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$failures = New-Object System.Collections.Generic.List[string]

$requiredPaths = @(
    "index.html",
    "assets/style.css",
    "assets/fontawesome-free-6.4.2-web/css/fontawesome.min.css",
    "content.md"
)

foreach ($relativePath in $requiredPaths) {
    $absolutePath = Join-Path $root $relativePath
    if (-not (Test-Path -LiteralPath $absolutePath)) {
        $failures.Add("Missing required file: $relativePath")
    }
}

$htmlPath = Join-Path $root "index.html"
if (Test-Path -LiteralPath $htmlPath) {
    $html = Get-Content -Raw -LiteralPath $htmlPath
    $matches = [regex]::Matches($html, '(?:src|href)\s*=\s*"([^"]+)"')

    foreach ($match in $matches) {
        $reference = $match.Groups[1].Value.Trim()

        if (
            [string]::IsNullOrWhiteSpace($reference) -or
            $reference.StartsWith("#") -or
            $reference.StartsWith("mailto:") -or
            $reference.StartsWith("http://") -or
            $reference.StartsWith("https://") -or
            $reference.StartsWith("//")
        ) {
            continue
        }

        $normalizedReference = $reference.Replace("/", [System.IO.Path]::DirectorySeparatorChar)
        $targetPath = Join-Path $root $normalizedReference

        if (-not (Test-Path -LiteralPath $targetPath)) {
            $failures.Add("Missing referenced file from index.html: $reference")
        }
    }
}

$contentPath = Join-Path $root "content.md"
if (Test-Path -LiteralPath $contentPath) {
    $content = Get-Content -Raw -LiteralPath $contentPath
    $requiredMarkers = @(
        "## Identity And Summary",
        "## Section Labels",
        "## Links"
    )

    foreach ($marker in $requiredMarkers) {
        if (-not $content.Contains($marker)) {
            $failures.Add("Missing required section in content.md: $marker")
        }
    }
}

if ($failures.Count -gt 0) {
    $message = ($failures | Sort-Object -Unique) -join [Environment]::NewLine
    Write-Error $message
    exit 1
}

Write-Host "Checks passed."
