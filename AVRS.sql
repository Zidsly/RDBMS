CREATE DATABASE AVRS
--Create database that we will use

USE AVRS
--Using the database we have created

--Create table that we will insert in database
CREATE TABLE XUSER(	
	Nuser VARCHAR(50) NOT NULL, 
	NID INT NOT NULL PRIMARY KEY,
	Ulong FLOAT NOT NULL,
	Ulat FLOAT NOT NULL,
	Unumber BIGINT NOT NULL,
	Udate DATE NOT NULL
);

CREATE TABLE Vehicle(
	VID INT not null PRIMARY KEY,
	NID INT NOT NULL CONSTRAINT FKNID FOREIGN KEY REFERENCES XUSER (NID), 
	Vtype VARCHAR(11) not null,
	Vlong FLOAT not null,
	Vlat FLOAT not null,
	Vdate DATE not null
);

CREATE TABLE Destination(
	DID INT NOT NULL PRIMARY KEY, 
	NID INT NOT NULL CONSTRAINT FKNID2 FOREIGN KEY REFERENCES XUSER (NID), 
	VID INT NOT NULL CONSTRAINT FKNVID FOREIGN KEY REFERENCES Vehicle (VID), 
	XRange INT NOT NULL CHECK(XRange BETWEEN -1 and 2),
	Dlat FLOAT NOT NULL,
	Dlong FLOAT NOT NULL, 
	Dname Varchar(15) NOT NULL
);
 
CREATE TABLE Vcheckup(
	CID INT NOT NULL PRIMARY KEY,
	VID INT NOT NULL CONSTRAINT FKVID2 FOREIGN KEY REFERENCES Vehicle (VID),
	Cdate DATE NOT NULL,
	Cmotor INT NOT NULL CHECK (Cmotor BETWEEN -1 and 2),
	Cbattery INT NOT NULL CHECK (Cbattery BETWEEN -1 and 2),
	Cskeleton INT NOT NULL CHECK (Cskeleton BETWEEN -1 and 2),
	Cwheels INT NOT NULL CHECK (Cwheels BETWEEN -1 and 2),
	Cinterior INT NOT NULL CHECK (Cinterior BETWEEN -1 and 2)
);


CREATE TABLE Vprice(
   PID INT NOT NULL PRIMARY KEY,
   Mmotor MONEY NOT NULL,
   Mbattery MONEY NOT NULL,
   Mskeleton MONEY NOT NULL,
   Mwheels MONEY NOT NULL, 
   Minterior MONEY NOT NULL,
   Rprice MONEY NOT NULL
);

CREATE TABLE Vtransaction(	
	TID INT NOT NULL PRIMARY KEY,
	PID INT NOT NULL CONSTRAINT FKPID FOREIGN KEY REFERENCES Vprice (PID),
	NID INT NOT NULL CONSTRAINT FKNID3 FOREIGN KEY REFERENCES XUSER (NID),
	Tdate DATE NOT NULL,
	XRange TINYINT NOT NULL,
	CTotal	BIGINT NOT NULL,
	MTotal BIGINT NOT NULL,
	TPrice VARCHAR(10) NOT NULL
);


--Rule 
CREATE RULE rulVtype 
AS 
@Vtype in ('Sport','SUV','Convertible','Coupe','Hatchback','MPV','Sedan','Off-road','Truck','Van')
DROP RULE rulVtype 


--Display the table
SELECT *FROM XUSER
SELECT *FROM Vehicle
SELECT *FROM Destination
SELECT *FROM Vcheckup
SELECT *FROM Vprice
SELECT *FROM Vtransaction

--For Drop the table that have created 
DROP TABLE Vtransaction
DROP TABLE Vprice
DROP TABLE Vcheckup
Drop Table Destination
DROP TABLE Vehicle
DROP TABLE XUSER

--For drop the RULE that have created 
DROP RULE rulVtype 


--Trigger
CREATE TRIGGER REACT
ON [dbo].[XUSER] AFTER INSERT AS
BEGIN
PRINT 'New User Added'
END
RETURN
GO
CREATE TRIGGER REACT2
ON [dbo].[Vehicle] AFTER INSERT AS
BEGIN
PRINT 'New Vehicle Added'
END
RETURN
GO
CREATE TRIGGER REACT3
ON [dbo].[Destination] AFTER INSERT AS
BEGIN
PRINT 'New Destination Added'
END
RETURN
GO
CREATE TRIGGER REACT4
ON [dbo].[Vcheckup] AFTER INSERT AS
BEGIN
PRINT 'New Vcheckup Added'
END
RETURN
GO
CREATE TRIGGER REACT5
ON [dbo].[Vtransaction] AFTER INSERT AS
BEGIN
PRINT 'New Vtransaction has been processed '
END
RETURN

--Trigger Coordinate Reaction
CREATE TRIGGER RCOR
ON Destination
AFTER INSERT, UPDATE
AS
IF ( UPDATE (Dlat)) AND ( UPDATE (Dlong))
BEGIN
PRINT 'Destination coordinate injected'
UPDATE Destination
SET Xrange = 1
END;


--Drop the trigger have created 
DROP TRIGGER REACT
DROP TRIGGER REACT2
DROP TRIGGER REACT3
DROP TRIGGER REACT4
DROP TRIGGER REACT5
DROP TRIGGER RCOR



/* DML
PROCEDURE 
Basis Input*/
CREATE PROCEDURE Input
AS
BEGIN
INSERT INTO XUSER VALUES 
('Kevinova Reynaldi','10001','107.296654','-6.301566','6289643558982', '2033-03-17'),
('Brandon Fino Putra','10002','106.975571','-6.238270','6287361571847','2033-03-21'),
('Alfarel Adiputra','10003','107.172089','-6.307923','62817362573612','2033-03-24'),
('Keiza Setia Azzahra','10004','12.198675','11.238764','62789176543789','2033-04-01'),
('Aldino Stefanus', '10005','13.224876','9.213586','62718657825634','2033-04-05')
INSERT INTO Vehicle VALUES
('101', '10001', 'Sedan','-6.200595109073441','106.79749005446278','2033-03-17'),
('102', '10002', 'Truck','-6.181354849378713','106.87546352445293','2033-03-21'),
('103', '10003', 'Convertible','-6.225132392537005','106.86690888116263','2033-03-24'),
('104', '10004', 'Coupe','-6.202268141992156','106.75611923855077','2033-04-01'),
('105', '10005', 'SUV','-6.162950467875379','106.98975916841327','2033-04-05')
INSERT INTO Destination VALUES
('34591', '10001', '101', '1', '13.21', '35.79', 'Jalan Cempaka'),
('34592', '10002', '102', '1', '79.10', '35.55', 'Jalan Emas'),
('34593', '10003', '103', '1', '-54.21', '19.25', 'Jalan Kalibaru'),
('34594', '10004', '104', '1', '97.03', '-57.23', 'Jalan Kalijodo'),
('34595', '10005', '105', '1', '-11.37', '-75.39', 'Jalan Senen')
INSERT INTO Vcheckup VALUES 
('101','101', '2033-03-17', '1', '0', '0', '0', '0'),
('102','102', '2033-03-21', '0', '0', '1', '1', '1'),
('103','103', '2033-03-24', '1', '1', '0', '0', '0'),
('104','104', '2033-04-01', '0', '0', '0', '1', '0'),
('105','105', '2033-03-15', '0', '0', '0', '0', '1')
INSERT INTO Vprice VALUES
('129897','500','700','400','300','350','2000')
INSERT INTO Vtransaction VALUES 
('45691', '129897', '10001', '2033-03-17', '1', '1', '500', '500x'),
('45692', '129897', '10002', '2033-03-21', '1', '3', '1050', '1050x'),
('45693', '129897', '10003', '2033-03-24', '1', '2', '1200', '1200x'),
('45694', '129897', '10004', '2033-04-01', '1', '1', '300', '300x'),
('45695', '129897', '10005', '2033-04-05', '1', '1 ', '350', '350x')
END

--Procedure for Add new values
CREATE PROCEDURE AddNewUser( 
	@Nuser VARCHAR(50),
	@NID INT,
	@Ulong FLOAT,
	@Ulat FLOAT,
	@Unumber BIGINT,
	@Udate DATE
)
AS
BEGIN
	INSERT INTO [dbo].[XUSER]
	VALUES (@Nuser, @NID, @Ulong, @Ulat, @Unumber, @Udate)
END
GO
CREATE PROCEDURE AddNewVehicle(
	@VID INT,
	@NID INT, 
	@Vtype VARCHAR(11),
	@Vlong FLOAT,
	@Vlat FLOAT,
	@Vdate DATE
)
AS
BEGIN
	INSERT INTO [dbo].[Vehicle]
	VALUES (@VID, @NID, @Vtype, @Vlong, @Vlat, @Vdate)
END
GO
CREATE PROCEDURE AddNewDestination(
	@DID INT, 
	@NID INT, 
	@VID INT, 
	@XRange INT,
	@Dlat FLOAT,
	@Dlong FLOAT, 
	@Dname Varchar(15)
)
AS
BEGIN
	INSERT INTO [dbo].[Destination]
	VALUES (@DID, @NID, @VID, @XRange, @Dlat, @Dlong, @Dname)
END
GO
CREATE PROCEDURE AddNewVcheckup(
	@CID INT,
	@VID INT,
	@Cdate DATE,
	@Cmotor INT,
	@Cbattery INT,
	@Cskeleton INT,
	@Cwheels INT,
	@Cinterior INT
)
AS
BEGIN
	INSERT INTO [dbo].[Vcheckup]
	VALUES (@CID, @VID, @Cdate, @Cmotor, @Cbattery, @Cskeleton, @Cwheels, @Cinterior)
END
GO
CREATE PROCEDURE AddNewVtransaction(	
	@TID INT,
	@PID INT,
	@NID INT,
	@Tdate DATE,
	@XRange TINYINT,
	@CTotal	BIGINT,
	@MTotal BIGINT,
	@TPrice VARCHAR(10) 
)
AS
BEGIN
	INSERT INTO [dbo].[Vtransaction]
	VALUES (@TID, @PID, @NID, @Tdate, @XRange, @CTotal, @Mtotal,@Tprice)
END

--Create procedure to display the new data that has been entered 
CREATE PROCEDURE Display_XUser
AS
BEGIN
SELECT * FROM [dbo].[XUSER]
END
GO
CREATE PROCEDURE Display_Vehicle
AS
BEGIN
SELECT * FROM [dbo].[Vehicle]
END
GO
CREATE PROCEDURE Display_Destination
AS
BEGIN
SELECT * FROM [dbo].[Destination]
END
GO
CREATE PROCEDURE Display_Vcheckup
AS
BEGIN
SELECT * FROM [dbo].[Vcheckup]
END
GO
CREATE PROCEDURE Display_Vprice
AS
BEGIN
SELECT * FROM [dbo].[Vprice]
END
GO
CREATE PROCEDURE Display_Vtransaction
AS
BEGIN
SELECT * FROM [dbo].[Vtransaction]
END

--Run the procedure that have created 
EXEC Input
EXEC AddNewUser 'Riky Brandon', '10006','23.95893','71.009323','6289643558982', '2033-05-13'
EXEC AddNewVehicle '106', '10006', 'Van', '-6.21134520907394', '106.807091097463', '2033-05-13'
EXEC AddNewDestination '34596', '10006', '106', '1', '75.10', '69.63', 'Jalan Kemayoran'
EXEC AddNewVcheckup ' 106', '106', '2033-05-11', '1', '1', '1', '1', '0'  
EXEC AddNewVtransaction ' 45696', '129897', '10006', '2033-05-13', '1', '4', '1900', '1900x'
EXEC Display_XUser
EXEC Display_Destination
EXEC Display_Vcheckup
EXEC Display_Vprice
EXEC Display_Vtransaction

--Delete the new data that have created 
DELETE FROM [dbo].[Destination] WHERE DID='34596';
DELETE FROM [dbo].[Vcheckup] WHERE CID='106';
DELETE FROM [dbo].[Vtransaction] WHERE TID='45696';
DELETE FROM [dbo].[Vehicle] WHERE Vtype='Van';
DELETE FROM [dbo].[XUSER] WHERE Nuser='Riky Brandon';

--For drop the Procedure that have created 
DROP PROCEDURE Input
DROP PROCEDURE AddNewUser
DROP PROCEDURE AddNewVehicle
DROP PROCEDURE AddNewDestination
DROP PROCEDURE AddNewVcheckup
DROP PROCEDURE AddNewVtransaction
DROP PROCEDURE Display_XUser
DROP PROCEDURE Display_Vehicle
DROP PROCEDURE Display_Destination
DROP PROCEDURE Display_Vcheckup
DROP PROCEDURE Display_Vprice
DROP PROCEDURE Display_Vtransaction



--Right outer join
Select X.NID, Nuser, Unumber, VID, Udate, Tprice
From Xuser as X right outer join Vehicle as V
ON X.NID = V.NID
right outer join Vtransaction as T
ON V.NID = T.NID


--SUM Ctotal
SELECT 
   Cmotor,
   Cbattery,
   Cskeleton,
   Cwheels,
   Cinterior,
   (Cmotor + Cbattery + Cskeleton + Cwheels + Cinterior) as 'Ctotal'
FROM Vcheckup



/*View
Display virtual table whose contents are defined by a query*/
CREATE VIEW Vehicle_Type_Sport AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Sport'
GO
CREATE VIEW Vehicle_Type_SUV AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'SUV'
GO
CREATE VIEW Vehicle_Type_Convertible AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Convertible'
GO
CREATE VIEW Vehicle_Type_Coupe AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Coupe'
GO
CREATE VIEW Vehicle_Type_Hatchback AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Hatchback'
GO
CREATE VIEW Vehicle_Type_MPV AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'MPV'
GO
CREATE VIEW Vehicle_Type_Sedan AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Sedan'
GO
CREATE VIEW Vehicle_Type_Off_Road AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Off-Road'
GO
CREATE VIEW Vehicle_Type_Truck AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Truck'
GO
CREATE VIEW Vehicle_Type_Van AS
SELECT VID, Vtype 
FROM Vehicle
WHERE Vtype = 'Van'

--Display the view that have created
SELECT *FROM Vehicle_Type_Sport
SELECT *FROM Vehicle_Type_SUV
SELECT *FROM Vehicle_Type_Convertible
SELECT *FROM Vehicle_Type_Coupe
SELECT *FROM Vehicle_Type_Hatchback
SELECT *FROM Vehicle_Type_MPV
SELECT *FROM Vehicle_Type_Sedan
SELECT *FROM Vehicle_Type_Off_Road
SELECT *FROM Vehicle_Type_Truck
SELECT *FROM Vehicle_Type_Van

--Drop the view that have created
DROP VIEW Vehicle_Type_Sport
DROP VIEW Vehicle_Type_SUV
DROP VIEW Vehicle_Type_Convertible
DROP VIEW Vehicle_Type_Coupe
DROP VIEW Vehicle_Type_Hatchback
DROP VIEW Vehicle_Type_MPV
DROP VIEW Vehicle_Type_Sedan
DROP VIEW Vehicle_Type_Off_Road
DROP VIEW Vehicle_Type_Truck
DROP VIEW Vehicle_Type_Van



/*Order By Clause 
The ORDER BY keyword is used to sort the results-set in ascending or descending order.
Display the table order by recent date*/
SELECT *FROM XUSER ORDER BY Udate DESC
SELECT *FROM Vehicle ORDER BY Vdate DESC
SELECT *FROM Vtransaction ORDER BY Tdate DESC



/*Aggregate Functions
An aggregate function performs a calculation on a set of values, and returns a single value.
Display the average, minimum, and maximum values*/
SELECT AVG(MTotal) AS AVGMtotal FROM Vtransaction;
SELECT MIN(Mtotal) AS MINMtotal FROM Vtransaction;
SELECT MAX(CTotal) AS MAXMtotal FROM Vtransaction;
SELECT AVG(CTotal) AS AVGCtotal FROM Vtransaction;
SELECT MIN(CTotal) AS MICMtotal FROM Vtransaction;
SELECT MAX(CTotal) AS MAXCtotal FROM Vtransaction;


