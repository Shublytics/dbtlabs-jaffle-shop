select
    -- Extract just the time portion (HH:MM:SS)
    to_char(transaction_at, 'HH24:MI:SS') as transaction_time,
    
    -- Volume Metrics
    count(*) as total_transactions,
    sum(case when payment_state = 'declined' then 1 else 0 end) as declined_count,
    
    -- Correlation Metric: Decline Rate
    round(
        sum(case when payment_state = 'declined' then 1 else 0 end) * 100.0 / count(*), 
        2
    ) as decline_rate_pct

from {{ ref('fct_transactions') }}
group by 1
order by 1