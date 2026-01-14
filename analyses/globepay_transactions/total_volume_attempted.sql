--- Total Volume Attempted

select
    concat('$', round(sum(amount_usd) / 1000000, 2), 'M') as total_attempted_usd

from {{ ref('fct_transactions') }}