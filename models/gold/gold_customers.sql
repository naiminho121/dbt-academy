WITH customers AS (
    SELECT * FROM {{ ref('bronze_tpch_customers') }}
),
nations AS (
    SELECT * FROM {{ ref('bronze_tpch_nations') }}
),
orders AS (
    SELECT
        customer_id,
        COUNT(*)            AS total_orders,
        SUM(net_revenue)    AS total_revenue,
        MIN(order_date)     AS first_order_date,
        MAX(order_date)     AS last_order_date
    FROM {{ ref('silver_orders_enriched') }}
    GROUP BY 1
)

SELECT
    c.customer_id,
    c.customer_name,
    c.market_segment,
    n.nation_name,
    COALESCE(o.total_orders, 0)     AS total_orders,
    COALESCE(o.total_revenue, 0)    AS total_revenue,
    CASE
        WHEN o.total_orders > 0
        THEN o.total_revenue / o.total_orders
        ELSE 0
    END                             AS avg_order_value,

    CASE
        WHEN COALESCE(o.total_revenue, 0) > 500000 THEN 'Platinum'
        WHEN COALESCE(o.total_revenue, 0) > 100000 THEN 'Gold'
        WHEN COALESCE(o.total_revenue, 0) > 0      THEN 'Silver'
        ELSE 'No Orders'
    END                             AS customer_tier,
    {{ revenue_tier('total_revenue', 1000000, 3000000) }} AS revenue_tier
FROM customers c
LEFT JOIN nations n ON c.nation_id   = n.nation_id
LEFT JOIN orders  o ON c.customer_id = o.customer_id
ORDER BY 1 ASC