--- Task 2.1
-- Calculate and present the acceptance rate over time

select 
    date_trunc('day', transaction_at) as transaction_date,
    round(sum(is_accepted) * 100.0 / count(*), 2) as acceptance_rate_pct
from {{ ref('fct_transactions') }}
group by 1 
order by 1