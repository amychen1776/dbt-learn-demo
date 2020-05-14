with ticket_charges as (

    select * from {{ref('ticket_sales')}}

),

aggregated as (

    select

        {{dbt_utils.surrogate_key(['event_name','order_date'])}} as primary_key,
        event_name,
        order_date,
        sum(tickets_purchased) as total_ticket_orders,
        sum(case when is_charged then tickets_purchased else 0 end) as total_tickets_charged,
        sum(case when is_refunded then tickets_purchased else 0 end) as total_tickets_refunded
    
    from ticket_charges
    group by 1, 2, 3

)

select * from aggregated