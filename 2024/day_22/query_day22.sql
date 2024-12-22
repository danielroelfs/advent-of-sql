SELECT COUNT(elf_name) AS numofelveswithsql
FROM elves
WHERE 'SQL' = ANY(STRING_TO_ARRAY(skills, ','));
