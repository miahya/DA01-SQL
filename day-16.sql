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

--- exercise 4


--- exercise 5


--- exercise 6


--- exercise 7


--- exercise 8


