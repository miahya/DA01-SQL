--- exercise 1
SELECT 
	EXTRACT(year from transaction_date) as year,
	product_id,
	spend as curr_year_spend,
	lag(spend) OVER(PARTITION BY product_id) as prev_year_spend,
	round((spend-lag(spend) OVER(PARTITION BY product_id))/lag(spend) OVER(PARTITION BY product_id)*100,2) AS yoy_rate
FROM user_transactions;