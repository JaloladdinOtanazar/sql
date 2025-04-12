use my;

drop table if exists orders
create table orders(
	order_id int primary key,
	customer_name varchar(50),
	order_date date
);
alter table orders
drop constraint PK__orders__46596229C80B8791;
alter table orders
add constraint PK_orders primary key(order_id)
