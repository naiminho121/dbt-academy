WITH line_totals AS (
    SELECT * FROM {{ ref('silver_lineitem_totals') }}
),
orders AS (
    SELECT * FROM {{ ref('bronze_tpch_orders') }}
),
customers AS (
    SELECT * FROM {{ ref('bronze_tpch_customers') }}
)

SELECT
    c.market_segment,
    COUNT(DISTINCT o.order_id)                AS total_orders,
    SUM(l.net_revenue)                        AS total_revenue,
    SUM(l.net_revenue) /
        NULLIF(COUNT(DISTINCT o.order_id), 0) AS avg_order_value
FROM orders o
JOIN customers c   ON o.customer_id = c.customer_id
JOIN line_totals l ON o.order_id    = l.order_id
GROUP BY 1