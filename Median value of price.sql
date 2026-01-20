#Find the median value of the price list. 
WITH price_rank AS (
    SELECT
        list_price,
        ROW_NUMBER() OVER (ORDER BY list_price) AS rn,
        COUNT(*) OVER () AS total_count
    FROM products
)

SELECT list_price AS median_price
FROM price_rank
WHERE rn IN (
    (total_count + 1) / 2, 
    (total_count + 2) / 2);