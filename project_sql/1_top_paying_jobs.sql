/*
 The top-paying data analyst jobs: 
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
    j.job_id,
    c.name AS "company_name",
    j.job_title,
    j.salary_year_avg
FROM 
    job_postings_fact j
JOIN
    company_dim c
ON
    c.company_id = j.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND
    job_location = 'Anywhere'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;