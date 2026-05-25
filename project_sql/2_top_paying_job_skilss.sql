/*
skills that are required for the top-paying data analyst jobs:
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (

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
            10
)

SELECT
    j.*,
    s.skills
FROM
    top_paying_jobs AS j
JOIN
    skills_job_dim AS sj ON j.job_id = sj.job_id
JOIN
    skills_dim AS s ON sj.skill_id = s.skill_id
ORDER BY
    j.salary_year_avg DESC;
