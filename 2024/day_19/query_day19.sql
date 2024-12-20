WITH avg_last_score AS (
    SELECT
        AVG(
            year_end_performance_scores[
                ARRAY_UPPER(year_end_performance_scores, 1)
            ]
        ) AS avg_score
    FROM employees
),

salaries_w_bonus AS (
    SELECT
        CASE
            WHEN
                em.year_end_performance_scores[
                    ARRAY_UPPER(em.year_end_performance_scores, 1)
                ]
                > (SELECT als.avg_score FROM avg_last_score AS als)
                THEN em.salary * 1.15
            ELSE em.salary
        END AS salary_w_bonus
    FROM employees AS em
)

SELECT ROUND(SUM(salary_w_bonus), 2) AS total_salary_paid
FROM salaries_w_bonus;
