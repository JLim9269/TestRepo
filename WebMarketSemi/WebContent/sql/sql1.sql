show tables;
select * from product;

update product set p_condition='New';

select max(p_id) from product;

select concat('P',cast(substr(max(p_id),2) as unsigned)+1) from product;

select distinct p_category from product;

update product set p_category='Tablet' where p_id='P1237';

create table category(
seq int not null auto_increment,
categoryName varchar(20) not null,
description varchar(30),
primary key(seq)
);

select * from category;

insert into category(categoryName,description) values('Smart Phone','Smart Phone');
insert into category(categoryName,description) values('Notebook','Notebook');
insert into category(categoryName,description) values('Tablet','Tablet');

/*배송테이블*/
create table sale(
seq int not null auto_increment,
saledate varchar(20),
sessionId varchar(50),
productId varchar(20),
unitprice int,
saleqty int,
status int,
primary key(seq)
)default charset=utf8;

alter table sale add column status int;
update sale set status = 1;
select productId, if(status=1,'결재완료','미정')from sale;  /*아직 안함 모름*/

/*주문테이블*/
create table delivery(
seq int not null auto_increment,
sessionId varchar(50),
name varchar(20),
deliverydate varchar(20),
nation varchar(20),
zipcode varchar(5),
address varchar(200),
primary key(seq)
)default charset=utf8;


select * from sale;
select * from delivery;

select * from sale s,delivery d,product p where s.sessionId=d.sessionId and s.productId=p.p_id;


