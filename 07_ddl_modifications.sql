/* 1. Create a Table called MemberCategories with the following fields
MemberCategory nvarchar(2) MemberCatDescription nvarchar(200)
None of the fields above can be null. Set the MemberCategory as the Primary key. */
CREATE TABLE MemberCategories (
MemberCategory			nvarchar(2)		NOT NULL,
MemberCatDescription	nvarchar(200)	NOT NULL
PRIMARY KEY (MemberCategory)
)

/* 2. Add the following data into the MemberCategories Table... */
INSERT INTO MemberCategories
VALUES
('A', 'Class A Members'),
('B', 'Class B Members'),
('C', 'Class C Members')

/* 3. Create a Table called GoodCustomers with the following fields... */
CREATE TABLE GoodCustomers (
CustomerName		nvarchar(50)	NOT NULL,
Address				nvarchar(65),
PhoneNumber			nvarchar(9)		NOT NULL,
MemberCategory		nvarchar(2),
PRIMARY KEY(CustomerName, PhoneNumber),
FOREIGN KEY(MemberCategory) REFERENCES MemberCategories (MemberCategory)
)

/* 4. Insert into GoodCustomer all records form Customer table with corresponding fields except Address, which is to be left Null. Only Customers having Member Category ‘A’ or ‘B’ are good customers hence the table should be inserted only those records from the Customers table. */
INSERT INTO GoodCustomers
(CustomerName, PhoneNumber, MemberCategory)
SELECT CustomerName, PhoneNumber, MemberCategory
FROM Customers
WHERE MemberCategory IN ('A', 'B')

/* 5. Insert into GoodCustomers the following new customer... */
INSERT INTO GoodCustomers
(CustomerName, PhoneNumber, MemberCategory)
VALUES
('Tracy Tan', 736572, 'B')

/* 6. Insert into GoodCustomers table the following information for a new customer */
INSERT INTO GoodCustomers
VALUES
('Grace Leong', '15 Bukit Purmei Road, Singapore 0904', 278865, 'A')

/* 7. Insert into GoodCustomers table the following information for a new customer. This should not go through! */
INSERT INTO GoodCustomers
VALUES
('Lynn Lim', '15 Bukit Purmei Road, Singapore 0904', 278865, 'P')

/* 8. Change the Address of Grace Leong so that the new address is '22 Bukit Purmei Road, Singapore 0904' in GoodCustomers table. */
UPDATE GoodCustomers
SET Address = '22 Bukit Purmei Road, Singapore 0904'
WHERE CustomerName = 'Grace Leong'

/* 9. Change the Member Category to ‘B’ for customer whose Customer ID is 5108 in GoodCustomers table. */
UPDATE GoodCustomers
SET MemberCategory = 'B'
WHERE CustomerName in (SELECT CustomerName FROM Customers
						WHERE CustomerID = 5108)

/* 10. Remove Grace Leong from GoodCustomers table. */
DELETE FROM GoodCustomers
WHERE CustomerName = 'Grace Leong'

/* 11. Remove customers with ‘B’ member category in GoodCustomers table. */
DELETE FROM GoodCustomers
WHERE MemberCategory = 'B'

/* 12. Add column FaxNumber (nvarchar(25)) to GoodCustomers table. */
ALTER TABLE GoodCustomers
ADD FaxNumber nvarchar(25)

/* 13. Alter the column Address to nvarchar(80) in GoodCustomers table. */
ALTER TABLE GoodCustomers
ALTER COLUMN Address nvarchar(80)

/* 14. Add column ICNumber (nvarchar(10)) to GoodCustomers table. */
ALTER TABLE GoodCustomers
ADD ICNumber nvarchar(10)

/* 15. Create a unique index ICIndex on table GoodCustomers bases on ICNumber. Notice that the column ICNumber have no values. Can you create the unique index successfully? Why? */
CREATE UNIQUE INDEX gdCust_idx
ON GoodCustomers(PhoneNumber)

/* 16. Create an index on table GoodCustomers based on FaxNumber. */
CREATE INDEX gdCust_idx
ON GoodCustomers(FaxNumber)

/* 17. Drop the index created on FaxNumber. */
DROP INDEX gdCust_idx ON GoodCustomers

/* 18. Remove the column FaxNumber from GoodCustomer table. */
ALTER TABLE GoodCustomers
DROP COLUMN FaxNumber

/* 19. Delete all records from GoodCustomers. */
DELETE FROM GoodCustomers

/* 20. Drop the table GoodCustomers. */
DROP TABLE GoodCustomers