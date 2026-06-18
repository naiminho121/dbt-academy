WITH lineitem_totals AS (
    SELECT
        order_id,
        SUM(net_price) AS lineitem_net_revenue
    FROM {{ ref('bronze_tpch_lineitem') }}
    GROUP BY 1
),
order_totals AS (
    SELECT
        order_id,
        net_revenue AS order_net_revenue
    FROM {{ ref('gold_orders') }}
)

SELECT
    l.order_id,
    l.lineitem_net_revenue,
    o.order_net_revenue,
    ABS(l.lineitem_net_revenue - o.order_net_revenue) AS discrepancy
FROM lineitem_totals l
JOIN order_totals o ON l.order_id = o.order_id
WHERE ABS(l.lineitem_net_revenue - o.order_net_revenue) > 0.01


--group by bronze based net_price match net_revenue 