DML
select, insert, update, delete
DDL
create, drop, alter, rename, truncate

show tables;

drop table member;

create table if not exists member(
id varchar(10) not null,
password varchar(10) not null,
name varchar(10) not null,
gender varchar(4),
birth varchar(10),
mail varchar(30),
phone varchar(20),
postcode varchar(5),
address varchar(200),
detailAddress varchar(100),
extraAddress varchar(50),
regist_day varchar(50),
primary key(id)
)default charset=utf8;

select * from member;

select * from sale;

select * from delivery;

select * from sale s,delivery d,product p where s.productId=p.p_id and s.sessionId=d.sessionId order by s.seq

select * from member where id='hong';
select count(*) from member where id='hong';

alter table member add admin boolean;
update member set admin=true where id='hong';

insert into member values('zhang','8888','장비','남','2000/01/01','zhang@gmail.com','010-8888-8888','88888','촉','삼','국','2020-07-28',false);

alter table member drop admin;