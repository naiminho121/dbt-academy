SELECT
    l_orderkey                                          AS order_id,
    l_linenumber                                        AS line_number,
    l_partkey                                           AS part_id,
    l_suppkey                                           AS supplier_id,
    l_quantity                                          AS quantity,
    l_extendedprice                                     AS extended_price,
    l_discount                                          AS discount_rate,
    l_tax                                               AS tax_rate,
    ROUND(l_extendedprice * (1 - l_discount), 2)        AS net_price,
    l_returnflag                                        AS return_flag,
    l_shipdate                                          AS ship_date,
    l_shipmode                                          AS ship_mode
FROM {{ source('tpch', 'lineitem') }}

