drop database DBTourism;

select * from Ñountries;
select * from Tours;
select * from Trips;
select * from Orders;

create database DBTourism;

use DBTourism;
go

create table Ñountries
(
	id int identity(1,1) primary key,
	Country nvarchar(30)
);

insert into Ñountries values
('Belarus'), ('Russia'),('Finland'), ('France'), ('Germany'), ('Italy'),
('Latvia'),('Moldova'),('Netherlands'),('Norway'),('Poland'),('Singapore'),('Spain'),
('Turkey'),('United States of America'),('Slovakia'),('Monaco'),('Luxembourg'),('Israel'),
('Greece'),('Denmark'),('Cuba'),('China'),('Canada'),('Brazil'),('Qatar'),('Thailand'),
('United Kingdom'),('Uzbekistan'),('Peru')

create table Tours
(
	id int identity(1,1) primary key,
	idCountry int foreign key references Ñountries(id),
	Name nvarchar(30)
);

insert into Tours values
(2,'Cry, baby'), (5, 'Reise, Reise'), (22, 'Dirty magic'), 
(16, 'Acheron'), (10, 'Into the surf'), (1, 'Movement'),
(30, 'Blue memories'), (9, 'Wolf like me'), (18, 'Miracle'),
(11, 'This is all yours')


create table Trips
(
	id int identity(1,1) primary key,
	idTour int foreign key references Tours(id),
	CountOfPeople int,
	Duration int,
	Price real
);

insert into Trips values
(2, 4, 14, 1000), (5, 1, 7, 899), (3, 2, 7, 350), 
(1, 4, 21, 1300), (10, 2, 28, 1799), (8, 2, 7, 449),
(9, 2, 7, 500), (4, 2, 14, 900), (1, 4, 14, 499),
(2, 3, 21, 1099)

create table Orders
(
	id int identity(1,1) primary key,
	idTrip int foreign key references Trips(id),
	Custromer nvarchar(50),
	Sdate date
);
drop table Orders
insert into Orders values
('2','Ilya','2018-02-12'), (5, 'Anastason Stalmashenko','2020-06-02'), (9, 'Romax2000','2020-08-11'), 
(2, 'Nika Labovitch','2020-02-12'), (10, 'Nikita Petuh','2020-02-12'), (1, 'Polina Smart','2020-02-12'),
(1, 'Slavik Chill','2020-02-10'), (4, 'Develer12','2020-05-05'), (8, 'Polina Skripkina','2022-12-12'),
(3, 'Vodemka','20-04-2000')
select * from Orders
drop view v_Orders;
create view v_Orders as
select Custromer, Duration, CountOfPeople, Price, Name, Country, Sdate
from Orders O 
		inner join Trips T
			on O.id = T.id
		inner join Tours TT
			on TT.id = T.idTour
		inner join Ñountries C
			on TT.idCountry = C.id;

drop view v_OrdersCountry;
create view v_OrdersCountry as
select Custromer, Duration, CountOfPeople, Price, Name, Country, Sdate
from Orders O 
		inner join Trips T
			on O.id = T.id
		inner join Tours TT
			on TT.id = T.idTour
		inner join Ñountries C
			on TT.idCountry = C.id
where C.Country ='Germany' OR C.Country ='Russia';

select * from v_OrdersCountry;

select * from v_Orders;

create index ix_Ñountries on Ñountries(id);

Create Procedure AddOrder
	@pidTrip int,
	@pCustromer nvarchar(50), 
    @responseMessage nvarchar(250) output
as
Begin
    SET NOCOUNT ON

    Begin try

        Insert into Orders(idTrip, Custromer)
        values(@pidTrip, @pCustromer)

        SET @responseMessage='Success'

    End try
    Begin catch
        SET @responseMessage=ERROR_MESSAGE() 
    End catch
End

Declare
	@responseMessage nvarchar(250)
EXEC AddOrder
          @pidTrip = 4,
          @pCustromer = N'Test2',
          @responseMessage=@responseMessage OUTPUT
Select * From Orders;
Go

create function TripsOrderByPrice (@price int)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT Duration, Price, Name, Country
    FROM Trips T   
    INNER JOIN Tours TT ON T.idTour = TT.id 
    INNER JOIN Ñountries C ON TT.idCountry = C.id
    WHERE T.Price < @price  
);  

SELECT * FROM TripsOrderByPrice (1000); 

create trigger tg_insert on Orders after INSERT 
       as print 'Òðèããåð';
 return;  