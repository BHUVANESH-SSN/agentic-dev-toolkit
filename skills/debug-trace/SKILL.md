---
name: debug-trace
description: >
  Systematic debugging playbook for bugs, failing tests, unexpected behavior, and production incidents.
  Trigger: "this is broken", "why is this failing", "debug this", "production issue", test suite failures.
---

# Debug Trace Skill

## Step 1 — Reproduce
- Get the exact error message, stack trace, and steps to reproduce
- Confirm the bug is reproducible in a clean environment
- Note: when did it start? what changed recently?

## Step 2 — Isolate
- Narrow down to the smallest code path that triggers the bug
- Check: is it environment-specific? (dev vs prod, one user vs all)
- Check: is it data-specific? (specific input values trigger it)

## Step 3 — Hypothesize
List 3 possible causes ranked by likelihood, then test the most likely one first.

## Step 4 — Verify
- Write a failing test that reproduces the bug BEFORE fixing it
- Fix the bug
- Confirm the test now passes
- Check for related bugs triggered by the same root cause

## Step 5 — Document
```
Bug: <description>
Root cause: <what was wrong>
Fix: <what was changed>
Regression test: <test file + test name>
Related risks: <anything else that could be affected>
```
