select 
    cvv_provided as is_cvv_provided,
    count(*) as total_transactions,
    sum(case when payment_state = 'accepted' then 1 else 0 end) as accepted_count,
    concat(
        round(
            sum(case when payment_state = 'accepted' then 1 else 0 end) * 100.0 / count(*), 
        2), 
    '%') as acceptance_rate
from {{ ref('fct_transactions') }}
group by 1
order by 1