USE company_jobs;

CREATE TABLE jan_2023_cleanup_copy AS
SELECT *
FROM data_jobs.job_postings_fact;

DELETE FROM jan_2023_cleanup_copy
WHERE job_posted_date < '2023-01-01';

SELECT 
    (SELECT COUNT(*) FROM jan_2023_cleanup_copy) AS new_table_count,
    (SELECT COUNT(*) FROM data_jobs.job_postings_fact) AS original_table_count;

SELECT job_id, job_posted_date
FROM jan_2023_cleanup_copy
ORDER BY job_posted_date;