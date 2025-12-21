WITH roll_avg AS (
    SELECT
        child_id,
        child_name,
        behavior_date,
        AVG(score) OVER (
            PARTITION BY child_id
            ORDER BY
                child_id,
                behavior_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS rolling_avg_score
    FROM behavior_logs
)

SELECT
    child_id,
    child_name,
    behavior_date,
    rolling_avg_score
FROM roll_avg
WHERE
    1 = 1
    AND behavior_date >= '2025-12-07' AND rolling_avg_score < 0
ORDER BY behavior_date, child_name
LIMIT 25;
