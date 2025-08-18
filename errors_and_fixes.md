# Errors and fixes

## 1. IN without brackets and wrong column (17 Aug 2025)

**Query**
```sql
SELECT mode FROM payment
WHERE amount IN 'Cash','Credit Card'
```
**PostgreSQL said:** `syntax error at or near "'Cash'"`

**Fix**
```sql
SELECT mode FROM payment
WHERE mode IN ('Cash', 'Credit Card');
```
`IN` needs a bracketed list, and the filter was on `amount` instead of `mode`.

## 2. Comma missing and wrong alias syntax (18 Aug 2025)

**Query**
```sql
SELECT a1.name AS first
a2.name AS second
FROM family.a1 JOIN family.a2 ON a1.parent_id = a2.id;
```
**PostgreSQL said:** `syntax error at or near "a2"`

**Fix**
```sql
SELECT a1.name AS first, a2.name AS second
FROM family a1
JOIN family a2 ON a1.parent_id = a2.id;
```
A comma between select items, and an alias goes after the table name (`family a1`), not `family.a1`.

## 3. Self join with wrong aliases (18 Aug 2025)

**Query**
```sql
SELECT child.name AS child, parent.name AS parent
FROM family.one JOIN family.two ON family.name = family.parent_id;
```
**PostgreSQL said:** `relation "family.one" does not exist`

**Fix**
```sql
SELECT child.name AS child, parent.name AS parent
FROM family child
JOIN family parent ON child.parent_id = parent.id;
```
A self join needs the same table twice with two different aliases, and the ON clause must use those aliases.

## 8. LIMIT syntax error (17 Aug 2025)

PostgreSQL returned `ERROR: syntax error at or near "LIMIT"` (SQL state 42601) while practising `ORDER BY` with `LIMIT`. The query that caused it was not saved. The working form is `SELECT ... FROM payment ORDER BY amount DESC LIMIT 3;` (LIMIT last, after ORDER BY).
