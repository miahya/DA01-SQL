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

--- exercise 6: sử dụng TO_CHAR để lấy theo định dạng cả ngày-tháng-năm
select
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    count(case
            when state='approved' then 1
        end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case
            when state='approved' then amount
        end) as approved_total_amount
from transactions
group by month, country

--- exercise 7: sử dụng hàm RANK để lấy thông tin về năm đầu tiên bán được của từng mặt hàng
with cte_sales as
(select
    product_id,
    year,
    quantity,
    price,
    rank() over(partition by product_id 
                order by year) as ranking
from sales)

select
    product_id,
    year as first_year,
    quantity,
    price
from cte_sales
where ranking = 1

--- exercise 8: sdung sub-query để lấy sum(số lượng product) hiện có
with cte_customer as
    (select customer_id, count(customer_id) as customer_count
    from customer
    group by customer_id
    order by customer_id)

select distinct a.customer_id
from customer a
left join cte_customer b on a.customer_id = b.customer_id
where b.customer_count = (select count(product_key) from product)
order by customer_id;

--- exercise 9: khi chỉ muốn xuất hiện một (cột ex9/dòng ex8) giá trị thì có sdung CTE được không, join như nào
select employee_id
from employees
where salary < 30000
and manager_id in 
        (select 
        staff.manager_id as left_id
        from employees as staff
        right join employees as manager on staff.employee_id = manager.manager_id
        where staff.manager_id is not NULL)

--- exercise 10: trùng link với ex 1

--- exercise 11: tại sao dùng UNION lại không loại các giá trị trùng lặp mà UNION ALL lại xóa các giá trị trùng lặp và được accepted
with cte_customer as
(select
    users.user_id,
    name,
    count(rating),
    rank() over(order by count(rating) desc) as user_ranking
from users
left join movierating on users.user_id = movierating.user_id
group by users.user_id, name
order by user_ranking, name),
cte_movie as
(select 
    movies.movie_id,
    title,
    avg(rating),
    rank() over(order by avg(rating) desc) as movie_ranking
from movies
left join movierating on movies.movie_id = movierating.movie_id
where TO_CHAR(created_at, 'YYYY-MM') = '2020-02'
group by movies.movie_id, title
order by movie_ranking, title)

(select name as results
from cte_customer
limit 1)
union all
(select title
from cte_movie
limit 1)

--- exercise 12: vì mỗi id chỉ hiện 1 lần ở bảng request/accept => khi UNION ALL, số lượt id xuất hiện = số friends (được accept/chấp nhận request)
with cte_friends as
(select requester_id as id 
from RequestAccepted
union all
select accepter_id
from RequestAccepted)

select id, count(*) as num
 from cte_friends
 group by id
 order by count(*) desc 
 limit 1
