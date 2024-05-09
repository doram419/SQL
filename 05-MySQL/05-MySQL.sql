-- MySQL은 사용자와 Database를 구분하는 DBMS
SHOW DATABASES;

-- 데이터베이스 사용 선언
USE sakila;

-- 데이터베이스 내에 어떤 테이블이 있는가?
SHOW TABLES;

-- 테이블 구조 확인
DESCRIBE actor;

-- 간단한 쿼리 실행
SELECT version(), current_date();
SELECT version(), current_date() FROM DUAL;

-- 특정 테이블 데이터 조회
SELECT * FROM actor;

-- 데이터베이스 생성
-- webdb 데이터베이스 생성
CREATE DATABASE webdb;
-- 기본 방식으로 설치한 경우, 시스템 설정에 좌우되는 경우가 많다.
-- 그러지 않을 경우 다른 운영체제에서 사용시 오류 발생 가능성 

DROP DATABASE webdb;
-- 문자셋, 정렬 방식을 명시적으로 지정하는 것이 좋다
CREATE DATABASE webdb CHARSET utf8mb4
	COLLATE utf8mb4_unicode_ci;

SHOW DATABASES;

-- 사용자 만들기
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
-- 사용자 비밀번호 변경
-- ALTER USER 'dev'@'localhost' IDENTIFIED BY 'new_password';
-- 사용자 삭제
-- DROP USER 'dev'@'localhost';

-- 권한 부여
-- GRANT 권한 목록 ON 객체 TO '계정'@'접속호스트';
-- 권한 회수
-- REVOKE 권한 목록 ON 객체 FROM '계정'@'접속호스트';

-- 'dev'@'localhost'에게 webdb 데이터베이스의 모든 객체에 대한 모든 권한 허용
GRANT ALL PRIVILEGES ON webdb.* TO 'dev'@'localhost'; 
-- ALL PRIVILEGES : SELECT, INSERT, UPDATE, DELETE
-- REVOKE ALL PRIVILEGES ON webdb.* FROM 'dev'@'localhost';

-- 데이터베이스 확인
SHOW DATABASES;

USE webdb;

-- AUTHOR 테이블 생성
CREATE TABLE AUTHOR(
	author_id int PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    author_desc VARCHAR(500)
);

SHOW DATABASES;
DESC author;

-- 테이블 생성 정보 확인
SHOW CREATE TABLE author;

-- BOOK 테이블 생성
CREATE TABLE BOOK(
	book_id int PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    pubs VARCHAR(100),
    pub_date DATETIME DEFAULT now(),
    author_id int,
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

SHOW TABLES;
DESC book;

-- INSERT : 새로운 레코드 삽입
-- 묵시적 방법 : Column 목록 비제공 -> 선언된 컬럼의 순서대로 들어감
INSERT INTO author VALUES (1, '박경리', '토지 작가');


SELECT * FROM author;
-- 명시적 방법 : Column 목록 제공 -> 컬럼 목록의 갯수, 순서, 타입이
-- 			  값 목록의 갯수, 순서, 타입과 일치해야한다
INSERT INTO author(author_id, author_name)
VALUES(2, '김영하');

SELECT * FROM author;

-- MySQL은 기본적으로 자동 커밋 활성화
-- Auto Commit 비활성화 방법 : autocommit 옵션을 0으로 설정
SET autocommit = 0;

-- MySQL은 명시적 트랜잭션을 수행
START TRANSACTION;
SELECT * FROM author;

-- UPDATE author
-- SET author_desc = '알쓸신잡 출연';
-- Oracle은 WHERE이 없을시 전체 레코드 변경
-- MySQL은 실행 못하게 막음

UPDATE author
SET author_desc = '알쓸신잡 출연'
WHERE author_id = 2;

SELECT * FROM author;

COMMIT; 
-- 데이터 반영 
-- 취소는 ROLLBACK;

-- AUTO_INCREMENT 속성
-- 연속된 순차정보, 주로 PK 속성에 사용

-- author 테이블의 PK에 auto_increment 속성 부여
ALTER TABLE author MODIFY 
	author_id INT AUTO_INCREMENT PRIMARY KEY;

-- 1. 외래 키(FK) 정보 확인하기
SELECT *
FROM information_schema.KEY_COLUMN_USAGE;

SELECT 
	constraint_name, 
    table_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'book';

-- 2. 외래 키 삭제하기 (그래야 PK 삭제 가능)
ALTER TABLE book DROP FOREIGN KEY book_fk;

SELECT 
	constraint_name, 
    table_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'book';

-- 3. author의 PK에 AUTO_INCREMENT 속성 붙이기
ALTER TABLE author DROP PRIMARY KEY;

SELECT 
	constraint_name, 
    table_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'author';
-- AUTO_INCREMENT 속성이 부여된 새로운 PRIMARY KEY 생성

ALTER TABLE author 
MODIFY author_id INT AUTO_INCREMENT PRIMARY KEY;

SELECT 
	constraint_name, 
    table_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'author';

-- 4. book table에 삭제했던 외래키 복구하기
ALTER TABLE book 
ADD CONSTRAINT fk_book FOREIGN KEY (author_id)
REFERENCES author(author_id);

SELECT 
	constraint_name, 
    table_name, 
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME IN ('book', 'author');

-- autocommit을 다시 켜줌
SET autocommit = 1;

-- 새로운 AUTO_INCREMENT 값을 부여하기 위해서 PK 최댓값을 구함
SELECT MAX(author_id)
FROM author;

-- 새로 생성되는 AUTO_INCREMENT 시작 값을 변경
ALTER TABLE author AUTO_INCREMENT = 3; -- 3부터 시작함

-- 테이블 구조 확인
DESCRIBE author;

SELECT * FROM author;

INSERT INTO author(author_name)
VALUES('스티븐 킹');

INSERT INTO author(author_name, author_desc)
VALUES('류츠신', '삼체 작가') ;

SELECT * FROM author;

-- 테이블 생성시 AUTO_INCREMENT 속성을 부여하는 방법
DROP TABLE book CASCADE;

CREATE TABLE book
(
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    pubs VARCHAR(100),
	pub_date DATETIME DEFAULT now(),
    author_id INT,
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);


INSERT INTO book (title, pub_date, author_id)
VALUES ('토지', '1994-03-04', 1);

INSERT INTO book (title, author_id)
VALUES ('살인자의 기억법', 2);

INSERT INTO book (title, author_id)
VALUES ('쇼생크 탈출', 3);

INSERT INTO book (title, author_id)
VALUES ('삼체', 4);

SELECT * FROM book;

-- JOIN
SELECT 
	b.title 제목,
    b.pub_date 출판일,
    a.author_name 저자명,
    a.author_desc '저자 상세'
FROM book b
JOIN author a
	ON b.author_id = a.author_id; 