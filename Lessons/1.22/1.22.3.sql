USE company_jobs;

CREATE VIEW remote_jobs_view AS
SELECT
    job_id, 
    job_title_short,
    cd.name AS company_name
FROM 
    data_jobs.job_postings_fact AS jpf
INNER JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_work_from_home = TRUE;

SELECT
    company_name,
    COUNT(*) AS number_of_jobs
FROM remote_jobs_view
GROUP BY company_name
ORDER BY number_of_jobs DESC;