---
name: api-design
description: >
  Design or review REST API endpoints — naming, HTTP methods, status codes,
  request/response shapes, versioning, pagination, and OpenAPI spec generation.
  Trigger: "design this endpoint", "review this API", "write OpenAPI spec", "is this RESTful".
---

# API Design Skill

## REST Conventions
- Resources are nouns, plural: `/users`, `/orders/:id/items`
- HTTP methods: GET (read), POST (create), PUT (replace), PATCH (update), DELETE (remove)
- No verbs in URLs — `/users/activate` → `PATCH /users/:id { status: "active" }`

## Status Codes
| Scenario | Code |
|---|---|
| Success, returns data | 200 |
| Resource created | 201 |
| Success, no body | 204 |
| Validation error | 400 |
| Unauthenticated | 401 |
| Forbidden | 403 |
| Not found | 404 |
| Conflict / duplicate | 409 |
| Server error | 500 |

## Response Envelope
```json
{ "data": { ... }, "error": null, "meta": { "page": 1, "total": 42 } }
```

## Pagination
- Cursor-based for large datasets: `?cursor=<opaque>&limit=20`
- Offset for admin/small lists: `?page=1&limit=20`
- Always return `meta.total` and `meta.next_cursor`

## Versioning
- URL prefix: `/api/v1/...`
- Never remove a response field without a major version bump

## Output
For each endpoint produce an OpenAPI YAML block + a one-line description table.
