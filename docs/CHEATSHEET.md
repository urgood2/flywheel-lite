# Agent Flywheel Cheat Sheet
> Complete workflow for planning, refining, and executing with multi-agent swarms

---

## FLYWHEEL-LITE (Automated Workflow)

### Quick Start for Any Feature
```bash
cd /data/projects/my-repo
flywheel init                        # Initialize repo + beads + AGENTS.md
flywheel plan --rounds 2             # Interactive planning interview
flywheel refine --max 3              # Approval mode refinement
flywheel beads --min-beads 50        # Auto-create beads from plan
flywheel startwork --cc 2            # Spawn agents and start
```

### Full Workflow with APR Refinement
```bash
# 1. Setup
cd /data/projects/my-feature
flywheel init
cp existing-plan.md planning/PLAN_v0.md

# 2. Refine with APR (GPT Extended Reasoning)
apr setup                            # One-time workflow config
apr run 1                            # First refinement round
apr run 2                            # Second refinement round
apr status                           # Check progress
apr show 2 > planning/PLAN.md        # Save refined plan

# 3. Create beads (automated!)
flywheel beads --plan planning/PLAN.md --min-beads 50
# Or background: flywheel beads --bg

# 4. Start agents
flywheel startwork --cc 2 --cod 1
ntm attach my-feature
```

### Flywheel-Lite Commands
| Command | Description |
|---------|-------------|
| `flywheel doctor` | Check all dependencies |
| `flywheel init` | Initialize repo (beads, AGENTS.md, .flywheel/) |
| `flywheel checkout <branch>` | Create/switch branches |
| `flywheel plan [--rounds N]` | Interactive planning with Claude |
| `flywheel refine [--max N]` | **Approval mode** (default) - iterate until approved |
| `flywheel refine --iters N` | Fixed iterations mode (legacy) |
| `flywheel beads [--min-beads N]` | Auto-create beads from plan |
| `flywheel compete` | Generate 4 competing plans + synthesize |
| `flywheel startwork [--cc N] [--cod N]` | Spawn agent swarm |
| `flywheel status` | Show refine/beads progress |
| `flywheel jobs` | List all tmux sessions |
| `flywheel attach [session]` | Attach to refine/beads session |

### Refine Modes (New!)

**Approval Mode (Default):**
```bash
flywheel refine                      # Iterate until Codex outputs APPROVED
flywheel refine --max 5              # Max 5 iterations, stop early if approved
flywheel refine --max 10 --plan X.md # Custom input, max 10 iterations
```

**Fixed Iterations Mode (Legacy):**
```bash
flywheel refine --iters 3            # Exactly 3 iterations, no approval check
flywheel refine --iters 5 --plan X.md
```

Refine runs in a persistent tmux session. Detach with `Ctrl+B D`, reattach with `flywheel attach`.


### Competitive Plan Generation (New!)

Generate plans from multiple models and synthesize the best:
```bash
# After interview or with existing plan
flywheel plan                    # Interactive interview → PLAN_v0.md
flywheel compete                 # Generate 4 plans + synthesize

# Model mix:
# - 2x Opus (different perspectives)
# - 1x Codex with xhigh reasoning
# - 1x GPT-5.2 with xhigh reasoning
# - Synthesis: GPT-5.2 xhigh

# Output: planning/PLAN_synthesized.md → PLAN_v0.md
```

### Full Workflow with Compete
```bash
# 1. Setup
cd /data/projects/my-feature
flywheel init

# 2. Interview (interactive)
flywheel plan --rounds 2

# 3. Competitive planning (automated)
flywheel compete
# Generates 4 plans in parallel, synthesizes best ideas

# 4. Refine (optional)
flywheel refine --iters 3

# 5. Create beads and start work
flywheel beads --min-beads 50
flywheel startwork --cc 2
```

### APR Commands (Plan Refinement)

| Command | Description |
|---------|-------------|
| `apr setup` | Configure workflow (one-time) |
| `apr run <N>` | Run refinement round N |
| `apr status` | Check completion status |
| `apr show <N>` | View round N output |
| `apr diff 1 2` | Compare rounds |
| `apr stats` | Convergence analytics |

---

## PROJECT SETUP

### Initialize with Flywheel-Lite
```bash
cd /data/projects/my-repo
flywheel init    # Creates .flywheel/, planning/, AGENTS.md, initializes beads
```

### Manual Setup
```bash
bd init                              # Initialize beads
git branch beads-sync master         # Create sync branch
bd config set sync.branch=beads-sync # Configure sync
```

### Clone and Setup
```bash
cd /data/projects
git clone https://github.com/owner/repo.git
cd repo
flywheel init
```

---

## SPAWNING AGENTS

### Basic Spawn Commands
```bash
ntm spawn my-game --cc=2 --cod=1 --gmi=1   # Mixed team
ntm spawn my-game --cc=3                    # Claude-only
ntm spawn my-game --cc=1                    # Single agent
```

### With Flywheel-Lite
```bash
flywheel startwork --cc 2 --cod 1 --gmi 1
```

### Session Management
```bash
ntm list                     # List all sessions
ntm attach my-game           # Attach to session
ntm status my-game           # Session details
ntm kill my-game             # Kill session
```

---

## SENDING PROMPTS

### Broadcast to All
```bash
ntm send my-game --all "Implement the feature"
```

### Target by Type
```bash
ntm send my-game --cc "Deep analysis task"     # Claude only
ntm send my-game --cod "Quick prototype"       # Codex only
ntm send my-game --gmi "Research task"         # Gemini only
```

### Target Specific Pane
```bash
ntm send my-game --pane=2 "Specific task for pane 2"
```

### With File Context
```bash
ntm send my-game --cc -c src/file.lua "Review this"
```

---

## TASK MANAGEMENT (BEADS)

### Create Tasks
```bash
br add -t epic -p P1 "Main Feature" "Epic description"
br add -t task -p P1 "Sub-task" "Acceptance criteria"
br add -t bug -p P1 "Fix crash" "Reproduction steps"
```

### View Tasks
```bash
bv                       # View all
bv --robot-triage        # AI recommendations
br ready                 # Unblocked tasks
```

### Work on Tasks
```bash
br update <id> --status=in_progress   # Claim
bd close <id>                          # Complete
br update <id> --parent <epic-id>      # Set dependency
```

---

## GIT WORKTREES

### Create Worktree from Remote Branch
```bash
cd /data/projects/main-repo
git fetch origin
git worktree add ../repo-feature origin/feature-branch -b feature-local
```

### Setup Worktree with Flywheel
```bash
cd ../repo-feature
flywheel init
flywheel startwork --cc 2
```

### Manage Worktrees
```bash
git worktree list                      # List all
git worktree remove ../repo-feature    # Remove
```

---

## QUICK REFERENCE

### New Feature Workflow
```bash
# 1. Create worktree
git worktree add ../repo-feature origin/branch -b local

# 2. Initialize
cd ../repo-feature
flywheel init

# 3. Setup plan (if existing)
cp .sisyphus/plans/plan.md planning/PLAN_v0.md

# 4. Refine with APR
apr setup
apr run 1
apr run 2
apr show 2 > planning/PLAN.md

# 5. Create beads
flywheel beads --min-beads 50

# 6. Start work
flywheel startwork --cc 2
ntm attach repo-feature
```

### Daily Commands
| Task | Command |
|------|---------|
| View tasks | `bv --robot-triage` |
| Claim task | `br update <id> --status=in_progress` |
| Complete | `bd close <id>` |
| Start agents | `flywheel startwork --cc 2` |
| Attach | `ntm attach <session>` |
| Background jobs | `flywheel jobs` |

---

## TROUBLESHOOTING

### Check Health
```bash
flywheel doctor    # All dependencies
ntm deps -v        # Detailed check
```

### Session Issues
```bash
ntm interrupt my-game         # Send Ctrl+C
ntm kill my-game              # Kill session
tmux kill-session -t my-game  # Force kill
```

### Background Jobs
```bash
flywheel jobs           # List jobs
flywheel logs <job>     # View output
flywheel attach <job>   # Attach
```

---

*Location: /data/projects/FLYWHEEL_CHEATSHEET.md*

---

## DOODLESTEIN WORKFLOW (GPT Pro Integration)

### The Philosophy
> "Planning tokens are far fewer and cheaper than implementation tokens."
> Spend 85%+ of time on planning. The code will write itself.

### Full Doodlestein Workflow

```bash
# 1. Setup
cd /data/projects/my-feature
flywheel init

# 2. Initial plan (interview or compete)
flywheel plan --rounds 2           # OR
flywheel compete                   # Multi-model generation

# 3. GPT Pro guided refinement (2-3 rounds)
flywheel plan-pro --rounds 3       # Interactive: prompts for GPT Pro web

# 4. Create beads
flywheel beads --min-beads 50

# 5. Polish beads ("Measure N times, implement once")
flywheel polish --max 9            # Run 6-9 iterations until steady state

# 6. Start agents
flywheel startwork --cc 2
ntm attach my-feature
```

### New Commands (Doodlestein Integration)

| Command | Description |
|---------|-------------|
| `flywheel plan-pro [--rounds N]` | Guided planning with GPT Pro web (manual steps) |
| `flywheel polish [--max N]` | Iterative bead refinement (default: 9 rounds) |

### GPT Pro Web Workflow (Manual Steps)

The `plan-pro` command guides you through:

1. **Copy plan** → Clipboard or show path
2. **Show prompt** → Copy to GPT 5.2 Pro (Extended Reasoning)
3. **Wait for GPT** → Press Enter when done
4. **Paste output** → Save to `planning/gpt_roundN.md`
5. **Claude integrates** → Creates `planning/PLAN_vN.md`
6. **Repeat** → For N rounds

### Key Prompts (Word-for-Word)

See: `/data/projects/flywheel-lite/prompts/DOODLESTEIN_PROMPTS.md`

| Phase | Prompt |
|-------|--------|
| GPT Plan Review | "Carefully review this entire plan..." |
| Multi-Model Synthesis | "I asked 3 competing LLMs..." |
| Plan → Beads | "OK so now read ALL of [PLAN]..." |
| Bead Polish | "Reread AGENTS dot md..." |

### When to Use What

| Situation | Command |
|-----------|---------|
| New project, need interview | `flywheel plan` |
| Want multi-model plans | `flywheel compete` |
| Want GPT Pro deep review | `flywheel plan-pro` |
| Ready to make beads | `flywheel beads` |
| Want to polish beads | `flywheel polish` |
| Ready to implement | `flywheel startwork` |

### Model Recommendations (Doodlestein)

| Task | Best Model | Why |
|------|------------|-----|
| Plan creation | Claude Code (Opus) | Code access needed |
| Plan review | GPT 5.2 Pro Extended | Deep reasoning, no code needed |
| Plan integration | Claude Code (Opus) | Needs to write to files |
| Multi-model synthesis | GPT 5.2 Pro Extended | Final arbiter |
| Plan → Beads | Claude Code (Opus) | Needs bd/br tools |
| Bead polish | Claude Code (Opus) | Needs bd/br tools |
| Final polish | Codex (high reasoning) | Fresh perspective |
