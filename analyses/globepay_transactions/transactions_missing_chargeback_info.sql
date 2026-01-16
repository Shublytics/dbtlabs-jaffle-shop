--- Task 2.3
-- Identify transactions from the Acceptance report that are missing chargeback data

select 
    external_payment_id,
    transaction_at,
    payment_state,
    country_code,
    local_amount,
    amount_usd
from {{ ref('fct_transactions') }}
where is_missing_chargeback_data = true