#List all products that have never been ordered.(use Exists)
WITH ordered_products AS (
    SELECT DISTINCT product_id
    FROM order_items
)

SELECT 
    p.product_id,
    p.product_name,
    p.list_price
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM ordered_products op
    WHERE op.product_id = p.product_id
);
