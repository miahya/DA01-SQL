--- exercise 1
-- first order table > schdule and immediate > percentage: count(immediate)/count(first order)*100
with cte_delivery as
(select *
from
(select 
delivery_id, customer_id, order_date, customer_pref_delivery_date as prefer,
case 
    when order_date = customer_pref_delivery_date then 'immediate'
    else 'scheduled'
end as status,
row_number() over(partition by customer_id order by order_date) as ranking
from delivery) as status_table
where ranking = 1),
cte_count as
(select (select 
count(customer_id)
from cte_delivery
where status = 'immediate') as immediate_count,
count(*) as total_order
from cte_delivery)

select round(immediate_count::decimal / total_order::decimal * 100.00,2) as immediate_percentage
from cte_count

--- exercise 2: c cho em hỏi tại sao cách này lại sai được không ạ? em có xem hướng dẫn giải rồi nhưng không biết cách này khác ở đâu dẫn đến kqua bị lệch 0.01 ạ 
with cte_login as
(select 
    player_id, 
    min(event_date) over(partition by player_id) as first_login,
    lead(event_date) over(partition by player_id) as actual_next_day,
    case
        when lead(event_date) over(partition by player_id) - min(event_date) over(partition by player_id) = 1 then 'yes'
        else 'no'
    end as consecutive
from activity)

select 
round((select count(consecutive) as count from cte_login
    where consecutive = 'yes') / count(distinct player_id) * 1.00, 2) as fraction
from activity

--- exercise 3
with cte_seat as
(
select *,
row_number() over(order by id) as number
from seat
)

select id,
coalesce(case
            when number%2=0 then lag(student) over(order by id)
            else lead(student) over(order by id)
        end, student) as student
from cte_seat

--- exercise 4: c ơi, ngoài cách dùng lag(data) 7 ngày như vậy có cách nào cộng dữ liệu trong 1 khoảng thời gian nhanh hơn không ạ?
with cte_rolling as
(select
    visited_on,
    today+one+two+three+four+five+six as amount
from(select
    visited_on,
    total as today,
    lag(total, 1) over(order by visited_on) as one,
    lag(total, 2) over(order by visited_on) as two,
    lag(total, 3) over(order by visited_on) as three,
    lag(total, 4) over(order by visited_on) as four,
    lag(total, 5) over(order by visited_on) as five,
    lag(total, 6) over(order by visited_on) as six
from 
(select distinct visited_on,
        sum(amount) over(partition by visited_on) as total
		from customer
		order by visited_on
)) as rolling
where six is not null)

select
    visited_on,
    amount,
    round(amount*1.00/7,2) as average_amount
from cte_rolling
order by visited_on

--- exercise 5
with cte_location as
(select *,
count(*) as location
from insurance
group by lat, lon),
cte_value as
(select *,
count(tiv_2015) over(partition by tiv_2015) as value
from insurance)

select round(sum(a.tiv_2016),2) as tiv_2016
from cte_value a
left join cte_location b on a.pid = b.pid
where a.lat in (select lat from cte_location where location = 1)
and value <> 1

--- exercise 6
with cte_emp as
(select *,
dense_rank() over(partition by departmentID order by salary desc) as salary_ranking
from employee)

select b.name as department,
a.name as employee,
salary
from cte_emp a
left join department b on a.departmentId = b.id
where salary_ranking <= 3

--- exercise 7
select distinct
    first_value(person_name) over(order by turn desc) as person_name
from
(select
    turn,
    person_name,
    weight,
    sum(weight) over(order by turn) as total
from queue
order by turn) as turn_table 
where total <=1000

--- exercise 8
with cte_product as
(select product_id, new_price as price, change_date as date,
row_number() over(partition by product_id order by change_date desc) as rnumb
from products
where change_date <= '2019-08-16'
order by change_date)

select product_id, price
from cte_product
where rnumb = 1
union
select product_id, 10 as price
from products
where product_id not in (select product_id from cte_product)
order by product_id

*****
(select product_id, new_price as price
from products
where (product_id, change_date) In
    (select product_id, max(change_date) as latest
    from products
    where change_date <='2019-08-16'
    group by product_id))
UNION
(select product_id, 10 as price
from products
where product_id not in 
            (select distinct product_id 
            from Products 
            where change_date <='2019-08-16'))
order by product_id


