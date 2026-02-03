# Flywheel-Lite

**Ship faster with AI agent swarms.** An orchestration layer for multi-model AI development workflows.

```
One command. Multiple AI models. Parallel execution. Real results.
```

## Why Flywheel?

Traditional AI-assisted coding uses one model at a time. Flywheel changes the game:

- **Multi-model synthesis** — Opus, Codex, GPT-5.2, and Gemini working together
- **Parallel agent swarms** — 6+ agents implementing simultaneously in tmux
- **Battle-tested prompts** — Structured delegation, failure recovery, evidence requirements
- **Safety rails** — Destructive command blocking + two-person authorization

---

## Key Features

### 🏆 `compete` — Competitive Plan Generation

Why trust one model when four can compete?

```bash
flywheel compete planning/PLAN_v0.md
```

Generates **4 independent plans** in parallel:
- 2× Claude Opus (different focus areas)
- 1× Codex with extended reasoning
- 1× GPT-5.2 with extended reasoning

Then **synthesizes the best ideas** into a unified plan. Different models catch different edge cases.

---

### 🔄 `refine` — Iterative Plan Refinement

Plans improve through iteration, not perfection on first try.

```bash
flywheel refine --iters 5
```

Each iteration:
1. AI reviews the plan against codebase reality
2. Identifies gaps, ambiguities, missing edge cases
3. Produces improved version
4. Stops when changes converge

**Result:** Plans that actually work when implemented.

---

### ✨ `polish` — "Measure N Times, Implement Once"

The Doodlestein method for bulletproof implementation plans.

```bash
flywheel polish --max 9
```

Interactive refinement loop:
1. Run polish prompt in Claude
2. Review output — are improvements still happening?
3. Choose: **[C]ontinue** / **[F]resh session** / **[X] Codex final** / **[D]one**
4. Repeat 6-9 times until steady state
5. Final pass with different model for fresh perspective

**Philosophy:** Cheap planning tokens prevent expensive implementation mistakes.

---

### 🧠 `plan-pro` — Guided Planning with GPT Pro

Leverage GPT Pro's extended thinking for complex architectural decisions.

```bash
flywheel plan-pro --rounds 3
```

Workflow:
1. Copies plan + critique prompt to clipboard
2. Opens GPT Pro web interface
3. You paste and get extended reasoning response
4. Paste response back → next iteration

**Best for:** Architecture decisions requiring deep reasoning chains.

---

### 🚀 `startwork` — Spawn Agent Swarms

One command launches a full development team.

```bash
flywheel startwork --cc 3 --cod 2 --gmi 1
```

Spawns in tmux:
- **3 Claude agents** — Primary implementation
- **2 Codex agents** — Parallel code generation
- **1 Gemini agent** — Review and verification

Each agent gets:
- System prompt with intent classification
- Project context and current plan
- Structured task delegation format
- Failure recovery protocols

---

### 📦 `beads` — Auto-Generate Implementation Tasks

Turn plans into actionable, parallelizable work units.

```bash
flywheel beads --min-beads 50
```

Analyzes your plan and creates:
- Atomic implementation tasks
- Clear acceptance criteria
- Dependency ordering
- Complexity estimates (S/M/L)

**Integration:** Works with the beads task management system (`br`, `bv`).

---

### 🌳 `wt` — Git Worktree Manager

Isolated workspaces for parallel feature development.

```bash
wt add feature/auth      # Create worktree
cd $(wt cd feature/auth) # Jump to it
wt sync                  # Update all worktrees
```

**Why worktrees?** Each agent swarm can work in its own worktree without conflicts.

---

### 🆕 `new-repo` — One-Command Project Setup

From zero to fully-configured in seconds.

```bash
new-repo my-project
```

Automatically:
1. Creates local directory with git
2. Creates GitHub repo (private by default)
3. Adds to sync system
4. Initializes flywheel + beads
5. Commits and pushes

---

## Quick Start

```bash
# Install
./install.sh

# Verify dependencies
flywheel doctor

# In any project:
cd /path/to/your-project
flywheel init

# The full workflow:
flywheel plan --rounds 2       # Interview → initial plan
flywheel refine --iters 3      # AI-powered refinement
flywheel compete planning/PLAN.md  # Multi-model competition
flywheel polish                # Interactive final polish
flywheel beads --min-beads 50  # Generate tasks
flywheel startwork             # Launch agent swarm
```

---

## Prompts System

Flywheel loads agent behavior prompts from `~/.config/flywheel/prompts/`:

| File | Purpose |
|------|---------|
| `SYSTEM_PROMPT.md` | Base rules for ALL agents |
| `INTERVIEW.md` | Planning interview prompt |
| `AGENT_WORKER.md` | Implementation agent work loop |
| `QA_AGENT.md` | QA verification checklist |
| `DELEGATION_RULES.md` | 7-section task delegation structure |
| `LIBRARIAN.md` | External research pattern |

### Key Prompt Features

**Intent Classification** — Agents classify every task before acting:
- Trivial, Explicit, Exploratory, Open-ended, Ambiguous

**Evidence Requirements** — No task complete without proof:
- File edits need clean lint
- Builds need exit code 0
- Tests must pass

**Failure Recovery** — After 3 consecutive failures:
- STOP, REVERT, DOCUMENT, ESCALATE

---

## Safety Tools

### DCG — Destructive Command Guard

Blocks dangerous commands before execution:
- `rm -rf` outside safe directories
- `git reset --hard`, `git push --force`
- `git branch -D`, `git clean -f`

### SLB — Two-Person Authorization

High-risk commands require approval:

| Risk Level | Examples | Approval |
|------------|----------|----------|
| **CRITICAL** | `DROP DATABASE`, `terraform destroy` | 2+ approvals |
| **DANGEROUS** | `git push --force`, `DELETE FROM` | 1 approval |
| **CAUTION** | `rm file`, `git stash drop` | Auto after 30s |

```bash
slb init && slb daemon start
```

---

## Configuration

**Global:** `~/.config/flywheel/config.env`
**Local:** `.flywheel/config.env`

```bash
# Agent mix
FW_CC=3              # Claude agents
FW_COD=2             # Codex agents
FW_GMI=1             # Gemini agents

# Models
FW_CLAUDE_MODEL=opus
FW_CODEX_IMPL_MODEL=gpt-5.2-codex
FW_CODEX_REASONING=high

# Iteration limits
FW_INTERVIEW_ROUNDS=2
FW_PLAN_ITERS=3
```

### Config Templates

| File | Purpose |
|------|---------|
| `config/claude-settings.json.template` | Claude Code settings with dcg+slb hooks |
| `config/slb/config.toml.template` | SLB configuration |

**Required setup:** In `config/claude-settings.json.template`, replace:
```json
"Authorization": "Bearer YOUR_AGENT_MAIL_TOKEN_HERE"
```
with your actual Agent Mail MCP token.

---

## Command Reference

| Command | Description |
|---------|-------------|
| `flywheel doctor` | Verify dependencies |
| `flywheel init` | Initialize repo |
| `flywheel plan [--rounds N]` | Planning interview |
| `flywheel refine [--iters N]` | AI plan refinement |
| `flywheel compete <plan>` | Multi-model competition |
| `flywheel plan-pro [--rounds N]` | GPT Pro guided planning |
| `flywheel polish [--max N]` | Interactive polish loop |
| `flywheel beads [--min-beads N]` | Generate tasks |
| `flywheel startwork [--cc N] [--cod N] [--gmi N]` | Launch agents |
| `flywheel qa` | QA verification |
| `flywheel nudge` | Nudge idle agents |
| `flywheel watchdog [N]` | Auto-nudge every N seconds |
| `flywheel finalize [--push]` | Commit work |
| `flywheel sync` | Finalize + push |
| `wt add/list/remove/cd/sync` | Worktree management |
| `new-repo <name> [--public]` | Create new project |

---

## Prerequisites

- Agent toolchain: `claude`, `codex`, `gemini`
- Task management: `ntm`, `br`/`bd`, `bv`, `apr`, `ubs`
- Standard tools: `tmux`, `git`, `gh`

Run `flywheel doctor` to verify.

---

## Philosophy

> "Planning tokens are far fewer and cheaper than implementation tokens."

Flywheel invests heavily in planning:
- Multiple models competing on plans
- Iterative refinement until convergence
- Human review at key checkpoints
- Only then: parallel implementation

The result? Less rework. Faster shipping. Better code.

---

## License

MIT
