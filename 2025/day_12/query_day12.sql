UPDATE hotline_messages
SET status = 'approved'
WHERE
    1 = 1
    AND LOWER(transcript) LIKE '%sorry%'
    AND status IS NULL;


DELETE FROM hotline_messages
WHERE
    1 = 1
    AND tag IN (
        'penguin prank',
        'time-loop advisory',
        'possible dragon',
        'nonsense alert'
    )
    OR LOWER(caller_name) = 'test caller';

SELECT
    COALESCE(status, 'needs review') AS imputed_status,
    COUNT(*) AS n_messages
FROM hotline_messages
GROUP BY imputed_status;
