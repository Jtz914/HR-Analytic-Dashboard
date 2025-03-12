
use [HR Data];

select *
from [dbo].[HR Table];

-- Employee Count
select sum(employee_count) 
as Employee_Count 
from [dbo].[HR Table];


-- Attrition Count
select count(attrition) as Attrition_Count
from [dbo].[HR Table]
where attrition='Yes';


-- Attrition_Rate
select
(CAST(SUM(CASE 
WHEN (Attrition) = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*)) * 100 AS [Attrition Rate]
FROM [dbo].[HR Table];


-- Active_Employee
SELECT COUNT(*) AS [Active Employees] 
FROM [dbo].[HR Table]
WHERE [CF_current_Employee] = 1;


-- Average Age
SELECT AVG(Age) AS [Average Age] FROM [dbo].[HR Table];


-- Attrition By Gender
SELECT 
    Gender,
    COUNT(*) AS [Attrition Count]
FROM [dbo].[HR Table]
WHERE Attrition = 'Yes'
GROUP BY Gender;


-- Department-wise Attrition
SELECT 
    Department,
    COUNT(*) AS [Attrition Count]
FROM [dbo].[HR Table]
WHERE Attrition = 'Yes'
GROUP BY Department;


-- Employees by Age Group
select CF_age_band, Gender, sum(Employee_Count)as Total from [dbo].[HR Table]
group by CF_age_band, Gender
order by CF_age_band, Gender desc
;


-- Education Field-wise Atrrition
SELECT 
Education_Field,
COUNT(*) AS [Attrition_Count]
FROM [dbo].[HR Table]
WHERE Attrition = 'Yes'
GROUP BY Education_Field
;


-- Job Satisfaction Rating
SELECT 
    Job_Role,
    COALESCE([1], 0) AS one,
    COALESCE([2], 0) AS two,
    COALESCE([3], 0) AS three,
    COALESCE([4], 0) AS four
FROM (
    SELECT 
        Job_Role,
        Job_Satisfaction,
        SUM([Employee_Count]) AS employee_count
    FROM [dbo].[HR Table]
    GROUP BY Job_Role, Job_Satisfaction
) AS src
PIVOT (
    SUM(Employee_Count)
    FOR Job_Satisfaction IN ([1], [2], [3], [4])
) AS pvt
ORDER BY Job_Role;

