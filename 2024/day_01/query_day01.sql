WITH latest_list AS (
    SELECT
        child_id,
        MAX(submitted_date) AS latest
    FROM wish_lists
    GROUP BY child_id
),

wishes AS (
    SELECT
        wl.child_id,
        wl.wishes::json ->> 'first_choice' AS primary_wish,
        wl.wishes::json ->> 'second_choice' AS backup_wish
    FROM wish_lists AS wl
    INNER JOIN latest_list AS ll ON
        wl.child_id = ll.child_id
        AND wl.submitted_date = ll.latest
),

complexity AS (
    SELECT
        toy_name,
        CASE
            WHEN difficulty_to_make = 1 THEN 'Simple Gift'
            WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
            ELSE 'Complex Gift'
        END AS gift_complexity,
        CASE
            WHEN category = 'educational' THEN 'Learning Workshop'
            WHEN category = 'outdoor' THEN 'Outdoor Workshop'
            ELSE 'General Workshop'
        END AS workshop_assignment
    FROM toy_catalogue
)

SELECT
    ch.name,
    wsh.primary_wish,
    wsh.backup_wish,
    cmplx.gift_complexity,
    cmplx.workshop_assignment
FROM children AS ch
INNER JOIN wishes AS wsh ON ch.child_id = wsh.child_id
INNER JOIN complexity AS cmplx ON wsh.primary_wish = cmplx.toy_name
ORDER BY ch.name
LIMIT 5;
