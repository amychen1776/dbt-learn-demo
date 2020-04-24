with orders as (
    select * from {{ ref('stg_ticket_tailor__orders') }}
),

refunds as (
    select * from {{ ref('stg_learn_stripe__refunds')}}
),

joined as (
    select
        orders.*,
        charges.charge_id is not null as has_charge,
        refunds.charge_id is not null as has_refund

    from orders

    left join charges on orders.transaction_id = charges.charge_id

    left join refunds on orders.transaction_id = refunds.charge_id
),

final as (
    select
        event_id,
        event_name,
        sum(tickets_purchased) as tickets_orders,
        sum(case when has_charge then tickets_purchased else 0 end) as tickets_charged,
        sum(case when is_cancelled then tickets_purchased else 0 end) as tickets_cancelled,
        sum(case when has_refund then tickets_purchased else 0 end) as tickets_refunded
    from joined
    group by 1, 2
)

select * from final
order by event_id