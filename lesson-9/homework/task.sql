
--1st task

drop table if exists employees
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

select *,
DENSE_RANK() over(order by ManagerID )- 1 as depth
from Employees
order by ManagerID

--2nd task
declare @n int = 10
;with ect as (
select 1 as number, 1 as factorial
union all
select number+1, factorial * (number+1) from ect
where number < @n
)
select number, factorial from ect

--3rd task

declare @num int = 10
;with cte as (
select 1 as n, 0 as prev, 1 as curr
union all
select n+1, curr, prev + curr from cte
where n < @num
)
select n, curr as fibonacci_numbers from cte