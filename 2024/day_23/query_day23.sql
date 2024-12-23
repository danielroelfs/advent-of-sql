WITH lag_values AS (
    SELECT
        LAG(id, 1) OVER (ORDER BY id) + 1 AS gap_start,
        id - 1 AS gap_end,
        id - LAG(id, 1) OVER (ORDER BY id) AS gap
    FROM sequence_table
),

long_gaps AS (
    SELECT
        gap_start,
        gap_end,
        GENERATE_SERIES(gap_start, gap_end) AS gap_numbers
    FROM lag_values
    WHERE gap > 1
)

SELECT
    gap_start,
    gap_end,
    ARRAY_AGG(gap_numbers ORDER BY gap_start) AS missing_numbers
FROM long_gaps
GROUP BY gap_start, gap_end;
