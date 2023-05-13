WITH failedcount AS (
    SELECT f.name, 
    SUM(CASE WHEN state_type IN (SELECT state FROM prefect.failed_states) THEN 1 ELSE 0 END) AS failed,
    COUNT(1) AS total_runs
    FROM {{ ref('dim_flows') }} f
    INNER JOIN {{ ref('fct_runs') }} r
    ON f.id=r.flow_id
    GROUP BY 1
),
rates AS (
    SELECT
    name,
    (total_runs-failed)/total_runs AS success_rate
    FROM failedcount
),
slas AS (
    SELECT flow_name, sla FROM {{ ref('slas') }}
),
targets AS (
    SELECT name,
    success_rate,
    sla,
    CASE WHEN success_rate>sla THEN 1 ELSE 0 END AS sla_ok
    FROM rates r
    INNER JOIN slas s ON r.name=s.flow_name
)
SELECT * FROM targets

