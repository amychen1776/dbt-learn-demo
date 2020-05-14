with orders as (

    select * from {{ ref('stg_ticket_tailor__orders') }}

),

charges as (

    select * from {{ ref('stg_learn_stripe__charges') }}

),

refunds as (

    select * from {{ ref('stg_learn_stripe__refunds') }}

),

joined as (

    select
    
        orders.*,
        charges.charge_id is null as is_charged,
        refunds.charge_id is null as is_refunded

    from orders
    left join charges on 
        charges.charge_id = orders.transaction_id 
    left join refunds on
        refunds.charge_id = charges.charge_id

)

select * from joined