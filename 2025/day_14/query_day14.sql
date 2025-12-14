WITH total_counts AS (
    SELECT
        user_name,
        artist,
        COUNT(artist) AS count
    FROM listening_logs
    WHERE played_at > '2025-01-01'
    GROUP BY user_name, artist
)

SELECT
    user_name,
    artist,
    count
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY
                user_name
            ORDER BY count DESC) AS user_count
        FROM total_counts
    ) AS tc
WHERE user_count < 4
ORDER BY user_name ASC, count DESC
LIMIT 24;
