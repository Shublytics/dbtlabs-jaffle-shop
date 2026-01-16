--- Chargeback Rate (Disputes / Accepted Transactions)

select
    concat(      
        round(
              sum(case when has_chargeback = true then 1 else 0 end) * 100.0 / 
              nullif(sum(is_accepted), 0), 
              2
          ),
          '%'
        ) as chargeback_rate

from {{ ref('fct_transactions') }}