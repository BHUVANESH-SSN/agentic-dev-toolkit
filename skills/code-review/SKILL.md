---
name: code-review
description: >
  Structured code review covering correctness, readability, security, performance, and test coverage.
  Trigger: "review this code", "review this PR", "check this before I merge", "give me feedback on this".
---

# Code Review Skill

## Review dimensions

### 1. Correctness
- Does it do what it's supposed to do?
- Are all edge cases handled? (null, empty, zero, very large, concurrent)
- Are errors caught and handled — not silently swallowed?

### 2. Readability
- Is the intent of each function clear from its name and structure?
- Are functions short enough to understand in one read? (> 40 lines is a warning sign)
- Are variable names meaningful? Single-letter names only acceptable in loops
- Is there dead code, commented-out code, or TODOs without context?

### 3. Security
- Any SQL string interpolation? → Flag immediately
- Any secrets or credentials in source? → Flag immediately
- Any auth bypass risk? → Flag immediately
- For anything auth-related: invoke `security-audit` skill

### 4. Performance
- Any N+1 query patterns? (loop with a DB call inside)
- Any unbounded queries? (missing LIMIT or pagination)
- Any unnecessary synchronous blocking in async code?

### 5. Test coverage
- Is new logic covered by tests?
- Are tests testing behavior, not implementation?
- Do integration tests verify DB state, not just response?

## Output format

```markdown
## Code Review

### Summary
<2-3 sentence overall assessment>

### Findings

| # | Severity | File:Line | Issue | Suggested Fix |
|---|---|---|---|---|
| 1 | BLOCKING | src/auth.ts:42 | SQL string interpolation | Use parameterized query |
| 2 | MEDIUM | src/users.ts:87 | N+1 query in loop | Batch with `WHERE id = ANY($1)` |
| 3 | LOW | src/utils.ts:12 | Misleading variable name `d` | Rename to `durationMs` |

### Verdict
APPROVED / CHANGES REQUESTED
```
