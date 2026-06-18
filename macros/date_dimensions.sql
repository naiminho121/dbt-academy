{% macro date_dimensions(date_column) %}
    YEAR({{ date_column }})         AS {{ date_column | replace('.', '_') }}_year,
    MONTH({{ date_column }})        AS {{ date_column | replace('.', '_') }}_month,
    DAY({{ date_column }})          AS {{ date_column | replace('.', '_') }}_day,
    DAYOFWEEK({{ date_column }})    AS {{ date_column | replace('.', '_') }}_day_of_week,
    QUARTER({{ date_column }})      AS {{ date_column | replace('.', '_') }}_quarter
{% endmacro %}