WITH drinks AS (
    SELECT
        date,
        SUM(
            CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END
        ) AS eggnog,
        SUM(
            CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END
        ) AS hot_cocoa,
        SUM(
            CASE
                WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0
            END
        ) AS peppermint_schnapps
    FROM drinks
    GROUP BY date
)

SELECT date FROM drinks
WHERE
    1 = 1
    AND eggnog = 198
    AND hot_cocoa = 38
    AND peppermint_schnapps = 298;
