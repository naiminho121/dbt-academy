
select
o.order_id,
c.customer_id
FROM {{ ref('bronze_tpch_customers') }} as c
RIGHT JOIN {{ ref('bronze_tpch_orders')}} as o on c.customer_id = o.customer_id
where c.customer_id is null
