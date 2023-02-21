{{ config(materialized='table') }}

with fhv_data as (
    select *, 
        'fhv' as service_type 
    from {{ ref('stg_fhv_tripdata') }}
), 

zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 

    tripid,
    vendorid,
    pickup_locationid,
    dropoff_locationid,
    
    -- timestamps
    pickup_datetime,
    dropoff_datetime,
    
    -- trip info
    SR_Flag,
    passenger_count
    
    ,


    
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone
    
from fhv_data
inner join zones as pickup_zone
on fhv_data.pickup_locationid = pickup_zone.locationid
inner join zones as dropoff_zone
on fhv_data.dropoff_locationid = dropoff_zone.locationid
where pickup_datetime > '2019-01-01 00:00:00 UTC' and pickup_datetime < '2020-01-01 00:00:00 UTC'
