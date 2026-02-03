# Flywheel-Lite

An "oh-my-opencode" style workflow wrapper for the Agent Flywheel / ACFS toolchain.

## What It Does

One command (`flywheel ...`) that:
- Works in **any repo** (existing or freshly cloned)
- Supports **any branch** (existing or new)
- **External modular prompts** for agent behavior
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
flywheel beads --min-beads 50
flywheel startwork --cc 3 --cod 2 --gmi 1
```

## Commands

| Command | Description |
|---------|-------------|
| `flywheel doctor` | Verify dependencies and prompts |
| `flywheel init` | Initialize repo |
| `flywheel checkout <branch> [base]` | Create/switch branches |
| `flywheel plan [--rounds N]` | Start planning interview |
| `flywheel refine [--max N] [--bg]` | Refine plan until approved |
| `flywheel beads [--min-beads N]` | Auto-create beads from plan |
| `flywheel startwork [--cc N] [--cod N] [--gmi N]` | Spawn agent swarm |
| `flywheel qa` | Run QA verification agent |
| `flywheel finalize [--push]` | Commit and optionally push |
| `flywheel sync` | Full finalize + push |
| `flywheel jobs` | List background jobs |
| `flywheel logs [job]` | Tail job logs |
| `flywheel attach <job>` | Attach to background job |
| `flywheel nudge` | Nudge idle agents |
| `flywheel watchdog [N]` | Auto-nudge every N seconds |

## Prompts System

Flywheel loads agent behavior prompts from `~/.config/flywheel/prompts/`:

| File | Purpose |
|------|---------|
| `SYSTEM_PROMPT.md` | Base rules for ALL agents (intent classification, evidence requirements, failure recovery) |
| `INTERVIEW.md` | Planning interview prompt |
| `AGENT_WORKER.md` | Implementation agent work loop |
| `QA_AGENT.md` | QA verification checklist |
| `DELEGATION_RULES.md` | 7-section task delegation structure |
| `LIBRARIAN.md` | External research pattern |

### Key Prompt Features (from Oh-My-OpenCode)

**Intent Classification** - Agents classify every task before acting:
- Trivial, Explicit, Exploratory, Open-ended, Ambiguous

**Evidence Requirements** - No task complete without proof:
- File edits need clean lint
- Builds need exit code 0
- Tests must pass

**Failure Recovery** - After 3 consecutive failures:
- STOP, REVERT, DOCUMENT, ESCALATE

**7-Section Delegation** - Structured task prompts:
- TASK, EXPECTED OUTCOME, SKILLS, TOOLS, MUST DO, MUST NOT, CONTEXT

## Configuration

Global: `~/.config/flywheel/config.env`
Local: `.flywheel/config.env`

```bash
FW_INTERVIEW_ROUNDS=2
FW_PLAN_ITERS=3
FW_CC=3              # Claude agents
FW_COD=2             # Codex agents
FW_GMI=1             # Gemini agents
FW_CLAUDE_MODEL=opus
FW_CODEX_IMPL_MODEL=gpt-5.2-codex
FW_CODEX_REASONING=high
```

## Prerequisites

Requires Agent Flywheel / ACFS toolchain:
- `ntm`, `br`, `bv`, `apr`, `ubs`
- `claude`, `codex`, `gemini`

Run `flywheel doctor` to verify.

## License

MIT

## Safety Tools Integration

Flywheel integrates with **dcg** (Destructive Command Guard) and **slb** (Smart Lint Buddy) to protect against dangerous commands.

### DCG - Destructive Command Guard

Blocks dangerous commands before execution:
- `rm -rf` outside temp directories
- `git reset --hard`, `git push --force`
- `git branch -D`, `git clean -f`

### SLB - Two-Person Authorization

Requires approval for high-risk commands:
- **CRITICAL** - 2+ approvals (data destruction, production deploys)
- **DANGEROUS** - 1 approval (force pushes, schema changes)
- **CAUTION** - Auto-approved after 30s

**Setup:**
```bash
slb init                # Initialize SLB
slb hook install        # Install Claude hook
slb daemon start        # Start daemon (required)
```

### Config Templates

| File | Purpose |
|------|---------|
| `config/claude-settings.json.template` | Claude Code settings with dcg+slb hooks |
| `config/slb/config.toml.template` | SLB configuration |

### tmux Nesting Fix

Flywheel uses `smart_attach()` which:
- Uses `tmux switch-client` when already in tmux
- Uses `tmux attach` when in a regular terminal
- No more "sessions should be nested with care" warnings
