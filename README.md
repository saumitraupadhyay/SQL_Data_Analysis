
---
# 📊 Decoding the Data Job Market: A SQL-Driven Analysis

## 🎯 Executive Summary

Navigating the data job market requires more than just knowing how to code; it requires knowing *what* to code. This project analyzes real-world job postings to uncover the most optimal skills for Data Analysts in 2023.

By analyzing salary data, remote work trends, and skill frequencies, this project answers a critical strategic question: **Where does high demand intersect with high compensation?**

**Key Takeaways:**

* **The Salary Ceiling is High:** Top-tier remote Data Analyst roles command anywhere from $184,000 to a staggering $650,000.
* **The Foundation is Non-Negotiable:** SQL and Python are the undisputed backbone of the industry. You cannot secure top-paying roles without them.
* **The "Unicorn" Premium:** The highest average salaries belong to analysts who pair foundational skills with specialized Cloud (AWS, Snowflake, GCP) and Big Data (PySpark, Hadoop) technologies.

---

## 🧭 The Mission

This project was born out of a desire to streamline the job search process for aspiring data professionals. Rather than guessing which skills to learn next, I wanted the data to dictate the optimal learning path.

The dataset originates from the [SQL Course](https://lukebarousse.com/sql) and contains thousands of detailed job postings, including titles, salaries, locations, and essential skills.

---

## 🛠️ The Arsenal

* **PostgreSQL:** The core database engine used to store, query, and aggregate the job posting data.
* **SQL:** Utilized advanced querying techniques including Common Table Expressions (CTEs), multi-table `JOIN`s, and aggregate functions to extract actionable insights.
* **Visual Studio Code:** The primary IDE for database management and script execution.
* **Git & GitHub:** Implemented version control for robust project tracking and seamless portfolio sharing.

---

## 🔎 The Deep Dive

### Phase 1: The Highest Echelon (Top Paying Roles)

To establish a baseline for the high-end market, I isolated the top 10 highest-paying remote Data Analyst roles.

```sql
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

```

**Insight:** High-paying roles are not restricted to a single industry. Companies ranging from Meta and AT&T to financial platforms like SmartAsset are heavily investing in data talent, with a high diversity in specific titles (ranging from Principal Data Analyst to Director of Analytics).


*Visualizing the salary distribution for the top 10 remote data analyst roles in 2023.*

### Phase 2: Decoding Market Demand

Chasing outliers isn't always a reliable career strategy. I shifted focus to analyze the broader market to determine which skills are most frequently requested across *all* remote job postings.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

```

**Insight:** The data firmly establishes that traditional data manipulation and visualization remain paramount. SQL (7,291 postings) and Excel (4,611 postings) lead the pack, closely followed by Python and Tableau.

| Skill | Demand Count |
| --- | --- |
| **SQL** | 7,291 |
| **Excel** | 4,611 |
| **Python** | 4,330 |
| **Tableau** | 3,745 |
| **Power BI** | 2,609 |

### Phase 3: The "Sweet Spot" (Optimal Skills)

The final and most crucial step of the analysis was finding the intersection of **Demand** and **Salary**. I designed a query to identify skills that appear frequently in job postings (demand > 10) *and* command the highest average salaries.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 10;

```

**Insight:** This query reveals the true blueprint for career advancement. While Python and R are in high demand (averaging ~$100K), the skills that push average salaries comfortably over the **$110K+ mark** are specialized Cloud, Big Data, and CI/CD tools.

| Skill | Demand Count | Average Salary ($) |
| --- | --- | --- |
| **Go** | 27 | $115,320 |
| **Confluence** | 11 | $114,210 |
| **Hadoop** | 22 | $113,193 |
| **Snowflake** | 37 | $112,948 |
| **Azure** | 34 | $111,225 |
| **BigQuery** | 13 | $109,654 |
| **AWS** | 32 | $108,317 |

---

## 💡 Strategic Recommendations

Based on the analysis, a Data Analyst looking to maximize their market value in the current landscape should adopt a "T-shaped" skill profile:

1. **Master the Core (The Vertical):** Secure absolute proficiency in **SQL** and **Python**. These are the gatekeepers to the industry.
2. **Learn to Tell the Story:** Visualization tools like **Tableau** or **Power BI** are essential for translating data into business value.
3. **Specialize in the Cloud (The Horizontal):** To break into the highest salary tiers, develop a niche in Cloud architecture and Big Data environments (e.g., **Snowflake, AWS, Hadoop, or Azure**). The data proves that employers pay a massive premium for analysts who can operate seamlessly within modern, scaled data infrastructures.

---

*For a complete look at the raw SQL queries, please navigate to the [project_sql](https://www.google.com/search?q=/project_sql/) folder.*