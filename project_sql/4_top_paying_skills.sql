/*
Top paying skills:
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    s.skills,
    ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact j
JOIN 
    skills_job_dim sd ON j.job_id = sd.job_id
JOIN 
    skills_dim s ON s.skill_id = sd.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    s.skills
ORDER BY
    avg_salary DESC
LIMIT 10;