with source as (

	select * from {{ source('learn_stripe', 'refunds') }}

),

fields as (

	select

        id,
		charge_id,
		status,
		currency,
		created

	 from source

)

select * from fields