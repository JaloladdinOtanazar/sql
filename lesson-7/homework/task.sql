drop table if exists Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);
drop table if exists Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');


-- 1st task
select c.CustomerName, o.OrderID, o.OrderDate
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID;
-- 2nd task
select c.CustomerName, o.OrderID
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID 
where o.OrderID is NULL;

--3rd task
 select d.OrderID, d.Quantity, p.ProductName
 from OrderDetails as d
join Products as p
	on p.ProductID = d.ProductID;

--4th task

select c.CustomerName, count(c.CustomerName) as orders_count
from Customers as c
left join Orders as o
	on c.CustomerID = o.CustomerID
where o.OrderID is not null
group by c.CustomerName;

--5th task
--1st way
select d.OrderID,  max(d.Price) as maxPrice
 from OrderDetails as d 
join Products as p
	on p.ProductID = d.ProductID
group by d.OrderID;

--2nd way
select d.OrderID, p.ProductName, d.Price from OrderDetails as d
join Products as p
	on d.ProductID = p.ProductID
where d.Price = (
select max(d1.Price) from OrderDetails as d1
where d1.OrderID = d.OrderID
)
order by d.OrderID;

--6th task

select c.CustomerName, o.OrderID, o.OrderDate
from Customers as c
join Orders as o
	on c.CustomerID = o.CustomerID
where o.OrderDate=(
select max(o1.OrderDate) from Orders as o1
where o1.CustomerID = o.CustomerID
)
order by c.CustomerName;

--7th task
select * from Customers
select * from Orders
select * from OrderDetails
select * from Products
select c.CustomerName
from Customers as c
join Orders as o
	on o.CustomerID = c.CustomerID
join OrderDetails as d
	 on d.OrderID = o.OrderID
join Products as p
	on p.ProductID = d.ProductID
group by c.CustomerName
having count(case when p.Category = 'Electronics' then p.Category end) > 0
	and count( case when p.Category != 'Electronics' then p.Category end) = 0

--8th task

select c.CustomerName
from Customers as c
join Orders as o
	on o.CustomerID = c.CustomerID
join OrderDetails as d
	 on d.OrderID = o.OrderID
join Products as p
	on p.ProductID = d.ProductID
group by c.CustomerName
having count(case when p.Category = 'Stationery' then p.Category end) > 0

--9th task

select c.CustomerID, c.CustomerName, sum(d.Price) as TotalSpent
from Customers as c
join Orders as o
	on o.CustomerID = c.CustomerID
join OrderDetails as d
	 on d.OrderID = o.OrderID
group by c.CustomerID, c.CustomerName
