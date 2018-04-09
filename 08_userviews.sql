-- Question 1
CREATE VIEW Customer1998
	AS SELECT c.CustomerID, c.CompanyName as CustomerName, ode.ProductID, ode.ProductName
	FROM Customers c, [Order Details Extended] ode, Orders o
	WHERE o.OrderID = ode.OrderID
	AND o.CustomerID = c.CustomerID
	AND YEAR(o.OrderDate) = 1998

--CREATE VIEW Customer1998
--AS SELECT c.CustomerID, c.CompanyName, p.ProductID, p.ProductName
--FROM Customers c, Products p
--WHERE CustomerID IN (SELECT c.CustomerID
--	FROM Customers c, Orders o
--	WHERE c.CustomerID = o.CustomerID
--	AND YEAR(o.OrderDate) = 1998)

-- Question 2
SELECT c.CustomerName, c.ProductName, s.CompanyName as SupplierName
FROM Customer1998 c, Suppliers s, Products p
WHERE p.SupplierID = s.SupplierID
AND c.ProductID = p.ProductID

-- Question 3
SELECT CustomerName, COUNT(*) as NumProducts
FROM Customer1998
GROUP BY CustomerName

-- Question 4a
DROP VIEW TotalBusiness

CREATE VIEW TotalBusiness
AS SELECT c.CustomerID, SUM(od.UnitPrice * od.Quantity) as Amount
FROM Customers c, Orders o, [Order Details] od
WHERE c.CustomerID = o.CustomerID
AND o.OrderID = od.OrderID
GROUP BY c.CustomerID

-- Question 4b
SELECT SUM(Amount) / COUNT(Amount) AS AverageBusiness
FROM TotalBusiness

-- Test Query
SELECT * FROM Customer1998
SELECT * FROM TotalBusiness
