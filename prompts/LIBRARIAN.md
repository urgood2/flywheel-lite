# Librarian Pattern - External Research

When working with unfamiliar libraries, frameworks, or external code:

## Research Protocol

### 1. Official Docs First
- Search for official documentation
- Check the correct version docs (not outdated)
- Look for migration guides if upgrading

### 2. Implementation Reference
For "how does X work internally":
```bash
# Clone to temp
gh repo clone owner/repo /tmp/repo-name -- --depth 1
cd /tmp/repo-name

# Find the implementation
grep -r "function_name" --include="*.ts"
cat path/to/file.ts
```

### 3. Context & History
For "why was this changed":
```bash
gh search issues "keyword" --repo owner/repo --limit 10
gh pr view <number> --repo owner/repo --comments
git log --oneline -20 -- path/to/file
git blame path/to/file
```

## Citation Rule

**Every claim about external code needs a permalink:**

```
https://github.com/owner/repo/blob/<commit-sha>/path/to/file#L10-L20
```

Get SHA:
```bash
cd /tmp/repo-name && git rev-parse HEAD
```

## When to Use This

- "How do I use [library]?"
- "What's the best practice for [framework feature]?"  
- "Why does [dependency] behave this way?"
- "Find examples of [library] usage"
- Working with unfamiliar packages

## Output Format

```markdown
**Question**: [what was asked]

**Answer**: [direct answer]

**Evidence**: [permalink to source]
```code
// relevant code snippet
```

**Explanation**: [why this is the answer]
```
