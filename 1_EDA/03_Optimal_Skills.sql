/*

Question: What are the most optimal skills for data engineers—balancing both demand and salary?

- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. 
    It weights core skills appropriately, rather than letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as 
    the most practical and valuable to learn for data engineering careers.

*/

SELECT
    sd.skills AS skills,
    ROUND(MEDIAN(jpf.salary_year_avg),2) AS median_salary,
    COUNT(jpf.*) AS job_count,
    ROUND(LN(COUNT(jpf.*)),2) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/ 1_000_000,2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_work_from_home IS TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*

Here's a breakdown of the most optimal skills for Data Engineers, based on high demand and strong salaries:

Top Skills by Optimal Score:

- Terraform leads with a $184K median salary and 193 postings, achieving the highest overall "optimal score."
- Python and SQL dominate demand with over 1,100 postings each and strong median salaries of $135K and $130K.
- AWS (783 postings, $137K median), Spark (503 postings, $140K median), and Airflow (386 postings, $150K median) are highly sought-after cloud and big data technologies.
- Kafka offers high compensation ($145K median) with solid demand (292 postings).
- Snowflake, Azure, and Databricks each have 250–475 postings and median salaries between $128K–$137K.

DevOps & Engineering Tools:

- Airflow ($150K), Kubernetes ($150.5K), and Docker ($135K) stand out for combining strong demand with top median salaries.
- Git ($140K/208 postings) and GitHub ($135K/127 postings) offer broad utility and competitive compensation.

Noteworthy Languages:

- Java (303 postings, $135K median) and Scala (247 postings, $137K median) remain strong choices for well-paid data engineering roles.
- Go ($140K/113 postings) also delivers excellent compensation.

Databases & Cloud:

- Redshift ($130K/274 postings), GCP ($136K/196 postings), Hadoop ($135K/198 postings), 
NoSQL ($134.4K/193 postings), and MongoDB ($135.8K/136 postings) round out a well-balanced data engineering skill set.
- R, PySpark, and BigQuery each deliver competitive salaries and meet the demand threshold.

Summary: Skills near the top balance market demand (job security) with financial reward. 
Python, SQL, AWS, Spark, Airflow, and Terraform are particularly strategic for immediate opportunities and long-term career growth in data engineering.

┌────────────┬───────────────┬───────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ job_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │   int64   │     double      │    double     │
├────────────┼───────────────┼───────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │       193 │            5.26 │          0.97 │
│ python     │      135000.0 │      1133 │            7.03 │          0.95 │
│ sql        │      130000.0 │      1128 │            7.03 │          0.91 │
│ aws        │     137320.31 │       783 │            6.66 │          0.91 │
│ airflow    │      150000.0 │       386 │            5.96 │          0.89 │
│ spark      │      140000.0 │       503 │            6.22 │          0.87 │
│ kafka      │      145000.0 │       292 │            5.68 │          0.82 │
│ snowflake  │      135500.0 │       438 │            6.08 │          0.82 │
│ azure      │      128000.0 │       475 │            6.16 │          0.79 │
│ java       │      135000.0 │       303 │            5.71 │          0.77 │
│ scala      │     137290.48 │       247 │            5.51 │          0.76 │
│ git        │      140000.0 │       208 │            5.34 │          0.75 │
│ kubernetes │      150500.0 │       147 │            4.99 │          0.75 │
│ databricks │      132750.0 │       266 │            5.58 │          0.74 │
│ redshift   │      130000.0 │       274 │            5.61 │          0.73 │
│ gcp        │      136000.0 │       196 │            5.28 │          0.72 │
│ nosql      │      134415.0 │       193 │            5.26 │          0.71 │
│ hadoop     │      135000.0 │       198 │            5.29 │          0.71 │
│ pyspark    │      140000.0 │       152 │            5.02 │           0.7 │
│ mongodb    │      135750.0 │       136 │            4.91 │          0.67 │
│ docker     │      135000.0 │       144 │            4.97 │          0.67 │
│ r          │      134775.0 │       133 │            4.89 │          0.66 │
│ go         │      140000.0 │       113 │            4.73 │          0.66 │
│ bigquery   │      135000.0 │       123 │            4.81 │          0.65 │
│ github     │      135000.0 │       127 │            4.84 │          0.65 │
└────────────┴───────────────┴───────────┴─────────────────┴───────────────┘
  25 rows                                                        5 columns