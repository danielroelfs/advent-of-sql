INSERT INTO misdelivered_presents
SELECT
    id,
    child_name,
    delivery_location,
    gift_name,
    scheduled_at,
    date_trunc('minute', now()) AS flagged_at,
    'Invalid delivery location' AS reason
FROM deliveries
WHERE
    delivery_location IN (
        'Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse', 'The Vibes'
    );

SELECT
    id,
    child_name,
    delivery_location,
    gift_name,
    scheduled_at,
    flagged_at,
    reason
FROM misdelivered_presents
WHERE flagged_at = date_trunc('minute', now())
LIMIT 25;
