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

--- Exercise 6
--- Exercise 7
--- Exercise 8
--- Exercise 9
--- Exercise 10
