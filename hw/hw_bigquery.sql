
--hw04

--q1

--select count(*) from  `stoked-duality-375907.dbt_nyc_trip_data.fact_trips`
--61636696


---- Q2 ---
-- select service_type, count(*) from  `stoked-duality-375907.dbt_nyc_trip_data.fact_trips`
-- group by service_type 

-- 55+6/61  = 0.89



-- --- ******* create fhv table - only 2019
-- CREATE OR REPLACE EXTERNAL TABLE `dbt_nyc_trip_data.fhv-vehicle`
-- OPTIONS (
--   format = 'CSV',
--    uris = ['gs://fhv-vehicle/data/fhv_tripdata_2019*.csv.gz']
--  ); 


--- check row count native table --- 
-- SELECT count(*) FROM `stoked-duality-375907.dbt_nyc_trip_data.fhv-vehicle`   43244693

-- SELECT count(*) FROM `stoked-duality-375907.dbt_nyc_trip_data.fhv-vehicle` as fhv_data
-- inner join `stoked-duality-375907.dbt_nyc_trip_data.dim_zones` as pickup_zone
-- on fhv_data.PUlocationID = pickup_zone.locationid
-- inner join `stoked-duality-375907.dbt_nyc_trip_data.dim_zones` as dropoff_zone
-- on fhv_data.DOlocationID = dropoff_zone.locationid
-- where pickup_datetime > '2019-01-01 00:00:00 UTC' and pickup_datetime < '2020-01-01 00:00:00 UTC'
-- AND pickup_zone.locationid not in (264,265)
-- AND dropoff_zone.locationid not in (264,265)
# 22998722

--check dbt --
---

--query 3
-- SELECT count(*) FROM `stoked-duality-375907.dbt_nyc_trip_data.stg_fhv_tripdata`  > 43244693


-- check for zone without unknown
-- select * from `stoked-duality-375907.dbt_nyc_trip_data.dim_zones`
--     where borough != 'Unknown'
--     order by locationid desc

-- q4
--SELECT count(*) FROM `stoked-duality-375907.dbt_nyc_trip_data.fact_fhv_trips`
--229998722


-- q5  - in the looker image
    SELECT EXTRACT(MONTH FROM pickup_datetime) AS month, count(*) as monthly_trips FROM `stoked-duality-375907.dbt_nyc_trip_data.fact_fhv_trips`
    group by EXTRACT(MONTH FROM pickup_datetime) 


    january = 19849151