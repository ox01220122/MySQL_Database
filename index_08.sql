CREATE DATABASE bookstore CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

USE bookstore;
CREATE TABLE authors(
	author_id int NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
 );
 
 -- DROP TABLE IF EXISTS authors;  만약 테이블에 authors가 있다면 DROP해주라는 뜻 
 -- 삭제하려는 데이터 테이블이 존재하지 않아서 발생하는 에러 방지 키워드(있으면 지우고 없으면 그냥 지나감)

CREATE TABLE books(
	book_id int NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    title VARCHAR(50),
    author_id int ,
    publication_data date,
    FOREIGN KEY(author_id) REFERENCES authors(author_id) ON UPDATE CASCADE ON DELETE CASCADE
 );
 
CREATE TABLE orders(
	order_id int NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    book_id int,
    customer_name VARCHAR(50),
    order_data date,
    FOREIGN KEY(book_id) REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE
 );


INSERT INTO authors VALUES 
	('1', 'J.K', 'Rowling', 'jkrowling@gmail.com'),
	('2', 'George R.R', 'Martin', 'grmartin@yahoo.com'),
    ('3', 'Stephen', 'King', 'sking@hotmail');

INSERT INTO books VALUES 
	('1', 'Harry Potter and the Philosopher''s Stone', '1', '1997-06-26'),
	('2', 'A Game of Thrones', '2', '1996-08-06'),
    ('3', 'The Shining', '3', '1977-01-28');


INSERT INTO orders VALUES 
	('1', '1', 'Jhon Smith', '2022-02-15'),
	('2', '2', 'Jane Doe', '2022-02-16'),
    ('3', '3', 'Bob Johnson', '2022-02-17');

SELECT * FROM authors;

-- 1. author_id가 1인 작성자의 이메일을 jkrowling@yahoo.com으로 업데이트하는 SQL 문을 작성합니다.
UPDATE authors SET email = 'jkrowling@yahoo.com' WHERE author_id='1';

-- 2. books 테이블에서 book_id 2인 책을 삭제하는 SQL 문을 작성합니다.
DELETE FROM books WHERE book_id='2';
-- 3. 다음 세부 정보가 포함된 새 책을 삽입하는 SQL 문을 작성합니다.
INSERT INTO books VALUES ('4', '스탠드', '3','1987-01-01');
-- 책 ID: 4
-- 제목: 스탠드
-- 저자 ID: 3
-- 발행일자 : 1978-01-01

-- 4. book_id 1인 책의 출판 날짜를 1997-06-30으로 업데이트하는 SQL 문을 작성하십시오.
UPDATE books SET  publication_data = '1977-06-30' WHERE book_id='1';

-- 5. 2022-02-17 이전에 접수된 모든 주문을 삭제하는 SQL 문을 작성합니다.
DELETE FROM orders WHERE order_data < '2022-02-17';

-- 6. 다음 세부 정보와 함께 새 주문을 삽입하는 SQL 문을 작성합니다.
INSERT INTO orders VALUES ('4', '1', '사라 존슨','2022-02-18');
INSERT INTO orders (order_id,book_id,customer_name,order_data) 
	VALUES ('4','1','사라 존슨','2022-02-18');
-- INSERT INTO orders VALUES ('1', '4', '사라 존슨','2022-02-18');
-- 주문 ID: 4
-- 책 ID: 1
-- 고객 이름: 사라 존슨
-- 주문일자 : 2022-02-18

-- 7. order_id가 1인 주문의 고객 이름을 Jack Smith로 업데이트하는 SQL 문을 작성합니다.
UPDATE authors SET  first_name = 'Jack Smith' WHERE order_id='1'; 

-- 8. 다음 세부 정보와 함께 새 작성자를 삽입하는 SQL 문을 작성합니다.
INSERT INTO authors VALUES ('4', '아가사', '크리스티','agatha.christie@example.com');
-- 저자 ID: 4
-- 이름: 아가사
-- 성: 크리스티
-- 이메일: agatha.christie@example.com

-- 9. author_id 2인 작성자의 성을 Martinez로 업데이트하는 SQL 문을 작성합니다.
UPDATE authors SET  last_name = 'Martinez' WHERE author_id='2'; 
SELECT * FROM authors;

-- 10. author_id 3인 저자가 쓴 모든 책을 삭제하는 SQL 문을 작성합니다.
DELETE FROM authors WHERE author_id = '3';


-- < 추가 실습 >
-- 11. Stephen King이 쓴 모든 책의 제목과 발행일을 표시합니다.
SELECT title, publication_data FROM books 
WHERE author_id = 
(SELECT author_id FROM authors WHERE first_name = 'Stephen' AND last_name = 'King');

-- JOIN으로 풀기
SELECT title, publication_data 
	FROM books JOIN authors ON books.author_id = authors.author_id 
	WHERE first_name = 'Stephen' AND last_name = 'King';


-- 12. 책을 쓴 저자의 이름을 표시합니다.  -> 이 문제 틀린 듯 (다른 데이터를 넣었을 때도 잘 동작해야한다)
SELECT first_name,last_name FROM authors,books
WHERE authors.author_id = books.author_id;

-- 다른 방법
SELECT first_name,last_name FROM authors,books
JOIN books ON authors.author_id = books.author_id
GROUP BY authors.author_id; -- GROUP BY를 쓰지 않으면 단순히 두 테이블을 연결해주는것밖에 안된다 

-- 서브쿼리 사용하는 방법
SELECT first_name, last_name
FROM authors
WHERE author_id IN (SELECT author_id FROM books);

-- 13. 각 저자가 쓴 책의 수를 표시합니다.
SELECT authors.first_name, authors.last_name, COUNT(books.book_id) as 'num_books' 
	FROM authors,books
	WHERE authors.author_id = books.author_id
    GROUP BY authors.author_id;
    
-- 14. 2022년 2월 16일 이후에 발생한 모든 주문에 대한 책 제목과 고객 이름을 표시합니다.
SELECT books.title , orders.customer_name
	FROM books, orders
	WHERE books.book_id = orders.book_id AND orders.order_data >= '2022-02-16';
    
-- 다른 방법 
SELECT books.title, orders.customer_name
FROM books JOIN orders
ON books.book_id = orders.book_id
WHERE orders.order_data >= '2022-02-16';