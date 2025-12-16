WITH available_cars AS (
    SELECT
        car_id,
        available_mixins
    FROM cocoa_cars
    ORDER BY total_stock DESC
    LIMIT 3
),

available_mixins AS (
    SELECT
        car_id,
        UNNEST(available_mixins) AS available_mixins
    FROM available_cars
),

passengers_mixins AS (
    SELECT
        passenger_name,
        UNNEST(favorite_mixins) AS favorite_mixins
    FROM passengers
)

SELECT
    pm.passenger_name,
    ARRAY_AGG(DISTINCT am.car_id) AS cars_available
FROM passengers_mixins AS pm
INNER JOIN available_mixins AS am
    ON pm.favorite_mixins = am.available_mixins
GROUP BY pm.passenger_name
ORDER BY pm.passenger_name ASC
LIMIT 25;
