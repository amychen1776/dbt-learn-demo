with source as (

	select * from {{ source('ticket_tailor', 'orders') }}

),

fields as (

	select

		event_id,
		order_cancelled,
		tickets_purchased,
		total_paid,
		order_id,
		tax_amount,
		transaction_id,
		event_name,
		order_items,
		tickets_checked_in,
		transaction_type,
		event_end,
		event_start,
		order_date

	 from source

)

select * from fields