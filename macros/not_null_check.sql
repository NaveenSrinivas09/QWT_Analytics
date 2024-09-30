{% test not_null_check(model,column_name) %}
 
with null_check_data as (
    SELECT
        {{column_name}} as error_col,
        '' as error_value,
        *
    FROM
        {{ model }}
)
 
select
    *
FROM
    null_check_data
where
    {{column_name}} is null or trim(cast ({{column_name}} as text)) = ''
 
{% endtest %}