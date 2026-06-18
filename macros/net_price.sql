{% macro net_price(price_col, discount_col, precision=2) %}
    ROUND({{ price_col }} * (1 - {{ discount_col }}), {{ precision }})
{% endmacro %}