SELECT
    TRIM(LOWER(raw_wish)) AS wish,
    COUNT(*) AS count
FROM wish_list
GROUP BY wish
ORDER BY count DESC
LIMIT 20;
