--1st task 
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

 insert into #EmployeeTransfers
 select EmployeeID, Name,
	case
		when department = 'HR' then 'IT'
		when department = 'IT' then 'Sales'
		else 'HR'
	end,
	salary
	from Employees
select * from #EmployeeTransfers


--2nd task


CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);



--EXECUTE ALL THE QUERY AT THE SAME TIME BELOW TO WORK 

declare @MissingOrders table (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

insert into @MissingOrders
select * from
(
	select o1.* from Orders_DB1 as o1
	left join Orders_DB2 as o2
		on o1.OrderID = o2.OrderID
	where o2.OrderID IS NULL
) as tab;

SELECT	* FROM @MissingOrders


--3RD TASK


CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);


CREATE VIEW vw_MonthlyWorkSummary AS
SELECT w.EmployeeID, w.EmployeeName, w.Department ,
	sum(w.HoursWorked) TotalHoursWorked,
	sum(w.HoursWorked) TotalHoursDepartment,
	avg(w.HoursWorked) AvgHoursDepartment
		  FROM WorkLog w
	group by w.EmployeeID, w.EmployeeName, w.Department

select * from vw_MonthlyWorkSummary
