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
select mng.employee_id,
mng.name,
count(mng.employee_id) as reports_count,
round(avg(emp.age),0) as average_age
from employees emp
inner join employees mng on emp.reports_to = mng.employee_id
group by mng.employee_id,  mng.name
order by mng.employee_id;
  
--- Exercise 6
select product_name,
sum(unit) as unit
from products
join orders on products.product_id = orders.product_id
where extract(month from order_date) = 02 and extract(year from order_date) = 2020
group by product_name
having sum(unit) >= 100;

--- Exercise 7
SELECT p.page_id
FROM pages p
FULL OUTER JOIN page_likes pl on p.page_id = pl.page_id
Where pl.user_id is NULL
ORDER BY p.page_id;

------- MID TERM TEST
--- Q1
select distinct title, replacement_cost
from film
order by replacement_cost, title;

--- Q2
select
case
	when replacement_cost between 9.99 and 19.99 then 'low'
	when replacement_cost between 20.00 and 24.99 then 'medium'
	when replacement_cost between 25.00 and 29.99 then 'high'
end as category,
count(*) as so_luong
from public.film
group by category;

--- Q3
select a.title, a.length, c.name
from film as a
join film_category as b on a.film_id = b.film_id
join category as c on b.category_id=c.category_id
and c.name IN  ('Drama', 'Sports')
where c.name is not null
order by a.length desc;

--- Q4
select c.name, count(c.name) as so_luong
from film as a
join film_category as b on a.film_id = b.film_id
join category as c on b.category_id=c.category_id
group by c.name
order by count(c.name) desc;

--- Q5
select first_name, last_name, count(film_id)
from actor a
left join film_actor b on a.actor_id = b.actor_id
group by first_name, last_name
order by count(film_id) desc;

--- Q6
select address
from address a
left join customer c on a.address_id = c.address_id
where customer_id is null;

--- Q7
select city, sum(amount) as doanh_thu
from city a
join address b on a.city_id = b.city_id
join customer c on b. address_id = c.address_id
join payment d on c.customer_id = d.customer_id
group by city
order by sum(amount) desc;

--- Q8
select country|| ', '||city as thong_tin, 
sum(amount) as doanh_thu
from city a
join address b on a.city_id = b.city_id
join customer c on b. address_id = c.address_id
join payment d on c.customer_id = d.customer_id
join country e on a.country_id = e.country_id
group by country, city
order by sum(amount);
