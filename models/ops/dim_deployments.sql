with source_data as (

    select id,
    flow_id,
    schedule:cron::varchar as cron,
    name
    FROM {{ source('landing', 'deployments') }}
)

select *
from source_data