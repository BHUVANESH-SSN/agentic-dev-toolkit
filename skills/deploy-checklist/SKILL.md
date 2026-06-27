---
name: deploy-checklist
description: >
  Pre-deployment safety checklist for production releases.
  Trigger: "ready to deploy", "deploy this", "push to production", "release checklist",
  any task that ends with shipping to a live environment.
---

# Deploy Checklist Skill

Run through every item. Do not skip. Mark each ✅ or ❌ with a note.

## Code quality
- [ ] All tests passing (unit + integration + E2E)
- [ ] No lint errors or type errors
- [ ] No `console.log` or debug statements left in production code
- [ ] No TODOs blocking this release

## Security
- [ ] No secrets or API keys in source code
- [ ] `.env` is in `.gitignore` and not committed
- [ ] `security-audit` skill run on any auth changes in this release
- [ ] Dependencies audited: `npm audit` or `pip-audit` — no HIGH/CRITICAL unresolved

## Database
- [ ] Migrations tested on a staging DB before production
- [ ] Migrations are reversible (rollback plan exists)
- [ ] No destructive schema changes without a data migration plan
- [ ] Indexes added for any new query patterns

## Infrastructure
- [ ] Environment variables set correctly in production environment
- [ ] Health check endpoint responding
- [ ] Reverse proxy / Nginx config tested
- [ ] Docker images built from production config (not dev overrides)

## Observability
- [ ] Logs flowing to the expected destination
- [ ] Key metrics instrumented (request count, error rate, latency)
- [ ] Alerts configured for error rate spikes

## Rollback plan
- [ ] Previous version is deployable within < 5 minutes
- [ ] DB rollback migration written and tested
- [ ] Team notified of deployment window

## Output
Return a checklist with ✅ / ❌ per item and a final verdict:
**DEPLOY: GO / NO-GO**
If NO-GO, list the blocking items.
