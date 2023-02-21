{{ config(materialized="table") }}

select locationid, borough, zone, replace(service_zone, 'Boro', 'green') as service_name
from {{ ref("taxi_zone_lookup") }}
