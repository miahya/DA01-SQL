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

--- exercise 2: phải sdung hàm RANK thay LIMIT vì là top2 ở mỗi category, limit order by là tính chung trên toàn data => tạo 1 bảng mới có cột ranking r filter sau
WITH spend_cte AS
(SELECT category, product, 
sum(spend) AS total_spend,
RANK() OVER(PARTITION BY category 
            ORDER BY SUM(spend) desc) AS ranking
FROM product_spend
WHERE EXTRACT(year FROM transaction_date) = '2022'
GROUP BY category, product)

SELECT category, product, total_spend
FROM spend_cte
WHERE ranking <=2;

--- exercise 3:
SELECT COUNT(policy_holder_id) AS member_count
FROM(SELECT policy_holder_id, COUNT(case_id)
     FROM callers
     GROUP BY policy_holder_id
     HAVING COUNT(case_id) >= 3) as count_table;

--- exercise 4:







