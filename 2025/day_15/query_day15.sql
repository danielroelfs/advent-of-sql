WITH dates AS (
    SELECT DISTINCT gift_date AS delivery_date
    FROM deliveries_assigned
    WHERE gift_date > '2025-12-14'
    ORDER BY delivery_date
),

expected_delivery_dates AS (
    SELECT
        fam.id AS family_id,
        fam.family_name,
        dt.delivery_date
    FROM families AS fam
    CROSS JOIN dates AS dt
)

SELECT
    edd.delivery_date AS unassigned_date,
    edd.family_name
FROM expected_delivery_dates AS edd
LEFT JOIN deliveries_assigned AS del
    ON
        edd.delivery_date = del.gift_date
        AND edd.family_id = del.family_id
WHERE del.id IS NULL
GROUP BY unassigned_date, edd.family_name
ORDER BY unassigned_date ASC, edd.family_name ASC
LIMIT 25;
