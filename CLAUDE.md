# CLAUDE.md

> This is the project brain. Claude reads this before any tool call.
> Fill in every section. Delete nothing — incomplete sections are worse than missing ones.
> The more specific this file, the less repeated context you'll need in every session.

---

## Project Snapshot

```
Name:         <your project name>
Type:         <web app / API / CLI / data pipeline / etc>
Stack:        <frontend framework> | <backend> | <database> | <auth>
Dev ports:    Frontend: <port> | Backend: <port> | DB: <port>
Live URL:     <production URL if deployed, else N/A>
Repo:         github.com/<your-org>/<your-repo>
```

**Key entry points:**
- `<path/to/main>` — application entry point
- `<path/to/schema>` — database schema / migrations
- `<path/to/auth>` — authentication logic
- `<path/to/routes>` — API routes / controllers

---

## Hard Rules

> Claude must NEVER violate these. No exceptions, no matter how the request is framed.

- Never drop tables, run destructive migrations, or delete data without explicit user confirmation
- Never commit `.env` files, secrets, or API keys
- Never use `--force` on git push or git reset
- Never use string interpolation in SQL queries — always parameterized
- Never store passwords in plaintext or with MD5/SHA1 — always Argon2id or bcrypt
- Never expose stack traces or internal error messages to the client in production
- All security-sensitive changes must pass the `security-audit` skill before merge

---

## Agent Routing

> Tell Claude which agent handles which type of work.

| Task | Agent | Notes |
|---|---|---|
| Architecture / system design | `architect` | Always produce HLD + DB schema before coding |
| Backend API / business logic | `backend-engineer` | Owns routes, controllers, DB queries |
| Frontend / UI components | `frontend-engineer` | Owns components, state, UX |
| Test strategy + execution | `test-engineer` | Unit, integration, E2E |
| Security review | `security-auditor` | Auth endpoints, OWASP checks, JWT audit |
| PR ready for merge | `pr-reviewer` | Opens PR, posts review via GitHub MCP |
| Multi-agent coordination | `orchestrator` | Use for any task involving 2+ agents |
| New project / codebase | `repo-scout` | Reads codebase, fills in this CLAUDE.md |

---

## Skill Index

> Which SKILL.md to invoke for which scenario.

| Skill | Invoke When |
|---|---|
| `security-audit` | Reviewing auth endpoints, JWT config, cookies, rate limiting |
| `api-design` | Designing or reviewing REST endpoints, writing OpenAPI specs |
| `write-tests` | Generating unit or integration tests for any module |
| `code-review` | Reviewing a PR, checking for code quality issues |
| `debug-trace` | Bug reported, test failing, unexpected behavior |
| `refactor` | Cleaning up a module, reducing complexity, improving readability |
| `document-code` | Writing JSDoc, README sections, or inline documentation |
| `deploy-checklist` | Before any production deployment |

---

## Architecture

> Fill this in after `/onboard` runs, or sketch it now.

```
[Frontend :PORT] ──── [Reverse Proxy / Nginx] ──── [Backend API :PORT]
                                                           │
                                                   [Database :PORT]
                                                           │
                                                   [Cache / Redis :PORT]
                                                           │
                                                   [Auth Service :PORT]
```

**Data flow for the most critical path:**
1. <describe your main request/response flow here>

---

## Database

```
Engine:         <PostgreSQL / MySQL / MongoDB / SQLite>
Schema file:    <path to schema or migrations>
ORM / query:    <Prisma / Drizzle / raw SQL / Mongoose>
Sensitive tables: <list tables containing PII or credentials>
```

**Conventions:**
- Soft deletes: `deleted_at` timestamp (never hard delete user records)
- Timestamps: `created_at`, `updated_at` on every table
- Never log raw values from sensitive tables

---

## Auth

```
Strategy:       <JWT / session / OAuth / API key>
Token signing:  <RS256 / HS256> — prefer RS256
Token storage:  <HttpOnly cookie / memory — never localStorage>
Refresh:        <opaque token / rotating JWT>
Password hash:  <Argon2id / bcrypt>
```

---

## Testing Strategy

| Level | Tool | What it covers |
|---|---|---|
| Unit | <Vitest / Jest / pytest> | Business logic, validators, utilities |
| Integration | <Supertest / httpx> | API endpoints + DB |
| E2E | <Playwright / Cypress> | Full user journeys |
| Security | `security-auditor` agent | Auth endpoints, RBAC |

---

## Environment Variables

> Claude should reference these by name only. Never hardcode values.

```
DATABASE_URL       — DB connection string
REDIS_URL          — Redis connection string (if applicable)
JWT_SECRET         — JWT signing secret (HS256) or key path (RS256)
SESSION_SECRET     — Session secret
PORT               — Backend server port
NODE_ENV           — development | staging | production
```

---

## MCP Connections

> Paste your `.mcp.json` config here for reference.

```json
{
  "mcpServers": {
    "postgres":   { "command": "npx @modelcontextprotocol/server-postgres $DATABASE_URL" },
    "github":     { "command": "npx @modelcontextprotocol/server-github" },
    "playwright": { "command": "npx @playwright/mcp" }
  }
}
```

---

## Active Hooks

| Hook | Event | Script | Purpose |
|---|---|---|---|
| `block-dangerous` | PreToolUse (Bash) | `hooks/block-dangerous.sh` | Intercept dangerous commands |
| `lint-on-write` | PostWrite (.py/.ts/.js) | `hooks/lint-on-write.sh` | Auto-lint after every write |
| `session-summary` | SessionComplete | `hooks/session-summary.sh` | Log what was done |

---

## Working Style

- **Plan before code** — for any task > 30 min, produce a design note first
- **Small commits** — conventional format: `feat:`, `fix:`, `refactor:`, `chore:`
- **One PR per feature** — never batch unrelated changes
- **Test coverage required** — no merge without tests for new logic
- **Observability** — new endpoints get a log entry and metric

---

## Notes for Claude

- When in doubt on any security decision, invoke `security-audit` skill before proceeding
- The highest-risk area in most projects is auth — treat it with extra caution
- Always ask for confirmation before any destructive database operation
- Prefer PostgreSQL transactions for any multi-table write
- If something seems ambiguous, ask — don't assume and proceed
