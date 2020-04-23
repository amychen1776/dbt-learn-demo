{% snapshot orders_snapshot_check %}

{{
    config(
      target_database='analytics',
      target_schema='snapshots',
      unique_key="id",

      strategy='check',
      check_cols='all',
    )
}}

select * from {{ source('jaffle_shop', 'orders') }}

{% endsnapshot %}
