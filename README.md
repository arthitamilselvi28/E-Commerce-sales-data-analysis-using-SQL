# E-Commerce-sales-data-analysis-using-SQL

## Project Overview

This project analyzes an E-Commerce database using SQL.

The database simulates a real e-commerce system including customers, products, orders, and payments. Using SQL queries, the project extracts useful business insights such as sales performance, customer behavior, and product demand.

---

##  Project Objectives

• Analyze customer purchasing behavior
• Identify top-selling products
• Track total revenue generated
• Understand payment method usage
• Demonstrate advanced SQL features used in real business analysis

---

##  Database Tables

###  Customers

Stores customer information.

Columns:

* customer_id
* customer_name
* email
* city

###  Products

Stores product details.

Columns:

* product_id
* product_name
* category
* price

###  Orders

Stores order information.

Columns:

* order_id
* customer_id
* order_date
* total_amount

###  Order_Items

Stores product-level order details.

Columns:

* order_item_id
* order_id
* product_id
* quantity
* price

###  Payments

Stores payment transaction details.

Columns:

* payment_id
* order_id
* payment_method
* payment_date

---

## SQL Concepts Used

### Beginner SQL

* SELECT
* WHERE
* ORDER BY
* DISTINCT
* LIMIT

### Intermediate SQL

* GROUP BY
* HAVING
* INNER JOIN
* LEFT JOIN
* Aggregate Functions (SUM, COUNT, AVG)
* Subqueries

### Advanced SQL

* Stored Procedures
* Triggers
* SQL Functions
* Data aggregation for business insights

---

##  Business Analysis Performed

### 1. Total Revenue Analysis

Calculates total revenue generated from all orders.

### 2. Customer Spending Analysis

Identifies customers who spend the most.

### 3. Product Sales Analysis

Determines the most sold products.

### 4. Payment Method Analysis

Analyzes which payment methods customers prefer.

### 5. Order Distribution

Counts the number of orders per customer.

These analyses simulate real-world data analysis tasks performed by data analysts in e-commerce companies.

---

##  Project Structure

Ecommerce-SQL-Analysis

database_schema.sql – Database and table creation
insert_data.sql – Sample data insertion
analysis_queries.sql – Business analysis queries
stored_procedures.sql – Stored procedures for analysis
triggers.sql – Trigger automation
functions.sql – SQL functions for calculations
README.md – Project documentation

---

##  Skills Demonstrated

• SQL Data Analysis
• Relational Database Design
• Data Aggregation and Reporting
• Business Insight Generation
• Advanced SQL Features

---

## Tools Used

SQL
MySQL
GitHub

---

## Real-World Relevance

This project demonstrates how SQL is used in real-world e-commerce data analysis.
Businesses use these types of queries to understand sales trends, customer behavior, and product performance to improve decision making.

---

