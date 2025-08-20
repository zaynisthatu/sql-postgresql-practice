# Errors and fixes

Errors met during the August 2025 practice sessions, each with PostgreSQL's error message and the corrected query. Every query was re-run on PostgreSQL 16 against `schema.sql`. `verbatim` marks a query as written in the session, `shortened` a shorter form of the session's query, and `re-created` the same error rebuilt on this schema because the original used the Chinook sample database, which is not included.

## 1. IN without brackets and wrong column (17 Aug 2025, verbatim)

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

## 2. Comma missing and wrong alias syntax (18 Aug 2025, verbatim)

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

## 3. Self join with wrong aliases (18 Aug 2025, shortened)

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

## 4. Double quotes around a string (19 Aug 2025, verbatim)

**Query**
```sql
SELECT * FROM employees
WHERE dept_id IN (SELECT dept_id FROM employees WHERE emp_name = "John");
```
**PostgreSQL said:** `column "John" does not exist`

**Fix**
```sql
SELECT * FROM employees
WHERE dept_id IN (SELECT dept_id FROM employees WHERE emp_name = 'John');
```
In PostgreSQL double quotes mean an identifier (a column), single quotes mean a string.

## 5. Alias used in WHERE, aggregate in WHERE (20 Aug 2025, re-created)

**Query**
```sql
SELECT p.payment_id, AVG(p.amount) AS al
FROM payment p
WHERE p.amount > al;
```
**PostgreSQL said:** `column "al" does not exist`

**Fix**
```sql
SELECT payment_id, amount
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);
```
A SELECT alias cannot be used in WHERE, and an aggregate cannot be compared in WHERE. Use a subquery. (Original ran on the Chinook `track` table; re-created here on `payment`.)

## 6. Correlated subquery without the outer alias (19 Aug 2025, re-created)

**Query**
```sql
SELECT emp_name FROM employees
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id);
```
**PostgreSQL said:** `missing FROM-clause entry for table "e"`

**Fix**
```sql
SELECT emp_name FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id);
```
The outer table needs the alias `e` for the inner query to refer to it.

## 7. HAVING with a plain subquery (20 Aug 2025, re-created)

**Query**
```sql
SELECT mode, COUNT(*) AS n FROM payment
GROUP BY mode
HAVING (SELECT city FROM customer)
ORDER BY n DESC LIMIT 1;
```
**PostgreSQL said:** `argument of HAVING must be type boolean, not type text`

**Fix**
```sql
SELECT mode, COUNT(*) AS n FROM payment
GROUP BY mode
HAVING COUNT(*) > 2
ORDER BY n DESC, mode LIMIT 1;
```
`HAVING` needs a true/false condition on the group. (Original ran on the Chinook `genre` and `invoice` tables; re-created here.)

## 8. LIMIT syntax error (17 Aug 2025)

PostgreSQL returned `ERROR: syntax error at or near "LIMIT"` (SQL state 42601) while practising `ORDER BY` with `LIMIT`. The query that caused it was not saved. The working form is `SELECT ... FROM payment ORDER BY amount DESC LIMIT 3;` (LIMIT last, after ORDER BY), see `queries/01_select_filter_sort.sql`.
