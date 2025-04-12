drop table if exists products
create table products(
	product_id int NOT NULL unique,
	product_name varchar(50),
	price  float
);
alter table products
drop constraint UQ__products__47027DF4DC698FEB;
alter table products
add unique(product_id, product_name);
insert into products
values
	(1, 'nam', 2.4);

select * from products
