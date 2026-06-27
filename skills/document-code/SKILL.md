---
name: document-code
description: >
  Write or improve code documentation — JSDoc/docstrings, README sections, inline comments,
  and API reference docs. Trigger: "document this", "add JSDoc", "write a README for this",
  "this needs comments", "explain what this does".
---

# Document Code Skill

## JSDoc / Docstrings

For every exported function or class:
```typescript
/**
 * <one-line description of what this does>
 *
 * @param {Type} paramName - <what this param is>
 * @returns {Type} <what is returned>
 * @throws {ErrorType} <when this throws>
 *
 * @example
 * const result = myFunction(input);
 * // result => { ... }
 */
```

## Inline comments

Comment WHY, not WHAT. The code says what — comments say why.
```typescript
// Bad: increment counter
counter++;

// Good: track retries separately from attempts so we can distinguish
// a first-time failure from an exhausted retry budget
retryCount++;
```

Only add inline comments when the reasoning isn't obvious from the code.

## README sections

For any module, service, or feature:
```markdown
## <Feature Name>

**What it does:** <one sentence>

**When to use it:** <trigger conditions>

**How it works:** <brief explanation, diagram if useful>

**Configuration:**
| Variable | Default | Description |
|---|---|---|

**Example:**
\`\`\`
<minimal working example>
\`\`\`
```

## Output
List all files documented, note any functions left undocumented and why.
