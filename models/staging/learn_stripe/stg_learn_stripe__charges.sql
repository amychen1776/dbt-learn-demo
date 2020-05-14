with source as (

	select * from {{ source('learn_stripe', 'charges') }}

),

fields as (

	select

        id as charge_id,
		livemode,
		captured,
		paid,
		refunded,
		status,
		failure_code,
		description,
		object,
		currency,
		failure_message,
		created,
		fraud_details

	 from source

)

select * from fields