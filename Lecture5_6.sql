-- Create Table
CREATE TABLE GoodCustomers
	(CustomerID nvarchar(4) not null,
	 CustomerName nvarchar(50) not null,
	 Address nvarchar(65) not null,
	 PhoneNumber nvarchar(9),
	 MemberCategory nvarchar(2) not null,
	 PRIMARY KEY (CustomerID,MemberCategory))


-- CREATE TABLE (with foreign key definition)
CREATE TABLE ProducerWebSite1
	(Producer nvarchar(50) not null,
	 WebSite varchar(200) not null,
	 PRIMARY KEY(Producer),
	 FOREIGN KEY(Producer)
		REFERENCES Producers(Producer))
		-- References Producer column in the Producers table

/* As-is, this query will fail, until you set the producer column in Producers to a primary key */


-- CREATE TABLE
/* Allows you to define your own contraint name. If not, SQL will auto-generate one for you */
CREATE TABLE ProducerWebSite2
	(Producer nvarchar(50) not null,
	WebSite varchar(200) not null,
	PRIMARY KEY(Producer),
	CONSTRAINT ProducerWS_FK_1	FOREIGN KEY (Producer) 
								REFERENCES Producers(Producer))
	-- The only difference with the previous example is the 'CONSTRAINT' syntax
	-- These constraints appear in the Keys submenu in Object Explorer

DROP TABLE ProducerWebSite2

-- Single-Row Insert (With Column Names)
INSERT INTO GoodCustomers
(CustomerID, CustomerName, Address)
VALUES (9000, 'Grace Leong', '15 Bukit Purmei Road, Singapore 0904')


-- Insert using a Query (INSERT INTO... SELECT... FROM...)
INSERT INTO GoodCustomers (CustomerID,CustomerName,Address,PhoneNumber,MemberCategory)
	SELECT
		CustomerID,CustomerName,Address,PhoneNumber,
		MemberCategory
	FROM Customers
	WHERE MemberCategory in ('A','B')


-- Create Index
CREATE UNIQUE INDEX Cust_idx ON
	Customers(CustomerName)
	-- Index the CustomerName column in Customers table

/* Sample query to access Customers
SELECT *
FROM Customers
WHERE CustomerName = 'Lou Anna Tan'
*/

CREATE UNIQUE INDEX gdCust_idx ON
	GoodCustomers(CustomerID, CustomerName)

CREATE INDEX Cust_idx ON Customers(Address)
-- Creates a non-unique index

-- Drop Table
DROP INDEX Cust_idx ON GoodCustomers

-- Validity Checking Constraint
CREATE TABLE StockAdjustment1
	(VideoCode smallint not null,
	AdjustmentQty int,
	DateAdjusted DateTime,
	WhoAdjust nvarchar(20),
	AdjustReason nvarchar(50),
	CONSTRAINT Con_VideCode CHECK(VideoCode BETWEEN 0 AND 99999))

/* Check constraint */
INSERT INTO StockAdjustment1
(VideoCode)
VALUES (9000)

SELECT * FROM StockAdjustment1


-- Referential Integrity Constraint
CREATE TABLE Movies1
	(VideoCode smallint not null,

	PRIMARY KEY(VideoCode))

CREATE TABLE IssueTran1
	(TransactionID smallint not null,
	VideoCode smallint not null,

	PRIMARY KEY(TransactionID),
	FOREIGN KEY(VideoCode) REFERENCES Movies1(VideoCode))