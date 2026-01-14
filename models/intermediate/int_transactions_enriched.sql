with acceptance as (
    select * from {{ ref('stg_globepay__acceptance') }}
),

chargeback as (
    select * from {{ ref('stg_globepay__chargeback') }}
),

calculation as (
    select
        a.external_payment_id,
        a.transaction_at,
        a.payment_state,
        a.country_code,
        a.local_currency_code,
        a.local_amount,
        
        -- 1. Parse the string into JSON
        -- 2. Extract the rate for the specific currency
        -- 3. Cast to numeric for the math
        cast(
            get(parse_json(a.exchange_rates_json), a.local_currency_code) 
            as numeric(18,6)
        ) as exchange_rate,

        -- Calculate USD Amount: Local / Rate
        round(
            a.local_amount / cast(get(parse_json(a.exchange_rates_json), a.local_currency_code) as numeric(18,6)), 
            2
        ) as amount_usd,

        -- Boolean flags for metrics
        case when a.payment_state = 'accepted' then 1 else 0 end as is_accepted,
        coalesce(c.has_chargeback, false) as has_chargeback,
        
        -- Data Integrity Check (for Task #2)
        case when c.external_payment_id is null then true else false end as is_missing_chargeback_data

    from acceptance a
    left join chargeback c 
        on a.external_payment_id = c.external_payment_id
)

select * from calculation