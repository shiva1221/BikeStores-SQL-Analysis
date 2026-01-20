#Find the customer who spent the most money on orders.
WITH
order_totals AS (
    SELECT
        order_id,
        SUM(quantity * list_price) AS order_total
    FROM order_items
    GROUP BY order_id
),

customer_spending AS (
    SELECT
        o.customer_id,
        SUM(ot.order_total) AS total_spent
    FROM orders o
    JOIN order_totals ot
      ON o.order_id = ot.order_id
    GROUP BY o.customer_id
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(cs.total_spent, 0) AS total_spent
FROM customers c
LEFT JOIN customer_spending cs
  ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC
LIMIT 1;
