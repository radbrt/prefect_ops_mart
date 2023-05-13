WITH flows AS (
  SELECT id, name AS flow_name FROM {{ ref('dim_flows') }}
),
runs AS (
  SELECT 
  id,
  flow_id,
  flow_run_name,
  state_type,
  next_scheduled_start_time
  FROM {{ ref('fct_runs') }}
  WHERE state_type='SCHEDULED'
),
scheduled AS (
  SELECT 
  flow_name,
  MIN_BY(flow_run_name, next_scheduled_start_time) AS next_run_name,
  MIN(next_scheduled_start_time) AS next_run 
  FROM runs
  INNER JOIN flows
  ON runs.flow_id=flows.id
  GROUP BY flow_name
)
SELECT * FROM scheduled
