#Find the total number of orders placed by each customer per store.
WITH order_counts AS (
    SELECT
        customer_id,
        store_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id, store_id
),

customer_info AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name
    FROM customers c
),

store_info AS (
    SELECT 
        store_id,
        store_name
    FROM stores
)

SELECT
    ci.customer_name,
    si.store_name,
    oc.total_orders
FROM order_counts oc
LEFT JOIN customer_info ci
    ON oc.customer_id = ci.customer_id
LEFT JOIN store_info si
    ON oc.store_id = si.store_id
ORDER BY ci.customer_name, si.store_name;
