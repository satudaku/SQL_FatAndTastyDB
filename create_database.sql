/*
Name of script: Database Creation
Author: Sato Daiki	
Date written: 31/08/2015
Purpose: Creates shimsoFAT database
*/

USE master;
 

IF DB_ID('shimsoFAT') IS NOT NULL             
	BEGIN
		PRINT 'Database exists - dropping.';
		DROP DATABASE shimsoFAT;
	END

GO

PRINT 'Creating database.';
CREATE DATABASE shimsoFAT;

GO
USE shimsoFAT

PRINT 'Creating pay table';
CREATE TABLE pay
	(PayID CHAR(1)
		CONSTRAINT pay_PayID_nn NOT NULL,
		CONSTRAINT pay_PayID_u UNIQUE (PayID),
		CONSTRAINT pay_PayID_pk PRIMARY KEY (PayID),
	 PayName VARCHAR(25)
		CONSTRAINT pay_PayName_nn NOT NULL,
	 PayHourly DECIMAL(5,2) DEFAULT 0
		CONSTRAINT pay_PayHourly_nn NOT NULL,
		CONSTRAINT pay_PayHourly_ck CHECK (PayHourly > 0),
	 PaySuper DECIMAL(4,2)
		CONSTRAINT pay_PaySuper_nn NOT NULL)
;

PRINT 'Creating staff table';
CREATE TABLE staff
	(StaffID INT IDENTITY (1000,1)
		CONSTRAINT staff_StaffID_nn NOT NULL,
		CONSTRAINT staff_StaffID_u UNIQUE (StaffID),
		CONSTRAINT staff_StaffID_pk PRIMARY KEY (StaffID),
	 StaffFirstName VARCHAR(20)
		CONSTRAINT staff_StaffFirstName_nn NOT NULL,
	 StaffLastName VARCHAR(20),
	 StaffPhone Char(10)
		CONSTRAINT staff_StaffPhone_nn NOT NULL,
	 StaffGender Char(1)
		CONSTRAINT staff_StaffGender_nn NOT NULL,
		CONSTRAINT staff_StaffGender_ck CHECK (StaffGender IN('f', 'm', 'i')),
	 StaffDOB DATE DEFAULT GETDATE()
		CONSTRAINT staff_StaffDOB_nn NOT NULL,
		CONSTRAINT staff_StaffDOB_ck CHECK (StaffDOB <= GETDATE()),
	 Mentor INT DEFAULT NULL
		CONSTRAINT staff_Mentor_fk FOREIGN KEY (Mentor)
			REFERENCES staff(StaffID),
	 PayID CHAR(1)
		CONSTRAINT staff_PayID_fk FOREIGN KEY (PayID)
			REFERENCES pay(PayID) ON DELETE SET NULL ON UPDATE CASCADE)
;

PRINT 'Creating availability table';
CREATE TABLE availability
	(AvailabilityID INT IDENTITY (2000,1)
		CONSTRAINT availability_AvailabilityID_nn NOT NULL,
		CONSTRAINT availability_AvailabilityID_u UNIQUE (AvailabilityID),
		CONSTRAINT availability_AvailabilityID_pk PRIMARY KEY (availabilityID),
	 AvailableDay Char(3)
		CONSTRAINT availability_AvailableDay_nn NOT NULL,
		CONSTRAINT availability_AvailableDay_ck CHECK (AvailableDay IN('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat')),
	 StartTime TIME DEFAULT '00:00'
		CONSTRAINT availability_StartTime_nn NOT NULL,
	 EndTime TIME DEFAULT '00:00'
		CONSTRAINT availability_EndTime_nn NOT NULL,
	 StaffID INT
		CONSTRAINT availability_StaffID_fk FOREIGN KEY (StaffID)
			REFERENCES staff(StaffID) ON DELETE SET NULL ON UPDATE CASCADE)
;

PRINT 'Creating store table';
CREATE TABLE store
	(StoreID INT IDENTITY (3000,1)
		CONSTRAINT store_StoreID_nn NOT NULL,
		CONSTRAINT store_StoreID_u UNIQUE (StoreID),
		CONSTRAINT store_StoreID_pk PRIMARY KEY (StoreID),
	 StoreName VARCHAR(15)
		CONSTRAINT store_StoreID_nn NOT NULL,
	 StoreAddress VARCHAR(50)
		CONSTRAINT store_StoreAddress_nn NOT NULL,
	 StoreOpenTime TIME DEFAULT '00:00:00',
	 StoreCloseTime TIME DEFAULT '00:00:00',
	 ManagerID INT
		CONSTRAINT store_ManagerID_fk FOREIGN KEY (ManagerID)
			REFERENCES staff(StaffID))
;

PRINT 'Creating shift table';
CREATE TABLE shift
	(ShiftID INT IDENTITY (4000,1)
		CONSTRAINT shift_ShiftID_nn NOT NULL,
		CONSTRAINT shift_ShiftID_u UNIQUE (ShiftID),
		CONSTRAINT shift_ShiftID_pk PRIMARY KEY (ShiftID),
	 ShiftDate DATE DEFAULT GETDATE()
		CONSTRAINT shift_ShiftDate_nn NOT NULL,
	 ShiftStartTime TIME DEFAULT '00:00:00'
		CONSTRAINT shift_ShiftStartTime_nn NOT NULL,
	 ShiftEndTime TIME DEFAULT '00:00:00'
		CONSTRAINT shift_ShiftEndTime_nn NOT NULL,
	 StaffID INT
		CONSTRAINT shift_StaffID_fk FOREIGN KEY (StaffID)
			REFERENCES staff(StaffID) ON DELETE SET NULL ON UPDATE CASCADE,
	 StoreID INT
		CONSTRAINT shift_StoreID_fk FOREIGN KEY (StoreID)
			REFERENCES store(StoreID) ON DELETE SET NULL ON UPDATE CASCADE)
;

PRINT 'Creating product table';
CREATE TABLE product
	(ProductID INT IDENTITY (5000,1)
		CONSTRAINT product_ProductID_nn NOT NULL,
		CONSTRAINT product_ProductID_u UNIQUE (ProductID),
		CONSTRAINT product_ProductID_pk PRIMARY KEY (ProductID),
	 ProductName VARCHAR(30)
		CONSTRAINT product_ProductName_nn NOT NULL,
	 ProductPrice DECIMAL (5,2) DEFAULT 0,
	 ProductSize DECIMAL (6,2) DEFAULT 0,
	 ProductDecription VARCHAR(70),
	 ProductCalories DECIMAL (7,2) DEFAULT 0)
;

PRINT 'Creating healthy table';
CREATE TABLE healthy
	(ProductID INT
		CONSTRAINT healthy_ProductID_nn NOT NULL,
		CONSTRAINT healthy_ProductID_u UNIQUE (ProductID),
		CONSTRAINT healthy_ProductID_pk PRIMARY KEY (ProductID),
		CONSTRAINT healthy_ProductID_fk FOREIGN KEY (ProductID)
			REFERENCES product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	 Fat DECIMAL (6,2) DEFAULT 0
		CONSTRAINT healthy_Fat_nn NOT NULL,
	 Protein DECIMAL (6,2) DEFAULT 0
		CONSTRAINT healthy_Protein_nn NOT NULL,
	 Sugar DECIMAL (6,2) DEFAULT 0
		CONSTRAINT healthy_Sugar_nn NOT NULL)
;

PRINT 'Creating vegetairan table';
CREATE TABLE vegetarian
	(ProductID INT
		CONSTRAINT vegetarian_ProductID_nn NOT NULL,
		CONSTRAINT vegetarian_ProductID_u UNIQUE (ProductID),
		CONSTRAINT vegetarian_ProductID_pk PRIMARY KEY (ProductID),
		CONSTRAINT vegetarian_ProductID_fk FOREIGN KEY (ProductID)
			REFERENCES product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	 Fibre DECIMAL (6,2) DEFAULT 0
		CONSTRAINT vegetarian_Fibre_nn NOT NULL,
	 Sodium DECIMAL (6,2) DEFAULT 0
		CONSTRAINT vegetarian_Sodium_nn NOT NULL,
	 Carbohydrate DECIMAL (6,2) DEFAULT 0
		CONSTRAINT vegetarian_Carbohydrate_nn NOT NULL)
;

PRINT 'Creating store_product table';
CREATE TABLE store_product
	(StoreID INT 
		CONSTRAINT store_product_StoreID_nn NOT NULL,
		CONSTRAINT store_product_StoreID_fk FOREIGN KEY (StoreID)
			REFERENCES store(StoreID) ON DELETE CASCADE ON UPDATE CASCADE,
	 ProductID INT
		CONSTRAINT store_product_ProductID_nn NOT NULL,
		CONSTRAINT store_product_ProductID_fk FOREIGN KEY (ProductID)
			REFERENCES product(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	 CONSTRAINT store_product_StoreProductID_pk PRIMARY KEY (StoreID, ProductID))
;

PRINT 'Creating supplier table';
CREATE TABLE supplier
	(SupplierID INT IDENTITY (6000,1)
		CONSTRAINT supplier_SupplierID_nn NOT NULL,
		CONSTRAINT supplier_SupplierID_u UNIQUE (SupplierID),
		CONSTRAINT supplier_SupplierID_pk PRIMARY KEY (SupplierID),
	 SupplierName VARCHAR(25)
		CONSTRAINT supplier_SupplierName_nn NOT NULL,
	 SupplierABN Char(11)
		CONSTRAINT supplier_SupplierABN_nn NOT NULL,
	 SupplierCPName VARCHAR(25)
		CONSTRAINT supplier_SupplierCPName_nn NOT NULL,
	 SupplierCPPhone Char(10)
		CONSTRAINT supplier_SupplierCPPhone_nn NOT NULL)
;

PRINT 'Creating store_supplier table';
CREATE TABLE store_supplier
	(StoreID INT 
		CONSTRAINT store_supplier_StoreID_nn NOT NULL,
		CONSTRAINT store_supplier_StoreID_fk FOREIGN KEY (StoreID)
			REFERENCES store(StoreID) ON DELETE NO ACTION ON UPDATE CASCADE,
	 SupplierID INT
		CONSTRAINT store_supplier_SupplierID_nn NOT NULL,
		CONSTRAINT store_supplier_SupplierID_fk FOREIGN KEY (SupplierID)
			REFERENCES supplier(SupplierID) ON DELETE NO ACTION ON UPDATE CASCADE,
	 DateProductSupplied DATE DEFAULT GETDATE()
		CONSTRAINT store_supplier_DateProductSupplied_ck CHECK (DateProductSupplied <= GETDATE()),
	 ProductID CHAR(4),
	 CONSTRAINT store_product_StoreSupplierID_pk PRIMARY KEY (StoreID, SupplierID, DateProductSupplied, ProductID),
	 OrderPrice DECIMAL(5,2)
		CONSTRAINT store_supplier_OrderPrice_nn NOT NULL,
	 OrderQuantity NUMERIC(5)
		CONSTRAINT store_supplier_OrderQuantity_nn NOT NULL)
;