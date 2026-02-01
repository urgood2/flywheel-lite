# Flywheel-Lite

An "oh-my-opencode" style workflow wrapper for the Agent Flywheel / ACFS toolchain.

## What It Does

One command (`flywheel ...`) that:
- Works in **any repo** (existing or freshly cloned)
- Supports **any branch** (existing or new)
- **Automated beads creation** from plans
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
flywheel beads --min-beads 50    # Now automated!
flywheel startwork --cc 3 --cod 2 --gmi 1
```

## Commands

| Command | Description |
|---------|-------------|
| `flywheel doctor` | Verify all dependencies are installed |
| `flywheel init` | Initialize repo (creates .flywheel/, planning/, AGENTS.md, beads) |
| `flywheel checkout <branch> [base]` | Create/switch branches |
| `flywheel plan [--rounds N]` | Start interactive planning interview |
| `flywheel refine [--iters N] [--bg]` | Refine plan with Codex |
| `flywheel beads [--min-beads N] [--bg]` | **Auto-create beads from plan** |
| `flywheel startwork [--cc N] [--cod N] [--gmi N]` | Spawn agent swarm |
| `flywheel jobs` | List background jobs |
| `flywheel logs [job]` | Tail job logs |
| `flywheel attach <job>` | Attach to background job |

## Full Workflow with APR

```bash
# 1. Initialize
cd /data/projects/my-feature
flywheel init
cp existing-plan.md planning/PLAN_v0.md

# 2. Refine with APR (optional)
apr setup
apr run 1
apr run 2
apr show 2 > planning/PLAN.md

# 3. Create beads (automated!)
flywheel beads --plan planning/PLAN.md --min-beads 50

# 4. Start agents
flywheel startwork --cc 2
ntm attach my-feature
```

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

## License

MIT
