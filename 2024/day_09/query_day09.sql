WITH avg_exercise AS (
    SELECT
        reindeer_id,
        exercise_name,
        AVG(speed_record) AS avg_speed
    FROM training_sessions
    GROUP BY reindeer_id, exercise_name
),

max_avg_speed AS (
    SELECT
        reindeer_id,
        MAX(avg_speed) AS max_avg_speed
    FROM avg_exercise
    GROUP BY reindeer_id
)

SELECT
    re.reindeer_name,
    ROUND(mas.max_avg_speed, 2) AS top_speed
FROM max_avg_speed AS mas
INNER JOIN reindeers AS re ON mas.reindeer_id = re.reindeer_id
WHERE re.reindeer_name != 'Rudolph'
ORDER BY top_speed DESC
LIMIT 3;
