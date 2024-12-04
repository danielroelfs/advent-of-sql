SELECT
    toy_id,
    (
        SELECT COUNT(*)
        FROM (
            SELECT UNNEST(new_tags)
            EXCEPT
            SELECT UNNEST(previous_tags)
        )
    ) AS added,
    (
        SELECT COUNT(*)
        FROM (
            SELECT UNNEST(previous_tags)
            INTERSECT
            SELECT UNNEST(new_tags)
        )
    ) AS unchanged,
    (
        SELECT COUNT(*)
        FROM (
            SELECT UNNEST(previous_tags)
            EXCEPT
            SELECT UNNEST(new_tags)
        )
    ) AS removed
FROM toy_production
ORDER BY added DESC
LIMIT 1;
