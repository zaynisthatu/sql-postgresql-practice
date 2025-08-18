-- 02_joins.sql: INNER JOIN and LEFT JOIN

-- 1. Each payment with the customer's name
SELECT c.first_name, c.last_name, p.amount, p.mode
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
ORDER BY p.payment_id;

-- 2. Customers who have never paid (LEFT JOIN, then keep the rows with no match)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN payment p ON p.customer_id = c.customer_id
WHERE p.payment_id IS NULL;

-- 3. Every employee with a department name; Raj has no department, so he needs a LEFT JOIN
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON d.dept_id = e.dept_id
ORDER BY e.emp_id;
