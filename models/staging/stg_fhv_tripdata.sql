{{ config(materialized='view') }}
 
-- with tripdata as 
-- (
--   select *,
--     row_number() over(partition by CAST(dispatching_base_num as STRING), pickup_datetime) as rn
--   from {{ source('staging','fhv-vehicle') }}
--   where dispatching_base_num is not null 
-- )
select
   -- identifiers
    {{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    cast(dispatching_base_num as string) as vendorid,
    cast(PUlocationID as integer) as  pickup_locationid,
    cast(DOlocationID as integer) as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    SR_Flag,
    cast(Affiliated_base_number as string) as passenger_count
from {{ source('staging','fhv-vehicle') }}
-- where rn = 1

-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=false) %}

  limit 100

{% endif %}
