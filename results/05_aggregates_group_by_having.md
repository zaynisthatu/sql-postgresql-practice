# Results for 05_aggregates_group_by_having.sql
Run on PostgreSQL (PostgreSQL 16.2 on x86_64-pc-linux-gnu) against `schema.sql`.

## 05_aggregates_group_by_having.sql: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
```sql
SELECT COUNT(*) AS payments, SUM(amount) AS total, ROUND(AVG(amount), 2) AS average,
       MIN(amount) AS smallest, MAX(amount) AS largest
FROM payment;
```
| payments | total | average | smallest | largest |
|---|---|---|---|---|
| 12 | 810.00 | 67.50 | 20.00 | 120.00 |

1 row(s)

## 2. Count and total per payment mode
```sql
SELECT mode, COUNT(*) AS payments, SUM(amount) AS total
FROM payment
GROUP BY mode
ORDER BY total DESC;
```
| mode | payments | total |
|---|---|---|
| Cash | 3 | 220.00 |
| Credit Card | 2 | 200.00 |
| Debit Card | 2 | 150.00 |
| Mobile Payment | 3 | 120.00 |
| Net Banking | 2 | 120.00 |

5 row(s)

## 3. Only the modes with more than two payments (HAVING filters groups, WHERE filters rows)
```sql
SELECT mode, COUNT(*) AS payments
FROM payment
GROUP BY mode
HAVING COUNT(*) > 2
ORDER BY mode;
```
| mode | payments |
|---|---|
| Cash | 3 |
| Mobile Payment | 3 |

2 row(s)

## 4. The most used payment mode
```sql
SELECT mode, COUNT(*) AS payments
FROM payment
GROUP BY mode
ORDER BY payments DESC, mode
LIMIT 1;
```
| mode | payments |
|---|---|
| Cash | 3 |

1 row(s)

## 5. Total paid per customer (JOIN + GROUP BY)
```sql
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC, c.customer_id;
```
| first_name | last_name | total_paid |
|---|---|---|
| Linda | Williams | 200.00 |
| Barbara | Brown | 170.00 |
| Mary | Smith | 130.00 |
| Patricia | Johnson | 80.00 |
| Susan | Davis | 80.00 |
| Elizabeth | Jones | 70.00 |
| Robert | Miller | 50.00 |
| James | Garcia | 30.00 |

8 row(s)

## 6. Average salary per department
```sql
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary, COUNT(*) AS people
FROM employees e
JOIN departments d ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;
```
| dept_name | avg_salary | people |
|---|---|---|
| IT | 81333.33 | 3 |
| Sales | 61666.67 | 3 |
| HR | 52000.00 | 1 |

3 row(s)
