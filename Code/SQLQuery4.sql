--Simulasi Sales Transaction

--Customer CS010 ingin membeli 3 Classic Sandwich SW001 pada tanggal 20 Desember 2019 dilayani oleh Staff ST003 dan sandwich dibuat oleh Chef CH002

--INSERT DATA
INSERT INTO SALES VALUES('SH016','ST003','CS010','CH002','2019-12-20')

INSERT INTO SalesTransactionDetail VALUES('SH016','SW001',3)

--Simulasi Purchase Transaction

--Staff ST006 ingin membeli 5 Roti IG001 pada tanggal 19 November 2019 yang dijual oleh vendor VE007 

--INSERT DATA
INSERT INTO Purchase VALUES('PH016','ST006','VE007','2019-11-19')

INSERT INTO PurchaseTransactionDetail VALUES('PH016','IG001',5)