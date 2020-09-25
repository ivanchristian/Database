--1
SELECT CustomerName,
	   CustomerPhone
FROM Customer C,
	 Sales S,
	 SalesTransactionDetail STD
WHERE
	 C.CustomerId = S.CustomerId AND
	 S.SalesId = STD.SalesId AND
	 DATEPART(YEAR, S.SandwichTransactionDate) = 2019 AND
	 STD.SandwichQuantity > 3

--2
SELECT StaffName,
	   TransactionCount = COUNT(SalesId)
FROM Staff ST,
	 Sales S,
	 Customer C
WHERE ST.StaffId = s.StaffId AND
	  S.CustomerId = C.CustomerId AND
	  LEFT(CustomerName,1) = 'T' AND
	  DATEPART(MONTH, CustomerDOB) > 9
GROUP BY StaffName

--3
SELECT ChefName,
	   [Average Sandwich per Transaction] = AVG(STD.SandwichQuantity)
FROM Chef C,
	 Sales S,
	 SalesTransactionDetail STD
WHERE C.ChefId = S.ChefId AND
	  S.SalesId = STD.SalesId AND
	  ChefExperience LIKE 'Expert' OR ChefExperience LIKE 'Advance' 
GROUP BY ChefName
HAVING SUM(STD.SandwichQuantity) > 3

--4
SELECT [Vendor Code] = RIGHT(V.VendorId,3),
	   VendorName,
	   [Minimum Item Price] = MIN(I.IngredientPrice),
	   [Maksimum Item Price] = MAX(I.IngredientPrice)
FROM Vendor V,
	 Purchase P,
	 PurchaseTransactionDetail PTD,
	 Ingredient I
WHERE V.VendorId = P.VendorId AND
	  P.PurchaseId = PTD.PurchaseId AND
	  PTD.IngredientId = I.IngredientId AND
	  V.VendorEmail LIKE '%@gmail.com' OR V.VendorEmail LIKE '% % %'
GROUP BY V.VendorId,VendorName

--5
SELECT	[Staff Nickname] = LEFT(ST.StaffName,1) + RIGHT(ST.StaffName,1),
		StaffSalary
FROM Staff ST,
	 Sales S,
	 Customer C,
	 ( 
		SELECT [Average Salary] = AVG(StaffSalary)
		FROM Staff
	 )  
	 AS AVGSalary
WHERE ST.StaffId = S.StaffId AND
	  S.CustomerId = C.CustomerId AND
	  ST.StaffSalary > AVGSalary.[Average Salary] AND CustomerGender LIKE 'Female'

--6
SELECT CustomerName,
	   CustomerAge = DATEDIFF(YEAR, CustomerDOB, GETDATE()),
	   SandwichName,
	   STD.SandwichQuantity
FROM Customer C,
	 Sales S,
	 SalesTransactionDetail STD,
	 Sandwich SA,
	 (
		SELECT [Average Age] = AVG( DATEDIFF(YEAR, CustomerDOB, GETDATE()))
		FROM Customer CU
	 ) 
	 AS AA
WHERE C.CustomerId = S.CustomerId AND
	  S.SalesId = STD.SalesId AND
	  STD.SandwichId = SA.SandwichId AND
	  STD.SandwichQuantity > 5 AND
	  DATEDIFF(YEAR, CustomerDOB, GETDATE()) > AA.[Average Age]

--7
SELECT	Price = SA.SandwichPrice + MinimumPrice,
		SandwichName
FROM Sandwich SA,
	 SalesTransactionDetail STD,
	(
		SELECT MinimumPrice = MIN(SandwichPrice)
		FROM Sandwich SAND
	)	
	AS SQ
WHERE  SA.SandwichId = STD.SandwichId AND
	   SandwichName LIKE '% %'
GROUP BY SandwichName, SA.SandwichPrice + MinimumPrice
HAVING SUM(SandwichQuantity) BETWEEN 5 AND 25

--8
SELECT StaffName,
	   StaffSalary = 'Rp. ' + CAST(CAST(StaffSalary AS NUMERIC(11,2))AS VARCHAR),
	   Gender = LEFT(StaffGender,1)
FROM Staff ST,
	 (
		SELECT [AverageMaleSalary] = AVG(StaffSalary),
			   [MinimumMaleSalary] = MIN(StaffSalary)
		FROM Staff STF
		WHERE StaffGender LIKE 'MALE'
	 )
	 AS STA
WHERE StaffSalary BETWEEN STA.MinimumMaleSalary AND STA.AverageMaleSalary

--9
GO
CREATE VIEW [Staff Sales Statistic] AS
SELECT StaffName,
	   SandwichName,
	   SalesCount = COUNT(S.SalesId),
	   SalesTotal = SUM(SandwichQuantity)
FROM Staff ST,
	 Sales S,
	 SalesTransactionDetail STD,
	 Sandwich SA
WHERE ST.StaffId = S.StaffId AND
	  S.SalesId = STD.SalesId AND
	  STD.SandwichId = SA.SandwichId AND
	  SandwichName LIKE '% %' 
GROUP BY StaffName, SandwichName
HAVING SUM(SandwichQuantity) > 1

--10
GO
CREATE VIEW [Vendor Statistic] AS
SELECT VendorName,
	   [Price Range] = MAX(IngredientPrice) - MIN(IngredientPrice),
	   [Minimum Item Purchase] = MIN(PTD.IngedientQuantity),
	   [Maximum Item Purchase] = MAX(PTD.IngedientQuantity)
FROM Vendor V,
	 Purchase P,
	 PurchaseTransactionDetail PTD,
	 Ingredient I
WHERE V.VendorId = P.VendorId AND
	  P.PurchaseId = PTD.PurchaseId AND
	  PTD.IngredientId = I.IngredientId AND
	  VendorAddress NOT LIKE '%Gold%'
GROUP BY VendorName
HAVING  MAX(IngredientPrice) - MIN(IngredientPrice) > 0