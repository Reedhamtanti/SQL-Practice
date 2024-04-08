/*1.	Create one more table named “TotalSalesByCustomer” and add data of each customer and their total amount of Purchase
For example, if customer id 3001 has 2 orders placed in order table, 1st order has purch amount 100 and 2nd order has purch amount 200 then “TotalSalesByCustomer” table will have 3001 and total amount 300. Update the table accordingly with existing data given in Exercise 1.
*/

CREATE TABLE TotalSalesByCustomer 
(
customer_id int PRIMARY KEY,
totalpurchaseamount  int 
)


INSERT INTO TotalSalesByCustomer
SELECT customer_id, SUM(purch_amt)
from orders
Group by customer_id
order by customer_id, SUM(purch_amt) ASC;


SELECT * FROM TotalSalesByCustomer;

/*2.	Create a trigger on Order table after insert, update “TotalSalesByCustomer” table, if the customer is already existing on this table, update the totalamount and if that customer is new then insert that customer information.
For example, if the new record on Order table is for customer 3001 with purchase amount 100, update “TotalSalesByCustomer” table and add 100 on the total amount for the customer 3001.
*/


USE Inventory;
GO
DROP TRIGGER if exists UpdatePurchamount 
GO 
CREATE TRIGGER UpdatePurchamount
  ON orders
  AFTER INSERT
AS
BEGIN
  UPDATE TotalSalesByCustomer
    SET totalpurchaseamount = totalpurchaseamount + (SELECT purch_amt FROM inserted Where TotalSalesByCustomer.customer_id = inserted.customer_id) where TotalSalesByCustomer.customer_id IN (Select customer_id from inserted);
	END


INSERT INTO orders VALUES (70015, 27 , '2015-09-10' , 3001 , 5005);



--3.	Create a store procedure which returns data of customer who placed 2 or more orders.


DROP PROCEDURE IF EXISTS displaycustomerdatafortwoormoreorders
GO
CREATE PROCEDURE displaycustomerdatafortwoormoreorders
AS
;WITH MORE_ORDER AS(
	SELECT o.order_no,o.purch_amt,o.ord_date,o.customer_id,o.salesman_id,c.cust_name,c.city,c.grade,
	ROW_NUMBER() over ( 
	partition by c.customer_id, c.cust_name, c.city
	order by o.customer_id) ROW_NUM 
	from orders as o
	join customer as c
	on c.customer_id = o.customer_id 
	)
	SELECT * from MORE_ORDER
	where ROW_NUM >= 2;


EXEC displaycustomerdatafortwoormoreorders;


--4.	Create a store procedure which returns data of order and customer. Use join to join orders and customer table. We need to provide order ID as parameter.

DROP PROCEDURE IF EXISTS displayorderandcustomerdata_orderno
GO
CREATE PROCEDURE displayorderandcustomerdata_orderno
@order_no INT
AS
SELECT c.customer_id,c.cust_name,c.city,c.grade,o.order_no,o.ord_date,o.purch_amt,o.salesman_id FROM customer AS c 
JOiN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_no = @order_no


EXEC displayorderandcustomerdata_orderno 70001;


--5.	Create a user defined function which will accept customerId as input and will return customer name.

CREATE FUNCTION customer_name (@customer_id int)
RETURNS varchar(50)
AS 
BEGIN 
	DECLARE @ret varchar(50);
	SELECT @ret = cust_name 
	FROM customer  
	WHERE customer_id = @customer_id;
	return @ret 
END;

Select dbo.customer_name(3002) as customername;



