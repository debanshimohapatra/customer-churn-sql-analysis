# Customer Churn Analysis Using SQL

## Project Overview

This project analyzes customer churn using SQL and SQLite on a dataset of 7,043 telecom customers.

The analysis focuses on identifying customer groups with higher churn rates and understanding how churn varies across contract type, tenure, internet service, payment method, and support services.

## Objective

* Analyze overall customer churn.
* Identify customer segments with higher churn rates.
* Compare churn across different customer characteristics.
* Use SQL to generate business insights.

## Tools Used

* SQL
* SQLite
* Python
* Google Colab
* Pandas
* Matplotlib

## SQL Skills

* SELECT, WHERE, ORDER BY
* GROUP BY and aggregate functions
* CASE statements
* HAVING
* CTEs
* Subqueries
* Window functions and RANK()
* SQL Views
* Customer segmentation
* Churn-rate calculations
* Data-quality validation

## Key Findings

* Overall churn rate: **26.54%**
* Month-to-month contract churn rate: **42.71%**
* 0–12 months tenure churn rate: **47.44%**
* Fiber optic churn rate: **41.89%**
* Electronic check churn rate: **45.29%**
* Highest-risk segment identified: **Month-to-month + Fiber optic + No Online Security + No Tech Support — 60.70% churn**

## Visualizations

The project includes charts showing:

* Churn Rate by Contract
* Churn Rate by Tenure Group
* Churn Rate by Internet Service
* Top 10 High-Risk Customer Segments

## Project Structure

customer-churn-sql-analysis/
├── dataset/
│   └── Telco-Customer-Churn.csv
├── sql/
│   └── churn_analysis.sql
├── notebook/
│   └── Customer_Churn_SQL_Analysis.ipynb

## Conclusion

This analysis used SQL and SQLite to explore customer churn patterns across contract type, tenure, internet service, payment method, and customer support services.

The analysis identified several customer groups with substantially higher observed churn, particularly customers on month-to-month contracts and customers with shorter tenure.

The segmentation analysis also highlighted a high-risk group combining month-to-month contracts, fiber optic service, no online security, and no tech support.

These findings can help a business prioritize customer-retention efforts toward segments with higher observed churn.

> The findings represent associations observed in the dataset and should not be interpreted as proof that any individual factor directly causes churn.
