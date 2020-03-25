use DBTourism

CREATE TABLE Clients(
  hid hierarchyid NOT NULL,
  clientId int NOT NULL,
  ClientName nvarchar(50) NOT NULL,
CONSTRAINT PK_Clients PRIMARY KEY CLUSTERED
(
  [hid] ASC
))


insert into Clients
values(hierarchyid::GetRoot(), 1, 'Иванов')

declare @Id hierarchyid

select @Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = hierarchyid::GetRoot()

insert into Clients
values(hierarchyid::GetRoot().GetDescendant(@id, null), 2, 'Петров');

select @Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = hierarchyid::GetRoot()

insert into Clients
values(hierarchyid::GetRoot().GetDescendant(@id, null), 3, 'Сидоров');

select @Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = hierarchyid::GetRoot()

insert into Clients
values(hierarchyid::GetRoot().GetDescendant(@id, null), 4, 'Васечкин');

declare @phId hierarchyid
select @phId = (SELECT hid FROM Clients WHERE clientId = 2);

select @Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = @phId

insert into Clients
values( @phId.GetDescendant(@id, null), 7, 'Смирнов');

select @phId = (SELECT hid FROM Clients WHERE ClientId = 4);

select Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = @phId

insert into Clients
values( @phId.GetDescendant(@id, null), 5, 'Круглов');

select Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = @phId

insert into Clients
values( @phId.GetDescendant(@id, null), 6, 'Квадратов');

select @phId = (SELECT hid FROM Clients WHERE clientId = 7);

select Id = MAX(hid)
from Clients
where hid.GetAncestor(1) = @phId

insert into Clients
values( @phId.GetDescendant(@id, null), 8, 'Пупкин');



select hid.ToString(), hid.GetLevel(), * from Clients

--2------------------------------------------
GO  
CREATE PROCEDURE SelectRoot(@level int)    
AS   
BEGIN  
   select hid.ToString(), * from Clients where hid.GetLevel() = @level;
END;
  
GO  
exec SelectRoot 2;
--3---------------------------------------------
GO  
CREATE PROCEDURE AddDocherRoot(@UserId int,@UserName nvarchar(50))   
AS   
BEGIN  
declare @Id hierarchyid
declare @phId hierarchyid
select @phId = (SELECT hid FROM Clients WHERE ClientId = @UserId);

select @Id = MAX(hid) from Clients where hid.GetAncestor(1) = @phId

insert into Clients values( @phId.GetDescendant(@id, null),@UserId,@UserName);
END;  

GO  
exec AddDocherRoot 2, 'Us3';
select * from Clients; 

go
CREATE PROCEDURE MovRoot(@old_uzel int, @new_uzel int )
AS  
BEGIN  
DECLARE @nold hierarchyid, @nnew hierarchyid  
SELECT @nold = hid FROM Clients WHERE clientId = @old_uzel ;  
  
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE  
BEGIN TRANSACTION  
SELECT @nnew = hid FROM Clients WHERE ClientId = @new_uzel ; 
  
SELECT @nnew = @nnew.GetDescendant(max(hid), NULL)   
FROM Clients WHERE hid.GetAncestor(1)=@nnew ; 
UPDATE Clients   
SET hid = hid.GetReparentedValue(@nold, @nnew)   
WHERE hid.IsDescendantOf(@nold) = 1 ;   
 commit;
  END ;  
GO  
----
exec MovRoot 2,3
select hid.ToString(), hid.GetLevel(), * from Clients