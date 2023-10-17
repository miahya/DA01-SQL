--- 1 output
--- 2 input
--- 3 filtering

--- Exercise 1
select distinct city
from station
where ID%2=0;

--- Exercise 2 (use mathematics function in select)
select count(city) - count(distinct city)
from station;

--- Exercise 3 (xóa số 0 chứ không cần thay thế bằng khoảng trắng - sử dụng hàm replace vì không phải giá trị  nào cũng có số 0)
select ceiling(avg(salary) - avg(replace(salary,'0','')))
from employees;

--- Exercise 4 (sdung hàm CAST(data AS DECIMAL) hoặc ::DECIMAL)
select ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) as decimal) ,1) as mean
from items_per_order;

--- Exercise 5 (chọn id > lọc skill theo đkiện 3 skill > group theo id & count đếm những ai có đủ ba kĩ năng mới hiện)
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3; 
###tcount=3 vì có nghĩa là có đủ cả ba kĩ năng

--- Exercise 6 (hàm DATE & HAVING count vì đây là hàm tổng hợp)
SELECT user_id, 
Date(MAX(post_date))-date(MIN(post_date)) as days_between
FROM posts
WHERE (post_date BETWEEN '2021-01-01' AND '2022-01-01')
GROUP BY user_id
HAVING COUNT(post_id) >= 2;

--- Exercise 7
SELECT card_name,
MAX(issued_amount)-MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

--- Exercise 8 (nhớ có dấu , giữa các trường SELECT)
SELECT manufacturer,
COUNT(drug) AS drug_count,
abs(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;

--- Exercise 9 (tìm odd/even number sử dụng chia hết ra số dư %)
SELECT *
FROM Cinema
WHERE id%2=1 AND description != 'boring'
ORDER BY rating DESC;

--- Exercise 10 (nhớ phải AS name)
SELECT teacher_id,
COUNT(DISTINCT subject_id) as cnt
FROM Teacher
Group by teacher_id;

--- Exercise 11
SELECT user_id,
COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;

--- Exercise 12 (Cứ có hàm aggregate là nhét vào GROUP BY HAVING, kể cả trên SELECT không có hàm tổng hợp)
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
