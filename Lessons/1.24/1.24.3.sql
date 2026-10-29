UPDATE main.job_skill_priorities
SET status = 'URGENT'
WHERE status = 'ACTIVE';

SELECT *
FROM job_skill_priorities;