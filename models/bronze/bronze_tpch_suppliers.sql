SELECT
    s_suppkey       AS supplier_id,
    s_name          AS supplier_name,
    s_nationkey     AS nation_id,
    s_acctbal       AS account_balance,
    s_phone         AS phone
FROM {{ source('tpch', 'supplier') }}
