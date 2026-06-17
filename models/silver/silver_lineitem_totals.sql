{{ config(materialized='ephemeral') }}

SELECT
    order_id,
    COUNT(*)            AS total_items,
    SUM(extended_price) AS gross_revenue,
    SUM(net_price)      AS net_revenue
FROM {{ ref('bronze_tpch_lineitem') }}
GROUP BY 1


