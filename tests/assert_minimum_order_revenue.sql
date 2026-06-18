-- Finds orders below a minimum revenue threshold.
-- A failing test tells you how many orders are below the threshold — useful for investigation.
-- Override threshold with: dbt test --vars '{"min_order_revenue": 1000}'
SELECT
    order_id,
    net_revenue
FROM {{ ref('gold_orders') }}
WHERE net_revenue < {{ var('min_order_revenue', 100) }}