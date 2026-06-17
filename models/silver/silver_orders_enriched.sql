WITH line_totals AS (
    SELECT * FROM {{ ref('silver_lineitem_totals') }}
),
orders AS (
    SELECT * FROM {{ ref('bronze_tpch_orders') }}
),
customers AS (
    SELECT * FROM {{ ref('bronze_tpch_customers') }}
),
nations AS (
    SELECT * FROM {{ ref('bronze_tpch_nations') }}
)

SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.order_priority,
    o.customer_id,
    c.customer_name,
    c.market_segment,
    n.nation_name,
    l.total_items,
    l.gross_revenue,
    l.net_revenue
FROM orders o
LEFT JOIN customers  c ON o.customer_id = c.customer_id
LEFT JOIN nations    n ON c.nation_id   = n.nation_id
LEFT JOIN line_totals l ON o.order_id   = l.order_id