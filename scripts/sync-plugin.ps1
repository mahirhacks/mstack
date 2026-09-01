# Sync canonical skill/ into plugin/skills/mvp-spec-driven-delivery/
# Run from the repository root after editing skill/.

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$source = Join-Path $root "skill"
$dest = Join-Path $root "plugin\skills\mvp-spec-driven-delivery"

if (-not (Test-Path $source)) {
    Write-Error "skill/ not found at $source"
}

New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Path (Join-Path $source "*") -Destination $dest -Recurse -Force

$agentSource = Join-Path $source "agents"
$agentDest = Join-Path $root "plugin\agents"
New-Item -ItemType Directory -Force -Path $agentDest | Out-Null
Copy-Item -Path (Join-Path $agentSource "*") -Destination $agentDest -Force

Write-Host "Synced skill/ -> plugin/skills/mvp-spec-driven-delivery/"
Write-Host "Synced skill/agents/ -> plugin/agents/"
