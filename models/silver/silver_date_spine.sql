
SELECT
    CAST(date_day AS DATE) AS date_day
FROM (
    {{ dbt_utils.date_spine(
        datepart   = 'day',
        start_date = "CAST('1992-01-01' AS DATE)",
        end_date   = "CAST('1999-01-01' AS DATE)"
    ) }}
)