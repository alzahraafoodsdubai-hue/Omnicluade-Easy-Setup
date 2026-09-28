# OmniClaude Easy Setup

Windows-first bootstrap concept for non-technical users who want Claude Code routed through OmniRoute with local Ollama fallback.

> Important: This project does not provide unlimited Anthropic Claude usage. OmniRoute can route Claude Code requests to configured free-tier or local models. Provider quotas and availability vary.

## Goal

One installer / launcher that:

1. Checks required components.
2. Keeps components that already work.
3. Installs missing components.
4. Starts OmniRoute and Ollama.
5. Runs OmniRoute diagnostics.
6. Opens the OmniRoute dashboard for first-time provider setup.
7. Starts Claude Code through an OmniRoute launch profile.

## Install

1. Download this repository.
2. Right-click `Install-OmniClaude.ps1` and choose **Run with PowerShell**, or run `INSTALL.cmd`.
3. Follow the on-screen steps.
4. Configure providers in the OmniRoute dashboard when prompted.
5. Use `START-OMNICLAUDE.cmd` afterward.

## Security

- Never commit provider API keys to GitHub.
- Never put real keys inside `.cmd` or `.ps1` files.
- Enter provider credentials only through trusted provider/OmniRoute configuration flows.
- `.env`, `credentials.env`, and common secret files are ignored by this repository.

## What the bootstrap checks

- Windows
- winget
- Node.js / npm
- Claude Code
- OmniRoute
- Ollama
- OmniRoute health (`omniroute doctor`)

## Daily Use

Double-click:

`START-OMNICLAUDE.cmd`

The launcher starts/checks OmniRoute and Ollama, then asks OmniRoute to launch Claude Code using the `auto-coding` profile. If the installed OmniRoute release does not provide that launch command, the dashboard opens and explains the next step.

## Local Models

No large Ollama model is downloaded silently. Local models can consume significant disk/RAM/GPU resources. Use `OLLAMA-MODEL-SETUP.cmd` to choose a model explicitly.

## Troubleshooting

Run:

`HEALTH-CHECK.cmd`

This prints versions and runs OmniRoute diagnostics.

## Uninstall

`UNINSTALL.cmd` removes the globally installed npm packages for Claude Code and OmniRoute. Ollama is intentionally left installed so local models are not accidentally deleted.

## License

MIT. See `LICENSE`.
