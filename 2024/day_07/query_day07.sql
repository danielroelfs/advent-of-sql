WITH min_experience AS (
    SELECT DISTINCT ON (primary_skill)
        elf_id,
        years_experience,
        primary_skill
    FROM workshop_elves
    ORDER BY primary_skill ASC, years_experience ASC, elf_id ASC
),

max_experience AS (
    SELECT DISTINCT ON (primary_skill)
        elf_id,
        years_experience,
        primary_skill
    FROM workshop_elves
    ORDER BY primary_skill ASC, years_experience DESC, elf_id ASC
)

SELECT
    max_exp.elf_id AS elf_1_id,
    min_exp.elf_id AS elf_2_id,
    max_exp.primary_skill AS shared_skill
FROM min_experience AS min_exp
INNER JOIN max_experience AS max_exp
    ON min_exp.primary_skill = max_exp.primary_skill
ORDER BY min_exp.primary_skill
LIMIT 3;
