USE [master]
GO
IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = N'RestaurantDB'OR name = N'RestaurantDB')))
DROP DATABASE RestaurantDB
 
CREATE DATABASE RestaurantDB
GO
 
USE RestaurantDB
GO
 
If OBJECT_ID('CustomerDetail')  IS NOT NULL
       DROP TABLE CustomerDetail
GO
 
If OBJECT_ID('TableDetail') IS NOT NULL
       DROP TABLE TableDetail
GO
 
If OBJECT_ID('CustodianDetail')  IS NOT NULL
       DROP TABLE CustodianDetail
GO 
 
 



CREATE TABLE CustodianDetail(
CustodianId VARCHAR(5) PRIMARY KEY  CHECK (CustodianId like 'C%'),
CustodianName VARCHAR(15),
Experience INT,
FeedbackCount INT CHECK (FeedbackCount <= 5)
)
GO
INSERT INTO CustodianDetail VALUES('C1011','Guru',5,5)
INSERT INTO CustodianDetail VALUES('C1010','John',3,4)


GO
CREATE TABLE TableDetail(
TableId VARCHAR(5) PRIMARY KEY  CHECK (TableId like 'T%'),
Accommodation INT CHECK (Accommodation >= 2) NOT NULL,
[Type] VARCHAR(10) CHECK ([Type] = 'GUEDON ' OR [Type] = 'SILVER '),
TableInchargeId VARCHAR(5) REFERENCES CustodianDetail(CustodianId)
)
GO

INSERT INTO TableDetail VALUES('T101',3,'SILVER','C1011')
INSERT INTO TableDetail VALUES('T102',3,'SILVER','C1010')

GO
CREATE TABLE CustomerDetail(
BookingId BIGINT PRIMARY KEY IDENTITY (10000,1),
BookingDate DATE  CHECK(BookingDate >= GETDATE()),
TableNumber VARCHAR(5) REFERENCES TableDetail(TableId),
CustomerName VARCHAR(10) not null,
Contact BIGINT CHECK (LEN(Contact)=10) ,
Duration INT  CHECK (Duration <= 6),
TotalSeats INT CHECK (TotalSeats <= 20) 
)
GO
INSERT INTO CustomerDetail VALUES ('2028/11/20','T101','Harry',9786986234,2,4)
INSERT INTO CustomerDetail VALUES ('2028/11/21','T102','Kelly',9786556217,1,2)
GO
