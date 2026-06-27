# 🤖 claude-code-starter-kit

> A production-ready Claude Code setup — CLAUDE.md, 8 skills, 7 agents, hooks, and MCP config.
> Clone it, fill in your project details, and have a full agentic workflow running in minutes.

---

## What's inside

```
claude-code-starter-kit/
├── CLAUDE.md                          ← project brain template
├── README.md
│
├── skills/
│   ├── security-audit/SKILL.md        ← OWASP security checks
│   ├── api-design/SKILL.md            ← REST API design + OpenAPI
│   ├── write-tests/SKILL.md           ← unit + integration test gen
│   ├── code-review/SKILL.md           ← structured code review
│   ├── debug-trace/SKILL.md           ← systematic debugging
│   ├── refactor/SKILL.md              ← safe refactoring playbook
│   ├── document-code/SKILL.md         ← docs, JSDoc, README gen
│   └── deploy-checklist/SKILL.md      ← pre-deploy safety checks
│
├── agents/
│   ├── orchestrator.md                ← coordinates all other agents
│   ├── architect.md                   ← HLD, system design, DB schema
│   ├── backend-engineer.md            ← API, DB, auth, business logic
│   ├── frontend-engineer.md           ← UI components, state, UX
│   ├── test-engineer.md               ← test strategy + execution
│   ├── security-auditor.md            ← compliance-focused security review
│   ├── security-hacker.md             ← adversarial attacker-perspective review
│   ├── code-reviewer.md               ← full review: correctness + security + perf
│   ├── debugger.md                    ← root cause analyst, 6-step fault localization
│   ├── shipper.md                     ← deployment debugger, Docker/nginx/auth failures
│   └── pr-reviewer.md                 ← PR review + GitHub integration
│
├── hooks/
│   ├── block-dangerous.sh             ← PreToolUse: guards bash commands
│   ├── lint-on-write.sh               ← PostWrite: auto-lints files
│   └── session-summary.sh             ← SessionComplete: logs session
│
├── mcp/
│   └── .mcp.json                      ← PostgreSQL + GitHub + Playwright
│
├── settings.json                      ← permissions + hook wiring
└── install.sh                         ← one-command project setup
```

---

## Quick start

```bash
# 1. Clone into any project
git clone https://github.com/BHUVANESH-SSN/claude-code-starter-kit
cd claude-code-starter-kit
bash install.sh /path/to/your/project

# 2. Edit CLAUDE.md with your project details
# 3. Edit .mcp.json with your connection strings
# 4. Start Claude Code
claude

# 5. Onboard Claude to your codebase
/onboard
```

---

## The mental model

```
CLAUDE.md          ← Claude reads this first, every session
    │
    ├── Skills     ← HOW to do specific tasks (/security-audit, /write-tests ...)
    ├── Agents     ← WHO handles what (architect, backend, security, PR reviewer ...)
    ├── Hooks      ← WHEN to run guardrails (before bash, after write, session end)
    └── MCP        ← WHAT tools Claude can actually use (DB, GitHub, browser)
```

Each layer compounds. A great `CLAUDE.md` means less repeated context. Skills mean consistent, high-quality task execution. Agents mean parallel work with clear ownership. Hooks mean automated quality gates. MCP means real tool access, not simulated calls.

---

## Concepts explained

### CLAUDE.md — The Project Brain

The single most important file. Claude reads it before any tool call. It defines:

- **Stack** — what's running, on which ports, with which dependencies
- **Hard rules** — things Claude must never do (no force-push, no schema drops without confirmation)
- **Agent routing** — which agent to delegate which task to
- **Skill index** — which SKILL.md to invoke for which scenario

See the full template: [`CLAUDE.md`](./CLAUDE.md)

---

### SKILL.md — Reusable Playbooks

A skill is a markdown file with a YAML frontmatter describing when to trigger it, followed by a structured checklist or procedure. Claude invokes it with `/skill-name`.

```
skills/
└── security-audit/
    └── SKILL.md    ← triggered by: "audit this", "check JWT", "is this safe"
```

Skills are reusable across projects. Write once, use everywhere.

---

### Agents — A Simulated Team

Each agent is a markdown file defining a **role** with specific tools, scope, and output format.

```
agents/
├── orchestrator.md        ← plans work, delegates to other agents, aggregates output
├── architect.md           ← system design before any code is written
├── backend-engineer.md    ← owns API, DB, business logic
├── frontend-engineer.md   ← owns UI, components, state
├── test-engineer.md       ← owns test strategy and coverage
├── security-auditor.md    ← compliance-focused security review (SOC2/OWASP checklist)
├── security-hacker.md     ← adversarial review — thinks like an attacker, finds exploits
├── code-reviewer.md       ← full review: correctness + security + perf + maintainability
├── debugger.md            ← root cause analyst, 6-step fault localization, never guesses
├── shipper.md             ← deployment debugger — Docker, nginx, auth callback failures
└── pr-reviewer.md         ← opens PRs, posts review comments via GitHub MCP
```

**The three security agents serve different purposes:**

| Agent | Lens | Ask it when |
|---|---|---|
| `security-hacker` | Attacker | "What can be exploited right now?" |
| `security-auditor` | Compliance | "Do we meet OWASP/SOC2 standards?" |
| `code-reviewer` | Quality + security | "Is this production-safe overall?" |

The orchestrator coordinates. Role agents run in parallel on scoped tasks. Results are aggregated.

---

### Hooks — Automated Guardrails

Hooks fire at lifecycle events without any manual invocation:

| Hook | Event | What it does |
|---|---|---|
| `block-dangerous.sh` | `PreToolUse` (Bash) | Blocks `rm -rf`, `DROP TABLE`, `--force` before execution |
| `lint-on-write.sh` | `PostWrite` (.py/.ts/.js) | Auto-lints every file after Claude writes it |
| `session-summary.sh` | `SessionComplete` | Writes a summary of what was done this session |

Wired in `settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "command": ".claude/hooks/block-dangerous.sh" }],
    "PostWrite":  [{ "matcher": ".*\\.(py|ts|js)$", "command": ".claude/hooks/lint-on-write.sh" }],
    "SessionComplete": [{ "command": ".claude/hooks/session-summary.sh" }]
  }
}
```

---

### MCP — Real Tool Integrations

MCP connects Claude to actual tools. No simulation — real queries, real PRs, real browser actions.

```json
{
  "mcpServers": {
    "postgres":   { "command": "npx @modelcontextprotocol/server-postgres $DATABASE_URL" },
    "github":     { "command": "npx @modelcontextprotocol/server-github" },
    "playwright": { "command": "npx @playwright/mcp" }
  }
}
```

With PostgreSQL MCP, agents can verify DB state directly. With GitHub MCP, `pr-reviewer` opens real PRs and posts comments. With Playwright MCP, agents can interact with UIs without context switching.

---

## Best plugins to install

```bash
/plugin install context7@claude-plugins-official      # always-fresh library docs
/plugin install frontend-design@claude-plugins-official  # design tokens + Tailwind constraints
/plugin install superpowers@claude-plugins-official   # /ship /fix /onboard slash commands
```

---

## One-liner examples

```bash
# Onboard Claude to a new codebase
claude "Read the codebase, fill in CLAUDE.md, and tell me what's missing."

# Full feature with planning first
claude "Architect a user notification system. Start with HLD + DB schema before any code."

# Security review before merge
claude "Run security-audit skill on all auth endpoints. Output a findings table."

# Parallel agent run
claude "Use the orchestrator to build the payment module. Delegate to architect, backend, and test-engineer in parallel."
```

---

## What the ecosystem looks like

```
Session start
     │
     ▼
Claude reads CLAUDE.md ──── understands project, stack, rules
     │
     ▼
You give a task
     │
     ▼
Orchestrator plans ──── delegates to agents (parallel)
     │
     ├── architect        → system design
     ├── backend-engineer → implementation
     ├── test-engineer    → test coverage
     └── security-auditor → security check
     │
     ▼
Hooks fire automatically
     │
     ├── PreToolUse  → guards every bash command
     ├── PostWrite   → lints every file written
     └── SessionComplete → logs the session
     │
     ▼
MCP gives agents real tools
     │
     ├── PostgreSQL → verify DB state
     ├── GitHub     → open PRs, post reviews
     └── Playwright → interact with UIs
```

---

## Contributing

PRs welcome. If you've written a skill or agent that's generic enough to be reusable, open a PR with it under `skills/` or `agents/`.

---

## Author

**Bhuvanesh** — B.E. CSE @ SSN College of Engineering  
GitHub: [@BHUVANESH-SSN](https://github.com/BHUVANESH-SSN)

---

*Star ⭐ if this saves you setup time. Fork and adapt to your own stack.*
