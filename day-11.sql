----- PRACTICE
--- Exercise 1 (round down = floor)
select COUNTRY.Continent, floor(avg(CITY.Population))
from city
inner join country on CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;

--- Exercise 2 (join multiple conditions, left join để lấy full data của e.email_id)
SELECT round(count(t.email_id)::decimal/ count(DISTINCT e.email_id),2) as activation_rate
FROM emails e
LEFT JOIN texts t on e.email_id = t.email_id
AND signup_action = 'Confirmed'

--- Exercise 3
SELECT age_bucket, 
ROUND(SUM(case when activity_type = 'send' then time_spent END)/
  SUM(time_spent)*100.0,2) as send_perc,
ROUND(SUM(CASE WHEN activity_type = 'open' then time_spent END)/
  SUM(time_spent)*100.0,2) as open_perc
FROM activities a
LEFT JOIN age_breakdown b on a.user_id = b.user_id
WHERE activity_type IN ('send','open')
GROUP BY age_bucket;

--- Exercise 4 (vì category chỉ có đúng 3 loại đó nên không cần câu lệnh WHERE để specify, nếu nhiều hơn thì mới cần)
SELECT customer_id
FROM products
JOIN customer_contracts ON customer_contracts.product_id = products.product_id
## --- WHERE product_category IN ('Analytics', 'Containers', 'Compute')
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = 3;

--- Exercise 5

--- Exercise 6
select product_name,
sum(unit) as unit
from products
join orders on products.product_id = orders.product_id
where extract(month from order_date) = 02 and extract(year from order_date) = 2020
group by product_name
having sum(unit) >= 100;

--- Exercise 7

--- Exercise 8
\
