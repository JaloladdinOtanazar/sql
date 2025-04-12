use my;
drop table if exists invoice;
create table invoice(
	invoice_id int primary key identity,
	amount float
);
insert into invoice(amount)
values (1.3);

SET IDENTITY_INSERT invoice ON
insert into invoice(invoice_id, amount)
values (13, 1.3);
select * from invoice;
