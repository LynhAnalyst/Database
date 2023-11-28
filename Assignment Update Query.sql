create database HOTEL_DB
go
use HOTEL_DB

--Q1 Thêm cột RoomType
alter table Data
add RoomType char(1)
go
update Data
set RoomType = left (RoomID,1)
go

--Q2 Thêm cột Floors
alter table Data
add Floors char(1)
go
update Data
set Floors = substring (RoomID,2,1)
go

--Q3 Thêm cột Nationality
alter table Data
add Nationality char(2)
go
update Data
set Nationality = left (CustomerID,2)
go

--Q4 Thêm cột  CustomerType
alter table Data
add  CustomerType varchar(6)
go
update Data
set CustomerType = iif(RIGHT(CustomerID,1) = 'G','Group','Single')
go

--Q5 Thêm cột  Age
alter table Data
add  Age float
go
update Data
set Age = DATEDIFF(year, DateOfBirth,getdate())
go

--Q6 Thêm cột  UnitPrice
alter table Data
add  UnitPrice float
go
update Data
set UnitPrice = iif(RoomType = 'A','200',
iif(RoomType = 'B','150',
iif(RoomType = 'C','100','80')))
go

--Q7 Thêm cột Duration
alter table Data
add Duration float
go
update Data
set Duration = iif(DATEDIFF(day,DateCheckin,DateCheckout)=0,1,
DATEDIFF(day,DateCheckin,DateCheckout))
go

--Q8 Thêm cột RoomMoney
alter table Data
add RoomMoney float
go
update Data
set RoomMoney =  Duration * UnitPrice
go

--Q9 Thêm cột Discount
alter table Data
add Discount int
go
update Data
set Discount = iif(Duration>10,0.2,
iif(Duration>=6,0.1,
iif(Duration>=3,0.05,0))) * RoomMoney
go

--Q10 Thêm cột TotalPaid
alter table Data
add TotalPaid int
go
update Data
set TotalPaid = RoomMoney - Discount + 0.1*RoomMoney
go

select * from Data
