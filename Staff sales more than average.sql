#List the names of staff members who have made more sales than the average number of sales by all staff members.
WITH staff_sales AS (
    SELECT
        staff_id,
        COUNT(*) AS total_sales
    FROM orders
    GROUP BY staff_id
),

sales_with_avg AS (
    SELECT
        staff_id,
        total_sales,
        AVG(total_sales) OVER () AS avg_sales
    FROM staff_sales
)

SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    swa.total_sales
FROM sales_with_avg swa
LEFT JOIN staffs s
    ON swa.staff_id = s.staff_id
WHERE swa.total_sales > swa.avg_sales
ORDER BY swa.total_sales DESC;
