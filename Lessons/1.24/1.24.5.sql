UPDATE staging.priority_skills
SET priority_lvl = 1
WHERE skill_id = 0;

UPDATE staging.priority_skills
SET priority_lvl = 2
WHERE skill_id = 1;

SELECT * FROM staging.priority_skills;

MERGE INTO main.job_skill_priorities as tgt
USING staging.priority_skills AS src
    ON tgt.skill_id = src.skill_id

WHEN MATCHED AND (tgt.priority_lvl <> src.priority_lvl OR tgt.priority_lvl IS NULL) THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        status = 'PRIORITY CHANGE';

SELECT * FROM main.job_skill_priorities;