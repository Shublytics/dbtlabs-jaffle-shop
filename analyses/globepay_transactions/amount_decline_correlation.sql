select
    -- Create "Bins" for Amount Ranges to spot trends
    case
        when amount_usd < 500 then '1. Micro (< $100)'
        when amount_usd >= 500 and amount_usd < 5000 then '2. Standard ($100 - $5k)'
        when amount_usd >= 5000 and amount_usd < 50000 then '3. High Value ($5k - $50k)'
        when amount_usd >= 50000 then '4. Whale ($50k+)'
        else 'Unknown'
    end as transaction_tier,

    -- Key Metrics per Bucket
    count(*) as total_transactions,
    sum(case when payment_state = 'accepted' then 1 else 0 end) as accepted_count,
    sum(case when payment_state = 'declined' then 1 else 0 end) as declined_count,
    
    -- Correlation Metric: Decline Rate %
    round(
        sum(case when payment_state = 'declined' then 1 else 0 end) * 100.0 / count(*), 
        2
    ) as decline_rate_pct

from {{ ref('fct_transactions') }}
group by 1
order by 1