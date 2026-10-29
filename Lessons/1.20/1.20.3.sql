SELECT
    job_title_short,
    AVG(salary_hour_avg*40*52)::DECIMAL(10,2) AS salary_hour_annual,
    AVG(salary_hour_avg*40*52)::INT AS salary_hour_annual_no_decimals
FROM
    job_postings_fact
WHERE
    salary_hour_avg IS NOT NULL
    AND job_country = 'United States'
GROUP BY
    job_title_short
ORDER BY
    salary_hour_annual DESC;