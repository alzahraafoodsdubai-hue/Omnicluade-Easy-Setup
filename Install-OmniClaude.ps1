$ErrorActionPreference = 'Stop'
$Host.UI.RawUI.WindowTitle = 'OmniClaude Easy Setup'

function Step($text) { Write-Host "`n==> $text" -ForegroundColor Cyan }
function Good($text) { Write-Host "[OK] $text" -ForegroundColor Green }
function Warn($text) { Write-Host "[!] $text" -ForegroundColor Yellow }
function Has($cmd) { return [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }

if ($env:OS -ne 'Windows_NT') { throw 'This installer is intended for Windows.' }

Write-Host 'OmniClaude Easy Setup' -ForegroundColor White
Write-Host 'Checks first, installs only what is missing.' -ForegroundColor Gray

Step 'Checking package manager'
if (-not (Has 'winget')) {
  throw 'Windows Package Manager (winget) was not found. Update App Installer from Microsoft Store, then run setup again.'
}
Good 'winget available'

Step 'Checking Node.js and npm'
if (-not (Has 'node') -or -not (Has 'npm')) {
  Warn 'Node.js missing. Installing Node.js LTS...'
  winget install --id OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
} else { Good "Node.js $(node --version)" }
if (-not (Has 'npm')) { throw 'npm is still unavailable. Restart Windows and run setup again.' }

Step 'Checking Claude Code'
if (-not (Has 'claude')) {
  npm install -g @anthropic-ai/claude-code
} else { Good 'Claude Code already installed' }

Step 'Checking OmniRoute'
if (-not (Has 'omniroute')) {
  npm install -g omniroute
} else { Good 'OmniRoute already installed' }

Step 'Checking Ollama'
if (-not (Has 'ollama')) {
  Warn 'Ollama missing. Installing...'
  winget install --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
} else { Good 'Ollama already installed' }

Step 'Running OmniRoute diagnostics'
try { omniroute doctor } catch { Warn 'Diagnostics reported a problem. The dashboard will be opened so configuration can be completed.' }

Step 'Starting OmniRoute'
$portOpen = Test-NetConnection -ComputerName localhost -Port 20128 -InformationLevel Quiet -WarningAction SilentlyContinue
if (-not $portOpen) {
  Start-Process -WindowStyle Minimized -FilePath 'omniroute' -ArgumentList '--no-open'
  Start-Sleep -Seconds 6
}

$portOpen = Test-NetConnection -ComputerName localhost -Port 20128 -InformationLevel Quiet -WarningAction SilentlyContinue
if ($portOpen) {
  Good 'OmniRoute is available on localhost:20128'
  Start-Process 'http://localhost:20128'
} else {
  Warn 'OmniRoute did not become reachable on port 20128. Run HEALTH-CHECK.cmd after setup.'
}

Step 'Creating desktop shortcut'
$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$launcher = Join-Path $repoDir 'START-OMNICLAUDE.cmd'
$desktop = [Environment]::GetFolderPath('Desktop')
$shortcutPath = Join-Path $desktop 'OmniClaude.lnk'
$ws = New-Object -ComObject WScript.Shell
$sc = $ws.CreateShortcut($shortcutPath)
$sc.TargetPath = $launcher
$sc.WorkingDirectory = $repoDir
$sc.Description = 'Start Claude Code through OmniRoute'
$sc.Save()
Good 'Desktop shortcut created: OmniClaude'

Write-Host "`nSETUP COMPLETE" -ForegroundColor Green
Write-Host 'Configure available/free/local providers in the OmniRoute dashboard, then use the OmniClaude desktop shortcut.' -ForegroundColor White
Write-Host 'For local Ollama setup, run OLLAMA-MODEL-SETUP.cmd.' -ForegroundColor Gray
Read-Host 'Press Enter to close'
