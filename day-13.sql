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
WITH like_cte AS
(SELECT a.page_id as total_page, b.page_id as like_page
FROM pages a    
LEFT JOIN page_likes b on a.page_id = b.page_id)

SELECT total_page AS page_id
FROM like_cte
WHERE like_page is NULL;

--- exercise 5: chưa linh hoạt lắm vì sẽ phải nhập tay phần tháng khi muốn thay đổi...
WITH active_user_cte AS
(SELECT user_id,
        COUNT(*) as interaction
FROM user_actions
WHERE EXTRACT(month FROM event_date) in ('06','07')
GROUP BY user_id
HAVING COUNT(DISTINCT event_type) = 3)

SELECT EXTRACT(month from a.event_date),
       COUNT(distinct b.user_id)
FROM user_actions a
JOIN active_user_cte b ON a.user_id = b.user_id
Where EXTRACT(month from a.event_date) = '07'
and EXTRACT(year from a.event_date) = '2022'
GROUP BY EXTRACT(month from a.event_date)

--- exercise 6:





