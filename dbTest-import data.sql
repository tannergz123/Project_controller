
INSERT INTO Customer (Customer_FirstName, Customer_LastName, Customer_MI
, CustomerName,userPassword, Company, Email, VIP, Active)
SELECT Customer_FName,Customer_LName, Customer_MI, Customer_Name, Password, Company, isnull(Email, ''),
IS_VIP, IS_Active FROM  Epoch_ProjectController.dbo.Customer ;

SELECT count(email), email FROM Epoch_ProjectController.dbo.Customer 
group by email
having count(email) > 1 
order by Email

select * from Epoch_ProjectController.dbo.Customer
where password IS NOT NULL


ALTER TABLE Customer ALTER COLUMN Company nvarchar(60)

SELECT * FROM dbTest.dbo.Customer


ALTER TABLE Users ADD password_normal nvarchar(100)

INSERT INTO Teams (teamName) SELECT Team from Epoch_ProjectController.dbo.Team

select * from roles
select * from Epoch_ProjectController.dbo.team
truncate table Teams



INSERT INTO Roles (userRole) SELECT Role from Epoch_ProjectController.dbo.Role

INSERT INTO Users (LoginField, password_normal, First_Name, Last_Name, Email, userStatus,
Last_updated_by, Last_updated_date, roleID, teamID)  
SELECT Login,Password, First_Name, Last_Name, isnull(Email, ''), Status, Last_Update_By, Last_Update, Role_Sys_Id, Team_Sys_ID
from Epoch_ProjectController.dbo.Users;

select * from users

ALTER TABLE users
ADD password_encrypt varbinary(MAX) NULL
GO

--encrypted the userpassword data
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
UPDATE Users
        SET password_encrypt = EncryptByKey (Key_GUID('SymKey_test'), password_normal)
        FROM Users;
        GO
--symmetric key must be closed to end session
CLOSE SYMMETRIC KEY SymKey_test;
            GO

ALTER TABLE Users DROP COLUMN password_normal;
GO

--decrypts and displays password data
OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test;
SELECT First_Name, Last_Name, Email,password_encrypt AS 'Encrypted data',
            CONVERT(nvarchar(max), DecryptByKey(password_encrypt)) AS 'Decrypted password'
            FROM Users ;
CLOSE SYMMETRIC KEY SymKey_test;
            GO



--unused query, for emergency purposes only
update u
set u.RoleID= r.roleID
from users u, 
	(select u1.Login, r1.Role
	from epoch_projectcontroller.dbo.users u1, epoch_projectcontroller.dbo.role r1
	where u1.Role_Sys_Id = r1.Role_Sys_ID ) as oldRole,
	Roles r 
where r.userRole = oldrole.Role and 
	  u.LoginField= oldRole.Login 

INSERT INTO Project (GSNumber, OrderDate, OligoDate, DeliverDate, ProjectStatus,
Note, CompleteDate) SELECT  GSNumber, OrderDate, OligoDate, DeliveryDate,
ProjectStatus, Note, ComplDate FROM Epoch_ProjectController.dbo.Project

SELECT * FROM Epoch_ProjectController.dbo.Project
SELECT * FROM Project
TRUNCATE TABLE Project

update p
set p.CustomerID= c.Cust_ID
from Project p, 
	(select  p1.GSNumber, c1.Customer_Sys_ID
	from epoch_projectcontroller.dbo.customer c1, epoch_projectcontroller.dbo.Project p1
	where c1.Customer_Sys_Id = p1.Customer_Sys_ID ) as oldID,
	Customer c 
where c.Cust_ID = oldID.Customer_Sys_ID and 
	  p.GSNumber= oldID.GSNumber 


select  p1.GSNumber
	from epoch_projectcontroller.dbo.customer c1, epoch_projectcontroller.dbo.Project p1
group by GSNumber
having count(GSNumber) > 1 
order by GSNumber 


select * 
	from epoch_projectcontroller.dbo.Project 
	where GSNumber = 'GS203231'


INSERT INTO Plasmid (GSNumber_Plasmid, Plasmid_Name, Size, Vector, Cloning, GSContent, Step, 
Overlap, Memo, ComplDate, ExpDeliverDate, Last_Updated_Date, Notes, Bacteria)
SELECT GSNumber, PlasmidName, Size, Vector, Cloning, GCContent, Step, 
Overlap, Memo, ComplDate, ExpDeliveryDate,Last_Update_Date,
ProjectNote, Bacteria FROM Epoch_ProjectController.dbo.Plasmid;

ALTER TABLE Plasmid ALTER COLUMN Vector nvarchar(80)

SELECT * FROM Plasmid
--last_updated_by is not yet completed
--updates the assigned to bar
update pl
set pl.Assigned_to= u.LoginField
from Plasmid pl, 
	(select  pl1.GSNumber, u1.Login
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Plasmid pl1
	where u1.Login= pl1.Assign_To ) as oldID,
	Users u
where u.LoginField = oldID.Login and 
	  pl.GSNumber_Plasmid= oldID.GSNumber 

update pl
set pl.Last_Updated_By= u.LoginField
from Plasmid pl, 
	(select  pl1.GSNumber, u1.Login
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Plasmid pl1
	where u1.Login= pl1.Last_Update_By ) as oldID,
	Users u
where u.LoginField = oldID.Login and 
	  pl.GSNumber_Plasmid= oldID.GSNumber

SELECT * FROM Plasmid
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid
SELECT * FROM Epoch_ProjectController.dbo.Shipment
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Plasmid

SELECT * FROM Shipment
INSERT INTO Shipment (Carrier, Ship_To, Tracking, ShipDate, ShipNote, isVoid, isOligo)
SELECT Carrier,Ship_To,Tracking,ShipDate,ShipNotes,isVoid, 0 as isOligo
FROM Epoch_ProjectController.dbo.Shipment

INSERT INTO Shipment (Carrier, Ship_To, Tracking, ShipDate, ShipNote, isVoid, Last_Updated_Date, isOligo, NoOfPlates)
SELECT Carrier,Ship_To,Tracking,ShipDate,ShipNotes,isVoid, Last_Update_Date, 1 as isOligo, NoOfPlate
FROM Epoch_ProjectController.dbo.Shipment_Oligo

--check matching tracking number AND shipdate?
update s
set s.Last_Updated_By= u.LoginField
from Shipment s, 
	(select  so1.Tracking, so1.ShipDate,  u1.Login
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment_Oligo so1
	where u1.Login= so1.Last_Update_By ) as oldShip_Olig,
	Users u
where u.LoginField = oldShip_Olig.Login and 
	  s.Tracking= oldShip_Olig.Tracking and s.ShipDate=oldShip_Olig.ShipDate

INSERT INTO Shipment (Carrier, Ship_To, Tracking, ShipDate, ShipNote, isVoid, Last_Updated_Date, isOligo)
SELECT Carrier,Ship_To,Tracking,ShipDate,ShipNotes,isVoid, Last_Update_Date, 0 as isOligo
FROM Epoch_ProjectController.dbo.Shipment

update s
set s.Last_Updated_By= u.LoginField
from Shipment s, 
	(select  s1.Tracking, s1.ShipDate,  u1.Login
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment s1
	where u1.Login= s1.Last_Update_By ) as oldShip_Olig,
	Users u
where u.LoginField = oldShip_Olig.Login and 
	  s.Tracking= oldShip_Olig.Tracking and s.ShipDate=oldShip_Olig.ShipDate


TRUNCATE TABLE Shipment

SELECT * FROM Shipment
SELECT * FROM Epoch_ProjectController.dbo.users where Epoch_ProjectController.dbo.users.login='amyzhou'

INSERT INTO Shipment_Detail (GSNumber, Plasmid, Shipment_Status, Assigned_To, DataSend, Notes, Houston_Shipped,
Last_Updated_Date) SELECT GSNumber, Plasmid,Status, Assign_To, DataSend, Notes, Houston_Shipped, Last_Update_Date 
from Epoch_ProjectController.dbo.Shipment_Plasmid

--fills in the shipping ID gap
--1. update the column with the old, outdated shipping ID

update sd
set sd.Shipment_ID=oldShip_Plasmid.Ship_Sys_ID
from Shipment_Detail sd, 
	(select p1.Ship_Plasmid_Sys_ID, s1.Ship_Sys_ID, p1.GSNumber, p1.Plasmid
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment s1,
	Epoch_ProjectController.dbo.Shipment_Plasmid p1
	where p1.Ship_Sys_ID= s1.Ship_Sys_ID ) as oldShip_Plasmid
where sd.GSNumber=oldShip_Plasmid.GSNumber and sd.Plasmid=oldShip_Plasmid.Plasmid

--step 1.5: update last_updated_by data here. must ensure that shipment id, plasmid number, and 
--last update date are identical 
update sd
set sd.Last_Updated_By=oldShip_Plasmid.Last_Update_By
from Shipment_Detail sd, 
	(select p1.Ship_Sys_ID, p1.GSNumber, p1.Plasmid, p1.Last_Update_By, p1.Last_Update_Date
	from epoch_projectcontroller.dbo.Users u1, epoch_ProjectController.dbo.Shipment_Plasmid p1
	where p1.Last_Update_By=u1.Login ) as oldShip_Plasmid
where sd.GSNumber=oldShip_Plasmid.GSNumber and sd.Plasmid=oldShip_Plasmid.Plasmid 
	and sd.Shipment_ID=oldShip_Plasmid.Ship_Sys_ID 
	and DATEDIFF(day, sd.Last_Updated_Date, oldShip_Plasmid.Last_Update_Date)=0


--2. replace outdated shipping ID with new ID by searching for the matching tracking and ship date info
update sd
set sd.Shipment_ID=s.Shipping_ID
from Shipment_Detail sd, 
	(select p1.Ship_Plasmid_Sys_ID, s1.Ship_Sys_ID, s1.ShipDate, s1.Tracking, p1.Plasmid, p1.GSNumber
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment s1,
	Epoch_ProjectController.dbo.Shipment_Plasmid p1
	where p1.Ship_Sys_ID= s1.Ship_Sys_ID ) as oldShip_Plasmid,
	Shipment s
where s.ShipDate=oldShip_Plasmid.ShipDate and s.Tracking=oldShip_Plasmid.Tracking
	and oldShip_Plasmid.Ship_Sys_ID=sd.Shipment_ID

SELECT * FROM Shipment
SELECT * FROM Shipment_Detail
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Plasmid
SELECT * FROM Epoch_ProjectController.dbo.Shipment

SELECT Ship_Plasmid_Sys_ID,FORMAT(Last_Update_Date,'yyyy-mm-dd') from Epoch_ProjectController.dbo.Shipment_Plasmid

TRUNCATE TABLE Shipment_Detail

select * from Shipment_Detail

select * from Epoch_ProjectController.dbo.Shipment_Plasmid
select * from Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid


--import data from Shipment_Oligo_Plasmid table into the Shipment_Detail table

GO; 

INSERT INTO Shipment_Detail (GSNumber,  DataSend, Notes, Last_Updated_Date) SELECT GSNumber, DataSend, Notes, Last_Update_Date 
from Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid

SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid p, Epoch_ProjectController.dbo.Shipment_Plasmid sp
	WHERE p.GSNumber=sp.GSNumber and p.Last_Update_Date=sp.Last_Update_Date


GO;
--1. Update Ship ID with Ship_Oligo_Sys_ID

update sd
set sd.Shipment_ID=old_OligShip_Plasmid.Ship_Oligo_Sys_ID
from Shipment_Detail sd, 
	(select op1.Ship_Oligo_Sys_ID, op1.GSNumber, op1.Last_Update_Date
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment_Oligo so1,
	Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid op1
	where op1.Ship_Oligo_Sys_ID= so1.Ship_Oligo_Sys_ID ) as old_OligShip_Plasmid
where sd.GSNumber=old_OligShip_Plasmid.GSNumber 
	and DATEDIFF(DAY, sd.Last_Updated_Date, old_OligShip_Plasmid.Last_Update_Date)=0

--2. Update Last_Update_By matching to corresponding Ship_Oligo_Sys_ID, date, and GSNumber

update sd
set sd.Last_Updated_By=old_OligShip_Plasmid.Last_Update_By
from Shipment_Detail sd, 
	(select op1.Ship_Oligo_Sys_ID, op1.GSNumber, op1.Last_Update_Date, op1.Last_Update_By
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment_Oligo_Plasmid op1
	where op1.Last_Update_By= u1.Login ) as old_OligShip_Plasmid
where sd.GSNumber=old_OligShip_Plasmid.GSNumber 
	and DATEDIFF(DAY, sd.Last_Updated_Date, old_OligShip_Plasmid.Last_Update_Date)=0

--3. replace old ship id with new id

update sd
set sd.Shipment_ID=s.Shipping_ID
from Shipment_Detail sd, 
	(select op1.Ship_Oligo_Plasmid_Sys_ID, so1.Ship_Oligo_Sys_ID, so1.ShipDate, so1.Tracking
	from epoch_projectcontroller.dbo.Users u1, epoch_projectcontroller.dbo.Shipment_Oligo so1,
	Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid op1
	where op1.Ship_Oligo_Sys_ID= so1.Ship_Oligo_Sys_ID ) as oldShip_Plasmid,
	Shipment s
where s.ShipDate=oldShip_Plasmid.ShipDate and s.Tracking=oldShip_Plasmid.Tracking
	and oldShip_Plasmid.Ship_Oligo_Sys_ID=sd.Shipment_ID

SELECT * FROM Shipment_Detail
SELECT * FROM Shipment
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid 
SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo


SELECT * FROM Epoch_ProjectController.dbo.Shipment_Oligo_Plasmid s_op, Epoch_ProjectController.dbo.Shipment_Oligo so
where s_op.Last_Update_Date=so.Last_Update_Date