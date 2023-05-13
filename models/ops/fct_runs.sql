with source_data as (

SELECT 
id,
deployment_id, 
flow_id,
infrastructure_document_id,
name AS flow_run_name,
try_to_timestamp_ntz(expected_start_time) AS expected_start_time,
try_to_timestamp_ntz(start_time) AS start_time, 
try_to_timestamp_ntz(end_time) AS end_time,
total_run_time,
state_name,
state_type,
try_to_timestamp_ntz(next_scheduled_start_time) AS next_scheduled_start_time
FROM {{ source('landing', 'flow_runs') }}
)

select *
from source_data