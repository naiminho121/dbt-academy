{{ config(
    materialized = 'incremental',
    unique_key   = 'customer_id'
) }}

SELECT
    customer_id,
    first_name || ' ' || last_name AS full_name,
    email,
    country,
    account_balance,
    updated_at,
    CURRENT_TIMESTAMP()            AS loaded_at
FROM {{ ref('customers_seed') }}

{% if is_incremental() %}
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}