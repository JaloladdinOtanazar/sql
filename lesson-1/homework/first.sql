drop table if exists student
create table student(
	id int,
	name varchar(50),
	age int
);
alter table student
alter column id int NOT NULL

insert into student(id, name, age)
values
	(1, 'james', 19),
	(2, 'john', 20);
select * from student;