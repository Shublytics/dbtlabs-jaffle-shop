select
  external_payment_id,
  count(*) as attempts,
  sum(case when payment_state='declined' then 1 else 0 end) as declined
from {{ ref('fct_transactions') }}
group by 1
having count(*) > 1
order by attempts desc