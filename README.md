# Flywheel-Lite

An "oh-my-opencode" style workflow wrapper for the Agent Flywheel / ACFS toolchain.

## What It Does

One command (`flywheel ...`) that:
- Works in **any repo** (existing or freshly cloned)
- Supports **any branch** (existing or new)
- Configurable **interview rounds**, **plan refinement iterations**, and **agent mix**
- Integrates with NTM, Beads, APR, and Agent Mail

## Quick Start

```bash
# Install
./install.sh

# Verify
flywheel doctor

# Use in any project
cd /data/projects/your-repo
flywheel init
flywheel plan --rounds 2
flywheel refine --iters 3
flywheel beads
flywheel startwork --cc 3 --cod 2 --gmi 1
```

## Commands

| Command | Description |
|---------|-------------|
| `flywheel doctor` | Verify all dependencies are installed |
| `flywheel init` | Initialize repo (creates .flywheel/, planning/, AGENTS.md, beads) |
| `flywheel checkout <branch> [base]` | Create/switch branches |
| `flywheel plan [--rounds N]` | Start interactive planning interview |
| `flywheel refine [--iters N]` | Refine plan with Codex |
| `flywheel beads [--min-beads N]` | Convert plan to Beads tasks |
| `flywheel startwork [--cc N] [--cod N] [--gmi N]` | Spawn agent swarm |

## Configuration

Global config: `~/.config/flywheel/config.env`
Repo-local override: `.flywheel/config.env`

```bash
FW_INTERVIEW_ROUNDS=2
FW_PLAN_ITERS=3
FW_CC=3              # Claude agents
FW_COD=2             # Codex agents
FW_GMI=1             # Gemini agents
FW_CLAUDE_MODEL=opus
FW_CODEX_IMPL_MODEL=gpt-5.2-codex
FW_CODEX_REASONING=high
FW_GEMINI_MODEL=gemini-2.5-pro
```

## Prerequisites

Requires Agent Flywheel / ACFS toolchain:
- `ntm`, `bd` (or `br`), `bv`, `apr`, `ubs`
- `claude`, `codex`, `gemini`

Run `flywheel doctor` to verify.

## Files

- `bin/flywheel` - Main CLI script
- `config/config.env` - Default configuration
- `docs/GUIDE.md` - Full setup guide
- `docs/CHEATSHEET.html` - Visual command reference

## License

MIT
