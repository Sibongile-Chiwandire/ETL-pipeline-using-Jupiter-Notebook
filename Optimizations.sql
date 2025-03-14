#Creating second table to test Optimization of the pipeline

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

Select * from Customer.TransactionsOptimized

#creating indexes on frequently queried columns(Query Optimization)
CREATE INDEX idx_customer_id ON Customer.TransactionsOptimized(customer_id);
CREATE INDEX idx_transaction_date ON Customer.TransactionsOptimized(transaction_date);
CREATE INDEX idx_product_category ON Customer.TransactionsOptimized(product_category);

#Composite Indexing: on columns that are frequently queried together 
CREATE INDEX idx_customer_transaction_value ON Customer.TransactionsOptimized(customer_id, total_transaction_value);

#Creating a Unique Constraint to ensure each (customer_id, product_id, transaction_date) is unique, to avoid duplicate records
ALTER TABLE Customer.TransactionsOptimized 
ADD CONSTRAINT pk_transactions PRIMARY KEY (customer_id, product_id, transaction_date);

