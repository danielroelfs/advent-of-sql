WITH last_location AS (
    SELECT coordinate
    FROM sleigh_locations
    WHERE timestamp = (
        SELECT MAX(sl.timestamp) FROM sleigh_locations AS sl
    )
)

SELECT areas.place_name
FROM areas, last_location AS ll
WHERE ST_INTERSECTS(areas.polygon, ll.coordinate);
