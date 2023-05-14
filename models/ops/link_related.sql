WITH base AS (
SELECT id, event, related FROM {{ source('landing', 'events') }}
),
exploded AS (
SELECT id as id,
event AS event,
    f.value:"prefect.resource.id"::varchar AS resource_id,
    f.value:"prefect.resource.name"::varchar AS resource_name,
    f.value:"prefect.resource.role"::varchar AS resource_role
FROM base p,
lateral flatten(input => p.related) f
)
SELECT * FROM exploded

