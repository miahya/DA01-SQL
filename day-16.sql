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

--- exercise 2


--- exercise 3: c ơi, ngoài cách dùng lag(data) 7 ngày như vậy có cách nào cộng dữ liệu trong 1 khoảng thời gian nhanh hơn không ạ?
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

--- exercise 4
-- Write your PostgreSQL query statement below
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


--- exercise 6


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


