-- Exercise 1
select name
from city
where population > 120000
and (countrycode = 'USA');

-- Exercise 2
select *
from city
where countrycode = 'JPN';

-- Exercise 3
select city, state
from station;

-- Exercise 4
select distinct city
from station
where (city like 'A%') 
or (city like 'E%') 
or (city like 'I%') 
or (city like 'O%') 
or (city like 'U%');

HOẶC DÙNG REGEXP FUNCTION:
  select distinct city from station
  where city regexp '^[a,e,i,o,u]';

-- Exercise 5
select distinct city
from station
where (city like '%a') 
or (city like '%e') 
or (city like '%i') 
or (city like '%o') 
or (city like '%u');

-- Exercise 6 (tsao la wrong answer*)
select distinct city
from station
where not (city like 'A%') 
or (city like 'E%') 
or (city like 'I%') 
or (city like 'O%') 
or (city like 'U%');

-- Exercise 7
select name
from employee
order by name ASC;

-- Exercise 8
select name
from employee
where salary >= 2000 and months < 10
order by employee_id;

-- Exercise 9
elect product_id
from products
where low_fats = 'Y' and recyclable = 'Y';

-- Exercise 10 (tsao phai them condition is null*)
select name
from customer
where referee_id != 2 or referee_id is null;

-- Exercise 11
select name, population, area
from world
where area >= 3000000 or population >= 25000000;

-- Exercise 12 (((())))
select distinct author_id as id
from Views
where author_id = viewer_id
order by author_id;

-- Exercise 13
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date is NULL;

-- Exercise 14
select * from lyft_drivers
where (yearly_salary <= 30000) or (yearly_salary >= 70000);

-- Exercise 15
select advertising_channel 
from uber_advertising
where money_spent > 100000 and year = 2019;
