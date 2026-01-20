#Find the product with the highest total sales (quantity * price) for each category.
WITH product_sales AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.list_price) AS total_sales
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id, p.product_id, p.product_name
),

ranked_sales AS (
    SELECT
        category_id,
        product_id,
        product_name,
        total_sales,
        RANK() OVER (PARTITION BY category_id ORDER BY total_sales DESC) AS rnk
    FROM product_sales
)

SELECT 
    category_id,
    product_id,
    product_name,
    total_sales
FROM ranked_sales
WHERE rnk = 1;
