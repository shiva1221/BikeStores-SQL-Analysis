#Find the top 3 most sold products in terms of quantity.
WITH product_quantities AS (
    SELECT
        product_id,
        SUM(quantity) AS total_qty
    FROM order_items
    GROUP BY product_id
),
product_info AS (
    SELECT 
        product_id,
        product_name
    FROM products
)

SELECT
    pi.product_name,
    pq.total_qty
FROM product_quantities pq
LEFT JOIN product_info pi
    ON pq.product_id = pi.product_id
ORDER BY pq.total_qty DESC
LIMIT 3;
