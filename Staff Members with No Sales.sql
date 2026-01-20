#Find the names of staff members who have not made any sales.
WITH staff_orders AS (
    SELECT
        staff_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY staff_id
)

SELECT
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    s.email,
    s.store_id
FROM staffs s
LEFT JOIN staff_orders so
    ON s.staff_id = so.staff_id
WHERE COALESCE(so.total_orders, 0) = 0
ORDER BY staff_name;
