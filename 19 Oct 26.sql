create database user;
show databases;
use user;
create table customer(Custid int, custname varchar(15), City varchar(15), product varchar(15), Price int);
desc customer;
alter table customer modify Custid int Primary key;
insert into customer values(1, 'om', 'Pune', 'Mobile', 15000);
insert into customer values(2, 'ruca', 'nagpur', 'Mobile', 40000);
insert into customer values(3, 'raj', 'Mumbai', 'Mobile', 300);

select * from customer;
select custname, product from customer;

create table cloneTable as select * from customer;
select * from Clonetable;

/* where clause */
select custname, city from customer;

select custname, city from customer where custid=1;

select custname, product, price from customer where price > 15000;
 
 select custname, product from customer where price < 15000;
 
 select * from customer where price<=15000;
select * from customer where custid=1;
select * from customer where city="Nagpur";

/*Sorting data using order by single column*/
select * from customer order by price;
select * from customer order by price desc;
select * from customer order by Custid;
select * from customer order by Custid desc;
select * from customer order by price asc;
select * from customer order by city asc;

/* Sorting data order by multiple columns */
select * from customer order by city, price;
select * from customer order by price, city;
select * from customer order by city desc, price asc;

select upper(custname), lower(product) from customer
where custid<3; /* uppercase & lower case function */ 

alter table customer add column lastname varchar(15);
select * from customer;

update customer set lastname='sharma' where custid=1;
update customer set lastname='Rao' where custid=2;
update customer set lastname='girl' where custid=3;

/* concat two column */
select concat(custname,lastname) from customer;

select concat(custname,' ',lastname) from customer; /* concat two column*/

select * from customer;
select substr(custname,1,3) from customer;

select instr(custname, 'a') as position from customer; -- 
select substr(custname,1,2);

select substr(custname,1,3), instr(custname,'a')
from customer where custid<3;
select * from customer;

select now();
select now() as current_datetime;

alter table customer ADD column date date;

update customer set date='2024-10-26' where custid=1;
update customer set date='2024-10-27' where custid=2;
update customer set date='2024-10-28' where custid=3;

alter table customer drop column date;
