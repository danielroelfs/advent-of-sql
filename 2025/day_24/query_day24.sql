WITH dispatches AS (
    SELECT
        marker_letter,
        ROW_NUMBER()
            OVER (PARTITION BY system_id ORDER BY dispatched_at DESC)
            AS row_num
    FROM system_dispatches
    WHERE payload ->> 'source' = 'primary'
)

SELECT STRING_AGG(marker_letter, '') AS confirmation_phrase
FROM dispatches
WHERE row_num = 1;
