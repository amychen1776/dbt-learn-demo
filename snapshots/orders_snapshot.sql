{% snapshot orders_snapshot %}

{{
    config(
      target_database='analytics',
      target_schema='snapshots',
      unique_key="id",

      strategy='timestamp_with_deletes',
      updated_at='order_date',
    )
}}

select * from {{ source('jaffle_shop', 'orders') }}

{% endsnapshot %}
