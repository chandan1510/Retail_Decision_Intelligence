CREATE DATABASE IF NOT EXISTS retail_db;

USE retail_db;

DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data (
    Invoice BIGINT,
    StockCode VARCHAR(50),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    Price DECIMAL(12,4),
    Customer_ID VARCHAR(30),
    Country VARCHAR(100)
);
