/*Q-1 */USE Inventory;

/*Q-2 */
CREATE TABLE salesman
(
salesman_id int PRIMARY KEY,
name varchar(50),
city varchar(50),
commission float
)

INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5001', 'James Hoog' , 'New York', '0.15');
INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5002', 'Nail Knite' , 'Paris', '0.13');
INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5005', 'Pit Alex' , 'London', '0.11');
INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5006', 'Mc Lyon' , 'Paris', '0.14');
INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5003', 'Lauson Hen' , '', '0.12');
INSERT INTO dbo.salesman (salesman_id, name, city, commission) VALUES ('5007', 'Paul Adam' , 'Rome', '0.13');





/*Q-4 */
CREATE TABLE customer
(
customer_id int PRIMARY KEY,
cust_name varchar(50),
city varchar(50),
grade int,
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id)
)


INSERT INTO customer VALUES (3002, 'Nick Rimando' , 'New York', 100 , 5001);

INSERT INTO customer VALUES (3005, 'Graham Zusi' , 'California', 200 , 5002);

INSERT INTO customer VALUES (3001, 'Brad Guzan' , 'London', '' , 5005);

INSERT INTO customer VALUES (3004, 'Fabian Johns' , 'Paris', 300 , 5006);

INSERT INTO customer VALUES (3007, 'Brad Davis' , 'New York', 200 , 5001);

INSERT INTO customer VALUES (3009, 'Geoff Camero' , 'Berlin', 100 , 5003);

INSERT INTO customer VALUES (3008, 'Julian Green' , 'London', 300 , 5002);

INSERT INTO customer VALUES (3003, 'Jozy Altidor' , 'Moscow', 200 , 5007);

/*Q-3 */

CREATE TABLE orders
(
order_no int PRIMARY KEY,
purch_amt float,
ord_date DATE,
customer_id int FOREIGN KEY REFERENCES customer(customer_id),
salesman_id int FOREIGN KEY REFERENCES salesman(salesman_id)
)


INSERT INTO orders VALUES (70001, 150.5 , '2012-10-05' , 3005 , 5002);

INSERT INTO orders VALUES (70009, 270.65 , '2012-09-10' , 3001 , 5005);

INSERT INTO orders VALUES (70002, 65.26 , '2012-10-05' , 3002 , 5001);

INSERT INTO orders VALUES (70004, 110.5 , '2012-08-17' , 3009 , 5003);

INSERT INTO orders VALUES (70007, 948.5 , '2012-09-10' , 3005 , 5002);

INSERT INTO orders VALUES (70005, 2400.6 , '2012-07-27' , 3007 , 5001);

INSERT INTO orders VALUES (70008, 5760 , '2012-09-10' , 3002 , 5001);

INSERT INTO orders VALUES (70010, 1983.43 , '2012-10-10' , 3004 , 5006);

INSERT INTO orders VALUES (70003, 2480.4 , '2012-10-10' , 3009 , 5003);


INSERT INTO orders VALUES (70012, 250.45 , '2012-06-27' , 3008 , 5002);

INSERT INTO orders VALUES (70011, 75.29 , '2012-08-17' , 3003 , 5007);


INSERT INTO orders VALUES (70013, 3045.6 , '2012-04-25' , 3002 , 5001);



/* Q-5  Update customer table to add column Called "Country". */


ALTER TABLE customer
ADD country varchar(50);
/*insert the values of country to the newly addded column in the customer table*/

UPDATE customer
SET country= 'Uk'
WHERE customer_id = 3001;

UPDATE customer
SET country= 'USA'
WHERE customer_id = 3002;

/*Write a sql statement to display all the information of all salesman*/

select * from Inventory..salesman;


/*Write a sql statement to display specific columns like name and commission for all the salesmen*/

select name,commission from Inventory..salesman;

/*Write a sql statement to display all the information of customer who lives in USA.*/

select * from customer where country = 'USA';


/*Write a sql statement to display all the information fo those customers with a grade of 200.*/

select * from customer where grade = 200;


/*write a sql statement to display information of salesman whose commission is greater than 0.12*/

select * from salesman where commission > 0.12;


/*write a sql statement to display order information where purchase amount is below 2000*/

select * from orders where purch_amt < 2000;


/* Update customer table to remove the column called Country.*/

ALTER TABLE customer
DROP COLUMN country;


/*Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city. */

SELECT s.name, c.cust_name , s.city as city
FROM Inventory..salesman as s
JOIN Inventory..customer as c
ON s.city = c.city;


/*Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000*/

SELECT o.order_no,o.purch_amt, c.cust_name , c.city as cities
FROM Inventory..orders as o
JOIN Inventory..customer as c
ON o.customer_id = c.customer_id
Where o.purch_amt >500 AND o.purch_amt < 2000;


/*Write a SQL statement to know which salesman are working for which customer(all cust with salman)*/

SELECT s.name , c.cust_name
FROM Inventory..salesman as s
JOIN Inventory..customer as c
ON s.salesman_id = c.salesman_id;


/*Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%*/

SELECT c.cust_name,s.name, s.commission*100 as commissionsinpercentage
FROM Inventory..customer as c
LEFT JOIN Inventory..salesman as s
ON c.salesman_id = s.salesman_id
where s.commission > 0.12;


/*Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own.*/

SELECT c.cust_name,s.name, c.grade
FROM Inventory..customer as c
LEFT JOIN Inventory..salesman as s
ON c.salesman_id = s.salesman_id
where c.grade < 300
order by grade ASC;

/*Operator */

/*Write a query to display all customers with a grade above 100*/

SELECT cust_name,grade from customer
where grade > 100;


/*Write a query statement to display all customers in New York who have a grade value above 100.  */

SELECT cust_name,grade,city from customer
where grade > 100 AND city='NEW YORK';


/* Write a SQL statement to display all customers, who are either belongs to the city New York or had a grade above 100.*/

SELECT cust_name,grade,city from customer
where grade > 100 OR city='NEW YORK';

/*Write a SQL statement to display either those orders which are not issued on date 2012-09-10 and issued by the salesman whose ID is 505 and below or those orders which purchase amount is 1000.00 and below.*/

SELECT order_no,ord_date,salesman_id,purch_amt from orders
where not ord_date='2012-09-10'
AND salesman_id <=5005
AND purch_amt <=1000.00;


/* Display all in reverse, where order dates are 2012-08-17 or customer id greater than 3005 and purchase amount is below 1000.*/


SELECT order_no,ord_date,customer_id,purch_amt from orders
where  ord_date='2012-08-17'
OR customer_id > 3005
AND purch_amt < 1000.00
order by order_no DESC;


/*Aggregate*/

/*Write a SQL statement to find the total purchase amount of all orders*/

SELECT SUM(purch_amt) as totalamount  
FROM orders;

/*Write a SQL statement to find the average purchase amount of all orders*/


SELECT AVG(purch_amt) as AVGamount  
FROM orders;

/*Write a SQL statement to find the number of salesmen currently listing for all of their customers*/
/*
SELECT  customer_id,COUNT(salesman_id) as listingsalesman  
FROM orders
GROUP BY customer_id
HAVING customer_id >3001;
*/

SELECT COUNT(DISTINCT salesman_id) from orders;


/*Write a SQL statement know how many customer have listed their names*/

SELECT count(customer_id) from customer;


/*Write a SQL statement to get the maximum purchase amount of all the orders*/

SELECT MAX(purch_amt) from orders;


/* Write a SQL statement to get the minimum purchase amount of all the orders*/
SELECT MIN(purch_amt) from orders;

/*Write a SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount*/

SELECT MAX(purch_amt), customer_id
from orders
Group by customer_id
order by customer_id, MAX(purch_amt) ASC;


/*Write a SQL statement to find the highest purchase amount with their ID and order date, for those customers who have a higher purchase amount in a day is within the range 2000 and 6000.*/

SELECT MAX(purch_amt) as highestpurchase, customer_id , ord_date
from orders
Group by ord_date , customer_id
HAVING MAX(purch_amt) BETWEEN 2000 AND 6000;

/*Write a query that counts the number of salesmen with their order date and ID registering orders for each day.*/

SELECT COUNT(s.salesman_id) as salesman, o.ord_date from salesman as s JOIN orders as o
ON s.salesman_id = o.salesman_id
group by ord_date;


/*Write a query to display the orders according to the order number arranged by ascending order. */

select * from orders 
order by order_no ASC;

/*Write a SQL statement to arrange the orders according to the order date in such a manner that the latest date will come first then previous dates*/

SELECT order_no,MAX(ord_date) FROM orders 
Group by order_no 
order by MAX(ord_date) DESC;


/*Write a SQL statement to display the orders with all information in such a manner that, the older order date will come first and the highest purchase amount of same day will come first*/


SELECT order_no,MAX(ord_date),MAX(purch_amt) FROM orders 
Group by order_no 
order by MAX(ord_date) ASC;
