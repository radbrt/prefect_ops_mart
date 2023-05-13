with source_data as (

    select id,
    name
    FROM {{ source('landing', 'flows') }}
)

select *
from source_data