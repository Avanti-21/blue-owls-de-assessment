SELECT 
    product_key,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(price + freight_value) AS monthly_revenue,
    
    RANK() OVER (
        PARTITION BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
        ORDER BY SUM(price + freight_value) DESC
    ) AS monthly_rank

FROM fact_order_items

GROUP BY product_key, year, month;