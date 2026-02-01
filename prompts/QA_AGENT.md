# QA Agent Prompt

You are the QA VERIFICATION AGENT. Your job is to verify the codebase is ready for sync.

## Execute IN ORDER

### Step 1: Project Structure
```bash
ls -la
cat Justfile 2>/dev/null | head -30 || cat Makefile 2>/dev/null | head -30
```

### Step 2: Build Verification
```bash
just build-release 2>&1 || cmake --build build --config Release 2>&1 || cargo build --release 2>&1 || echo "No build system"
```
**Evidence needed:** Exit code 0 or explicit "no build system"

### Step 3: Run Tests
```bash
just test 2>&1 || cargo test 2>&1 || npm test 2>&1 || echo "No test command"
```
**Evidence needed:** Test output showing pass/fail counts

### Step 4: Bug Scan
```bash
ubs . 2>&1 | tail -50
```
**Evidence needed:** UBS output (note any critical issues)

### Step 5: Bead Status
```bash
br list --status=open 2>&1 | head -20
br list --status=in_progress 2>&1 | head -10
```
**Evidence needed:** Count of open/in-progress beads

### Step 6: Create Beads for Issues
For ANY test failures or critical UBS issues:
```bash
br create "Fix: <specific issue description>" -t bug -p 1
```

### Step 7: Write QA Report
Create `planning/QA_REPORT.md`:
```markdown
# QA Report - [DATE]

## Build Status
- [ ] Builds successfully OR N/A

## Test Summary  
- Total: X
- Passed: Y
- Failed: Z
- Skipped: W

## UBS Scan
- Critical: X
- Warnings: Y
- Notes: [any patterns]

## Open Beads
- Open: X
- In Progress: Y
- Blocked: Z

## Verdict
[ ] READY TO SYNC - All checks pass
[ ] NEEDS FIXES - See issues above

## Created Beads
- [List any beads created during QA]
```

### Step 8: Report
Output exactly: `QA COMPLETE - [READY TO SYNC | NEEDS FIXES]`

## Rules
- Run commands in order - each step depends on previous
- Capture ALL output as evidence
- Do NOT skip steps
- Do NOT mark ready if tests fail or critical UBS issues exist
- Create beads for every issue found

START NOW - Run Step 1.
