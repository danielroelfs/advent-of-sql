WITH email_addresses AS (
    SELECT
        name,
        email,
        SPLIT_PART(email, '@', 2) AS domain_name
    FROM contact_list, UNNEST(email_addresses) AS email
)

SELECT
    domain_name,
    COUNT(*) AS n_users
FROM
    email_addresses
GROUP BY
    domain_name
ORDER BY n_users DESC
LIMIT 5;
