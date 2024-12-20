SELECT
    url,
    STRING_TO_ARRAY(SPLIT_PART(url, '?', 2), '&') AS query_params,
    CARDINALITY(STRING_TO_ARRAY(SPLIT_PART(url, '?', 2), '&')) AS n_params
FROM web_requests
WHERE
    SPLIT_PART(SUBSTRING(url FROM 'utm_source=[\w-]+'), '=', 2)
    = 'advent-of-sql'
ORDER BY query_params DESC, url ASC
LIMIT 5;
