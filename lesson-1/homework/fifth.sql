use my;
drop table if exists account;
create table account(
	account_id int primary key,
	balance float check (balance >= 0),
	account_type varchar(max) check (account_type in ('Saving', 'Checking'))
);
alter table account drop constraint CK__account__balance__440B1D61; 
alter table account DROP CONSTRAINT CK__account__account__44FF419A;
alter table account add constraint CK__balance check(balance>=0); 
alter table account add CONSTRAINT CK__accounttype check(account_type in ('Saving', 'Checking'));