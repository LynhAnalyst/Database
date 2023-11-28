use DATA_SET
select * from Sale
select * from CustomerProfile

-- Lọc ra các SalePrice đơn vị Đô la nhưng đã được xóa '$'
SELECT SUBSTRING(SalePrice, 2, len(SalePrice)) from Sale
where SalePrice like '$%'

-- Xóa kí tự '$'
update Sale
set SalePrice = REPLACE(SalePrice, '$', '') 
where SalePrice like '$%'

-- Đặt lại các SalePrice có đơn vị Đô la sang đơn vị VNĐ (1 Đô la tương đương 23.000 VNĐ)
update Sale
set SalePrice = SalePrice * 23000 
where len(SalePrice) = 4

select SalePrice from Sale
where len(SalePrice) = 4

-- 
select CustomerProfile.* from CustomerProfile
where KH_ID = 'CTM14053'


select CustomerID from Sale
where CustomerID is Null

alter table CustomerProfile
add primary key (KH_ID)




