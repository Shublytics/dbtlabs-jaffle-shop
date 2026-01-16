with source as (

    select *
    from {{ ref('globepay_chargeback_report') }}

)

select
    external_ref as external_payment_id,
    source as payment_source,
    status as is_reported,
    chargeback as has_chargeback
from source