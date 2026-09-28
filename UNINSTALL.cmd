@echo off
setlocal
echo This removes Claude Code and OmniRoute npm packages.
echo Ollama and downloaded local models will be left untouched.
choice /C YN /M "Continue"
if errorlevel 2 exit /b 0
npm uninstall -g @anthropic-ai/claude-code omniroute
echo Done.
pause
