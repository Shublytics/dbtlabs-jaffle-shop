--- Task 2.2
-- List the countries where the amount (in dollars) of declined transactions went over $25M  

select 
    country_code,
    concat('$ ', round(sum(amount_usd) / 1000000, 2), ' million') as total_declined_usd
from {{ ref('fct_transactions') }}
where payment_state = 'declined'
group by 1
having sum(amount_usd) > 25000000
order by sum(amount_usd) desc