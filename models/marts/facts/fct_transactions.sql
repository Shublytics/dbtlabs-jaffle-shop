---  Analytics table 
-- final table which is going to be used by the end users in the BI tool

{{ config(
    materialized='table',
    cluster_by=['transaction_at']
) }}

with enriched_data as (
    select * from {{ ref('int_transactions_enriched') }}
)

select
    external_payment_id,
    transaction_at,
    payment_state,
    country_code,
    local_currency_code,
    local_amount,
    cvv_provided,
    exchange_rate,
    amount_usd,
    is_accepted,
    has_chargeback,
    is_missing_chargeback_data

from enriched_data
