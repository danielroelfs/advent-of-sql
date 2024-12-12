SELECT
    field_name,
    harvest_year,
    season,
    ROUND(AVG(trees_harvested) OVER (
        PARTITION BY field_name
        ORDER BY
            harvest_year,
            CASE
                WHEN season = 'Spring' THEN 1
                WHEN season = 'Summer' THEN 2
                WHEN season = 'Fall' THEN 3
                WHEN season = 'Winter' THEN 4
            END
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ), 2) AS moving_ave
FROM
    treeharvests
ORDER BY
    moving_ave DESC
LIMIT 1;
