#Find the highest-priced product for each category name.
WITH ranked_products AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        p.list_price,
        ROW_NUMBER() OVER (
            PARTITION BY p.category_id
            ORDER BY p.list_price DESC
        ) AS rn
    FROM products p
)

SELECT
    c.category_name,
    r.product_id,
    r.product_name,
    r.list_price AS highest_price
FROM categories c
LEFT JOIN ranked_products r
  ON c.category_id = r.category_id
  AND r.rn = 1
ORDER BY c.category_name;
