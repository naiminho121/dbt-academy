{% macro revenue_tier(col, low=1000, high=10000) %}
    CASE
        WHEN {{ col }} < {{ low }}  THEN 'Low'
        WHEN {{ col }} < {{ high }} THEN 'Medium'
        ELSE 'High'
    END
{% endmacro %}