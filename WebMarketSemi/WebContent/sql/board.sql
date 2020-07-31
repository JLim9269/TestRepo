DML
select, insert, update, delete
DDL
create, drop, alter, rename, truncate

create table board(
num int not null auto_increment,
id varchar(20) not null,
name varchar(20) not null,
subject varchar(100) not null,
content text not null,
regist_day varchar(30),
hit int,
ip varchar(30),
primary key(num)
)default charset=utf8;

desc board;
select * from board;

select count(*) from board;
select count(*) from board where subject like '%길동%';
select * from board where subject like '%길동%';

insert into board(id,name,subject,content,regist_day,hit,ip) values('hong','홍길동','제목1','내용1','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('hong','홍길동','제목길동2','내용길동2','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('hong','홍길동','제목3','내용3','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('lim','임꺽정','제목꺽정4','내용꺽정4','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('hong','홍길동','제목5','내용5','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('iljimae','일지매','제목지매6','내용지매6','20200729',0,'127.0.0.1');
insert into board(id,name,subject,content,regist_day,hit,ip) values('hong','홍길동','제목길동7','내용길동7','20200729',0,'127.0.0.1');

select * from board order by num desc;
select * from board order by num;