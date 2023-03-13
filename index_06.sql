CREATE TABLE new_user(
	id VARCHAR(10) NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    pw VARCHAR(20) NOT NULL ,
    name VARCHAR(5) NOT NULL ,
    gender CHAR(1),
    birthday DATE NOT NULL ,
    age INT NOT NULL 
 );
DESC new_user;
SELECT * FROM new_user;
-- DROP TABLE member; 
CREATE TABLE member(
	id VARCHAR(20) NOT NULL PRIMARY KEY, -- PRIMARY KEY는 NOT NULL이 포함되어 있어서 안써도된다  
    name VARCHAR(5) NOT NULL ,
    age INT ,
    gender VARCHAR(2) NOT NULL ,
    email VARCHAR(50),
    promotion VARCHAR(2) DEFAULT 'x'
 );
DESC member;
SELECT * FROM member;

ALTER TABLE member DROP age;
ALTER TABLE member MODIFY id VARCHAR(10) ; -- VARCHAR(10)을 넘어가면 ALTER명령어는 실행안될수있다 
ALTER TABLE member ADD interest VARCHAR(100);
-- SELECT * FROM member;
-- INSERT INTO member VALUES('id123id123id123','name','20','minji@minji.com',null,'f');
ALTER TABLE member DROP age;
