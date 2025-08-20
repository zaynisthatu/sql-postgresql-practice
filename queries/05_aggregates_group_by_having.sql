-- 05_aggregates_group_by_having.sql: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING

-- 1. Summary of all payments
SELECT COUNT(*) AS payments, SUM(amount) AS total, ROUND(AVG(amount), 2) AS average,
       MIN(amount) AS smallest, MAX(amount) AS largest
FROM payment;

-- 2. Count and total per payment mode
SELECT mode, COUNT(*) AS payments, SUM(amount) AS total
FROM payment
GROUP BY mode
ORDER BY total DESC;

-- 3. Only the modes with more than two payments (HAVING filters groups, WHERE filters rows)
SELECT mode, COUNT(*) AS payments
FROM payment
GROUP BY mode
HAVING COUNT(*) > 2
ORDER BY mode;

-- 4. The most used payment mode
SELECT mode, COUNT(*) AS payments
FROM payment
GROUP BY mode
ORDER BY payments DESC, mode
LIMIT 1;

-- 5. Total paid per customer (JOIN + GROUP BY)
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC, c.customer_id;

-- 6. Average salary per department
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary, COUNT(*) AS people
FROM employees e
JOIN departments d ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;
