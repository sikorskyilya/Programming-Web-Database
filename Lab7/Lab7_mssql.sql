go
use DBTourism
go


--TASK1
create table Report (
id INTEGER primary key identity(1,1),
xml_column XML
);

--TASK2	
go
create procedure generateXML
as
declare @x XML
set @x = (Select * from Ñountries FOR XML AUTO);
SELECT @x
go
--drop procedure generateXML
execute generateXML;

--TASK3
go
create procedure InsertInReport
as
DECLARE  @s XML  
SET @s = (Select * from Orders
for xml raw);
insert into Report values(@s);
go
  drop procedure InsertInReport
  execute InsertInReport
  select * from Report;

--task4
create primary xml index My_XML_Index on Report(xml_column)

create xml index Second_XML_Indeh on Report(xml_column)
using xml index My_XML_Index for path

--task5
go
create procedure SelectData
as
select xml_column.query('/row') as[xml_column] from Report for xml auto, type;
go

execute SelectData

select xml_column.value('(/row/@Date)[1]', 'nvarchar(max)') as[xml_column] from Report for xml auto, type;

select xml_column.query('/row') as [xml_column] from Report for xml auto, type;

select * from report