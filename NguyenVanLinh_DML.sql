--Q1 Tạo Database
CREATE DATABASE HOUSEDB
GO
USE HOUSEDB

-- Tạo bảng
CREATE TABLE EMPLOYEES
(
	EmpID VARCHAR(5) NOT NULL PRIMARY KEY,
	Ename VARCHAR(50) NOT NULL,
	Email VARCHAR(50) not null,
	Salary int NOT NULL,
	Gender bit NOT NULL
)
GO

CREATE TABLE HOUSES
(
	HouseID VARCHAR(5) NOT NULL PRIMARY KEY,
	Area_m2 int not null,
	Price int not null,
	BedRoom char(1) not null,
	HouseType varchar(9) not null
)
GO

CREATE TABLE CUSTOMERS
(
	CustomerID VARCHAR(5) NOT NULL PRIMARY KEY,
	Gender bit NOT NULL,
	Cname VARCHAR(50) NOT NULL,
	Caddress VARCHAR(150) not null,
	Email VARCHAR(50) not null
)
GO

CREATE TABLE CONTRACTS
(
	ContractNo VARCHAR(5) NOT NULL PRIMARY KEY,
	HouseID VARCHAR(5) NOT NULL,
	EmpID VARCHAR(5) NOT NULL,
	CustomerID VARCHAR(5) NOT NULL,
	StartDate date not null,
	EndDate date not null,
	Duration INT,
	ContractValue int,
	Prepaid int,
	OutstandingAmount int
)
GO

-- Tạo khóa ngoại
ALTER TABLE CONTRACTS
ADD CONSTRAINT FK_EmpID FOREIGN KEY (EmpID) REFERENCES EMPLOYEES (EmpID),
	CONSTRAINT FK_HouseID FOREIGN KEY (HouseID) REFERENCES HOUSES (HouseID),
	CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS (CustomerID)
GO

--Q2 Nhập dữ liệu (Đơn vị tiền:$)
INSERT INTO EMPLOYEES(EmpID,Ename,Email,Salary,Gender)
VALUES
('EP001','Nguyen Quang Tuan','qtuan06@gmail.com',500,1),
('EP002','Tran Dieu Nhi','tdnhi@gmail.com',350,0),
('EP003','Le Thi Oanh','oanh12@gmail.com',530,0),
('EP004','Nguyen Trong Tan','ntt@gmail.com',175,1),
('EP005','Nguyen Dieu Thuy','thuy22@gmail.com',880,0)
GO

INSERT INTO HOUSES(HouseID,Area_m2,Price,BedRoom,HouseType)
VALUES
('HO001',200,150,2,'Apartment'),
('HO002',300,400,3,'Villa'),
('HO003',100,800,1,'Family'),
('HO004',80,1000,0,'Office'),
('HO005',120,55,2,'Family')
GO

INSERT INTO CUSTOMERS(CustomerID,Gender,Cname,Caddress,Email)
VALUES
('CU001',0,'Le Thi Mo', 'Hue', 'mo20@gmail.com'),
('CU002',0,'Hoang Thanh Thao', 'Hai Phong', 'thao22@gmail.com'),
('CU003',1,'Nguyen The Trung', 'Ha Noi', 'nttrung@gmail.com'),
('CU004',0,'Tran Thi Mai', 'Hue', 'maii12@gmail.com'),
('CU005',1,'Nguyen Van Thanh', 'Quang Nam', 'nvthanh@gmail.com')
GO

INSERT INTO CONTRACTS(ContractNo,HouseID,EmpID,CustomerID,StartDate,EndDate,Prepaid)
VALUES
('CT001','HO001','EP001', 'CU001', '2020-01-01','2021-03-01',350),
('CT002','HO002','EP002', 'CU002', '2020-05-01', '2020-11-01',88),
('CT003','HO003','EP003', 'CU003', '2020-09-15', '2021-06-15',250),
('CT004','HO004','EP004', 'CU004', '2020-10-01', '2021-10-01',65),
('CT005','HO005','EP005', 'CU005', '2020-05-20', '2020-10-10',520)
GO

/*Q3 Đặt lại giá thuê nhà theo HouseType như sau: 
“Apartment”: $200/tháng; “Family”: $300/tháng; “Office”:$500/tháng; “Villa”: $1000/tháng*/
update HOUSES
set Price=iif(HouseType='Apartment',200,
iif(HouseType='Family',300,
iif(HouseType='Office',500,1000)))
go

--Q4 Giảm giá tất cả các nhà cho thuê 10%, trừ loại nhà là “Office”
update HOUSES
set Price=Price*0.9
where HouseType <> 'Office'
go

--Q5 Tính thời gian thuê nhà (theo tháng)
update CONTRACTS
set Duration = DATEDIFF(month,StartDate,EndDate)
go

--Q6 Tính giá trị hợp đồng = thời gian thuê * giá thuê
update CONTRACTS
set ContractValue = Duration * Price
from HOUSES inner join CONTRACTS
on HOUSES.HouseID = CONTRACTS.HouseID
go

/*Q7 Tính đặt trước như sau: 
Thuê >12 tháng, đặt trước 40% giá trị hợp đồng
Thuê từ 7 đến 12 tháng, trả trước 60% giá trị hợp đồng
Thuê từ 4 đến 6 tháng, trả trước 75% giá trị hợp đồng
Thuê dưới 4 tháng, trả trước 100% giá trị hợp đồng*/
update CONTRACTS
set Prepaid = iif(Duration>12,0.4,
iif(Duration>=7,0.6,
iif(Duration>=4,0.75,1)))*ContractValue
go

/*Q8 Thêm cột Discount, và tính giá trị cho cột này như sau:
Nếu loại nhà thuê là “Apartment” và “Family”: chiết khấu (Discount) =15% giá trị hợp đồng;
“Office”: chiết khấu =20% giá trị hợp đồng; “Villa”: chiết khấu =25% giá trị hợp đồng*/
alter table CONTRACTS
add Discount float
go
update CONTRACTS
set Discount = iif(HouseType='Apartment',0.15,
iif(HouseType='Family',0.15,
iif(HouseType='Office',0.2,0.25)))*ContractValue
from HOUSES inner join CONTRACTS
on HOUSES.HouseID = CONTRACTS.HouseID
go

/*Q9 Tính cột còn lại = Giá trị hợp đồng - đặt trước – chiết khấu + thuế (thuế = 10% giá trị hợp đồng)*/
update CONTRACTS
set OutstandingAmount = 1.1*ContractValue - Prepaid - Discount
go

select * from EMPLOYEES
select * from HOUSES
select * from CONTRACTS
select * from CUSTOMERS
