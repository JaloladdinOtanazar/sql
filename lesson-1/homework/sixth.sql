use my;
drop table if exists customer
create table customer(
	customer_id  int primary key, 
	name varchar(50),
	city varchar(50) default 'Unknown'
);
alter table customer drop constraint DF__customer__city__4CA06362;
alter table customer add constraint DF_city default 'Unknown' for city