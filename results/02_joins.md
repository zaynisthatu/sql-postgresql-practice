# Results for 02_joins.sql
Run on PostgreSQL (PostgreSQL 16.2 on x86_64-pc-linux-gnu) against `schema.sql`.

## 02_joins.sql: INNER JOIN and LEFT JOIN
```sql
SELECT c.first_name, c.last_name, p.amount, p.mode
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
ORDER BY p.payment_id;
```
| first_name | last_name | amount | mode |
|---|---|---|---|
| Mary | Smith | 90.00 | Net Banking |
| Patricia | Johnson | 20.00 | Mobile Payment |
| Linda | Williams | 100.00 | Credit Card |
| Barbara | Brown | 50.00 | Cash |
| Mary | Smith | 40.00 | Mobile Payment |
| Elizabeth | Jones | 70.00 | Debit Card |
| Patricia | Johnson | 60.00 | Mobile Payment |
| Linda | Williams | 100.00 | Credit Card |
| Barbara | Brown | 120.00 | Cash |
| James | Garcia | 30.00 | Net Banking |
| Robert | Miller | 50.00 | Cash |
| Susan | Davis | 80.00 | Debit Card |

12 row(s)

## 2. Customers who have never paid (LEFT JOIN, then keep the rows with no match)
```sql
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN payment p ON p.customer_id = c.customer_id
WHERE p.payment_id IS NULL;
```
| customer_id | first_name | last_name |
|---|---|---|
| 9 | Karen | Wilson |

1 row(s)

## 3. Every employee with a department name; Raj has no department, so he needs a LEFT JOIN
```sql
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON d.dept_id = e.dept_id
ORDER BY e.emp_id;
```
| emp_name | dept_name |
|---|---|
| Alice | IT |
| John | Sales |
| Sara | Sales |
| Omar | IT |
| Lina | IT |
| Dev | HR |
| Mia | Sales |
| Raj |  |

8 row(s)
