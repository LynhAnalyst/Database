USE JOB_DATA

-- Q1 Cho biết thông tin nhân viên có Skill là SQL làm việc từ 4 đến 6 năm
select * from EMPLOYEES
where Skill='SQL' and WorkingYear between 4 and 6
order by WorkingYear DESC

-- Q2  Cho biết số nhân viên theo từng Skill
select Skill, Count(*) as So_Nhan_Vien from EMPLOYEES
group by Skill
order by So_Nhan_Vien DESC

--Q3 Cho biết số nhân viên, lương (cao nhất, thấp nhất, trung bình) theo từng Skill
SELECT Skill, count(*) as So_Nhan_Vien,
MIN(Salary) as Luong_Min, 
MAX(Salary) as Luong_Max,
AVG(Salary) as Luong_TB 
FROM EMPLOYEES 
GROUP BY Skill 
order by Luong_TB DESC

-- Q4 Cho biết Số nhân viên theo từng Skill và Gender
select Skill,Gender, count(*) as So_Nhan_Vien
from EMPLOYEES 
group by Skill,Gender
order by Skill ASC, So_Nhan_Vien ASC

-- Q5 Cho biết thông tin các dự án và nhân viên có thể tham gia dự án đó
Select * from EMPLOYEES inner join PROJECTS
on EMPLOYEES.Skill = PROJECTS.Skill

-- Q6 Cho biết thông tin các nhân viên có thể tham gia dự án DA#03
Select * from EMPLOYEES inner join PROJECTS
on EMPLOYEES.Skill = PROJECTS.Skill
where ProjectID = 'DA#03'

-- Q7 Cho biết thông tin không thể tham gia dự án nào
Select EMPLOYEES.* from EMPLOYEES left outer join PROJECTS
on EMPLOYEES.Skill = PROJECTS.Skill
where ProjectID is null

-- Q8 Cho biết dự án không có nhân viên nào tham gia được
select * from PROJECTS 
where Skill <> all (select Skill from EMPLOYEES)

-- Q9 Thống kê số nhân viên theo từng Skill 
select Skill, count(*) as Skill_count
from EMPLOYEES
group by Skill 
union
select 'Skill_count', count(*) from EMPLOYEES
order by Skill_Count

-- Q10 Cho biết Skill nào dự án cần mà không có nhân viên nào có
Select Skill from PROJECTS
Except 
Select Skill from EMPLOYEES

-- Q11 Tính số lượng nhân viên thiếu cho các dự án
Select * from EMPLOYEES inner join PROJECTS 
on EMPLOYEES.Skill = PROJECTS.Skill
Select Skill, Count(*) as Skill_Count into Skill_Count
From EMPLOYEES
Group by Skill
Order by Count(*) DESC
GO

Select *, Employee_Count - iif(Skill_Count is null,0,Skill_Count) as Shortage
from Skill_count full outer join PROJECTS
on Skill_count.Skill = Projects.Skill
where Employee_Count > Skill_count or Skill_count is null
