# sdd-agentic-factory

A reusable agentic harness built on [GitHub Agentic Workflows](https://github.github.com/gh-aw/)
(`gh aw`) that drives spec-driven development (SDD) in any project.

## Supported

- **SDD workflows** (`sdd/*.env`): `speckit`, `bmad`, `openspec`, `featherspec`, `custom`
- **Agent tools** (`agents/*.env`): `copilot`, `claude`, `codex`, `gemini`

## Setup

Linux / macOS / WSL / Git Bash:

```sh
./install.sh                         # guided wizard
./install.sh -y -t ../my-project -s openspec -a claude   # non-interactive
```

Windows PowerShell: `./install.ps1`

The wizard generates `.github/workflows/sdd-<sdd>.md` (a gh-aw workflow, triggered when an issue
is labeled `sdd`) and an agent instructions file (`CLAUDE.md`, `AGENTS.md`, ...) in the target
project. Then run `gh aw compile`.

## Adding another SDD workflow or agent

Drop a new `NAME.env` in `sdd/` or `agents/` (see existing files for the variables); the wizard
picks it up automatically. Templates live in `templates/` and use `@VARIABLE@` placeholders.

## Tests

`tests/test_install.sh`
