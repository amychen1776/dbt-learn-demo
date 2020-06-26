{% macro clean_data2(source) %}

{% set where_clauses={
    'id': 'not in (1, 2)',
    'last_name': "not in ('Carroll')"
} %}
{% set columns=get_columns_in_relation(source) %}



select
    {% for column in columns %}
    {{ column.name }} {{- "," if not loop.last }}
    {% endfor %}

where
    {% for column in columns %}

    {% if column.name | lower in where_clauses.keys() %}
        {{ "and" if not loop.first }} {{ column.name }} {{ where_clauses[column.name | lower] }}
    {% endif %}
    {% endfor %}


{% endmacro %}
