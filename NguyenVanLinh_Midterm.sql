-- Tạo database 
CREATE DATABASE QuanLyKS
GO

--Tạo bảng 
CREATE TABLE PHONG
(
	MaPhong CHAR(5) NOT NULL PRIMARY KEY,
	LoaiPhong CHAR(3) NOT NULL,
	DonGia FLOAT NOT NULL,
	SucChua CHAR(1)
)

CREATE TABLE KHACHTHUE
(
	MaKhach CHAR(5) NOT NULL PRIMARY KEY,
	TenKhach VARCHAR(50) NOT NULL,
	QuocTich VARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	GioiTinh BIT NOT NULL,
	Email VARCHAR(50)
)

CREATE TABLE HOADON
(
	SoHoaDon CHAR(5) NOT NULL PRIMARY KEY,
	MaKhach CHAR(5) NOT NULL,
	MaPhong CHAR(5) NOT NULL,
	NgayLapHD DATE NOT NULL,
	NgayDen DATE NOT NULL,
	NgayDi DATE NOT NULL,
	ThoiGianThue INT,
	TienPhong FLOAT,
	ChietKhau FLOAT,
	TienThanhToan FLOAT
)

--Tạo khóa ngoại
ALTER TABLE HOADON
ADD CONSTRAINT FK_MaKhach FOREIGN KEY (MaKhach) REFERENCES KHACHTHUE (MaKhach),
	CONSTRAINT FK_MaPhong FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong)

-- Nhập dữ liệu
INSERT INTO PHONG (MaPhong,LoaiPhong,DonGia,SucChua)
VALUES
('MP001', 'VIP', 300, 3),
('MP002', 'Eco', 200, 5),
('MP003', 'VIP', 350, 3),
('MP004', 'Lux', 300, 4),
('MP005', 'Eco', 200, 6)

INSERT INTO KHACHTHUE(MaKhach,TenKhach,QuocTich,NgaySinh,GioiTinh)
VALUES
('MK001', 'Nguyen Van An', 'Viet Nam', '1999-10-25', 1),
('MK002', 'Nguyen Thi Mo', 'Trung Quoc', '1993-02-12', 0),
('MK003', 'Nguyen Quoc Manh', 'Lao', '2000-06-23' , 1),
('MK004', 'Tran Thi Loan', 'Viet Nam', '1978-09-04', 0),
('MK005', 'Nguyen Viet Hoang', 'Dai Loan', '1997-10-20', 1)

INSERT INTO HOADON (SoHoaDon,MaKhach,MaPhong,NgayLapHD,NgayDen,NgayDi)
VALUES
('HD001','MK001','MP001', '2018-01-01', '2018-01-10', '2018-01-19'),
('HD002','MK002','MP002', '2019-07-01', '2019-08-01', '2019-08-07'),
('HD003','MK003','MP003', '2021-04-15', '2020-04-20', '2020-04-27'),
('HD004','MK004','MP004', '2021-02-01', '2021-02-28', '2021-03-01'),
('HD005','MK005','MP005', '2021-10-10', '2021-10-20', '2021-10-22')

-- Q3.
UPDATE PHONG
SET DonGia = IIF(LoaiPhong='VIP',300,
IIF(LoaiPhong='Lux',150,100))

-- Q4.
UPDATE HOADON
SET ThoiGianThue=iif(DATEDIFF(day,NgayDen,NgayDi)=0,1,
DATEDIFF(day,NgayDen,NgayDi))

-- Q5.
UPDATE HOADON
SET TienPhong=ThoiGianThue*DonGia
FROM HOADON inner join PHONG
ON HOADON.MaPhong = PHONG.MaPhong

-- Q6.
UPDATE HOADON
SET ChietKhau=iif(ThoiGianThue>8,0.2,
IIF(ThoiGianThue>=6,0.1,
IIF(ThoiGianThue>=3,0.05,0)))*TienPhong

-- Q7.
SELECT LoaiPhong, COUNT(*) AS SoPhong FROM PHONG
GROUP BY LoaiPhong

-- Q8.	
SELECT LoaiPhong, COUNT(*) AS SoPhong FROM HOADON inner join PHONG
ON HOADON.MaPhong = PHONG.MaPhong
WHERE LoaiPhong='VIP' AND DATEPART(QUARTER,NgayLapHD)='2' AND ThoiGianThue>5 AND DATEPART(YEAR,NgayLapHD)='2021'
GROUP BY LoaiPhong

-- Q9.	
SELECT COUNT(HOADON.MAPHONG) AS [SoLanThue], 
SUM(ThoiGianThue) AS [TongThoiGianThue], 
AVG(ThoiGianThue) AS [ThoiGianTrungBinhThue]
FROM HOADON
WHERE DATEPART(MONTH,NgayLapHD) = 10 AND DATEPART(YEAR,NgayLapHD)=2021 AND NgayLapHD like '2021-10-%'


