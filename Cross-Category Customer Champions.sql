-- Identify the customers who have ordered all types of products (i.e., from every category).

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories cat
    ON p.category_id = cat.category_id
GROUP BY 
    c.customer_id, customer_name
HAVING 
    COUNT(DISTINCT cat.category_id) = (SELECT COUNT(*) FROM categories);
