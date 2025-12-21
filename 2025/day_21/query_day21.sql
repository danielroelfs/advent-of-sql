WITH scored AS (
    SELECT
        id,
        title,
        description,
        CASE
            WHEN
                (LOWER(title) LIKE '%flight%' OR LOWER(title) LIKE '%fly%')
                AND (
                    LOWER(description) LIKE '%flight%'
                    OR LOWER(description) LIKE '%fly%'
                )
                THEN 2
            WHEN
                (LOWER(title) LIKE '%flight%' OR LOWER(title) LIKE '%fly%')
                OR (
                    LOWER(description) LIKE '%flight%'
                    OR LOWER(description) LIKE '%fly%'
                )
                THEN 1
            ELSE 0
        END AS score
    FROM archive_records
)

SELECT
    id,
    title,
    description,
    score
FROM scored
WHERE score > 0
ORDER BY score DESC
LIMIT 5;
