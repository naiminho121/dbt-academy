{% macro drop_old_relations(schema, days_old=7, relation_type='TABLE') %}

    {% set type_filter %}
        {% if relation_type | upper == 'ALL' %}
            table_type IN ('BASE TABLE', 'VIEW')
        {% elif relation_type | upper == 'TABLE' %}
            table_type = 'BASE TABLE'
        {% else %}
            table_type = 'VIEW'
        {% endif %}
    {% endset %}

    {% set query %}
        SELECT table_name, table_type
        FROM information_schema.tables
        WHERE table_schema = UPPER('{{ schema }}')
          AND {{ type_filter }}
          AND created < DATEADD(day, -{{ days_old }}, CURRENT_TIMESTAMP())
    {% endset %}

    {% set results = run_query(query) %}

    {% if execute %}
        {% for row in results %}
            {% set obj_type = 'VIEW' if row[1] == 'VIEW' else 'TABLE' %}
            {% set drop_stmt %}
                DROP {{ obj_type }} IF EXISTS {{ schema }}.{{ row[0] }}
            {% endset %}
            {{ log('Dropping ' ~ obj_type ~ ': ' ~ row[0], info=True) }}
            {% do run_query(drop_stmt) %}
        {% endfor %}
    {% endif %}

{% endmacro %}