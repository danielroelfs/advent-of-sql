WITH gift_counts AS (
    SELECT
        gi.gift_name,
        COUNT(*) AS n_req
    FROM gift_requests AS req
    LEFT JOIN gifts AS gi ON req.gift_id = gi.gift_id
    GROUP BY gi.gift_name
)

SELECT
    gift_name,
    ROUND(PERCENT_RANK() OVER (
        ORDER BY n_req
    )::numeric, 2) AS percentile
FROM
    gift_counts
ORDER BY percentile DESC, gift_name ASC
LIMIT 20;
