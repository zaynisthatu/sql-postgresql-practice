-- 03_self_join.sql: joining a table to itself (two aliases of the same table)

-- 1. Child and parent in the family table
SELECT child.name AS child, parent.name AS parent
FROM family child
JOIN family parent ON child.parent_id = parent.id
ORDER BY child.id;

-- 2. Employee and manager
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;

-- 3. Everyone, including people without a parent (LEFT JOIN keeps Grandpa)
SELECT child.name AS person, parent.name AS parent
FROM family child
LEFT JOIN family parent ON child.parent_id = parent.id
ORDER BY child.id;
