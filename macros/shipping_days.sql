{% macro shipping_days(start_date, end_date, unit='day') %} --unit='week'

    DATEDIFF(
        '{{ unit }}',
        {{ start_date }},
        {{ end_date }}
    )

{% endmacro %}