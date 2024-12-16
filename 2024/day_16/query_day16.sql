WITH timepoints AS (
    SELECT
        coordinate,
        timestamp AS timestamp_current,
        LAG(timestamp, 1) OVER (ORDER BY timestamp DESC) AS timestamp_next
    FROM sleigh_locations
)

SELECT
    areas.place_name,
    SUM(tp.timestamp_next - tp.timestamp_current) AS duration
FROM timepoints AS tp, areas
WHERE ST_INTERSECTS(areas.polygon, tp.coordinate)
GROUP BY areas.place_name
ORDER BY duration DESC;
