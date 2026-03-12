---# E- COMMERCE DATA ANALYSIS #---

#1 ----Create Database -----
CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

#2 ----Create Tables -----
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
email VARCHAR(100),
city VARCHAR(50),
signup_date DATE
);

CREATE TABLE categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(50)
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category_id INT,
price INT
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount INT
);

CREATE TABLE order_items (
item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
price INT
);

CREATE TABLE payments (
payment_id INT PRIMARY KEY,
order_id INT,
payment_method VARCHAR(50),
payment_date DATE
);

#3 ---- Insert Sample Data ----
INSERT INTO customers VALUES
(1,'Arun','arun@gmail.com','Chennai','2024-01-01'),
(2,'Divya','divya@gmail.com','Bangalore','2024-01-05'),
(3,'Karthik','karthik@gmail.com','Hyderabad','2024-01-10'),
(4,'Priya','priya@gmail.com','Chennai','2024-02-01'),
(5,'Rahul','rahul@gmail.com','Mumbai','2024-02-15'),
(6,'Sneha','sneha@gmail.com','Delhi','2024-02-20'),
(7,'Vikram','vikram@gmail.com','Pune','2024-03-01'),
(8,'Anitha','anitha@gmail.com','Chennai','2024-03-05'),
(9,'Suresh','suresh@gmail.com','Bangalore','2024-03-07'),
(10,'Meena','meena@gmail.com','Hyderabad','2024-03-10');

INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Fashion'),
(3,'Home Appliances'),
(4,'Books'),
(5,'Sports');

INSERT INTO products VALUES
(101,'Laptop',1,60000),
(102,'Smartphone',1,30000),
(103,'Shoes',2,2000),
(104,'Microwave',3,8000),
(105,'T-shirt',2,1000),
(106,'Novel Book',4,500),
(107,'Cricket Bat',5,3000),
(108,'Headphones',1,2500),
(109,'Jeans',2,2500),
(110,'Mixer Grinder',3,4000);

INSERT INTO orders VALUES
(1001,1,'2024-03-01',62000),
(1002,2,'2024-03-02',30000),
(1003,3,'2024-03-03',2000),
(1004,1,'2024-03-05',8000),
(1005,4,'2024-03-07',1000),
(1006,6,'2024-03-10',500),
(1007,7,'2024-03-12',3000),
(1008,8,'2024-03-14',2500),
(1009,9,'2024-03-15',2500),
(1010,10,'2024-03-18',4000);

INSERT INTO order_items VALUES
(1,1001,101,1,60000),
(2,1001,103,1,2000),
(3,1002,102,1,30000),
(4,1003,103,1,2000),
(5,1004,104,1,8000),
(6,1005,105,1,1000),
(7,1006,106,1,500),
(8,1007,107,1,3000),
(9,1008,108,1,2500),
(10,1009,109,1,2500),
(11,1010,110,1,4000);

INSERT INTO payments VALUES
(1,1001,'Credit Card','2024-03-01'),
(2,1002,'UPI','2024-03-02'),
(3,1003,'Debit Card','2024-03-03'),
(4,1004,'UPI','2024-03-05'),
(5,1005,'Cash','2024-03-07'),
(6,1006,'UPI','2024-03-10'),
(7,1007,'Credit Card','2024-03-12'),
(8,1008,'Debit Card','2024-03-14'),
(9,1009,'UPI','2024-03-15'),
(10,1010,'Cash','2024-03-18');

#4 ---- Data Analysis Queries ----

--- Total Revenue ---
SELECT SUM(total_amount) AS total_revenue
FROM orders;

--- Top Selling Products ---
SELECT
p.product_name,
SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

--- Top Customers ---
SELECT
c.customer_name,
SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

--- Revenue by Category ---
SELECT
cat.category_name,
SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
JOIN categories cat ON p.category_id=cat.category_id
GROUP BY cat.category_name;

--- Payment Method Analysis ---
SELECT
payment_method,
COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method;

--- Customer Ranking (Window Function) ---
SELECT
customer_id,
SUM(total_amount) AS spending,
RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_position
FROM orders
GROUP BY customer_id;

--- Order Value Category (CASE Statement) ---
SELECT
order_id,
total_amount,
CASE
WHEN total_amount > 50000 THEN 'High Value'
WHEN total_amount > 10000 THEN 'Medium Value'
ELSE 'Low Value'
END AS order_type
FROM orders;

#5 ---- Create View ----
CREATE VIEW product_sales_summary AS
SELECT
p.product_name,
SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_name;

--- use view ---
SELECT * FROM product_sales_summary;

#6--- (Stored Procedure) Amount spent by customer ----

DELIMITER //

CREATE PROCEDURE GetCustomerSpending(IN cust_id INT)
BEGIN

SELECT 
c.customer_name,
SUM(o.total_amount) AS total_spending

FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id

WHERE c.customer_id = cust_id

GROUP BY c.customer_name;

END //

DELIMITER ;

CALL GetCustomerSpending(1);

--- Revenue by Category ---

DELIMITER //

CREATE PROCEDURE CategoryRevenue()
BEGIN

SELECT 
cat.category_name,
SUM(oi.quantity * oi.price) AS revenue

FROM order_items oi
JOIN products p 
ON oi.product_id = p.product_id

JOIN categories cat
ON p.category_id = cat.category_id

GROUP BY cat.category_name;

END //

DELIMITER ;

CALL CategoryRevenue();

#7 ---Trigger (Order Logging) log table ---
CREATE TABLE order_log (
log_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
action_time DATETIME
);

DELIMITER //

CREATE TRIGGER after_order_insert

AFTER INSERT ON orders

FOR EACH ROW

BEGIN

INSERT INTO order_log(order_id, action_time)
VALUES(NEW.order_id, NOW());

END //

DELIMITER ;

INSERT INTO orders
VALUES (10, 3, '2025-02-01', 15000);

Delete  from orders where  order_id =10;
Select * from orders;

#8 --- (FUNCTION) Calculate discount price ---
DELIMITER //

CREATE FUNCTION calculate_discount(price INT)
RETURNS INT
DETERMINISTIC

BEGIN

DECLARE discounted_price INT;

SET discounted_price = price - (price * 10 / 100);

RETURN discounted_price;

END //

DELIMITER ;

#--- use function ---
SELECT
product_name,
price,
calculate_discount(price) AS discounted_price
FROM products;

--- calculatate  total order value ---

DELIMITER //

CREATE FUNCTION order_category(amount INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN

DECLARE category VARCHAR(20);

IF amount > 50000 THEN
SET category = 'High Value';
ELSEIF amount > 10000 THEN
SET category = 'Medium Value';
ELSE
SET category = 'Low Value';
END IF;

RETURN category;

END //

DELIMITER ;

# --- use function ---
SELECT
order_id,
total_amount,
order_category(total_amount) AS order_type
FROM orders;

#9 --- (index) (Performance Optimization)---
CREATE INDEX idx_customer
ON orders(customer_id);

SELECT * 
FROM orders
WHERE customer_id = 3;

#10 --- Add Constraints (Data Quality) ----
ALTER TABLE products
ADD CONSTRAINT price_check
CHECK(price > 0);

#11 ---- Advanced Analytical Queries ----
--- Top 5 Customers by Spending ---
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

--- Monthly Revenue Trend ---
SELECT
MONTH(order_date) AS month,
SUM(total_amount) AS revenue
FROM orders
GROUP BY MONTH(order_date);

--- Most Popular Category ---
SELECT
c.category_name,
SUM(oi.quantity) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
JOIN categories c
ON p.category_id=c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;

--- Create Reporting Views (Customer Spending Report)---

CREATE VIEW customer_spending_report AS
SELECT
c.customer_name,
SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name;
--- use view ---
select * from customer_spending_report;

--- Best Selling Product ---
SELECT
p.product_name,
SUM(oi.quantity) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 1;


