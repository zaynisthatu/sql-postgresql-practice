# Results for 03_self_join.sql
Run on PostgreSQL (PostgreSQL 16.2 on x86_64-pc-linux-gnu) against `schema.sql`.

## 03_self_join.sql: joining a table to itself (two aliases of the same table)
```sql
SELECT child.name AS child, parent.name AS parent
FROM family child
JOIN family parent ON child.parent_id = parent.id
ORDER BY child.id;
```
| child | parent |
|---|---|
| Dad | Grandpa |
| Uncle | Grandpa |
| Me | Dad |
| Sister | Dad |
| Cousin | Uncle |

5 row(s)

## 2. Employee and manager
```sql
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;
```
| employee | manager |
|---|---|
| John | Alice |
| Sara | John |
| Omar | Alice |
| Lina | Omar |
| Dev | Alice |
| Mia | John |
| Raj | Dev |

7 row(s)

## 3. Everyone, including people without a parent (LEFT JOIN keeps Grandpa)
```sql
SELECT child.name AS person, parent.name AS parent
FROM family child
LEFT JOIN family parent ON child.parent_id = parent.id
ORDER BY child.id;
```
| person | parent |
|---|---|
| Grandpa |  |
| Dad | Grandpa |
| Uncle | Grandpa |
| Me | Dad |
| Sister | Dad |
| Cousin | Uncle |

6 row(s)
