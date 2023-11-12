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
with cte_transactions AS
(
SELECT
  transaction_date,
  user_id,
  COUNT(spend) OVER(PARTITION BY user_id order by transaction_date DESC) as count,
  row_number() over(PARTITION BY user_id order by transaction_date DESC) as ranking
FROM user_transactions
)

select transaction_date,
  user_id,
  count as purchase_count
from cte_transactions
where ranking = 1
order by transaction_date;

--- exercise 5: 3 days rolling = trung bình 3 ngày trước đó
WITH cte_count AS
(SELECT 
  user_id,
  tweet_date,
  COALESCE(two,'0') as a,
  COALESCE(one, '0') as b,
  tweet_count as today
FROM 
  (SELECT 
    user_id,
    tweet_date,
    lag(tweet_count,2) over(partition by user_id) as two,
    lag(tweet_count,1) over(partition by user_id) as one,
    tweet_count
  FROM tweets) as cte_tweet)

SELECT
  user_id,
  tweet_date,
  (CASE 
    when a = 0 and b = 0 then ROUND(today::decimal,2)
    when a = 0 then ROUND((b+today)/2::decimal,2)
    else ROUND((a+b+today)/3::decimal,2)
  END) as rolling_avg_3rd
FROM cte_count

--- exercise 6: khos quas khujkhuj

--- exercise 7

