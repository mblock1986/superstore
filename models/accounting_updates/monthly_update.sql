{{ config(materialized='table') }}

WITH filtered_orders AS (
    SELECT
        superstore.order_date,
        superstore.order_id,
        customer_id,
        employee_orders.emplid,
        segment,
        category,
        profit
    FROM superstore
    LEFT JOIN employee_orders ON employee_orders.order_id = superstore.order_id
    LEFT JOIN emplid ON emplid.emplid = employee_orders.emplid
    WHERE superstore.order_date >= dateadd('month', -1, date_trunc('month', current_date())) AND
          superstore.order_date <= date_trunc('month', current_date()) - interval '1 day'
)

SELECT * FROM filtered_orders
ORDER BY 1