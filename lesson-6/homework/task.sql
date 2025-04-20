drop table if exists department;
create table department(
DepartmentID int primary key,
DepartmentName varchar(50)
);
insert into department
values
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');
drop table if exists employee;
create table employee(
EmployeeID int primary key identity,
Name varchar(50),
DepartmentID int foreign key references department(DepartmentID),
Salary int
);
insert into employee
values 
('Alice', 101, 60000),
('Bob', 102, 70000),
('Charlie', 101, 65000),
('David', 103, 72000),
('Eva', NULL, 68000);
drop table if exists project;
create table project(
ProjectID int primary key identity,
ProjectName	varchar(50),
EmployeeID int foreign key references employee(EmployeeID)
);
insert into project
values
('Alpha', 1),
('Beta', 2),
('Gamma', 1),
('Delta', 4), 
('Omega', NULL);

--INNER JOIN
select e.Name as Empname, d.DepartmentName as Depname
from department as d
inner join employee as e
	on e.DepartmentID = d.DepartmentID;
--LEFT JOIN
select e.Name as Empname, d.DepartmentName as Depname
from employee as e
left join department as d
	on d.DepartmentID = e.DepartmentID;
-- RIGHT JOIN
select e.Name as Empname, d.DepartmentName as Depname
from department as d
left join employee as e
	on d.DepartmentID = e.DepartmentID;
-- FULL OUTER JOIN
select e.*, d.*
from department as d
full outer join employee as e
	on e.DepartmentID = d.DepartmentID
-- JOIN with Aggregation
--select sum(e.Salary) over(partition by d.DepartmentName order by e.salary), d.DepartmentName as Depname
--from department as d
--left join employee as e
--	on e.DepartmentID = d.DepartmentID;
--select  * from employee

select sum(e.Salary) as salary, d.DepartmentName as Depname
from department as d
left join employee as e
	on e.DepartmentID = d.DepartmentID
group by d.DepartmentName;
--CROSS JOIN
--1st way
select * from department, project;
--2nd way
select * from department
cross join project;
--MULTIPLE JOINS
select e.Name as EmpName, d.DepartmentName as DepName, p.ProjectName
from department d
right join employee as e
	on e.DepartmentID = d.DepartmentID
left join project as p
	on e.EmployeeID = p.EmployeeID