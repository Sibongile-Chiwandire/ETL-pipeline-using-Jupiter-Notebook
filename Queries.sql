#Insights from the data

#total transactions per product category
SELECT product_category,
       COUNT(*) AS total_transactions,
       SUM(transaction_amount) AS total_transaction_value
FROM Customer.Transactions
GROUP BY product_category
ORDER BY total_transaction_value DESC;

#top 5 accounts by total transaction value

SELECT customer_id,
       SUM(total_transaction_value) AS total_value
FROM Customer.Transactions
GROUP BY customer_id
ORDER BY total_value DESC
LIMIT 5;

#Monthly spend trends over the past year(empty as I only ingested data for one month,Jan 2023)

SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       SUM(transaction_amount) AS total_spend
FROM Customer.Transactions
WHERE transaction_date >= CURDATE() - INTERVAL 1 YEAR
GROUP BY month
ORDER BY month DESC;
