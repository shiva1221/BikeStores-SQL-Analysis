#Calculate the cumulative sum of quantities sold for each product over time.
SELECT
    oi.product_id,
    o.order_date,
    oi.quantity,
    SUM(oi.quantity) OVER (
        PARTITION BY oi.product_id
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_quantity
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
ORDER BY oi.product_id, o.order_date;
