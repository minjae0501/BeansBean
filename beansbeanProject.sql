
--sys 관리자계정에서 생성
-- id: beansbean / pw: beansbean
create user beansbean IDENTIFIED by beansbean;
grant connect, resource to beansbean;

 --Goods 테이블 
  create table goods
  ( gCode varchar2(20) CONSTRAINT goods_gCode_PK PRIMARY KEY, 
    gcategory varchar2(10) not null,
	gName varchar2(50) not null,
	gPrice NUMBER(10) not null,
    variation VARCHAR2(300),
    bundle VARCHAR2(300),
	gAmount INT ,
    gImage varchar2(20)
  );   
  
  -- Member 테이블 
  create table member
  (
    userid VARCHAR2(20) constraint member_userid_pk primary key,
    passwd VARCHAR2(20) not null,
    username VARCHAR2(20)not null,
    usercode number(2) ,
    post number(10) not null, 
    addr1 VARCHAR2(30) not null,
    addr2 VARCHAR2(30) not null,
    phone1 number(3) not null,
    phone2 number(4) not null,
    phone3 number(4) not null,
    email1 VARCHAR2(30) not null,
    email2 VARCHAR2(30) not null
  );
  
  -- Cart 테이블 
  create table cart
  (  num int constraint cart_num_pk PRIMARY KEY,
     userid VARCHAR2(20),
     gCode varchar2(20) ,
     gName varchar2(50) not null,
	 gPrice NUMBER(10) ,
     variation varchar2(50) ,
	 bundle varchar2(50)  ,
     gAmount INT not null,
     gImage varchar2(20) not null
  );   
  
   alter table cart
   add CONSTRAINT cart_userid_fk FOREIGN KEY(userid)
   REFERENCES member(userid) ON DELETE CASCADE;
   
   alter table cart
   add CONSTRAINT cart_gCode_fk FOREIGN KEY(gCode)
   REFERENCES goods(gCode) ON DELETE CASCADE;  
   
   -- orderinfo 테이블
  create table orderinfo
  (
     num int constraint orderinfo_num_pk PRIMARY KEY,
     userid VARCHAR2(20) not null,
     gCode varchar2(20) not null, 
     gName varchar2(50) not null,
	 variation varchar2(50) not null ,
	 bundle varchar2(50) not null,
     gPrice NUMBER(10) not null,
     gAmount INT not null,
     ordername VARCHAR2(20) not null , 
     post number(10) not null, 
     addr1 VARCHAR2(30) not null,
     addr2 VARCHAR2(30) not null,
     phone1 number(3) not null,
     phone2 number(4) not null,
     phone3 number(4) not null,
     paymethod varchar(10) not null,
     orderday date,
     gImage varchar2(20)
  );
  
   alter table orderinfo
   add CONSTRAINT orderinfo_userid_fk FOREIGN KEY(userid)
   REFERENCES member(userid) ON DELETE CASCADE;
   
   alter table orderinfo
   add CONSTRAINT orderinfo_gCode_fk FOREIGN KEY(gCode)
   REFERENCES goods(gCode) ON DELETE CASCADE; 
   
   --  게시판 생성 
  --re_board 테이블 (래시피보드)
  
CREATE TABLE cook_BRD
(
    num INT constraint cook_BRD_num_pk PRIMARY KEY, 
    userid VARCHAR(20), 
    type_num number(2), 
    title VARCHAR(50) ,
	content VARCHAR(1000) , 
    ingrement VARCHAR2(500),
    regdate date   
);

alter table cook_BRD
 add CONSTRAINT cook_BRD_userid_fk FOREIGN KEY(userid)
 REFERENCES member(userid) ON DELETE CASCADE;

-- bu_board 테이블 생성(비즈니스 보드)
CREATE TABLE info_BRD
(
    num INT constraint info_BRD_num_pk PRIMARY KEY, 
    userid VARCHAR(20),
    type_num number(2),
    title VARCHAR(50) NOT NULL,
	content VARCHAR(1000) NOT NULL, 
    regdate  DATE not null
);
  
 alter table info_BRD
 add CONSTRAINT info_BRD_userid_fk FOREIGN KEY(userid)
 REFERENCES member(userid) ON DELETE CASCADE;

------------------------시퀀스 생성----------
create sequence cart_seq;
create sequence orderinfo_seq;
create sequence cook_BRD_seq;   
create sequence info_BRD_seq;  
  