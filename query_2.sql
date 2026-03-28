SELECT 
    seller_key,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(payment_value) AS total_revenue,
    AVG(freight_value) AS avg_delivery_cost
FROM fact_order_items
GROUP BY seller_key;