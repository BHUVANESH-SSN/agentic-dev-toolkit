---
name: refactor
description: >
  Safe, behavior-preserving refactoring — reduce complexity, improve naming, extract modules,
  remove duplication. Trigger: "clean this up", "refactor this", "this is hard to read",
  "extract this into a function", "reduce complexity".
---

# Refactor Skill

## Rule 1 — Tests before you touch anything
If there are no tests covering the code being refactored, write them first.
Refactoring without tests is rewriting, not refactoring.

## Rule 2 — One change at a time
Each refactor commit should do exactly one thing:
- Rename a variable / function
- Extract a function
- Move a module
- Remove duplication
Never combine a rename + an extract + a logic change in one commit.

## Common refactors

### Extract function
When a block of code has a clear purpose and could have a name:
```typescript
// Before
if (user.role === 'admin' || user.permissions.includes('delete')) { ... }

// After
function canDelete(user: User): boolean {
  return user.role === 'admin' || user.permissions.includes('delete');
}
if (canDelete(user)) { ... }
```

### Remove duplication
Find repeated patterns → extract to a shared utility. Never copy-paste logic.

### Simplify conditionals
- Replace nested ternaries with early returns
- Replace repeated `if/else` chains with lookup tables or strategy pattern

### Reduce function length
Functions > 40 lines usually do more than one thing. Extract until each function does one thing.

## Output
List each change made, confirm all existing tests still pass, note any test gaps found.
