----- PRACTICE
--- Exercise 1 (round down = floor)
select COUNTRY.Continent, floor(avg(CITY.Population))
from city
inner join country on CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;

--- Exercise 2

--- Exercise 3

--- Exercise 4


--- Exercise 5

--- Exercise 6


--- Exercise 7
