USE smart_factory;
USE new_smart_factory;

-- creat (데이터베이스 생성)
CREATE DATABASE new_smart_factory DEFAULT CHARACTER SET UTF8 DEFAULT COLLATE utf8_general_ci;
 -- 더 최신 방식 데이터베이스 생성
 -- 한글 인코딩 : 프로그래밍 언어는 영어 기반이므로 한글을 사용할 수 있도록!
 CREATE DATABASE new_smartfactory CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
 
 
 -- 테이블 생성
-- new_customer 테이블
-- custid(고객번호) CHAR(10), NOT NULL 제약조건, PK
-- custname(고객이름) VARCHAR(10), NOT NULL 제약조건
-- addr (주소) CHAR(10), NOT NULL 제약조건
-- phone (연락처) CHAR(11)
-- birth (생년월일) DATE
 
 -- 1. 기본키 제약 조건
 -- 기본키는 중복 불가능, NULL도 불가능하다 
 CREATE TABLE new_customer(
	custid CHAR(10) NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    custname VARCHAR(10) NOT NULL ,
    addr CHAR(10) NOT NULL ,
    phone CHAR(11),
    birth DATE
 );
 
 DESC new_customer;
 SELECT * FROM new_customer;
  
-- new_orders 테이블 생성
-- orderid INT, NOT NULL 제약조건, PK, 숫자 자동 증가
-- custid CHAR(10), NOT NULL 제약조건
-- prodname CHAR(6), NOT NULL 제약조건
-- price INT, NOT NULL 제약조건
-- amount smallint, NOT NULL 제약조건

-- 2. 외래키 제약조건
-- 두 테이블 사이의 관계를 맺어줌 = 다른테이블의 기본키를 현제 테이블의 외래키로 연결함 
-- 기본키를 갖는 테이블 : "기준" 테이블
-- 외래키가 있는 테이블 : "참조" 테이블
-- 혁식 : FOREIGN KEY(열_이름) REFERENCES 기준_테이블(열_이름)
-- ON UPDATE CASCADE : 기준 테이블 데이터 수정시 -> 참조 테이블 데이터도 수정
-- ON DELETE CASCADE : 기준 테이블 데이터 삭제시 -> 참조 테이블 데이터도 삭제
CREATE TABLE new_orders(
	orderid INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    custid CHAR(10) NOT NULL ,
    prodname CHAR(6) NOT NULL ,
    price INT NOT NULL,
    amount smallint NOT NULL,
    FOREIGN KEY(custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
 );

INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5); -- AI설정 해줘서 자동 숫자증가 
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);
-- 드래그 한거 모두 실행시키기 ctrl + shift + enter
DESC new_orders;
SELECT * FROM new_orders;
DESC new_customer;
SELECT * FROM new_customer;

-- 테이블 수정 
-- 새로운 속성 추가 
-- : 고객 테이블에 새로운 속성 "nickname"이 생겼음 

ALTER TABLE new_customer ADD nickname VARCHAR(10); -- NULL 값으로 들어간다 
-- 속성 수정 (다른것도 수정할 수 있는데 거의 속성변경만한다 )
-- (1) 속성의 데이터 삽입을 수정 
ALTER TABLE new_customer MODIFY nickname INT;
DESC new_customer;

ALTER TABLE new_customer CHANGE nickname n_name VARCHAR(10); 

-- 기존 속성 삭제
ALTER TABLE new_customer DROP n_name;


-- DROP 테이블 삭제 명령어
DROP TABLE new_customer; -- 고객테입르 삭제가 안된다 (외래키 연결이 되어있어서 삭제가 안된다) (기본테이블)
-- 삭제할 때 순서가 정해져있다 
DROP TABLE new_orders; -- 외래키 테이블을 먼저 삭제하고 기본 테이블을 삭제해야한다
-- new_customer 테이블과 new_orders 테이블은 custid를 기준으로 pk-fk 관계를 맺고있음
-- 즉, new_customer 테이블에 등록된 고객만 new_orders 테이블에 들어갈 수있음
-- 만약 new_orders 테이블이 있는데 new_customer 테이블을 DROP한다면?
-- new_orders에서 특정 고객의 정보를 확인하고 싶어도, 이미 new_customer 테이블이 삭제되어 알 수 없음
-- => pk-fk 관계로 연결된 테이블은 "외래키가 설정된 테이블"을 먼저 삭제해야 함.


-- DDL은 테이블이나 관계의 구조를 생성하는데 사용하는 명령어 



