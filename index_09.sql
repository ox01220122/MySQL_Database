USE smart_factory;
SELECT * FROM orders;  -- AI 설정해서 이미 사용한 번호는 다시 세지 않음 
SELECT * FROM customer;

SELECT COUNT(*) FROM customer; -- 9명
SELECT COUNT(*) FROM orders;-- 19건

SELECT * FROM customer,orders; -- 조건 없는 테입르간 JOIN이 된 것 
-- a 고객이 orders의 19개 행과 결합, b 고객이 orders의 19개 행과 결합 -> 논리에 안맞음 

-- WHERE절을 이용해 JOIN조건 추가하기
-- 참고) [테이블이름.테이블명] 표기 : 특정 테이블의 열을 가르킴
SELECT * FROM customer,orders WHERE customer.custid = orders.custid; 
SELECT COUNT(*) FROM customer,orders WHERE customer.custid = orders.custid; 

-- 다른 방법
SELECT * FROM customer INNER JOIN orders ON customer.custid = orders.custid; 
SELECT * FROM customer JOIN orders ON customer.custid = orders.custid;  -- INNER생략가능
SELECT COUNT(*) FROM customer INNER JOIN orders ON customer.custid = orders.custid; 

SELECT *
	FROM customer,orders 
	WHERE customer.custid = orders.custid
	ORDER BY customer.custid;

SELECT *
	FROM customer 
    JOIN orders 
    ON customer.custid = orders.custid
	ORDER BY customer.custid;
    
   