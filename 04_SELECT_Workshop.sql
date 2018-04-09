/* 1a. List all details of all Shippers that the company is dealing with. */
SELECT *
FROM Shippers

/* 1b. List all details of Shippers with the output presented in ascending order of shipper
names. */
SELECT *
FROM Shippers
ORDER BY CompanyName

/* 2a. List all employees - you need to display only the details of their First Name, Last
Name, Title, Date of birth and their city of residence. */
SELECT FirstName, LastName, Title, BirthDate, City
FROM Employees

/* 2b. Based on the designations (Titles) available in the employees table, can you extract the
designation list? */
SELECT DISTINCT Title
FROM Employees

/* 3. Retrieve the details of all orders made on 19 May 1997 */
SELECT *
FROM Orders
WHERE OrderDate = '1997-05-19'

/* 4. Retrieve details of all customers that are located in the cities of London or Madrid. */
SELECT *
FROM Customers
WHERE City IN ('London', 'Madrid')

/* 5. List all customers (Customer number and names) who are located in UK. The list should be produced in alphabetical order of customer names. */
SELECT CustomerID, CompanyName
FROM Customers
WHERE Country = 'UK'
ORDER BY CompanyName

/* 6. Provide a list of Orders (Order IDs and order dates) made by customer whose ID is ‘Hanar’. */
SELECT OrderID, OrderDate
FROM Orders
WHERE CustomerID = 'HANAR'

/* 7. List the Fully Qualified Names of All Northwind Employees as a single column. Fully qualified Names should look like this: Dr. Venkat Raman OR Ms Esther Tan, where Ms is the Title of courtesy Esther is first name and Tan is last name. (Hint: You may need to use string concatenation).
  
  Is it possible that this is listed in alphabetical order of the last names? Yes.
*/
SELECT CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS 'Fully Qualified Name'
FROM Employees
ORDER BY LastName

/* 8. List all Orders (Order number and date) of the orders made by the Customer “Maison Dewey” (column: company name). Note: Maison Dewey is the name of the customer. */
SELECT o.OrderID, o.OrderDate
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
AND c.CompanyName = 'Maison Dewey'

/* 9. Retrieve the details of all Products having the word “lager” in the product name. */
SELECT *
FROM Products
WHERE ProductName LIKE '%lager%'

/* 10. Retrieve the Customer IDs and contact names of all customers who have yet to order any products. */
SELECT CustomerID, ContactName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID
						FROM Orders)

/* 11. Display the average product price. */
SELECT FORMAT(AVG(UnitPrice),'C') As 'AverageProductPrice'
FROM Products

/* 12. Prepare a list of cities where customers reside in. The list should not contain any duplicate cities. */
SELECT DISTINCT City
FROM Customers

/* 13. Retrieve the number of customers who has made orders. */
SELECT COUNT(DISTINCT CustomerID) AS 'CustomersWithOrders'
FROM Orders

/* 14. Retrieve the company name and phone number of customers that do not have any fax number captured. */
SELECT CompanyName, Phone
FROM Customers
WHERE Fax IS NULL

/* 15. Retrieve the total sales made. Assume sales is equal to unit price * quantity. */
SELECT FORMAT(SUM(UnitPrice * Quantity), 'C') AS TotalSales
FROM [Order Details]

/* 16. List order ids made by customer 'Alan Out' and 'Blone Coy’ */
SELECT o.OrderID
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
AND c.CompanyName IN ('Alan Out', 'Blone Coy')

/* 17. Prepare a list of customer ids and the number of orders made by the customers. */
SELECT CustomerID, COUNT(OrderID) AS 'NumOrders'
FROM Orders
GROUP BY CustomerID

/* 18. Retrieve company name for the customer id ‘BONAP’, and also order ids made by him. */
SELECT c.CompanyName, COUNT(OrderID) AS 'NumOrders'
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
AND o.CustomerID = 'BONAP'
GROUP BY c.CompanyName

/* 19a. Retrieve the number of orders made, IDs and company names of all customers that have made more than 10 orders. The retrieved list should be display in the descending order of ‘number of orders made’. */
SELECT COUNT(o.OrderID) AS 'NumOrdersMade', c.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) > 10

/* 19b. Retrieve the number of orders made, IDs and company names for the customer with customer id ‘BONAP’. */
SELECT COUNT(*) AS 'NumOrdersMade', o.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING o.CustomerID = 'BONAP'

/* 19c. Retrieve the number of orders made, IDs and company names of all customers that have more orders than customer with customer id ‘BONAP’. */
SELECT COUNT(*) AS 'NumOrdersMade', o.CustomerID, c.CompanyName
FROM Orders o, Customers c
WHERE o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
HAVING COUNT(*) > (SELECT COUNT(*)
					FROM Orders
					WHERE CustomerID = 'BONAP')

/* 20a. Prepare a Product list belonging to Beverages and Condiments categories (you may
use in your SQL statement Categories Codes 1 and 2). The list should be sorted on Product code and Product Name. */
SELECT *
FROM Products
WHERE CategoryID IN (1,2)
ORDER BY ProductID, ProductName

/* 20b. How would the above query change if you are not provided category codes but only the names "Beverages", "Condiments" for retrieval. Would this require a join or subquery? Both are possible.*/

-- Join
SELECT *
FROM Products p, Categories c
WHERE p.CategoryID = c.CategoryID
AND c.CategoryName IN ('Beverages', 'Condiments')
ORDER BY p.ProductID, p.ProductName

-- Subquery (better)
SELECT *
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories
		WHERE CategoryName IN ('Beverages', 'Condiments'))
ORDER BY ProductID, ProductName

/* 21a. How many employees do we have in our organization? */
SELECT *
FROM Employees

/* 21b. How many employees do we have in USA? */
SELECT *
FROM Employees
WHERE Country = 'USA'

/* 22. Retrieve all details of Orders administered by persons who hold the designation Sales Representative and shipped by United Package. */
SELECT *
FROM Orders o, Customers c, Shippers s
WHERE o.CustomerID = c.CustomerID
AND o.ShipVia = s.ShipperID
AND c.ContactTitle = 'Sales Representative'
AND s.CompanyName = 'United Package'

/* 23. Retrieve the names of all employee. For each employee list the name of his/her manager in adjacent columns. */
SELECT CONCAT(staff.FirstName, ' ', staff.LastName) AS 'EmployeeName',
		CONCAT(manager.FirstName, ' ', manager.LastName) AS 'ManagerName'
FROM Employees staff, Employees manager
WHERE staff.ReportsTo = manager.EmployeeID

/* 24. Retrieve the five highest ranking discounted product. "Discounted Product" indicates products with the total largest discount (in dollars) given to customers. */
SELECT TOP 5 p.ProductName, od.ProductID, FORMAT(SUM(od.Quantity * od.Discount), 'C') AS 'TotalDiscount'
FROM [Order Details] od, Products p
WHERE od.ProductID = p.ProductID
GROUP BY od.ProductID, p.ProductName
ORDER BY SUM(od.Quantity * od.Discount)

/* 25. Retrieve a list of Northwind’s Customers (names) who are located in cities where there are no suppliers. */
SELECT DISTINCT c.CompanyName
FROM Customers c LEFT OUTER JOIN Suppliers s
ON c.City = s.City
WHERE s.City IS NULL
AND c.City IS NOT NULL

/* 26. List all those cities that have both Northwind’s Supplier and Customers. */
SELECT DISTINCT c.City
FROM Customers c, Suppliers S
WHERE c.City = s.City

/* 27a. Northwind proposes to create a mailing list of its business associates. The mailing list would consist of all Suppliers and Customers collectively called Business Associates here. The details that need to be captured are the Business Associates' Names, Address and Phone. */
SELECT CompanyName AS 'AssociateName', Address, Phone FROM Suppliers UNION
SELECT CompanyName, Address, Phone FROM Customers

/* 27b. Is it possible for you to add on to the same list Northwind's Shippers also? Since we do not have address of shippers, it is sufficient only phone is included leaving the address column blank. */
SELECT CompanyName AS 'AssociateName', Address, Phone FROM Suppliers UNION
SELECT CompanyName, Address, Phone FROM Customers UNION
SELECT CompanyName, Address = NULL, Phone FROM Shippers

/* 28. Retrieve the manager’s name of the employee who has handled the order 10248. */
SELECT CONCAT(manager.FirstName, ' ', manager.LastName) AS ManagerName, o.OrderID
FROM Employees employee, Employees manager, Orders o
WHERE employee.ReportsTo = manager.EmployeeID
AND employee.EmployeeID = o.EmployeeID
AND o.OrderID = 10248

/* 29. List the product name and product id with unit price greater than average unit product price. */
SELECT ProductName, ProductID
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

/* 30. List all the orders (order number and amount) that exceed $10000 value per order. Amount means Quantity*Price. */
SELECT OrderID, Quantity
FROM [Order Details]
WHERE Quantity * UnitPrice > 10000

/* 31. List all the orders that exceed $10000 value per order. Your list should include order number and customer id. */
SELECT od.OrderID, od.Quantity, o.CustomerID
FROM Orders o, [Order Details] od
WHERE o.OrderID = od.OrderID
AND od.Quantity * od.UnitPrice > 10000

/* 32. List all the orders that exceed $10000 value per order. Your list should include order number and customer id and customer name. */
SELECT od.OrderID, od.Quantity, o.CustomerID, c.CompanyName
FROM Orders o, [Order Details] od, Customers c
WHERE o.OrderID = od.OrderID
AND o.CustomerID = c.CustomerID
AND od.Quantity * od.UnitPrice > 10000

/* 33. List the total orders made by each customer. Your list should have customer id and Amount (Quantity * Price) for each customer. */
SELECT o.CustomerID, FORMAT(SUM(od.Quantity * od.UnitPrice), 'C') As 'TotalOrders'
FROM [Order Details] od, Orders o
WHERE o.OrderID = od.OrderID
GROUP BY o.CustomerID

/* 34. Retrieve the Average Amount of business that a northwind customer provides. The Average Business is total amount for each customer divided by the number of customer. */
SELECT(
FORMAT(
(SELECT SUM(UnitPrice * Quantity) FROM [Order Details])
/
(SELECT COUNT(*) FROM Customers), 'C')
) AS 'AverageBusiness'

/* 35. List all customers (Customer id, Customer name) who have placed orders more than the average business that a northwind customer provides. */
SELECT c.CustomerID, c.CompanyName, FORMAT(SUM(od.UnitPrice * od.Quantity), 'C') AS 'TotalOrders'
FROM [Order Details] od, Customers c, Orders o
WHERE od.OrderID = o.OrderID
AND o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING SUM(od.UnitPrice * od.Quantity) > (SELECT(
								FORMAT(
								(SELECT SUM(UnitPrice * Quantity) FROM [Order Details])
								/
								(SELECT COUNT(*) FROM Customers), 'C')
								))

/* 36. List the total orders made by each customer. Your list should have customer id and Amount (Quantity * Price) for each customer in the year 1997. (Use year(orderdate) to retrieve the year of the column orderdate) */
SELECT o.CustomerID, FORMAT(SUM(od.Quantity * od.UnitPrice), 'C') As 'TotalOrders'
FROM [Order Details] od, Orders o
WHERE o.OrderID = od.OrderID
AND YEAR(o.OrderDate) = 1997
GROUP BY o.CustomerID