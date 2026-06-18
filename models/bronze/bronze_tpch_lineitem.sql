SELECT
    {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} AS lineitem_id,
    l_orderkey                                          AS order_id,
    l_linenumber                                        AS line_number,
    l_partkey                                           AS part_id,
    l_suppkey                                           AS supplier_id,
    l_quantity                                          AS quantity,
    l_extendedprice                                     AS extended_price,
    l_discount                                          AS discount_rate,
    l_tax                                               AS tax_rate,
    {{ net_price('l_extendedprice', 'l_discount') }}      AS net_price,
    {{ discount_amount('l_extendedprice', 'l_discount') }} AS discount_amount,
    l_returnflag                                        AS return_flag,
    l_shipdate                                          AS ship_date,
    l_receiptdate                                        as receipt_date,    
    l_shipmode                                          AS ship_mode,
    {{ shipping_days('l_shipdate', 'l_receiptdate') }} AS days_to_ship,
    {{ shipping_days('l_shipdate', 'l_receiptdate','week') }} AS weeks_to_receive
FROM {{ source('tpch', 'lineitem') }}

