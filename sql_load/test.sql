SELECT
    t1.name,
    CASE
        WHEN t2.jobs_posted < 10 THEN 'Small'
        WHEN t2.jobs_posted <= 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM 
    company_dim AS t1
JOIN (
    SELECT
        company_id,
        COUNT(job_id) AS jobs_posted
    FROM 
        job_postings_fact
    GROUP BY
        company_id
) AS t2 ON t1.company_id = t2.company_id;