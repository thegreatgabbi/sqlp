-- Question 17
/* Prepare a list of customer ids and the number of orders made by the customers. */
SELECT CustomerID, count(*)
FROM Orders
GROUP BY CustomerID

-- Question 18
/* Retrieve company name for the customer id ‘BONAP’, and also order ids made by him. */
SELECT c.CompanyName, o.OrderID
FROM Orders o, Customers c
WHERE c.CustomerID = 'BONAP'

-- Question 19a
/* Retrieve the number of orders made, IDs and company names of all customers that have made more than 10 orders. The retrieved list should be display in the descending order of ‘number of orders made’. */
SELECT count(*) AS NumOfOrders, o.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING count(*) > 10
ORDER BY NumOfOrders DESC

-- Question 19b
/* Retrieve the number of orders made, IDs and company names for the customer with customer id ‘BONAP’. */
SELECT count(*) AS NumOfOrders, o.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING o.CustomerID = 'BONAP'

-- Question 19c
/* Retrieve the number of orders made, IDs and company names of all customers that have more orders than customer with customer id ‘BONAP’. */
SELECT count(*) AS NumOfOrders, o.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING count(*) > 
	(SELECT count(*)
	 FROM Orders
	 WHERE CustomerID = 'BONAP')

-- Question 20a
/* Prepare a Product list belonging to Beverages and Condiments categories (you may use in your SQL statement Categories Codes 1 and 2). The list should be sorted on Product code and Product Name. */
SELECT *
FROM Products
WHERE CategoryID in ('1','2')
ORDER BY ProductID, ProductName

-- Question 20b
/* How would the above query change if you are not provided category codes but only the names "Beverages", "Condiments" for retrieval. Would this require a join or subquery? */
SELECT *
FROM Products p, Categories c
WHERE p.CategoryID = c.CategoryID
AND CategoryName in ('Beverages', 'Condiments')

-- Question 21a
/* How many employees do we have in our organization? */
SELECT count(*) as NumberOfEmployees
FROM Employees

-- Question 21b
/* How many employees do we have in USA? */
SELECT count(*)
FROM Employees
WHERE Country = 'USA'

-- Question 22
/* Retrieve all details of Orders administered by persons who hold the designation Sales Representative and shipped by United Package. */
SELECT *
FROM Orders o, Employees e, Shippers s
WHERE o.EmployeeID = e.EmployeeID
AND o.ShipVia = s.ShipperID
AND e.Title = 'Sales Representative'
AND s.CompanyName = 'United Package'
ORDER BY o.OrderID

-- Question 23
/* Retrieve the names of all employee. For each employee list the name of his/her manager in adjacent columns. */
SELECT CONCAT(staff.FirstName, ' ', staff.LastName) as StaffName,
	CONCAT(supervisor.FirstName, ' ', supervisor.LastName) as SupervisorName
FROM Employees staff, Employees supervisor
WHERE staff.ReportsTo = supervisor.EmployeeID

-- Question 24
/* Retrieve the five highest ranking discounted product. "Discounted Product" indicates products with the total largest discount (in dollars) given to customers. */
SELECT TOP 5 p.ProductName, SUM(ROUND((od.UnitPrice * od.Quantity * od.Discount), 2)) as TotalDiscount
FROM Products p, [Order Details] od
WHERE p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalDiscount DESC

-- Question 25
/* Retrieve a list of Northwind’s Customers (names) who are located in cities where there are no suppliers. */
SELECT c.CompanyName
FROM Customers c LEFT OUTER JOIN Suppliers s
ON c.City = s.City
WHERE s.City IS null
AND c.City IS NOT null

-- Question 26
/* List all those cities that have both Northwind’s Supplier and Customers. */
SELECT DISTINCT c.City
FROM Customers c, Suppliers s
WHERE c.City = s.City

-- Question 27a
/* Northwind proposes to create a mailing list of its business associates. The mailing list would consist of all Suppliers and Customers collectively called Business Associates here. The details that need to be captured are the Business Associates' Names, Address and Phone. */
SELECT CompanyName, Address, Phone FROM Suppliers UNION
SELECT CompanyName, Address, Phone FROM Customers

-- Question 27b
/* Is it possible for you to add on to the same list Northwind's Shippers also. Since we do not have address of shippers, it is sufficient only phone is included leaving the address column blank. */
SELECT CompanyName, Address, Phone FROM Suppliers UNION
SELECT CompanyName, Address, Phone FROM Customers UNION
SELECT CompanyName, NULL as Address, Phone FROM Shippers -- example of aliasing

-- Question 28
/* Retrieve the manager’s name of the employee who has handled the order 10248. */
SELECT CONCAT(manager.FirstName, ' ', manager.LastName)
FROM Employees manager, Employees staff, Orders o
WHERE staff.ReportsTo = manager.EmployeeID
AND o.OrderID = '10248'
AND o.EmployeeID = staff.EmployeeID

-- Question 29
/* List the product name and product id with unit price greater than average unit product price. */
SELECT ProductName, ProductID
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- Question 30
/* List all the orders (order number and amount) that exceed $10000 value per order. Amount means Quantity*Price. */
SELECT o.OrderID, sum(od.Quantity * od.UnitPrice) as amount
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING sum(od.Quantity * od.UnitPrice) > 10000

-- Question 31
/* List all the orders that exceed $10000 value per order. Your list should include order number and customer id. */

SELECT o.OrderID, o.CustomerID, (od.Quantity * od.UnitPrice) AS Amount
FROM [Order Details] od, Orders o
WHERE o.OrderId = od.OrderId
AND od.Quantity * od.UnitPrice > 10000

-- Question 32
/* List all the orders that exceed $10000 value per order. Your list should include order number and customer id and customer name. */
SELECT o.OrderID, c.CompanyName, (od.Quantity * od.UnitPrice) AS Amount
FROM [Order Details] od, Orders o, Customers c
WHERE o.OrderId = od.OrderId
AND o.CustomerID = c.CustomerId
AND od.Quantity * od.UnitPrice > 10000

-- Question 33
/* List the total orders made by each customer. Your list should have customer id and Amount (Quantity * Price) for each customer. */
SELECT o.CustomerID, FORMAT(SUM(od.Quantity * od.UnitPrice), 'C') as Amount
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
GROUP BY o.CustomerID

-- Question 34
/* Retrieve the Average Amount of business that a northwind customer provides. The Average Business is total amount for each customer divided by the number of customer. */
SELECT FORMAT((
		(SELECT SUM(od.Quantity * od.UnitPrice) as Amount
		FROM Orders o, [Order Details] od
		WHERE o.OrderID = od.OrderID)
		/ 
		(SELECT COUNT(*)
		FROM Customers
	)), 'C')

-- Question 35
/* List all customers (Customer id, Customer name) who have placed orders more than the average business that a northwind customer provides. */

SELECT o.CustomerID, c.CompanyName, FORMAT(SUM(od.Quantity * od.UnitPrice), 'C') as Amount
FROM Orders o, [Order Details] od, Customers c
WHERE o.OrderID = od.OrderID
AND o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING SUM(od.Quantity * od.UnitPrice) > (
SELECT ROUND((
	(SELECT SUM(od.Quantity * od.UnitPrice) as Amount
	FROM Orders o, [Order Details] od
	WHERE o.OrderID = od.OrderID)
	/ 
	(SELECT COUNT(*)
	FROM Customers
	)), 2)
)

-- Question 36
/* List the total orders made by each customer. Your list should have customer id and Amount (Quantity * Price) for each customer in the year 1997. (Use year(orderdate) to retrieve the year of the column orderdate) */
SELECT o.CustomerID, FORMAT(SUM(od.Quantity * od.UnitPrice), 'C') as Amount
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
AND YEAR(o.OrderDate) LIKE '1997'
GROUP BY o.CustomerID