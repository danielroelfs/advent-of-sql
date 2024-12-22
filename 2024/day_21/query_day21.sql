WITH total_sales AS (
    SELECT
        DATE_PART('YEAR', sale_date) AS sale_year,
        DATE_PART('QUARTER', sale_date) AS sale_quarter,
        SUM(amount) AS sale_amount
    FROM sales
    GROUP BY sale_year, sale_quarter
)

SELECT
    sale_year,
    sale_quarter,
    sale_amount,
    ROUND(
        sale_amount
        / LAG(sale_amount) OVER (ORDER BY sale_year, sale_quarter), 2
    ) AS growth_rate
FROM total_sales
ORDER BY growth_rate DESC NULLS LAST
LIMIT 5;
