use my;
drop table if exists books
create table books(
	book_id  int primary key identity, 
	title varchar(50) NOT NULL,
	price float check(price > 0),
	genre varchar(50) default 'Unknown'
);
-- Insert with all fields
INSERT INTO books (title, price, genre)
VALUES ('The Alchemist', 15.99, 'Fiction');

-- Insert without genre (uses default)
INSERT INTO books (title, price)
VALUES ('Zero to One', 20.00);
select * from books