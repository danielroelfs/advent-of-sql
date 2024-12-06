WITH previous AS (
    SELECT
        production_date,
        toys_produced,
        LAG(toys_produced, 1, NULL)
            OVER (ORDER BY production_date)
        AS previous_day_production
    FROM toy_production
)

SELECT
    tp.production_date,
    pr.toys_produced,
    pr.previous_day_production,
    tp.toys_produced - pr.previous_day_production AS production_change,
    ROUND(
        (tp.toys_produced - pr.previous_day_production)
        / (pr.previous_day_production * 1.0) * 100.0, 2
    ) AS production_change_percentage
FROM toy_production AS tp
INNER JOIN previous AS pr ON tp.production_date = pr.production_date
WHERE pr.previous_day_production IS NOT NULL
ORDER BY production_change_percentage DESC
LIMIT 1;
