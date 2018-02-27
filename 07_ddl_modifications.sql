-- Question 1
CREATE TABLE MemberCategories
	(MemberCategory nvarchar(2),
	MemberCatDescription nvarchar(200)
	
	PRIMARY KEY(MemberCategory)
	)

DROP TABLE MemberCategories

-- Question 2
INSERT INTO MemberCategories
VALUES ('A', 'Class A Members')

INSERT INTO MemberCategories
VALUES ('B', 'Class B Members')

INSERT INTO MemberCategories
VALUES ('C', 'Class C Members')

-- Question 3
CREATE TABLE GoodCustomers
	(
	CustomerName nvarchar(50) not null,
	Address nvarchar(65),
	PhoneNumber nvarchar(9) not null,
	MemberCategory nvarchar(2),
	PRIMARY KEY (CustomerName, PhoneNumber),
	FOREIGN KEY (MemberCategory) REFERENCES MemberCategories(MemberCategory)
	)

-- Question 4
INSERT INTO GoodCustomers
	(CustomerName, PhoneNumber, MemberCategory)
	SELECT CustomerName, PhoneNumber, MemberCategory
	FROM Customers
	WHERE MemberCategory IN ('A','B')

-- Question 5
INSERT INTO GoodCustomers
	(CustomerName, PhoneNumber, MemberCategory)
	VALUES ('Tracy Tan', 736572, 'B')

-- Question 6
INSERT INTO GoodCustomers
VALUES ('Grace Leong', '15 Bukit Purmei Road, Singapore 0904', 278865, 'A')

-- Question 7
INSERT INTO GoodCustomers
VALUES ('Lynn Lim', '15 Bukit Purmei Road, Singapore 0904', 278865, 'P')

-- Question 8
UPDATE GoodCustomers
SET Address = '22 Bukit Purmei Road, Singapore 0904'
WHERE CustomerName = 'Grace Leong'

-- Question 9
UPDATE GoodCustomers
SET MemberCategory = 'B'
WHERE CustomerName IN
	(SELECT CustomerName
	FROM Customers
	WHERE CustomerID = 5108)

-- Question 10
DELETE FROM GoodCustomers
WHERE CustomerName = 'Grace Leong'

-- Question 11
DELETE FROM GoodCustomers
WHERE MemberCategory = 'B'

-- Question 12
ALTER TABLE GoodCustomers
ADD FaxNumber nvarchar(25)

-- Question 13
ALTER TABLE GoodCustomers
ALTER COLUMN Address nvarchar(80)

-- Question 14
ALTER TABLE GoodCustomers
ADD ICNumber nvarchar(10)

-- Question 15
CREATE UNIQUE INDEX ICIndex
ON GoodCustomers(ICNumber)
/* Can't create because duplicate keys found */

-- Question 16
CREATE INDEX FaxIndex
ON GoodCustomers(FaxNumber)

-- Question 17
DROP INDEX FaxIndex ON GoodCustomers

-- Question 18
ALTER TABLE GoodCustomers
DROP COLUMN FaxNumber

-- Question 19
DELETE FROM GoodCustomers

-- Question 20
DROP TABLE GoodCustomers

-- For Previewing
SELECT * FROM MemberCategories
SELECT * FROM GoodCustomers