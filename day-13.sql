--- exercise 1: những so_bai > 1 mới là bài duplicate
WITH post_duplicate AS
(SELECT company_id, title, description,
COUNT(job_id) as so_bai
FROM job_listings
GROUP BY company_id, title, description)
SELECT 
COUNT(DISTINCT company_id) AS duplicate_companies
FROM post_duplicate
WHERE so_bai > 1;

--- exercise 2:
