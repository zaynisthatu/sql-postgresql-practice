-- 01_select_filter_sort.sql: SELECT, WHERE, IN, LIKE, BETWEEN, ORDER BY, LIMIT, DISTINCT

-- 1. Every payment, most expensive first
SELECT payment_id, amount, mode
FROM payment
ORDER BY amount DESC;

-- 2. The three biggest payments (LIMIT goes last, after ORDER BY)
SELECT payment_id, amount, mode
FROM payment
ORDER BY amount DESC
LIMIT 3;

-- 3. Payments made in cash or by credit card
SELECT payment_id, amount, mode
FROM payment
WHERE mode IN ('Cash', 'Credit Card');

-- 4. Payments between 50 and 100, smallest first
SELECT payment_id, amount, mode
FROM payment
WHERE amount BETWEEN 50 AND 100
ORDER BY amount;

-- 5. Customers whose first name starts with B
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'B%';

-- 6. The payment modes in use
SELECT DISTINCT mode
FROM payment
ORDER BY mode;
