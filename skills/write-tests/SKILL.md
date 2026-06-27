---
name: write-tests
description: >
  Generate unit and integration tests for any module, function, or API endpoint.
  Trigger: "write tests for this", "add test coverage", "test this function",
  "what tests are missing", any PR that adds logic without tests.
---

# Write Tests Skill

## Before writing

1. Read the function/module being tested — understand inputs, outputs, side effects
2. Check the existing test style in the repo — match naming, assertion library, mocking patterns
3. Identify: happy path, edge cases, error cases, boundary values

## Unit test structure

```typescript
describe('<module or function name>', () => {
  describe('<method or scenario>', () => {
    it('should <expected behavior> when <condition>', () => {
      // Arrange
      const input = ...;
      // Act
      const result = fn(input);
      // Assert
      expect(result).toEqual(expected);
    });
  });
});
```

## Integration test structure (API endpoints)

```typescript
describe('POST /api/<resource>', () => {
  it('should create resource and return 201 with correct shape', async () => {
    const res = await request(app).post('/api/<resource>').send({ ... });
    expect(res.status).toBe(201);
    expect(res.body.data).toMatchObject({ ... });
    // Verify DB state
    const record = await db.query('SELECT * FROM <table> WHERE id = $1', [res.body.data.id]);
    expect(record.rows[0]).toMatchObject({ ... });
  });

  it('should return 400 when required field is missing', async () => { ... });
  it('should return 401 when unauthenticated', async () => { ... });
});
```

## Coverage targets
- New logic: 100% branch coverage
- Existing modules: improve by at least 20% per task
- Auth/security code: 100% — no exceptions

## Output
List all tests written with their status (passing/failing) and any coverage delta.
