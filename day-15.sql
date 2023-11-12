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

--- exercise 6: cast data timestamp as time để tính minutes
with suspect_cte as
(select 
  merchant_id,
  credit_card_id,
  (t2 - t1)::time as interval
FROM
(SELECT 
  merchant_id,
  credit_card_id,
  transaction_timestamp::time as t1,
  lead(transaction_timestamp::time) 
      OVER(PARTITION BY merchant_id, credit_card_id, amount) as t2
FROM transactions) as time
where t2 is not null)

select 
  COUNT(*) as payment_count
from suspect_cte
where interval <= '00:10:00'

--- exercise 7: giong b2.day-13, không dùng window function cho sum(spend) được vì không order by được
with cte_spend as
(
SELECT 
  category,
  product,
  SUM(spend) as total_spend,
  rank() OVER(PARTITION BY category ORDER BY sum(spend) DESC) as ranking
FROM product_spend
where EXTRACT(year from transaction_date) = '2022'
GROUP BY category, product
)

select
	category,
	product,
	total_spend
from cte_spend
where ranking <= 2

--- exercise 8
with song_cte AS
(
select 
  artist_name,
  dense_rank() over(ORDER BY COUNT(c.song_id) desc) as artist_rank
FROM artists a
JOIN songs b on a.artist_id = b.artist_id
JOIN global_song_rank c on b.song_id = c.song_id
where c.rank <= 10
GROUP BY artist_name
)

SELECT
  artist_name,
  artist_rank
FROM song_cte
WHERE artist_rank <= 5
