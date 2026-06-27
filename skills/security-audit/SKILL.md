---
name: security-audit
description: >
  OWASP-aligned security review of auth endpoints, JWT config, cookies, rate limiting,
  CORS, password hashing, and input validation.
  Trigger: "audit this", "check security", "review auth", "is this safe", any JWT/cookie change.
triggers:
  - "audit"
  - "check security"
  - "review auth"
  - "is this safe"
  - "check JWT"
---

# Security Audit Skill

## JWT
- [ ] Algorithm: RS256 — never HS256 or none
- [ ] `kid` header present and validated against JWKS
- [ ] `exp` checked on every request
- [ ] No PII in payload

## Refresh Tokens
- [ ] Opaque (not JWT) — random 256-bit hex
- [ ] HttpOnly + Secure + SameSite=Strict cookie
- [ ] Rotated on every use, old token immediately revoked
- [ ] TTL ≤ 7 days, Redis-backed

## Passwords
- [ ] Argon2id (not bcrypt, not MD5)
- [ ] Memory ≥ 64MB, iterations ≥ 3
- [ ] Timing-safe comparison on login

## Rate Limiting
- [ ] Redis-backed (not in-memory)
- [ ] Per-IP AND per-user on login/register/reset
- [ ] Returns `Retry-After` header

## Cookies
- [ ] HttpOnly, Secure, SameSite=Strict
- [ ] Domain scoped correctly

## CORS
- [ ] Explicit allowlist — never `*` in production
- [ ] `credentials: true` only where needed

## SQL / Inputs
- [ ] All queries parameterized
- [ ] Request body size limited
- [ ] No PII in logs

## Output
Return a markdown table:
| # | Check | Status | Finding | Severity | Fix |
