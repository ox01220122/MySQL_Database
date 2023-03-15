USE smart_factory;
SELECT * FROM orders;  -- AI 설정해서 이미 사용한 번호는 다시 세지 않음 
SELECT * FROM customer;

SELECT COUNT(*) FROM customer; -- 9명
SELECT COUNT(*) FROM orders;-- 19건

SELECT * FROM customer,orders; -- 조건 없는 테이블간 JOIN이 된 것 
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
    
-- 고객별로 주문한 제품 총 구매액을 고객별로 정렬
-- 실행결과 (고객이름, 총 구매액)

SELECT customer.custname, COUNT(price)
	FROM customer, orders  
	WHERE customer.custid = orders.custid 
	ORDER BY customer.custid;

-- 고객별로 주문한 제품 총 구매액 조회 (단, 고객 이름 순으로 정렬)
-- 실행결과 (고객이름, 총 구매액)
SELECT custname, SUM(amount * price) as 'total_price'
	FROM customer 
    INNER JOIN orders 
    ON customer.custid = orders.custid
	GROUP BY custname
    ORDER BY custname;
-- ORDER BY는 GROUP BY의 뒤에 나온다 

SELECT * FROM customer;

-- 서브쿼리 , 부속질의
-- SQL문 내에 또 다른 SQL문 작성 
-- SELECT문의 WHERE절에 또 다른 테이블 경과를 이용해서 다시 SELECT문을 괄호로 묶는다!
-- 메인쿼리 : SELECT FROM WHERE (서브쿼리 : SELECT ~ FROM ~~);
-- STEP 1. 주문 금액이 가장 큰 주문 내역은 무엇인가
SELECT * FROM orders;
SELECT MAX(price*amount) as 'max' FROM orders;
-- STEP 2. 주문금액이 가장 큰 주문 금액에 대한 주문아이디, 고객아이디, 상품명조회
SELECT orderid,custid, prodname 
	FROM orders 
    WHERE price*amount = 10000;
-- STEP 3. 서브 쿼리를 이용해 두 SQL문을 하나로 합치기
SELECT orderid,custid, prodname 
	FROM orders 
    WHERE price*amount = (SELECT MAX(price*amount) as 'max' FROM orders);
-- 한번에 검색을 할 수 있다. 서브쿼리 !


-- 주문 이력이 있는 고객 조회 
SELECT custname FROM customer WHERE custid IN (SELECT custid FROM orders);

SELECT orderid, custid, prodname FROM orders 
	WHERE price * amount < (SELECT AVG(price * amount) FROM orders);
    




    
