--- exercise 1
SELECT 
	EXTRACT(year from transaction_date) as year,
	product_id,
	spend as curr_year_spend,
	lag(spend) OVER(PARTITION BY product_id) as prev_year_spend,
	round((spend-lag(spend) OVER(PARTITION BY product_id))/lag(spend) OVER(PARTITION BY product_id)*100,2) AS yoy_rate
FROM user_transactions;

--- exercise 2
with cte_jpmorgan AS
(SELECT *,
rank() over(partition by card_name order by issue_month, issue_year) as ranking
FROM monthly_cards_issued)

select card_name, issued_amount
from cte_jpmorgan
where ranking = 1
ORDER BY issued_amount DESC;

--- exercise 3
WITH cte_transactions AS
(SELECT *,
RANK() over(PARTITION BY user_id order by transaction_date) as ranking
FROM transactions)

SELECT user_id, spend, transaction_date
from cte_transactions
where ranking = 3

--- exercise 4
