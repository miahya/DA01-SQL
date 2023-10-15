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

--- Exercise 4 (cứ báo lỗi hoài à huhu)

--- Exercise 5 (chọn id > lọc skill gồm 3 skill > group theo id ***nhưng tại sao lại có count huhu***)
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3;

--- Exercise 6
--- Exercise 7
--- Exercise 8
--- Exercise 9
--- Exercise 10
--- Exercise 11
--- Exercise 12

