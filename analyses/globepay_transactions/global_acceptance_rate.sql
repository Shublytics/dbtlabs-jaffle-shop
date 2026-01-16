--- Global Acceptance Rate

select

    concat(
        round(sum(is_accepted) * 100.0 / count(*), 2),
        '%') as global_acceptance_rate

from {{ ref('fct_transactions') }}