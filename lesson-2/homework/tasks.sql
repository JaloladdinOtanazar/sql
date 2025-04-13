create database homework;
use homework;

-- 1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)

drop table if exists test_identity;
create table test_identity(
	id int primary key identity,
	names varchar(50)
);
insert into test_identity(names)
values ('John'), ('James'), ('Jack'), ('Josh'), ('Jost');

select * from test_identity;

-- USING DELETE
delete from test_identity where id=5;
delete from test_identity;
insert into test_identity
select 'Joshua'
--after using delete it deletes all the things in the table, but when inserting the new row the identity continues from the next number.

--USING TRUNCATE
TRUNCATE table test_identity;
insert into test_identity(names)
values ('John'), ('James'), ('Jack'), ('Josh'), ('Jost');
select * from test_identity;
-- but in truncate differing from delete, it drops all the thing including the indentity next number, which is the order

-- USING DROP
drop table test_identity;
-- difference of drop from delete and truncate is it deletes everything with the table itself, after drop there will be nothing left even the table itself


--2. Common Data Types

drop table if exists data_types_demo;
create table data_types_demo(
	id UNIQUEIDENTIFIER,
	num int,
	big bigint,
	demo decimal(10,2),
	floats float,
	nam varchar(50),
	dates date,
	times time,
	date_and_time datetime
	);
insert into data_types_demo
values (NEWID(), 2000000, 2000000000000, 1224422.97, 12.53565, 'Jaquiline', '1245-04-20', '09:11:59:12', GETDATE());
select * from data_types_demo;


--3. Inserting and Retrieving an Image

create table photos(
	id int primary key,
	photo varbinary(max)
);
insert into photos
select 1, bulkcolumn from openrowset(
BULK 'D:\sql_homework\homework\homework\sql\lesson-2\homework\image.jpg', SINGLE_BLOB
) as col
select * from photos;


--4. Computed Columns

create table student (
	id int primary key identity,
	classes int,
	tuition_per_class decimal(10,2),
	total_tuition as (classes * tuition_per_class)
);
insert into student(classes, tuition_per_class)
values
(1, 120000.00),
(3, 130000.10),
(4, 111111.11),
(6, 300000.41),
(2, 150000.00);
select * from student;

--5. CSV to SQL Server
drop table if exists worker;
create table worker(
	id int,
	names varchar(50)
);
--delete from worker;
BULK INSERT worker
FROM 'D:\sql_homework\homework\homework\sql\lesson-2\homework\worker.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);
select * from worker;






