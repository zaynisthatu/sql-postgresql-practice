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

## 8. LIMIT syntax error (17 Aug 2025)

PostgreSQL returned `ERROR: syntax error at or near "LIMIT"` (SQL state 42601) while practising `ORDER BY` with `LIMIT`. The query that caused it was not saved. The working form is `SELECT ... FROM payment ORDER BY amount DESC LIMIT 3;` (LIMIT last, after ORDER BY).
