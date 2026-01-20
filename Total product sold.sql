#Find the total number of products sold by each store along with the store name.
WITH store_sales AS (
    SELECT 
        orders.store_id,
        SUM(order_items.quantity) AS total_products_sold
    FROM orders
    JOIN order_items
        ON orders.order_id = order_items.order_id
    GROUP BY orders.store_id
)

SELECT 
    stores.store_name,
    COALESCE(store_sales.total_products_sold, 0) AS total_products_sold
FROM stores
LEFT JOIN store_sales
    ON stores.store_id = store_sales.store_id;
