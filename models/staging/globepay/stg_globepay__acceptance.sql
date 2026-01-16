with source as (

    select * from {{ ref('globepay_acceptance_report') }}

),

renamed as (

    select
        external_ref as external_payment_id,
        ref as payment_gateway_id,
        source as payment_source,
        status as is_reported,
        
        date_time::timestamp as transaction_at,
        lower(state) as payment_state,
        
        cvv_provided,
        amount as local_amount,
        
        currency as local_currency_code,
        country as country_code,

        -- Keeping it as a JSON only for downstream extraction
        rates as exchange_rates_json

    from source

)

select * from renamed