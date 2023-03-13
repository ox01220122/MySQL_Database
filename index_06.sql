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
ALTER TABLE member MODIFY id VARCHAR(10) ;
ALTER TABLE member ADD interest VARCHAR(100);
