--- Task 2.1
-- Calculate and present the acceptance rate over time

select 
    date(transaction_at) AS transaction_date,
    concat(round(sum(is_accepted) * 100.0 / count(*), 2), '%') as acceptance_rate
from {{ ref('fct_transactions') }}
group by 1 
order by 1