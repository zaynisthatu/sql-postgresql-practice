-- 04_subqueries.sql: scalar, IN, correlated and NOT EXISTS subqueries

-- 1. Everyone in the same department as John
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (SELECT dept_id FROM employees WHERE emp_name = 'John');

-- 2. Employees paid more than the company average
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 3. Employees paid more than the average of their own department (correlated)
SELECT e.emp_name, e.dept_id, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE dept_id = e.dept_id)
ORDER BY e.emp_id;

-- 4. Customers who paid at least once in cash
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment WHERE mode = 'Cash')
ORDER BY customer_id;

-- 5. Customers with no payment at all (same answer as the LEFT JOIN version in 02_joins.sql)
SELECT first_name, last_name
FROM customer c
WHERE NOT EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id);
