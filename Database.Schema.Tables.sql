#creating database where the data will be loaded
CREATE DATABASE transactions_db;

USE transactions_db;

#creating a schema for the data
CREATE SCHEMA IF NOT EXISTS Customer;

#creating a table within the above schema and database,where the data will be loaded
CREATE TABLE Customer.Transactions (
    customer_id INT,
    product_id INT,
    transaction_amount DECIMAL(10, 2),
    transaction_date DATETIME,
    transaction_category VARCHAR(50),
    total_transaction_value DECIMAL(15, 2),
    product_category VARCHAR(50),
    spend_category VARCHAR(50)
);

