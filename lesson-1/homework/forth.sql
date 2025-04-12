use my;
drop table if exists category
create table category(
	category_id  int primary key, 
	category_name varchar(50)
);
create table item(
	item_id   int primary key, 
	item_name  varchar(50),
	category_id int foreign key references category(category_id)
);
alter table item
drop constraint FK__item__category_i__3C69FB99;

alter table item 
add constraint FK_item foreign key(category_id) references category(category_id);
