create database 
use 

create table PHONGBAN
(
	MaPB char(3) not null primary key,
	TenPB nvarchar(50),
	NguoiQuanLy char(3)
)

create table NHANVIEN
(
	MaNV char(3) not null primary key,
	TenNV nvarchar(50),
	NgaySinh date,
	DiaChi nvarchar(100),
	GioiTinh numeric(1),
	Luong numeric(12),
	MaPB char(3) not null
)

create table CONGTRINH
(
	MaCT char(3) not null primary key,
	TenCT nvarchar(50),
	NgayKC date,
	NgayHT date,
	DiaDiem nvarchar(100) 
)

create table THAMGIA
(
	MaNV char(3) not null primary key,
	MaCT char(3) not null primary key,
	SoLuongNgayCong numeric(4)
)

alter table NHANVIEN
add constraint FK_MaPB foreign key (MaPB) references PHONGBAN (MaPB)

alter table THAMGIA
add constraint FK_MaCT foreign key (MaCT) references CONGTRINH (MaCT),
add constraint FK_MaNV foreign key (MaNV) references NHANVIEN (MaNV)