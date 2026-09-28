@echo off
setlocal
title OmniClaude Health Check
echo === OmniClaude Health Check ===
echo.
where node >nul 2>&1 && node --version || echo [MISSING] Node.js
where npm >nul 2>&1 && npm --version || echo [MISSING] npm
where claude >nul 2>&1 && claude --version || echo [MISSING] Claude Code
where omniroute >nul 2>&1 && omniroute --version || echo [MISSING] OmniRoute
where ollama >nul 2>&1 && ollama --version || echo [MISSING] Ollama
echo.
where omniroute >nul 2>&1 && omniroute doctor
echo.
powershell.exe -NoProfile -Command "if (Test-NetConnection localhost -Port 20128 -InformationLevel Quiet -WarningAction SilentlyContinue) { Write-Host '[OK] OmniRoute port 20128 reachable' -ForegroundColor Green } else { Write-Host '[FAIL] OmniRoute port 20128 not reachable' -ForegroundColor Red }"
echo.
pause
