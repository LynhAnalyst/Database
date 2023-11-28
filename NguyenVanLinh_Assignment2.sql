-- Tạo Database
CREATE DATABASE  HOUSE_LINH
GO
USE HOUSE_LINH

-- Tạo bảng
CREATE TABLE EMPLOYEES
(
	EmpID VARCHAR(5) NOT NULL PRIMARY KEY,
	Ename VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	Salary FLOAT NOT NULL,
	Gender varchar(3) NOT NULL
)
GO

CREATE TABLE HOUSES
(
	HouseID VARCHAR(5) NOT NULL PRIMARY KEY,
	Area_m2 FLOAT,
	Price FLOAT,
	BedRoom char(1),
	HouseType varchar(1)
)
GO

CREATE TABLE CUSTOMERS
(
	CustomerID VARCHAR(5) NOT NULL PRIMARY KEY,
	Gender VARCHAR(3) NOT NULL,
	Cname VARCHAR(30) NOT NULL,
	Caddress VARCHAR(30),
	Email VARCHAR(30) NOT NULL
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
	ContractValue FLOAT,
	Prepaid FLOAT,
	OutstandingAmount FLOAT
)
GO

-- Tạo khóa ngoại
ALTER TABLE CONTRACTS
ADD CONSTRAINT FK_EmpID FOREIGN KEY (EmpID) REFERENCES EMPLOYEES (EmpID),
	CONSTRAINT FK_HouseID FOREIGN KEY (HouseID) REFERENCES HOUSES (HouseID),
	CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS (CustomerID)
GO

-- Nhập dữ liệu
INSERT INTO EMPLOYEES
VALUES
('EP001','Nguyen Quang Tuan','tuan@gmail.com',20000000,'Nam'),
('EP002','Tran Dieu Nhi','nhi@gmail.com',6000000,'Nu'),
('EP003','Le Thi Oanh','oanh@gmail.com',30000000,'Nu'),
('EP004','Nguyen Trong Tan','tan@gmail.com',2500000,'Nam'),
('EP005','Nguyen Dieu Thuy','thuy@gmail.com',80000000,'Nu')
GO

INSERT INTO HOUSES
VALUES
('HO001',200,5000000,3,'A'),
('HO002',100,5000000,2,'B'),
('HO003',80,5000000,1,'A'),
('HO004',120,5000000,2,'C'),
('HO005',50,5000000,1,'B')
GO

INSERT INTO CUSTOMERS
VALUES
('CU001','Nu','Le Thi Mo', 'Hue', 'mo@gmail.com'),
('CU002','Nu','Hoang Thanh Thao', 'Hai Phong', 'thao@gmail.com'),
('CU003','Nam','Nguyen The Trung', 'Ha Noi', 'trung@gmail.com'),
('CU004','Nu','Tran Thi Mai', 'Hue', 'maii@gmail.com'),
('CU005','Nam','Nguyen Van Thanh', 'Quang Nam', 'thanh@gmail.com')
GO

INSERT INTO CONTRACTS(ContractNo,HouseID,EmpID,CustomerID,StartDate,EndDate,Prepaid)
VALUES
('CT001','HO001','EP001', 'CU001', '2020-01-01','2020-03-01',1000000),
('CT002','HO002','EP002', 'CU002', '2020-07-01', '2020-08-01',500000),
('CT003','HO003','EP003', 'CU003', '2020-09-15', '2020-12-15',1500000),
('CT004','HO004','EP004', 'CU004', '2020-02-01', '2020-11-01',2000000),
('CT005','HO005','EP005', 'CU005', '2020-06-20', '2020-10-10',1200000)
GO

select * from EMPLOYEES
select * from HOUSES
select * from CONTRACTS
select * from CUSTOMERS

