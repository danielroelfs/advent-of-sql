WITH combined AS (
    SELECT * FROM letters_a
    UNION ALL
    SELECT * FROM letters_b
),

decoded AS (
    SELECT
        *,
        CHR(value) AS string
    FROM combined
    WHERE
        (value BETWEEN 65 AND 90)
        OR (value BETWEEN 97 AND 122)
        OR (value IN (32, 33, 44, 46))
)

SELECT STRING_AGG(string, '') FROM decoded;
