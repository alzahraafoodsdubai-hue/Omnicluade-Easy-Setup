@echo off
setlocal
cd /d "%~dp0"
echo Starting OmniClaude Easy Setup...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-OmniClaude.ps1"
if errorlevel 1 (
  echo.
  echo Setup stopped because a requirement failed.
  echo Please read the message above, then run INSTALL.cmd again.
  pause
)
