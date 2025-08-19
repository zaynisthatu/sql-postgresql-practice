# Results for 04_subqueries.sql
Run on PostgreSQL (PostgreSQL 16.2 on x86_64-pc-linux-gnu) against `schema.sql`.

## 04_subqueries.sql: scalar, IN, correlated and NOT EXISTS subqueries
```sql
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (SELECT dept_id FROM employees WHERE emp_name = 'John');
```
| emp_name | dept_id |
|---|---|
| John | 1 |
| Sara | 1 |
| Mia | 1 |

3 row(s)

## 2. Employees paid more than the company average
```sql
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;
```
| emp_name | salary |
|---|---|
| Alice | 95000.00 |
| Omar | 78000.00 |
| Lina | 71000.00 |

3 row(s)

## 3. Employees paid more than the average of their own department (correlated)
```sql
SELECT e.emp_name, e.dept_id, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id)
ORDER BY e.emp_id;
```
| emp_name | dept_id | salary |
|---|---|---|
| Alice | 2 | 95000.00 |
| John | 1 | 62000.00 |
| Mia | 1 | 65000.00 |

3 row(s)

## 4. Customers who paid at least once in cash
```sql
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment WHERE mode = 'Cash')
ORDER BY customer_id;
```
| first_name | last_name |
|---|---|
| Barbara | Brown |
| Robert | Miller |

2 row(s)

## 5. Customers with no payment at all (same answer as the LEFT JOIN version in 02_joins.sql)
```sql
SELECT first_name, last_name
FROM customer c
WHERE NOT EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id);
```
| first_name | last_name |
|---|---|
| Karen | Wilson |

1 row(s)
