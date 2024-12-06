SELECT
    ch.name AS child_name,
    gi.name AS gift_name,
    gi.price AS gift_price
FROM children AS ch
INNER JOIN gifts AS gi ON ch.child_id = gi.child_id
WHERE gi.price > (SELECT AVG(mp.price) FROM gifts AS mp)
ORDER BY gi.price ASC
LIMIT 5;
