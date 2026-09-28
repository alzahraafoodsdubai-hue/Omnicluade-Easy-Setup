@echo off
setlocal
cd /d "%~dp0"
title OmniClaude

echo Checking OmniClaude...
where omniroute >nul 2>&1 || goto repair
where claude >nul 2>&1 || goto repair

powershell.exe -NoProfile -Command "if (-not (Test-NetConnection localhost -Port 20128 -InformationLevel Quiet -WarningAction SilentlyContinue)) { Start-Process -WindowStyle Minimized omniroute -ArgumentList '--no-open'; Start-Sleep 6 }"

where ollama >nul 2>&1 && (
  powershell.exe -NoProfile -Command "try { Invoke-RestMethod -TimeoutSec 2 http://localhost:11434/api/tags ^| Out-Null } catch { Start-Process -WindowStyle Minimized ollama -ArgumentList 'serve'; Start-Sleep 3 }"
)

echo Starting Claude Code through OmniRoute...
omniroute launch --profile auto-coding
if not errorlevel 1 exit /b 0

echo.
echo Automatic launch profile was not available in this OmniRoute version.
echo Opening OmniRoute dashboard. Configure/test providers, then use its Claude Code connection option.
start "" http://localhost:20128
pause
exit /b 1

:repair
echo A required component is missing. Starting repair/setup...
call "%~dp0INSTALL.cmd"
