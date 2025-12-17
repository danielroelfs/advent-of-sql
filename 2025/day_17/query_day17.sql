WITH last_score AS (
    SELECT MAX(id) AS last_id
    FROM price_changes
    GROUP BY product_id
),

price_calculations AS (
    SELECT
        pid.id,
        pd.product_name,
        pid.price AS current_price,
        LAG(pid.price)
            OVER (
                PARTITION BY pd.product_name
                ORDER BY pid.effective_timestamp ASC
            )
            AS previous_price,
        pid.price
        - LAG(pid.price)
            OVER (
                PARTITION BY pd.product_name
                ORDER BY pid.effective_timestamp ASC
            )
            AS price_difference
    FROM price_changes AS pid
    INNER JOIN products AS pd
        ON pid.product_id = pd.product_id
)

SELECT
    product_name,
    current_price,
    previous_price,
    price_difference
FROM price_calculations
WHERE
    id IN (SELECT ls.last_id FROM last_score AS ls)
ORDER BY product_name ASC
LIMIT 25;
