--- Exercise 1 (có thể để thành device_type IN ('tablet', 'phone') & dùng SUM/COUNT
SELECT 
COUNT(CASE
When device_type = 'laptop' THEN 1
END) as laptop_views,
COUNT(CASE
when device_type = 'phone' then 1
when device_type = 'tablet' then 1
END) as mobile_views
FROM viewership;

--- Exercise 2 (select x,y,z speed up hơn là *)
------- Triangle rule: a+b > c, a+c > b, b+c >a (phải tm 3 dk cùng lúc => AND)
SELECT *,
CASE
    WHEN (x+y)>z AND (x+z)>y AND (z+y)>x THEN 'Yes'
    ELSE 'No'
END as triangle
From Triangle;

--- Exercise 3
SELECT
  ROUND((COUNT(CASE when call_category is null or call_category = 'n/a' THEN 1 END))/COUNT(*)*100, 1) 
FROM callers;

--- Exercise 4
SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;

--- Exercise 5
select
survived,
count(case 
        when pclass=1 then 1
        end) as first_class,
count(case 
        when pclass=2 then 1
        end) as second_class,
count(case 
        when pclass=3 then 1
        end) as third_class
from titanic
group by survived;
