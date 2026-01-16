-- Find the declined transaction with the Lowest Amount
(
    select 
        'Minimum Amount Decline' as metric_type,
        external_payment_id,
        transaction_at,
        amount_usd,
        country_code
    from {{ ref('fct_transactions') }}
    where payment_state = 'declined'
    order by amount_usd asc
    limit 1
)

union all

-- Find the declined transaction with the Highest Amount
(
    select 
        'Maximum Amount Decline' as metric_type,
        external_payment_id,
        transaction_at,
        amount_usd,
        country_code
    from {{ ref('fct_transactions') }}
    where payment_state = 'declined'
    order by amount_usd desc
    limit 1
)