
-- Question 1
/* a. List all details of all Shippers that the company is dealing with. */
SELECT *
FROM Shippers

/* b. List all details of Shippers with the output presented in ascending order of shipper names. */
SELECT *
FROM Shippers
ORDER BY CompanyName

-- Question 2
/* a. List all employees - you need to display only the details of their 
First Name, Last Name, Title, Date of birth and their city of residence. */
SELECT FirstName, LastName, Title, BirthDate, City
FROM Employees

/* b. Based on the designations (Titles) available in the employees table, can you extract the designation list? */
SELECT Title
FROM Employees

-- Question 3
/* Retrieve the details of all orders made on 19 May 1997 */
SELECT *
FROM Orders

-- Question 4
/* Retrieve details of all customers that are located in the cities of London or Madrid. */
SELECT *
FROM Customers
WHERE City
IN ('London','Madrid')

-- Question 5
/* List all customers (Customer number and names) who are located in UK. The list should be produced in alphabetical order of customer names. */
SELECT CustomerID, ContactName, Country
FROM Customers
WHERE Country='UK'
ORDER BY ContactName

-- Question 6
/* Provide a list of Orders (Order IDs and order dates) made by customer whose ID is ‘Hanar’. */
SELECT OrderID, OrderDate, CustomerID
FROM Orders
WHERE CustomerID='Hanar'

-- Question 7
/* List the fully Qualified Names of All Northwind Employees as a single column.
Fully qualified Names should look like this: Dr. Venkat Raman OR Ms Esther Tan, where Ms is the Title of courtesy Esther is first name and Tan is last name.
Hint: You may need to use string concatenation.

Is it possible that this is listed in alphabetical order of the last names?
*/
SELECT CONCAT(TitleOfCourtesy, ' ', FirstName, ' ', LastName) AS FullyQualifiedName
FROM Employees
ORDER BY LastName

-- Question 8
/* List all Orders (Order number and date) of the orders made by the Customer “Maison Dewey” (column: company name).
 Note: Maison Dewey is the name of the customer.
*/
SELECT OrderID, OrderDate
FROM Orders
WHERE CustomerID
IN (SELECT CustomerID, CompanyName FROM Customers WHERE CompanyName='Maison Dewey')

-- Question 9
/* Retrieve the details of all Products’ having the word “lager” in the product name.*/
SELECT *
FROM Products
WHERE ProductName LIKE '%lager%'

-- Question 10
/* Retrieve the Customer IDs and contact names of all customers who have yet to order any products. */
SELECT CustomerID, ContactName
FROM Customers
WHERE CustomerID
NOT IN (SELECT CustomerID FROM Orders)
AND
ContactName IS NOT NULL

-- Question 11
/* Display the average product price. */
SELECT ROUND(AVG(UnitPrice), 2)
FROM Products

-- Question 12
/* Prepare a list of cities where customers reside in. The list should not contain any duplicate cities. */
SELECT DISTINCT City
FROM Customers

-- Question 13
/* Retrieve the number of customers who has made orders. */
SELECT COUNT(DISTINCT CustomerID)
FROM Orders

-- Question 14
/* Retrieve the company name and phone number of customers that do not have any fax number captured. */
SELECT CompanyName, Phone, Fax
FROM Customers
WHERE Fax IS NULL

-- Question 15
/* Retrieve the total sales made. Assume sales is equal to unit price * quantity. */
SELECT FORMAT(SUM(UnitPrice * Quantity), 'C') AS TotalSales
FROM "Order Details"

-- Question 16
/* List order ids made by customer 'Alan Out' and 'Blone Coy’ */
SELECT OrderID
FROM Orders
WHERE CustomerID
IN (SELECT CustomerID FROM Customers WHERE CompanyName IN ('Alan Out', 'Blone Coy'))