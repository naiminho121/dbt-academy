{{ config(materialized='view') }}

SELECT
    nation_name,
    COUNT(DISTINCT order_id)                AS total_orders,
    SUM(net_revenue)                        AS total_revenue,
    SUM(net_revenue) /
        NULLIF(COUNT(DISTINCT order_id), 0) AS avg_order_value
FROM {{ ref('silver_orders_enriched') }} 
GROUP BY 1