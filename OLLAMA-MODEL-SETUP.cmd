@echo off
setlocal
title Ollama Local Model Setup
where ollama >nul 2>&1 || (
  echo Ollama is not installed. Run INSTALL.cmd first.
  pause
  exit /b 1
)
echo.
echo Local models use your computer's RAM, GPU and disk space.
echo Check the current Ollama library/documentation and choose a model that fits your PC.
echo.
set /p MODEL=Enter the exact Ollama model name to install, or press Enter to cancel: 
if "%MODEL%"=="" exit /b 0
ollama pull "%MODEL%"
echo.
echo Installed models:
ollama list
pause
