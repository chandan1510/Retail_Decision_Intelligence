# Data Quality Report

## 1. Dataset Overview

This project uses the **Online Retail transactional dataset** containing retail purchase records.

The original dataset is stored in:

`data/raw/online_retail.xlsx`

The cleaned and analytical datasets generated during the project are stored in:

`data/cleaned/`

The dataset contains transaction-level information such as:

- Invoice number
- Stock code
- Product description
- Quantity
- Invoice date
- Unit price
- Customer ID
- Country

---

## 2. Data Quality Objectives

The data quality assessment was performed to ensure that the dataset was suitable for:

- SQL business analysis
- Exploratory data analysis
- Product performance analysis
- Customer RFM segmentation
- Market Basket Analysis
- Sales forecasting
- Power BI dashboard development

The main areas considered were:

1. Dataset structure
2. Missing values
3. Transaction validity
4. Cancelled and returned transactions
5. Data types
6. Revenue calculation
7. Feature consistency
8. Analytical dataset preparation

---

## 3. Dataset Validation

The raw dataset was initially inspected to understand its structure, columns, data types, and overall record count.

The dataset contained:

**504,730 transaction records**

The row count was validated during the SQL analysis using:

```sql
SELECT COUNT(*) AS total_rows
FROM sales_data;

## 4. Missing Value Validation

Important fields were checked for missing values, particularly fields required for customer and sales analysis.

Customer ID completeness was validated using:

SELECT
    COUNT(*) AS total_rows,
    SUM(Customer_ID IS NULL) AS missing_customer_ids
FROM sales_data;

The validation showed:

Metric	Result
Total Rows	504,730
Missing Customer IDs	0

Customer-level analysis could therefore be performed without missing Customer IDs in the analyzed dataset.

## 5. Transaction Validation

Transaction records were examined to distinguish completed sales from cancelled or returned transactions.

Cancelled and returned transactions were not included in completed-sales revenue calculations.

They were analyzed separately to prevent cancelled or returned transactions from overstating:

- Revenue
- Units sold
- Completed orders
- Product performance

This distinction was maintained in the SQL analysis and downstream analytical workflow.

6. Revenue Validation

Revenue was derived from transaction-level sales information using quantity and unit price.

The general calculation used was:

Revenue = Quantity × Price

Revenue-related calculations were used consistently for:

- Product revenue analysis
- Country revenue analysis
- Monthly revenue analysis
- Customer monetary analysis
- Power BI revenue metrics
- Sales forecasting
## 7. Data Cleaning and Preparation

The data preparation workflow included:

- Inspecting the raw dataset
- Validating column structure
- Checking missing values
- Separating cancelled and returned transactions
- Preparing completed-sales data
- Creating revenue-related fields
- Creating time-based features
- Preparing customer-level datasets
- Preparing product-level analytical datasets

The resulting cleaned datasets were stored in:

data/cleaned/

## 8. Feature Engineering

Additional analytical features were created to support downstream analysis.

These features were used for:

- Monthly revenue analysis
- Product performance analysis
- Customer analysis
- RFM segmentation
- Sales forecasting
- Power BI dashboard development

The main feature-engineered dataset is:

data/cleaned/sales_features.csv

## 9. Analytical Datasets

The project generated the following cleaned and analytical datasets:

Dataset	Purpose
sales_data.csv	Cleaned transactional sales data
sales_features.csv	Feature-engineered sales dataset
customer_data.csv	Customer-level analytical data
customer_rfm.csv	Customer RFM segmentation
sales_forecast.csv	Revenue forecasting results
abc_inventory.csv	ABC product classification
association_rules.csv	Market Basket Analysis results
10. Data Quality Checks by Analysis Stage
Analysis Stage	Main Data Quality Considerations
Sales Analysis	Valid transaction and revenue calculations
Product Analysis	Valid quantity and revenue values
Country Analysis	Consistent country information
Customer Analysis	Customer ID availability
RFM Analysis	Valid customer transaction history
Market Basket Analysis	Valid product and transaction relationships
Sales Forecasting	Consistent time-based revenue data
Power BI	Consistent analytical datasets and measures

## 11. Data Quality Outcome

After the validation and preparation process, the data was structured into analytical datasets suitable for SQL, Python, forecasting, and Power BI analysis.

The cleaned datasets provide a consistent foundation for:

- Business performance analysis
- Product prioritization
- Customer segmentation
- Market Basket Analysis
- Revenue forecasting
- Interactive dashboard reporting

## 12. Data Quality Limitations

The analysis is based on historical transaction data. Therefore:

- Historical data quality affects the reliability of analytical results.
- Forecast results depend on historical sales patterns.
- Customer segmentation reflects observed purchasing behavior within the available dataset.
- Cancelled and returned transactions are treated separately from completed sales analysis.

These limitations should be considered when interpreting the resulting business insights and forecasts.