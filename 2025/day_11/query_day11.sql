SELECT
    cat.official_category,
    SUM(inv.quantity) AS total_usable_snowballs
FROM snowball_categories AS cat
LEFT JOIN snowball_inventory AS inv
    ON
        cat.official_category = inv.category_name
        AND inv.quantity >= 0
GROUP BY cat.official_category
ORDER BY total_usable_snowballs ASC;
