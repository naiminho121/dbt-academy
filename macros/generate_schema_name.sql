{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- elif env_var('DBT_CLOUD_PR_ID', '') != '' -%}
        dbt_cloud_pr_{{ env_var('DBT_CLOUD_JOB_ID') }}_{{ env_var('DBT_CLOUD_PR_ID') }}_{{ custom_schema_name | trim }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}