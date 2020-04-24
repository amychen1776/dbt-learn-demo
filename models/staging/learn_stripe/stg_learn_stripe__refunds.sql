with source as (

    select * from {{ source('learn_stripe', 'refunds') }}

),

renamed as (

    select
        id as refund_id,
        charge_id,
        currency,
        created,
        status

    from source

)

select * from renamed
