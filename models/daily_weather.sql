WITH daily_weather as (
    select
    date(time) as daily_weather,
    weather,
    humidity,
    temp,
    clouds,
    pressure
    from {{ source('demo', 'weather') }}
    limit 20
),
daily_weather_agg as (
    select
    daily_weather,
    weather,
    round(avg(humidity),2) as avg_humidity,
    round(avg(temp),2) as avg_temp,
    round(avg(clouds),2) as avg_clouds,
    round(avg(pressure),2) as avg_pressure
    
    from daily_weather
    group by daily_weather, weather

    qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) desc) = 1
)
select *
from daily_weather_agg