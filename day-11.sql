----- PRACTICE
--- Exercise 1 (round down = floor)
select COUNTRY.Continent, floor(avg(CITY.Population))
from city
inner join country on CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;

--- Exercise 2

--- Exercise 3

--- Exercise 4 (vì category chỉ có đúng 3 loại đó nên không cần câu lệnh WHERE để specify, nếu nhiều hơn thì mới cần)
SELECT customer_id
FROM products
JOIN customer_contracts ON customer_contracts.product_id = products.product_id
## --- WHERE product_category IN ('Analytics', 'Containers', 'Compute')
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = 3;

--- Exercise 5

--- Exercise 6


--- Exercise 7
