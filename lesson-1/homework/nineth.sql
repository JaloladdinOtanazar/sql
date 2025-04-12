create database library;
use library;
go
drop table if exists loan;
drop table if exists members;
drop table if exists book;
create table book(
	book_id  int primary key,
	title varchar(50),
	author varchar(50),
	published_year int
);
create table members(
	member_id  int primary key,
	name varchar(50),
	email varchar(50),
	phone_number varchar(50)
);
create table loan (
	loan_id  int primary key,
	book_id int foreign key references book(book_id),
	member_id int foreign key references members(member_id),
	loan_date date NOT NULL,
	return_date date
);


INSERT INTO book (book_id, title, author, published_year)
VALUES 
(1, '1984', 'George Orwell', 1949),
(2, 'To Kill a Mockingbird', 'Harper Lee', 1960),
(3, 'Sapiens', 'Yuval Noah Harari', 2011);
INSERT INTO members (member_id, name, email, phone_number)
VALUES 
(1, 'Alice Smith', 'alice@example.com', '123456789'),
(2, 'Bob Johnson', 'bob@example.com', '987654321');
INSERT INTO loan (loan_id, book_id, member_id, loan_date, return_date)
VALUES 
(1, 1, 1, '2024-04-01', '2024-04-10'),  -- Alice borrowed 1984
(2, 2, 1, '2024-04-05', NULL),          -- Alice borrowed To Kill a Mockingbird (not returned)
(3, 1, 2, '2024-04-12', NULL);          -- Bob borrowed 1984 later (not returned yet)

select* from book
select* from members
select* from loan