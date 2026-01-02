SELECT
    vehicle_id,
    departure_time,
    SUM(ARRAY_LENGTH(XPATH('//passenger/name/text()', manifest_xml), 1)) AS n_passengers
FROM travel_manifests
WHERE UPPER(vehicle_id) LIKE 'CARGO%'
GROUP BY vehicle_id, departure_time
HAVING SUM(ARRAY_LENGTH(XPATH('//passenger/name/text()', manifest_xml), 1)) > 20
ORDER BY departure_time;
