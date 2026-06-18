{{ config(materialized='view') }}


{{ config(
    materialized = 'incremental',
    unique_key   = 'order_id'
) }}

SELECT
    *,
    {{ date_dimensions('order_date') }},
    gross_revenue - net_revenue                                     AS discount_amount,
    ROUND(
        (gross_revenue - net_revenue) / NULLIF(gross_revenue, 0),
        4
    )                                                               AS effective_discount_rate,
    net_revenue / NULLIF(total_items, 0)                            AS revenue_per_item,
    CASE
        WHEN total_items >= 5 THEN 'Large'
        WHEN total_items >= 3 THEN 'Medium'
        ELSE 'Small'
    END                                                             AS order_size_band,
    {{ revenue_tier('net_revenue') }} AS revenue_tier,
    CURRENT_TIMESTAMP()                                             AS loaded_at
FROM {{ ref('silver_orders_enriched') }}

{% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}

-- __config to configurate 
-- __ref to configurate into jinja

