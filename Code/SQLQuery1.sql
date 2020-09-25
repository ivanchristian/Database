CREATE DATABASE SandwEj

USE SandwEj

CREATE TABLE Staff(
StaffId CHAR(5) CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]'),
StaffName VARCHAR(50),
StaffGender VARCHAR(6),
StaffSalary NUMERIC,
StaffPhone VARCHAR(13)
PRIMARY KEY(StaffId)
)

CREATE TABLE Chef(
ChefId CHAR(5) CHECK(ChefId LIKE 'CH[0-9][0-9][0-9]'),
ChefName VARCHAR(50),
ChefExperience VARCHAR(100)
PRIMARY KEY(ChefId)
)

CREATE TABLE Customer(
CustomerId CHAR(5) CHECK(CustomerId LIKE 'CS[0-9][0-9][0-9]'),
CustomerName VARCHAR(50),
CustomerGender VARCHAR(6),
CustomerDOB DATE,
CustomerPhone VARCHAR(13),
PRIMARY KEY(CustomerId)
)

CREATE TABLE Vendor(
VendorId CHAR(5) CHECK(VendorId LIKE 'VE[0-9][0-9][0-9]'),
VendorName VARCHAR(50),
VendorAddress VARCHAR(100),
VendorPhone VARCHAR(13),
VendorEmail VARCHAR(50)
PRIMARY KEY(VendorId)
)

CREATE TABLE Ingredient(
IngredientId CHAR(5) CHECK(IngredientId LIKE 'IG[0-9][0-9][0-9]'),
IngredientName VARCHAR(50),
IngredientPrice NUMERIC,
PRIMARY KEY(IngredientId)
)

CREATE TABLE Sandwich(
SandwichId CHAR(5) CHECK(SandwichId LIKE 'SW[0-9][0-9][0-9]'),
SandwichName VARCHAR(50),
SandwichSauce VARCHAR(50),
SandwichPrice NUMERIC
PRIMARY KEY(SandwichId)
)

CREATE TABLE Purchase(
PurchaseId CHAR(5) CHECK(PurchaseId LIKE 'PH[0-9][0-9][0-9]'),
StaffId CHAR(5) REFERENCES Staff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
VendorId CHAR(5) REFERENCES Vendor(VendorId) ON UPDATE CASCADE ON DELETE CASCADE,
TransactionDate DATE,

PRIMARY KEY(PurchaseId)
)

CREATE TABLE Sales(
SalesId CHAR(5) CHECK(SalesId LIKE 'SH[0-9][0-9][0-9]'),
StaffId CHAR(5) REFERENCES Staff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
CustomerId CHAR(5) REFERENCES Customer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
ChefId CHAR(5) REFERENCES Chef(ChefId) ON UPDATE CASCADE ON DELETE CASCADE,
SandwichTransactionDate DATE,
PRIMARY KEY(SalesId)
)

CREATE TABLE PurchaseTransactionDetail(
PurchaseId CHAR(5) REFERENCES Purchase(PurchaseId) ON UPDATE CASCADE ON DELETE CASCADE,
IngredientId CHAR(5) REFERENCES Ingredient(IngredientId) ON UPDATE CASCADE ON DELETE CASCADE,
IngedientQuantity INT

PRIMARY KEY(PurchaseId, IngredientId)
)

DROP TABLE PurchaseTransactionDetail

CREATE TABLE SalesTransactionDetail(
SalesId CHAR(5) REFERENCES Sales(SalesId) ON UPDATE CASCADE ON DELETE CASCADE,
SandwichId CHAR(5) REFERENCES Sandwich(SandwichId) ON UPDATE CASCADE ON DELETE CASCADE,
SandwichQuantity INT

PRIMARY KEY(SalesId, SandwichId)
)

ALTER TABLE Customer
ADD CONSTRAINT validateGender CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female')

ALTER TABLE Customer
ADD CONSTRAINT validatePhone CHECK (LEN(CustomerPhone) = 12)

ALTER TABLE Vendor
ADD CONSTRAINT validateEmail CHECK (VendorEmail LIKE '%@%' AND VendorEmail LIKE '%.com' AND CHARINDEX('.', VendorEmail) != CHARINDEX('@', VendorEmail) + 1)

ALTER TABLE Sandwich
ADD CoNSTRAINT validatePrice CHECK (SandwichPrice BETWEEN 5000 AND 500000)

ALTER TABLE Sales
ADD CONSTRAINT validateSalesDate CHECK (SandwichTransactionDate <= GETDATE())

ALTER TABLE Purchase
ADD CONSTRAINT validatePurchaseData CHECK (TransactionDate <= GETDATE())

