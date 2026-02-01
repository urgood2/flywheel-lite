# Delegation Prompt Structure

When delegating tasks to other agents or breaking down work, use this 7-section structure:

## Mandatory Sections

Every task delegation MUST include ALL of these:

### 1. TASK
Atomic, specific goal. ONE action per delegation.
- Bad: "Fix the authentication system"
- Good: "Add logout button to Navbar component"

### 2. EXPECTED OUTCOME
Concrete deliverables with measurable success criteria.
- What files will be created/modified?
- What behavior will change?
- How will we know it's done?

### 3. REQUIRED SKILLS
Which expertise domains are needed:
- frontend, backend, database, testing, devops, etc.

### 4. REQUIRED TOOLS
Explicit tool whitelist to prevent scope creep:
- Which commands are allowed?
- Which files can be touched?

### 5. MUST DO (Exhaustive requirements)
Leave NOTHING implicit. List every requirement:
- Follow existing code style in [file]
- Add error handling for [case]
- Update [related file] if needed
- Run [verification command] after

### 6. MUST NOT DO (Forbidden actions)
Anticipate and block rogue behavior:
- Do NOT modify [unrelated files]
- Do NOT add new dependencies without approval
- Do NOT refactor surrounding code
- Do NOT skip tests

### 7. CONTEXT
File paths, existing patterns, constraints:
- Related files: [paths]
- Existing patterns to follow: [description]
- Known constraints: [list]

---

## Example

```
TASK: Add logout button to navbar

EXPECTED OUTCOME:
- Button visible in top-right of navbar
- Clicking clears session and redirects to /login
- Loading state shown during API call

REQUIRED SKILLS: frontend, React

REQUIRED TOOLS: edit src/components/*, run npm test

MUST DO:
- Follow existing button styles in Navbar.tsx
- Use existing useAuth hook for logout
- Add loading state during logout API call
- Handle error case with toast notification
- Add unit test for logout button

MUST NOT DO:
- Do NOT modify auth service internals
- Do NOT add new npm dependencies
- Do NOT refactor other navbar elements
- Do NOT change routing logic

CONTEXT:
- Navbar: src/components/Navbar.tsx
- Auth hook: src/hooks/useAuth.ts (has logout method)
- Existing buttons use <Button variant="ghost">
- Toast: use existing useToast hook
```

---

## Post-Delegation Verification

After ANY delegated work completes, VERIFY before accepting:

- [ ] Does it work as expected? (tested)
- [ ] Does it follow existing codebase patterns?
- [ ] Were all MUST DO requirements met?
- [ ] Were all MUST NOT DO rules respected?
- [ ] Is evidence collected? (test output, screenshots)

If verification fails → fix or escalate. Do NOT mark complete.
