
-- Create a view that has following information, customer_id, cust_name, city, grade, salesman_id, salesman_name, Commission, Ord_no, purch_amt and ord_date

CREATE VIEW customerinfo AS 
SELECT c.customer_id,c.cust_name,c.grade,c.city,s.commission,s.name,s.salesman_id,o.order_no,o.ord_date,o.purch_amt FROM customer AS c JOIN 
salesman AS s ON c.salesman_id = s.salesman_id
JOIN orders AS o
ON o.salesman_id = s.salesman_id



SELECT * FROM customerinfo


--Create a Procedure to display the order information with the customer details to each order

DROP PROCEDURE IF EXISTS displayorderinfo
GO
CREATE PROCEDURE displayorderinfo
AS
SELECT c.customer_id,c.cust_name,c.city,c.grade,o.order_no,o.ord_date,o.purch_amt,o.salesman_id FROM customer AS c 
JOiN orders AS o
ON c.customer_id = o.customer_id


EXEC displayorderinfo



--Create a parameterised stored procedure which will take the customer_id as variable and will return all the information about that customer including salesman detail associate with that customer

DROP PROCEDURE IF EXISTS displayorderinfo_fromcustid
GO
CREATE PROCEDURE displayorderinfo_fromcustid
@customer_id INT

AS
SELECT c.customer_id,c.cust_name,c.city,c.grade,o.order_no,o.ord_date,o.purch_amt,o.salesman_id,s.city,s.name,s.commission FROM customer AS c 
JOiN orders AS o
ON c.customer_id = o.customer_id
JOin salesman AS s
ON c.salesman_id = s.salesman_id
WHERE c.customer_id = @customer_id


EXEC displayorderinfo_fromcustid 3001;


--Create a stored procedure that will return all the information about customer.

DROP PROCEDURE IF EXISTS displaycustomerinfo
GO
CREATE PROCEDURE displaycustomerinfo
AS
SELECT * FROM customer 

EXEC displaycustomerinfo;


--Create a stored procedure that will accept 1 parameter which is for salesmanid and display all the records for that salesman

DROP PROCEDURE IF EXISTS displaysalesmaninfo_fromSalesmanid
GO
CREATE PROCEDURE displaysalesmaninfo_fromSalesmanid
@salesman_id INT
AS
SELECT * FROM salesman
where salesman_id = @salesman_id

EXEC displaysalesmaninfo_fromSalesmanid 5001;


--Create Stored procedure that will accept 2 parameter, first City and second customerid. Update the table with provided value as city for the provided customer id in table
DROP PROCEDURE IF EXISTS updatecityandcutomerid
GO
CREATE PROCEDURE updatecityandcutomerid
  @city varchar(50),
  @customer_id INT,
  @Update INT = 0 -- If @Update = 1, perform update, else show what would be updated
AS
BEGIN
  IF @Update = 1
    UPDATE customer
      SET city = @city
      WHERE customer_id = @customer_id;
  ELSE
    SELECT * FROM customer
	where customer_id = @customer_id

END



EXEC updatecityandcutomerid @city= MINAMAR,@customer_id=3001,@Update=1;


--Display only Year from orderdate from Order table

SELECT YEAR(ord_date) AS YEARS FROM orders;


--Display order date in DDMMYYYY formate in order table

SELECT FORMAT (ord_date, 'ddMMMyyyy') as date FROM orders;


--Display only order that were made in January month only 

SELECT * FROM orders 
where MONTH(ord_date) = 01;

select * from orders where DATEPART(MM,ord_date)=01



--Display Order that were made between 15 to 30th date of any month from order table

SELECT * FROM orders 
where DAY(ord_date) BETWEEN 15 AND 30;


--Create Userdefined function which takes customerid as input and gives us total amount that customer spent in orders.

CREATE FUNCTION totalamout( @customer_id int)
RETURNS int 
AS 
BEGIN 
	DECLARE @ret int;
	SELECT @ret = SUM(purch_amt)
	FROM orders  
	WHERE customer_id = @customer_id
	IF(@ret IS NULL)
		SET @ret = 0;
	RETURN @ret;
END;


Select dbo.totalamout(3002);


--Create userdefined function which takes salesmanid as input and returns howmuch commission he is getting.
DROP FUNCTION IF EXISTS totalcommission
GO
CREATE FUNCTION totalcommission( @salesman_id int)
RETURNS float
AS 
BEGIN 
	DECLARE @ret int;
	SELECT @ret = commission * 100
	FROM salesman  
	WHERE salesman_id = @salesman_id
	IF(@ret IS NULL)
		SET @ret = 0;
	RETURN @ret;
END;



select dbo.totalcommission(5001);


--create userdefined function which takes orderid as input and returns who placed this order.

DROP FUNCTION IF EXISTS orderinfo
GO
CREATE FUNCTION orderinfo( @order_no int)
RETURNS varchar(50)
AS 
BEGIN 
	DECLARE @ret varchar(50);
	SELECT @ret = c.cust_name
	FROM customer  AS c
	JOin orders as o
	On o.customer_id = c.customer_id
	WHERE o.order_no = @order_no
	IF(@ret IS NULL)
		SET @ret = 0;
	RETURN @ret;
END;


SELECT dbo.orderinfo(70001);