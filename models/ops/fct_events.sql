with source_data as (
  SELECT 
  event,
  follows,
  id,
  next_page,
  occurred
  FROM {{ source('landing', 'events') }}
)
select * from source_data