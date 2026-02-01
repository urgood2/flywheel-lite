# Flywheel‑Lite: an oh‑my‑opencode style loop on top of Agent Flywheel tooling

This guide turns the **Agent Flywheel / ACFS** toolchain into a "minimal-friction" workflow:

1) **Interactive interview** (1 Claude instance)  
2) **Plan refinement loop** (Codex GPT‑5.2, with a user‑set iteration count)  
3) **Plan → Beads** (structured task graph)  
4) **/startwork** (spawn an NTM swarm with a user‑set mix of worker types)  
5) **Coordinate via Agent Mail** (file reservations + review requests)  
6) **Guardrails** (UBS + a light memory routine) — optional, not overwhelming

---

## What you're building

You'll end up with **one command** (`flywheel …`) that:

- Works in **any repo** (existing or freshly cloned).
- Works on **any existing branch** or can create a **new branch**.
- Lets you set:
  - **Interview rounds**
  - **Plan refinement iterations**
  - **How many worker agents** of each type (`cc`, `cod`, `gmi`)
  - **Model defaults + reasoning effort** (where supported)

---

## Glossary

- **NTM**: Spawns and manages named tmux sessions with multiple agent panes (`cc`, `cod`, `gmi`).  
- **APR**: Automated Plan Reviser (requires manual `apr setup` first).  
- **Beads (`bd`/`br`)**: Local-first issue/task graph storage.  
- **BV (`bv`)**: Beads Viewer (graph triage; tells agents what's ready).  
- **Agent Mail (MCP)**: Agent-to-agent messaging + file reservations to avoid conflicts.  
- **UBS**: Bug scanner/guardrails before committing.  
- **CASS + CM**: Search across old sessions + memory (optional, light touch).

---

## 0) Prerequisites

Requires Agent Flywheel toolchain (ACFS). Verify:

```bash
which git tmux ntm bd bv apr ubs claude codex gemini
ntm deps -v
```

**Note**: If you have `br` but not `bd`, create a symlink:
```bash
ln -s $(which br) ~/.local/bin/bd
```

---

## 1) Installation

```bash
git clone https://github.com/YOUR_USER/flywheel-lite.git
cd flywheel-lite
./install.sh
source ~/.bashrc
flywheel doctor
```

---

## 2) Configuration

Global config: `~/.config/flywheel/config.env`

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

Repo-local override: `.flywheel/config.env`

---

## 3) The Workflow

### Step A — Initialize repo

```bash
cd /data/projects/your-repo
flywheel init
flywheel checkout feat/my-feature main
```

### Step B — Interactive interview (Claude)

```bash
flywheel plan --rounds 2
```

Do the Q/A in the `cc` pane. Claude writes:
- `planning/INTERVIEW_TRANSCRIPT.md`
- `planning/PLAN_v0.md`

### Step C — Plan refinement

```bash
flywheel refine --iters 3
```

Outputs: `planning/PLAN.md` (final)

### Step D — Plan → Beads

```bash
flywheel beads --min-beads 50
```

Then run the printed `cc "..."` command manually.

### Step E — Spawn the swarm

```bash
flywheel startwork --cc 3 --cod 2 --gmi 1
ntm attach your-repo
```

---

## 4) Agent Mail Usage

### File reservations (before editing)

Inside an agent with MCP tools:
```
mcp.file_reservation_paths(
  project_key=..., 
  agent_name=..., 
  paths=[...], 
  ttl_seconds=3600, 
  exclusive=true
)
```

### Review requests

When finishing a bead:
```
mcp.send_message(
  project_key=..., 
  sender_name=..., 
  to=[...], 
  subject=..., 
  body_md=...
)
```

---

## 5) Guardrails

### UBS before commits

```bash
ubs $(git diff --name-only --cached)
```

### Memory (light-touch)

- Before planning: search prior work with CASS
- After big beads: store notes with CM

---

## 6) Troubleshooting

### Session name must match project directory

```bash
# ✅ Correct (in /data/projects/myrepo)
ntm spawn myrepo --cc=2

# ❌ Wrong
ntm spawn myrepo-work --cc=2
```

### ntm send race condition

Wait 3 seconds after spawn, or use `--pane=N`:
```bash
ntm send myrepo --pane=2 "message"
```

### Agent count must be > 0

Only pass flags for agents you want:
```bash
# ✅ Correct
flywheel startwork --cc 3

# ❌ Wrong  
flywheel startwork --cc 3 --cod 0 --gmi 0
```

### APR requires manual setup

```bash
apr setup           # First time
apr run 1 --login   # First round
apr run 2           # Subsequent
```

---

## References

- Agent Flywheel: https://agent-flywheel.com/learn
- Claude Code CLI: https://code.claude.com/docs/en/cli-reference
- Codex CLI: https://developers.openai.com/codex/
- Gemini CLI: https://geminicli.com/docs/
