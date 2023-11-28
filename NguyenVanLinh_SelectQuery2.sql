use [Global-Superstore]
-- Q1. Số lượng đơn hàng, tổng doanh số, số lượng, lợi nhuận theo Sub-Category
with Q1_cte as
	(
	select [Sub-Category], count(*) as Order_Counts, 
	sum(Sales) as Sum_Sales, 
	sum(Quantity) as Sum_Quantity,
	sum(Profit) as Sum_Profit
	from Orders
	group by [Sub-Category]
	)
select * from Q1_cte
union 
select 'Grand total',
sum(Order_Counts),
sum(Sum_Sales),
sum(Sum_Quantity),
sum(Sum_Profit)
from Q1_cte
order by Order_Counts ASC

-- Q2. Số lượng đơn hàng, tổng doanh số, số lượng, lợi nhuận theo Category và Sub-Category
select Category, [Sub-Category], count(*) as Order_Counts,
sum(Sales) as Sum_Sales,
sum(Quantity) as Sum_Quantity,
sum(Profit) as Sum_Profit
from Orders
group by Category, [Sub-Category]
order by Category ASC, Sum_Profit DESC

-- Q3. Tống doanh số và lợi nhuận của Category theo từng quý trong năm 2016 và 2017
with Q3_cte as
	(
	select Category, 
	year([Order Date]) as Order_Year, 
	DATEPART(quarter,[Order Date]) as Order_Quarter, Sales, Profit
	from Orders 
	where year([Order Date]) between 2016 and 2017 and DATEPART(quarter,[Order Date]) between 1 and 4
	)
select Category, Order_Year, Order_Quarter,
sum(Sales) as Sum_Sales,
sum(Profit) as Sum_Profit
from Q3_cte
group by Category,Order_Year, Order_Quarter
order by Category, Order_Year, Order_Quarter

-- Q4. Tỷ lệ lợi nhuận của từng Sub-Category (Profit/Sales)
with Q4_cte as
	(
	select [Sub-Category], 
	round(sum(Profit)/sum(Sales),3) as Profit_Ratio
	from Orders
	group by [Sub-Category] 
	)
select * from Q4_cte
union
select 'Profit Average', AVG(Profit_Ratio) from Q4_cte
order by Profit_Ratio DESC

-- Q5. Top 10 sản phẩm có lợi nhuận cao nhất ở Việt Nam
select top 10 [Product Name] as Top_10_Product_VN,
sum(Profit) as Sum_Profit
from Orders
where Country='Vietnam'
group by [Product Name]
order by Sum_Profit DESC

-- Q6. Các mặt hàng có lợi nhuận âm hơn 1000 trong quý 4 năm 2017
select [Product Name], 
sum(Profit) as Sum_Profit
from Orders
where Year([Order Date])=2017 and DATEPART(quarter,[Order Date])=4
group by [Product Name]
having sum(Profit) < -1000
Order by Sum(Profit) DESC

/* Q7. Số đơn hàng, tổng chi phí ship hàng, chiết khấu của từng nhóm hàng và phân khúc khách 
hàng của thị trường Asia Pacific trong quý 2 năm 2017 */
select Category, Segment, count(*) as Order_count,
sum([Shipping Cost]) as Sum_Shipping_Cost, 
sum([Discount]) as Sum_Discount
from Orders
where Market = 'Asia Pacific' and DATEPART(quarter,[Order Date])=2 and Year([Order Date])=2017
group by Category, Segment
order by Category,Segment

-- Q8. Số ngày Ship hàng theo kế hoạch
select [Ship Mode],
case 
	when [Ship Mode]='Same Day' then 0
	when [Ship Mode]='First Class' then 1
	when [Ship Mode]='Second Class' then 3
	else 6
end 
as Days_to_ship_Schedule
into Q8_Table
from Orders
group by [Ship Mode]
order by Days_to_ship_Schedule
GO
select * from Q8_Table

-- Q9
select [Order ID], [Order Date], [Ship Date], Q8_Table.*, 
Datediff(day, [Order Date], [Ship Date]) as Days_to_ship_Actual, 
case
	when Datediff(day, [Order Date], [Ship Date]) > Days_to_ship_Schedule then 'Shipped Late'
	when Datediff(day, [Order Date], [Ship Date]) = Days_to_ship_Schedule then 'Shipped On Time'
	else 'Shipped Early'
end 
as ShippingStatus
into Q9_Table
from Orders inner join Q8_Table
on Orders.[Ship Mode] = Q8_Table.[Ship Mode]
GO
select * from Q9_Table
order by [Order ID] ASC

-- Q10. Thống kê số lượng đơn hàng theo tình trạng Ship hàng
select [Ship Mode], ShippingStatus, count(*) as Order_Count from  Q9_Table
group by [Ship Mode], ShippingStatus
union
select '', '', count(*) from Q9_Table
order by [Ship Mode], ShippingStatus


