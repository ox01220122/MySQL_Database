-- DML : SELECT, INSERT, UPDATE, DELETE
USE new_smart_factory;


-- 순서 바꿀 수 있지만 속성명과 값이 차례대로 대응되어야 한다 
INSERT INTO new_customer (custid,custname,addr,phone,birth) 
	VALUES ('lucky','강혜원','미국 뉴욕','01022223333','2002-03-05');
-- 순서대로 입력했을 경우 동일한 문장
INSERT INTO new_customer VALUES ('lucky','강혜원','미국 뉴욕','01022223333','2002-03-05');
    

INSERT INTO new_customer (birth,custid,custname,addr,phone) 
	VALUES ('2007-04-28','wow','이지은','대한민국 부산','01098765432');

-- 여러 고객 정보를 동시에 추가하고 싶으면 INSERT문을 여러번 작성하면 되나요?
-- YES 그러나 더 간편한 방법이 있다
INSERT INTO new_customer VALUES 
	('asdf', '강세희', '대한민국 부산', '01033331235', '2004-11-11'),
	('sdfg', '윤지성', '일본 도쿄', '01033331236', '1995-02-15'),
    ('dfgh', '이재은', '미국 뉴욕', '01033331237', '2004-06-07');


-- <UPDATE>
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid='apple';

SET sql_safe_updates=0; -- 이 명령어는 한번만 사용가능
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid LIKE '%y'; 
-- 안전해제하는 명령어로 임시로 풀고바꿔준다 

DELETE FROM new_customer WHERE custid='happy';
DELETE FROM new_customer WHERE custid='kiwi'; 

-- 외래키 연결되어있는 경우 연쇄삭제가 가능하다 
SELECT * FROM new_customer ;
SELECT * FROM new_orders ;

-- DDL : CREAT, ALTER, DROP
-- DML : SELECT, INSERT, UPDATE, DELETE










