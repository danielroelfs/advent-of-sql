WITH latest_order AS (
    SELECT
        customer_id,
        MAX(created_at) AS latest_date
    FROM orders
    GROUP BY customer_id
)

SELECT
    ord.customer_id,
    ((ord.order_data::json ->> 'gift')::json ->> 'wrapped')::boolean
        AS gift_wrap,
    (ord.order_data::json ->> 'shipping')::json ->> 'method' AS shipping_method,
    (ord.order_data::json ->> 'risk')::json ->> 'flag' AS risk
FROM orders AS ord
INNER JOIN
    latest_order AS lo
    ON
        ord.customer_id = lo.customer_id
        AND ord.created_at = lo.latest_date
