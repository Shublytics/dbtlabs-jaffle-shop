select 
    country_code,
    local_currency_code,
    count(*) as total_transactions,
    sum(case when payment_state = 'declined' then 1 else 0 end) as declined_count,
    concat(
        round(
            sum(case when payment_state = 'accepted' then 1 else 0 end) * 100.0 / count(*), 
        2), 
    '%') as acceptance_rate,
    round(avg(amount_usd), 2) as avg_transaction_value_usd,
    round(sum(case when payment_state = 'declined' then amount_usd else 0 end), 2) as total_declined_amount_usd
from {{ ref('fct_transactions') }}
group by 1, 2
order by total_declined_amount_usd desc