# Guided setup wizard for Windows PowerShell. Usage: ./install.ps1 [-Target dir] [-Sdd name] [-Agent name]
param([string]$Target, [string]$Sdd, [string]$Agent)
$ErrorActionPreference = 'Stop'
$Root = $PSScriptRoot

function Read-Env($path) {
  $h = @{}
  foreach ($l in Get-Content $path) { if ($l -match '^(\w+)="(.*)"$') { $h[$Matches[1]] = $Matches[2] } }
  $h
}
function Choose($prompt, $dir) {
  $items = Get-ChildItem "$Root/$dir/*.env" | ForEach-Object BaseName
  Write-Host $prompt
  for ($i = 0; $i -lt $items.Count; $i++) { Write-Host "  $($i+1)) $($items[$i])" }
  $p = Read-Host 'Choice [1]'; if (-not $p) { $p = 1 }
  $items[[int]$p - 1]
}
if (-not $Target) { $Target = Read-Host 'Target project directory [.]'; if (-not $Target) { $Target = '.' } }
if (-not $Sdd) { $Sdd = Choose 'Select SDD workflow:' 'sdd' }
if (-not $Agent) { $Agent = Choose 'Select agent tool:' 'agents' }
if ($Sdd -notmatch '^[a-z0-9_-]+$' -or -not (Test-Path "$Root/sdd/$Sdd.env")) { throw "Unknown SDD workflow: $Sdd" }
if ($Agent -notmatch '^[a-z0-9_-]+$' -or -not (Test-Path "$Root/agents/$Agent.env")) { throw "Unknown agent: $Agent" }

$v = Read-Env "$Root/sdd/$Sdd.env"; (Read-Env "$Root/agents/$Agent.env").GetEnumerator() | ForEach-Object { $v[$_.Key] = $_.Value }
function Render($tpl, $out) {
  $c = Get-Content -Raw $tpl
  foreach ($k in $v.Keys) { $c = $c.Replace("@$k@", $v[$k]) }
  New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null
  Set-Content -Path $out -Value $c.TrimEnd() -Encoding utf8
  Write-Host "created $out"
}
Render "$Root/templates/workflow.md.tpl" "$Target/.github/workflows/sdd-$Sdd.md"
$ins = "$Target/$($v.AGENT_INSTRUCTIONS_FILE)"
if (Test-Path $ins) { Write-Host "skipped $ins (exists)" } else { Render "$Root/templates/instructions.md.tpl" $ins }
Write-Host "`nDone. Run 'gh extension install github/gh-aw' then 'gh aw compile' in $Target."
