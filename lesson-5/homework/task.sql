drop table if exists Employees
CREATE TABLE Employees(
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
	);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'Engineering', 75000.00, '2020-03-15'),
(2, 'Jane Doe', 'Marketing', 75000.00, '2019-06-22'),
(3, 'Mike Johnson', 'Sales', 70000.00, '2021-01-10'),
(4, 'Emily Brown', 'HR', 60000.00, '2018-11-05'),
(5, 'David Lee', 'Engineering', 60000.00, '2022-07-19'),
(6, 'Sarah Wilson', 'Finance', 72000.00, '2020-09-30'),
(7, 'Tom Clark', 'Sales', 68000.00, '2019-12-12'),
(8, 'Lisa Davis', 'Marketing', 67000.00, '2021-04-25'),
(9, 'Robert Taylor', 'Engineering', 82000.00, '2017-08-03'),
(10, 'Anna White', 'HR', 62000.00, '2023-02-14');
--1st
select *, 	
ROW_NUMBER() OVER(ORDER BY Salary ) as rn
from Employees;
--2nd
select Salary, count(*) as repeats
from Employees
group by Salary
having count(*) > 1
order by Salary asc;
--3rd
select * from (
select *,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary desc) as ranks from employees
)  ranked 
where ranks < 3
ORDER BY Department, Salary DESC;
--4TH
select * from (
select *,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary ASC) as ranks from employees
)  ranked 
where ranks = 1
ORDER BY Department, Salary ASC;
--5TH
SELECT *, 
SUM(Salary) OVER(PARTITION BY Department ORDER BY EmployeeID) AS Total_Salaries
FROM Employees
ORDER BY Department;
--6TH
SELECT *, 
SUM(Salary) OVER(PARTITION BY Department ) AS Total_Salaries
FROM Employees
ORDER BY Department;
--7th
SELECT *, 
CAST(AVG(Salary) OVER(PARTITION BY Department ) AS  DECIMAL(10,2)) AS Average_Salaries
FROM Employees
ORDER BY Department;
--8TH
SELECT *,
CAST(AVG(Salary) OVER(PARTITION BY Department ) AS  DECIMAL(10,2)) AS Average_Salaries,
CAST(salary - AVG(Salary) OVER(PARTITION BY Department ) AS  DECIMAL(10,2)) AS Average_Salary_difference
from Employees
ORDER BY Department, Salary;
--9th
select *,
AVG(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Moving_avg
from Employees
ORDER BY EmployeeID, Salary;
--10TH
SELECT SUM(Salary) AS Total_salary_for_last_3 
FROM(SELECT Salary, 
	ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RN
FROM Employees) RANKED
WHERE RN < 4;
--11TH
SELECT CAST(AVG(Salary) OVER( ORDER BY HireDate) AS DECIMAL(10,2)) AS Average_salary_for_last_3 
FROM(SELECT *, 
	ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS RN
FROM Employees) RANKED
WHERE RN < 4;
--12TH
SELECT *, 
MAX(Salary) OVER(ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS Max_Salary
FROM Employees
ORDER BY HireDate;
--13TH
SELECT *, 
SUM(Salary) OVER(PARTITION BY Department) AS Total_Salary,
CAST(Salary/SUM(Salary) OVER(PARTITION BY Department)*100 AS DECIMAL(10,2)) AS percentage
FROM Employees
ORDER BY Department, Salary;