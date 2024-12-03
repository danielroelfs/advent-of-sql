-- noqa: disable=LT05
WITH parsed_menu AS (
    SELECT
        (XPATH('//food_item_id/text()', menu_data))::text [] AS array_food_item,
        CASE
            WHEN ARRAY_LENGTH(XPATH('//total_present/text()', menu_data), 1) > 0
                THEN (XPATH('//total_present/text()', menu_data))[1]::text::integer
            WHEN ARRAY_LENGTH(XPATH('//total_count/text()', menu_data), 1) > 0
                THEN (XPATH('//total_count/text()', menu_data))[1]::text::integer
            WHEN ARRAY_LENGTH(XPATH('//total_guests/text()', menu_data), 1) > 0
                THEN (XPATH('//total_guests/text()', menu_data))[1]::text::integer
        END AS n_guests
    FROM christmas_menus
)

SELECT
    UNNEST(array_food_item) AS food_item,
    COUNT(*) AS n
FROM parsed_menu
WHERE n_guests > 78
GROUP BY food_item
ORDER BY n DESC
LIMIT 1;
