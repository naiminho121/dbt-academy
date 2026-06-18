{% macro discount_amount(price_col, discount_col, precision=2) %}
    ROUND({{ price_col }} * {{ discount_col }}, {{ precision }})
{% endmacro %}