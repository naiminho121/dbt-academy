SELECT
    order_id,
    net_revenue
FROM {{ ref('gold_orders') }}
WHERE net_revenue IS NULL
   OR net_revenue <= 0