--- Total Volume Attempted & Declined

select
    concat('$', round(sum(amount_usd) / 1000000, 2), 'M') as total_attempted_usd,
    concat('$', 
        round(sum(case when payment_state = 'declined' then amount_usd else 0 end
    ) / 1000000, 2), 'M') as total_declined_usd,
    concat(
        round(sum(case when payment_state = 'declined' then 1 else 0 end) * 100.0 / count(*), 2),
        '%'
    ) as decline_rate_volume
from {{ ref('fct_transactions') }}