<img width="209" alt="image" src="https://github.com/user-attachments/assets/343ec296-c453-476c-9a45-0c8039d1a003" />

# Planet42Assesment
ETL Pipeline using pandas to pull data from an API and loading into MySql database

# ETL Pipeline - Customer Transactions

## Overview
This repository contains a Python-based ETL pipeline for extracting, transforming, and loading (ETL) customer transaction data into a MySQL database. The pipeline includes performance optimizations and data quality checks to ensure efficiency and data integrity.

## Prerequisites
Before running the pipeline, ensure you have the following installed:
- Python 3.8+
- Jupyter Notebook
- MySQL Server
- Required Python libraries:
  ```bash
  pip install pandas mysql-connector-python numpy concurrent.futures requests
  ```

## Repository Structure
- `SibongileChiwandireAssesment.ipynb`: Initial ETL pipeline without optimizations.
- `Optimized.ipynb`: Optimized ETL pipeline with performance enhancements and data validation.
- `Database.Schema.Table.sql`: SQL script to create the target database, schema and the table to load the data.
- `Queries.sql`: SQL queries to extract insights from the loaded data.
- `Optimizations.sql`: SQL queries to optimize the running of transactions in the database by improving query speed.
- `README.md`: Instructions for running the pipeline.

## Setting Up MySQL Database
1. Open MySQL and create a schema:
   ```sql
   CREATE SCHEMA Customer;
   ```
2. Create the `TransactionsOptimized` table:
   ```sql
   CREATE TABLE Customer.TransactionsOptimized (
       customer_id INT,
       product_id INT,
       transaction_amount DECIMAL(10,2),
       transaction_date DATETIME,
       transaction_category VARCHAR(50),
       total_transaction_value DECIMAL(15,2),
       product_category VARCHAR(50),
       spend_category VARCHAR(50),
       PRIMARY KEY (customer_id, product_id, transaction_date)
   );
   ```

## Running the ETL Pipeline
### 1. Running the Initial Pipeline
- Open `SibongileChiwandireAssesment.ipynb` in Jupyter Notebook.
- Run all cells to extract, transform, and load data into `Customer.Transactions`.

### 2. Running the Optimized Pipeline
- Open `Optimized.ipynb` in Jupyter Notebook.
- Run all cells to:
  - Process data in parallel.
  - Perform data quality checks.
  - Load data efficiently into `Customer.TransactionsOptimized`.

## Performance Optimizations
- **Parallel Processing:** Uses `ThreadPoolExecutor` for faster data loading.
- **Batch Processing:** Reduces database transactions to improve speed.
- **Indexing:** Applied indexes on frequently queried columns.
- **Data Quality Checks:**
  - No missing categories (`product_category`, `spend_category`).
  - No negative transaction amounts.
  - Logs discrepancies for monitoring.

## Querying Data for Insights
Run the queries in `queries.sql` to extract insights:
1. **Total Transactions per Product Category**:
   ```sql
   SELECT product_category, COUNT(*) AS total_transactions
   FROM Customer.TransactionsOptimized
   GROUP BY product_category;
   ```
2. **Top 5 Accounts by Total Transaction Value**:
   ```sql
   SELECT customer_id, SUM(total_transaction_value) AS total_value
   FROM Customer.TransactionsOptimized
   GROUP BY customer_id
   ORDER BY total_value DESC
   LIMIT 5;
   ```
3. **Monthly Spend Trends Over the Past Year**:
   ```sql
   SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month, SUM(transaction_amount) AS total_spend
   FROM Customer.TransactionsOptimized
   WHERE transaction_date >= NOW() - INTERVAL 1 YEAR
   GROUP BY month
   ORDER BY month;
   ```

## Handling Source Data Changes
- **Detecting Updates**: Implement Change Data Capture (CDC) using:
  - Timestamp comparisons.
  - Soft deletes or versioning.
- **Backdated Transactions**: Ensure updates by using `ON DUPLICATE KEY UPDATE`.

## Scaling the Solution
- **Parallel Data Ingestion**: Increase worker threads for processing.
- **Database Partitioning**: Use MySQL partitioning for better query performance.
- **Indexing**: Optimize indexes based on query patterns.

## Future Enhancements
- Automate ETL execution using AWS Lambda or Apache Airflow.
- Implement Change Data Capture for incremental updates.
- Improve logging and monitoring for pipeline health.

## Contact
For any queries, feel free to reach out or create an issue in this repository.


