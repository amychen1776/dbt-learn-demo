{% macro clean_data(relation) %}

{%- set columns = adapter.get_columns_in_relation(relation) -%}

{% set where_clauses={
    'id': 'not in (1, 2)',
    'last_name': "not in ('Carroll')"
} %}

select
    {% for column in columns %}
        {{ column.name | lower }} {{", " if not loop.last}}
    {%- endfor %}

from {{ relation }}

where
    {% for column in columns %}
        {% if column.name | lower in where_clauses.keys() %}
            {{ "and" if not loop.first }} {{ column.name | lower }} {{ where_clauses[ column.name | lower] }}
        {% endif %}
    {% endfor %}


{% endmacro %}
