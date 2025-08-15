-- schema.sql: small practice database (PostgreSQL)
-- Tables follow the exercises from Aug 2025: customers and payments (WHERE / IN / GROUP BY),
-- employees and departments (subqueries), family and employees.manager_id (self joins).
-- All data is made up.

DROP TABLE IF EXISTS payment, customer, employees, departments, family CASCADE;

CREATE TABLE departments (
    dept_id   INT PRIMARY KEY,
    dept_name TEXT NOT NULL
);

CREATE TABLE employees (
    emp_id     INT PRIMARY KEY,
    emp_name   TEXT NOT NULL,
    dept_id    INT REFERENCES departments (dept_id),
    salary     NUMERIC(10, 2),
    manager_id INT REFERENCES employees (emp_id)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    age         INT,
    city        TEXT
);

CREATE TABLE payment (
    payment_id   SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL REFERENCES customer (customer_id),
    amount       NUMERIC(8, 2) NOT NULL,
    mode         TEXT NOT NULL,
    payment_date DATE NOT NULL
);

CREATE TABLE family (
    id        INT PRIMARY KEY,
    name      TEXT NOT NULL,
    parent_id INT REFERENCES family (id)
);

INSERT INTO departments VALUES (1, 'Sales'), (2, 'IT'), (3, 'HR');

INSERT INTO employees VALUES
    (1, 'Alice', 2, 95000, NULL),
    (2, 'John',  1, 62000, 1),
    (3, 'Sara',  1, 58000, 2),
    (4, 'Omar',  2, 78000, 1),
    (5, 'Lina',  2, 71000, 4),
    (6, 'Dev',   3, 52000, 1),
    (7, 'Mia',   1, 65000, 2),
    (8, 'Raj', NULL, 48000, 6);

INSERT INTO customer VALUES
    (1, 'Mary',      'Smith',    28, 'Delhi'),
    (2, 'Patricia',  'Johnson',  35, 'Mumbai'),
    (3, 'Linda',     'Williams', 42, 'Kolkata'),
    (4, 'Barbara',   'Brown',    22, 'Chennai'),
    (5, 'Elizabeth', 'Jones',    31, 'Bangalore'),
    (6, 'James',     'Garcia',   45, 'Delhi'),
    (7, 'Robert',    'Miller',   39, 'Pune'),
    (8, 'Susan',     'Davis',    26, 'Mumbai'),
    (9, 'Karen',     'Wilson',   33, 'Pune');

INSERT INTO payment (customer_id, amount, mode, payment_date) VALUES
    (1,  90.00, 'Net Banking',    '2025-01-15'),
    (2,  20.00, 'Mobile Payment', '2025-01-16'),
    (3, 100.00, 'Credit Card',    '2025-01-17'),
    (4,  50.00, 'Cash',           '2025-01-18'),
    (1,  40.00, 'Mobile Payment', '2025-01-19'),
    (5,  70.00, 'Debit Card',     '2025-01-20'),
    (2,  60.00, 'Mobile Payment', '2025-01-21'),
    (3, 100.00, 'Credit Card',    '2025-01-22'),
    (4, 120.00, 'Cash',           '2025-01-23'),
    (6,  30.00, 'Net Banking',    '2025-01-24'),
    (7,  50.00, 'Cash',           '2025-01-25'),
    (8,  80.00, 'Debit Card',     '2025-01-26');

INSERT INTO family VALUES
    (1, 'Grandpa', NULL),
    (2, 'Dad',     1),
    (3, 'Uncle',   1),
    (4, 'Me',      2),
    (5, 'Sister',  2),
    (6, 'Cousin',  3);
