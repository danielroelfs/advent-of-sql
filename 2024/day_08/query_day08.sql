WITH RECURSIVE managers AS (
    SELECT
        s1.staff_id,
        s1.staff_name,
        s1.manager_id
    FROM staff AS s1
    UNION ALL
    SELECT
        s2.staff_id,
        s2.staff_name,
        s2.manager_id
    FROM staff AS s2
    INNER JOIN managers AS mgmt
        ON s2.manager_id = mgmt.staff_id
)

SELECT
    COUNT(*) AS n
FROM managers
GROUP BY staff_id
ORDER BY n DESC
LIMIT 1;
