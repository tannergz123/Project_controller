CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SQLShack@1';

CREATE CERTIFICATE Certificate_test WITH SUBJECT = 'Protect my data';

SELECT name CertName, 
    certificate_id CertID, 
    pvt_key_encryption_type_desc EncryptType, 
    issuer_name Issuer
FROM sys.certificates;

Go

CREATE SYMMETRIC KEY SymKey_test WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Certificate_test;

Go

SELECT name KeyName, 
    symmetric_key_id KeyID, 
    key_length KeyLength, 
    algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;


--creates table Customer
CREATE TABLE Customer
(
--1.change varchar to nvarchar
--2. add a "system ID" that increments for every entry as a primary key. System ID is self-identity
--3. be able to transferdata from "legacy database" and/or spreadsheets such as csv files
  Cust_ID int IDENTITY(1,1),  
  Customer_FirstName nvarchar(30),
  Customer_LastName nvarchar(30),
  Customer_MI nvarchar(30),
  CustomerName nvarchar(30),
  Company nvarchar(50),
  Email nvarchar(100) not null,
  userPassword nvarchar(25),
  VIP BIT ,
  Active BIT,
  PRIMARY KEY(Cust_ID)
);



INSERT INTO Customer (Customer_FirstName,Email,userPassword,VIP,Active) VALUES ('Jan','jAbrg15@gmail.com','111123',0,1)
INSERT INTO Customer (Customer_FirstName,Email,userPassword,VIP,Active) VALUES ('Baer','bbmo1nl@gmail.com','2222222',1,1) 
INSERT INTO Customer (Customer_FirstName,Email,userPassword,VIP,Active) VALUES ('Mike','MMaavwa@gmail.com','3333333333',1,0) 

SELECT * FROM Customer

DROP TABLE Customer


GO

ALTER TABLE Customer
ADD password_encrypt varbinary(MAX) NULL
GO

--encrypted the userpassword data
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
UPDATE Customer
        SET password_encrypt = EncryptByKey (Key_GUID('SymKey_test'), userPassword)
        FROM Customer;
        GO
--symmetric key must be closed to end session
CLOSE SYMMETRIC KEY SymKey_test;
            GO

ALTER TABLE Customer DROP COLUMN userPassword;
GO

--decrypts and displays password data
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
SELECT Customer_FirstName, Email,password_encrypt AS 'Encrypted data',
            CONVERT(nvarchar(max), DecryptByKey(password_encrypt)) AS 'Decrypted password'
            FROM Customer ;

SELECT * FROM dbo.Customer;
--keyword EncryptByKey encrypts the data in the second parentheses
INSERT INTO dbo.Customer (Customer_FirstName,Email,password_encrypt,VIP,Active) VALUES ('Dubois','dnonql@gmail.com',EncryptByKey (Key_GUID('SymKey_test'),'8974126' ),0,0)



--creates the role table
CREATE TABLE Roles
(
    roleID int IDENTITY(1,1),
	userRole nvarchar(30) UNIQUE NOT NULL,
	PRIMARY KEY(roleID)
)
--creates team table
CREATE TABLE Teams
(
	teamID int IDENTITY(1,1),
	teamName nvarchar(25) UNIQUE NOT NULL,
	PRIMARY KEY(teamID)
)

--creates table of users
CREATE TABLE Users
(
	UserID int IDENTITY(1,1),
	LoginField nvarchar(30) UNIQUE NOT NULL,
	userPassword varbinary(MAX) NOT NULL,
	First_Name nvarchar(25) NOT NULL,
	Last_Name nvarchar(25) NOT NULL,
	MI nvarchar(15),
	Email nvarchar(50) NOT NULL,
	RoleID int,
	TeamID int,
	userStatus nvarchar(20),
	Last_updated_by nvarchar(30),
	Last_updated_date date,
	FOREIGN KEY (RoleID) REFERENCES Roles(roleID),
	FOREIGN KEY(TeamID) REFERENCES Teams(teamID),
	FOREIGN KEY (Last_updated_by) REFERENCES Users(LoginField),
	PRIMARY KEY(UserID)
);


--insertion process: 1. open the symmetric key
--2. use the EncryptByKey keyword to encrypt incoming password data
--3. close the key
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
INSERT INTO Users (LoginField, userPassword) VALUES ('aaaa4123',EncryptByKey (Key_GUID('SymKey_test'),'67142'));
CLOSE SYMMETRIC KEY SymKey_test;
            GO

--decrypts users' passwords
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
SELECT LoginField,userPassword AS 'Encrypted data',
            CONVERT(varchar, DecryptByKey(userPassword)) AS 'Decrypted password'
            FROM Users;
CLOSE SYMMETRIC KEY SymKey_test;
            GO

CREATE TABLE Project
(
	ProjectID int IDENTITY(1,1),
	GSNumber nvarchar(20) NOT NULL,
	OrderDate date ,
	OligoDate date ,
	DeliverDate date,
	ProjectStatus nvarchar(15),
	Note text,
	CompleteDate date,
	CustomerID int,
	FOREIGN KEY (CustomerID) REFERENCES Customer(Cust_ID),
	PRIMARY KEY(ProjectID)
);

GO 	
--INSERT INTO dbo.Users (LoginField, userPassword, First_Name, Last_Name,Last_updated_by)
--VALUES('acdc','1234567');


CREATE TABLE Plasmid
(
	PlasmidID int IDENTITY(1,1),
	GSNumber_Plasmid nvarchar(20) UNIQUE NOT NULL,
	Plasmid_Name nvarchar(25),
	Size int,
	Vector nvarchar(20),
	Cloning nvarchar(25),
	GSContent nvarchar(25),
	Step nvarchar(20),
	Assigned_to nvarchar(30),
	Overlap nvarchar(20),
	Memo text,
	ComplDate date,
	ExpDeliverDate date,
	Last_Updated_By nvarchar(30),
	Last_Updated_Date date,
	Notes text,
	Bacteria bit,
	FOREIGN KEY (Assigned_to) REFERENCES Users(LoginField),
	FOREIGN KEY (Last_Updated_By) REFERENCES Users(LoginField),
	PRIMARY KEY(PlasmidID)
);
GO

CREATE TABLE Shipment
(
	Shipping_ID int IDENTITY(1,1) PRIMARY KEY,
    Carrier nvarchar(25),
    Ship_To nvarchar(25),
    Tracking nvarchar(50),
	ShipDate date,
	ShipNote text,
	IsOligo bit,
	NoOfPlates integer,
	IsVoid bit,
	Last_Updated_By nvarchar(30),
	Last_Updated_Date date,
	FOREIGN KEY (Last_Updated_By) REFERENCES Users(LoginField)
);
GO


CREATE TABLE Shipment_Detail
(
	--alter shipment_ID to not null
	ShipDetail_ID int IDENTITY(1,1),
	Shipment_ID integer,
	GSNumber nvarchar(50) NOT NULL,
	Plasmid nvarchar(50),
	Shipment_Status nvarchar(20),
	Assigned_To nvarchar(30),
	DataSend nvarchar(50),
	Notes text,
	Houston_Shipped bit,
	Last_Updated_By nvarchar(30),
	Last_Updated_Date date,
	FOREIGN KEY(Shipment_ID) REFERENCES Shipment(Shipping_ID),
	FOREIGN KEY(Last_Updated_By) REFERENCES Users(LoginField)
);
GO