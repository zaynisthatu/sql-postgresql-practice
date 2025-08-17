# Results for 01_select_filter_sort.sql
Run on PostgreSQL (PostgreSQL 16.2 on x86_64-pc-linux-gnu) against `schema.sql`.

## 01_select_filter_sort.sql: SELECT, WHERE, IN, LIKE, BETWEEN, ORDER BY, LIMIT, DISTINCT
```sql
SELECT payment_id, amount, mode
FROM payment
ORDER BY amount DESC;
```
| payment_id | amount | mode |
|---|---|---|
| 9 | 120.00 | Cash |
| 8 | 100.00 | Credit Card |
| 3 | 100.00 | Credit Card |
| 1 | 90.00 | Net Banking |
| 12 | 80.00 | Debit Card |
| 6 | 70.00 | Debit Card |
| 7 | 60.00 | Mobile Payment |
| 4 | 50.00 | Cash |
| 11 | 50.00 | Cash |
| 5 | 40.00 | Mobile Payment |
| 10 | 30.00 | Net Banking |
| 2 | 20.00 | Mobile Payment |

12 row(s)

## 2. The three biggest payments (LIMIT goes last, after ORDER BY)
```sql
SELECT payment_id, amount, mode
FROM payment
ORDER BY amount DESC
LIMIT 3;
```
| payment_id | amount | mode |
|---|---|---|
| 9 | 120.00 | Cash |
| 3 | 100.00 | Credit Card |
| 8 | 100.00 | Credit Card |

3 row(s)

## 3. Payments made in cash or by credit card
```sql
SELECT payment_id, amount, mode
FROM payment
WHERE mode IN ('Cash', 'Credit Card');
```
| payment_id | amount | mode |
|---|---|---|
| 3 | 100.00 | Credit Card |
| 4 | 50.00 | Cash |
| 8 | 100.00 | Credit Card |
| 9 | 120.00 | Cash |
| 11 | 50.00 | Cash |

5 row(s)

## 4. Payments between 50 and 100, smallest first
```sql
SELECT payment_id, amount, mode
FROM payment
WHERE amount BETWEEN 50 AND 100
ORDER BY amount;
```
| payment_id | amount | mode |
|---|---|---|
| 11 | 50.00 | Cash |
| 4 | 50.00 | Cash |
| 7 | 60.00 | Mobile Payment |
| 6 | 70.00 | Debit Card |
| 12 | 80.00 | Debit Card |
| 1 | 90.00 | Net Banking |
| 8 | 100.00 | Credit Card |
| 3 | 100.00 | Credit Card |

8 row(s)

## 5. Customers whose first name starts with B
```sql
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'B%';
```
| first_name | last_name |
|---|---|
| Barbara | Brown |

1 row(s)

## 6. The payment modes in use
```sql
SELECT DISTINCT mode
FROM payment
ORDER BY mode;
```
| mode |
|---|
| Cash |
| Credit Card |
| Debit Card |
| Mobile Payment |
| Net Banking |

5 row(s)
