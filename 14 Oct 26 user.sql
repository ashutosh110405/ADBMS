create database user;
show databases;
use user;
create table customer(Custid int, custname varchar(15), City varchar(15), product varchar(15), Price int);
desc customer;
alter table customer modify Custid int Primary key; -- alter table customer add primary key(Custid);
insert into customer values (1,"Om","Pune","Mobile",15000),
							(2,"Rucha","Nagpur","Laptop",40000),
                            (3,"Raj","Mumbai","Mouse",300);
select * from customer;
select custname, product from customer;
create table CloneTable as select * from customer; -- clone table
select * from CloneTable;
select * from customer;
drop table CloneTable;
/*WHERE CLAUSE*/

select custname, city from customer;
select custname, city from customer where Custid=1;
select custname, city, price from customer where price>15000;
select custname, city, price from customer where price<15000;
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

/*Sorting data order by multiple columns*/
select * from customer order by city, price;
select * from customer order by price, city;
select * from customer order by city desc, price asc;

/*Single-row functions*/
/*Case Conversion functions*/
select upper(custname), lower(product) from customer;
select upper(custname), lower(product) from customer where custid<3;

alter table customer add column LastName varchar(20);
desc customer;
select * from customer;

update customer set LastName="Malusare" where Custid=1;
update customer set LastName="Suryavanshi" where Custid=2;
update customer set LastName="More" where Custid=3;
select * from customer;

/*concat two cols*/
select concat(custname,LastName) from customer;
select concat(custname,'  ',LastName) from customer;
select concat(custname,LastName) as Fullname from customer;  -- alias name
select concat(custname,LastName) as concat_name from customer;  -- concat column name change

/** use of SUBSTR and INSTR Functions*/
Select * from customer;
Select substr(custname,1,0) from customer; -- empty
Select substr(custname,1,1) from customer;
Select substr(custname,0,1) from customer; -- empty
Select substr(custname,1,2) from customer;
Select substr(custname,1,3) from customer;
Select substr(custname,2,1) from customer;

select instr(custname, 'a') as position from customer;