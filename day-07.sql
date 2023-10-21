--- Exercise 1 (lưu ý hàm LEFT RIGHT để không bị nhầm hướng O:)
SELECT name
From Students
where marks > 75
ORDER BY Right(name, 3), ID ASC;

--- Exercise 2 (phải dùng kết hợp LOWER UPPER, không dùng được PROPER như trong Excel) + NHỚ , trong SELECT!!
SELECT user_id,
CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users;

--- Exercise 3: ROUND(data, 0): làm tròn đến số nguyên nhưng Ceiling/Floor tùy vào phần thập phân, # với ceiling & floor làm tròn lên xuống auto, không xét phần thập phân
SELECT manufacturer,
'$'||ROUND(SUM(total_sales)/1000000, 0)||' '||'million' As sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer

--- Exercise 4: hàm Extract month from.. dễ bị lỗi
SELECT 
EXTRACT(MONTH FROM submit_date) AS mth,
product_id as product,
ROUND(AVG(stars),2) as avg_stars
FROM reviews
GROUP BY product, mth
ORDER BY mth, product

--- Exercise 5
SELECT sender_id,
COUNT(sender_id) AS message_count
FROM messages
WHERE sent_date > '08/01/2022' AND sent_date <'09/01/2022'
GROUP BY sender_id
ORDER BY COUNT(sender_id) DESC
LIMIT 2;

--- Exercise 6
SELECT tweet_ID
FROM Tweets
WHERE LENGTH(content)>15;

--- Exercise 7 (((có cách nào nhanh hơn để không phải tính tay trừ 30 ngày ko huhu)))
SELECT activity_date AS day,
COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date>='2019-06-28'
AND activity_date<='2019-07-27'
GROUP BY activity_date 

--- Exercise 8
SELECT EXTRACT(MONTH FROM joining_date) AS MONTH, 
COUNT(*)
FROM employees
WHERE EXTRACT(MONTH FROM joining_date) IN (1,2,3,4,5,6,7)
GROUP BY EXTRACT(MONTH FROM joining_date)
ORDER BY EXTRACT(MONTH FROM joining_date)

--- Exercise 9 (ko check dc key)
select 
position('a' IN first_name)
from worker
WHERE first_name = 'Amitah';

--- Exercise 10
