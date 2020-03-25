use DBTourism;
go
exec sp_configure 'clr_enabled', 1;
go
reconfigure;
go
create assembly GetCostByService from 'D:\studing\6 sem\BD\labs\laba3\laba3\bin\Debug\laba3.dll';
drop assembly GetCostByService;

go
create procedure GetCostByService (@start DateTime, @end DateTime)
as external name GetCostByService.StoredProcedures.GetCostByService
go
drop procedure GetCostByService;

go
declare @num int
exec @num = GetCostByService '2017-01-01', '2022-01-01'
print @num