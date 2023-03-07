USE smart_factory;
-- 데이터베이스 규칙 (소문자, 언더바) -> 회사마다 달라용
/*
	주석 !         단축키 : crtl + / 
*/
SELECT * FROM customer; -- 고객테이블의 모든 정보를 조회 
SELECT * FROM orders;  -- 주문테이블의 모든 정보를 조회 
SELECT custid FROM customer;  -- 모든 고객의 고객아이디를 검색
SELECT custid,birth FROM customer; -- 고객아이디와 생년월일을 검색 
SELECT birth,custid FROM  customer; -- 생년월일과 고객아이디 검색 (순서가 있다)
-- 모든 고객의 아이디, 주소, 전화번호, 이름 , 생년월일 검색
SELECT custid, addr,phone,custname,birth FROM  customer; 
-- (와일드카드사용) 모든 고객의 아이디,이름,주소,전화번호,생년월일
-- * : ALL, 모든것을 의미한다. 
SELECT * From customer;
-- 고객 테이블에 있는 모든 주소를 검색 (중복 포함된 결과)
SELECT addr FROM customer;
-- 고객 테이블에 있는 중복을 제외한 주소 검색
SELECT DISTINCT addr FROM customer; -- 중복값을 제거해서 보여준다
-- <where절> 
-- 비교: =,<,<=,>,>=
-- 고객 이름이 강해린인 고객을 검색 
SELECT * FROM customer where custname = '강해린';
SELECT  * FROM orders;
SELECT  * FROM orders where price>='4000';-- 제품가격이 4000원 이상인 주문내역을 검색
-- 범위 : BETWEEN a AND b
-- 1995년이상 2000년 이하 출생고객 검색
SELECT  * FROM customer WHERE birth BETWEEN '1995-01-01' AND '2000-12-31';
SELECT  * FROM customer WHERE birth >= '1995-01-01' and birth <= '2000-12-31';

-- 집합
-- 주소가 서울 혹은 런던인 고객 검색 
SELECT * FROM customer WHERE addr IN('대한민국 서울','영국 런던'); 
SELECT * FROM customer WHERE addr='대한민국 서울' or addr='영국 런던';

-- 주소가 서울 혹은 런덴이 아닌 고객 검색
SELECT * FROM customer WHERE addr NOT IN('대한민국 서울','영국 런던'); 
SELECT * FROM customer WHERE addr!='대한민국 서울' and addr!='영국 런던';

-- 패턴(like) : 특정 패턴을 포함하는 데이터를 검색 
-- 주소가 '미국 로스앤젤레스'인 고객 검색
SELECT * FROM customer where addr LIKE '미국 로스앤젤레스'; -- =과 같은 의미 
SELECT * FROM customer WHERE addr LIKE '대한민국 서울' or addr LIKE '영국 런던';
SELECT * FROM customer WHERE addr='대한민국 서울' or addr='영국 런던';
-- 이렇게 두개 같은 의미 (NOT LIKE도 있다)
-- % : 0개 이상의 어떤 문자 
-- _ : 1개 이상의 단일 문자 
SELECT * FROM customer;
SELECT * FROM customer WHERE addr LIKE '미국%'; -- =, IN사용은 안된다 
-- 검출 가능한 케이스 예시 : '미국', '미국 ', '미국 워싱턴', '미국 로스앤젤레스', ...


SELECT * FROM customer WHERE addr LIKE '미국_';
-- 검출 가능한 케이스 예시 : '미국 ','미국인' (무조건 세글자여야한다)'미국__'은 네글자

-- 고객 이름 두번째 글자가 '지'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '_지%';

-- 고객 이름 세번째 글자가 '수'인 사람
SELECT * FROM customer WHERE custname LIKE '__수%'; -- 언더바에는 공백도 포함 

-- 복합조건(AND,OR, NOT)
-- 주소지가 대한민국이고, 2000년 이후 출생 고객 검색
SELECT * FROM customer WHERE addr='대한민국 서울' and birth >= '2000-01-01';
-- 주소지가 미국이거나 영국인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국%' or addr LIKE '영국%'; -- addr은 두번 써줘야함
-- 휴대폰 번호 마지막 자리가 4가 아닌 고객 검색 
SELECT * FROM customer WHERE phone NOT LIKE '%4';

-- ORDER BY (where뒤에 와야한다)
-- ORDER BY절을 사용하지 않는 경우, pk를 기준으로 정렬한다.
-- 결과각 출력되는 순서조절 (ASC : 오름차순, DESC : 내림차순)

SELECT * FROM customer;
SELECT * FROM customer order by custname DESC; -- custname기준으로 오름차순


SELECT * FROM customer WHERE birth >= '2000-01-01'ORDER BY addr DESC;
-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 그리고 아이디를 기준으로 내림차순 검색 
-- 주소가 같을 경우 custid를 기준으로 오름차순을 한다 
SELECT * FROM customer WHERE birth >= '2000-01-01'ORDER BY addr DESC, custid DESC;
SELECT * FROM customer WHERE birth >= '2000-01-01'ORDER BY custid DESC, addr DESC ;
-- 결과는 같은데 다른 쿼리문임 

SELECT * FROM orders ORDER BY price,amount;
SELECT * FROM orders ORDER BY amount,price;
-- 두 쿼리문의 결과는 상이함

-- LIMIT : 출력개수 제한 
-- 고객 테이블 전체 정보를 조회하는데, 앞에 2건만 조회하고 싶은 경우
-- LIMIT 형식 : LIMIT 시작, 개수
-- LIMIT 2 == LIMIT 0,2 (처음부터 2개) == LIMIT 2 OFFSET 0
SELECT * FROM customer LIMIT 2; -- LIMIT은 제일 뒤에 !
-- 문장이 길어지면 여러줄로 나눠서 쿼리를 작성한다 


-- 2000년 이후 출생자 고객 중에서 앞에 두건만 조회하고 싶은 경우 
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 2;
-- 뒤에서 2건만 조회하고 싶은 경우 
SELECT * FROM customer WHERE birth >= '2000-01-01'ORDER BY custid DESC LIMIT 2;
-- 주의 LIMIT에서 시작은 0임을 잊지말자
SELECT * FROM customer LIMIT 1,5;
SELECT * FROM customer LIMIT 5 OFFSET 1;

-- 문제 





