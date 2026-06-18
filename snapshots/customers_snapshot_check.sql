{% snapshot customers_snapshot_check %}

{{ config(
    target_schema = 'snapshots',
    unique_key    = 'customer_id',
    strategy      = 'check',
    check_cols = ['country','email'],
    updated_at    = 'updated_at'
) }}

SELECT
    *
FROM {{ ref('customers_seed') }}

{% endsnapshot %}