CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
);

DESC book;

-- author 테이블 생성
CREATE TABLE author (
    -- author_id NUMBER(10) PRIMARY KEY : 이렇게 해도 되지만 테이블 PRIMARY KEY로 지정해도 됨
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY(author_id) -- 복합키는 항상 이 방식으로 해야함
);

DESC author;

-- book 테이블의 author 컬럼 삭제
-- 나중에 author_id 컬럼 추가 -> author.author_id와 참조 연결할 예정
ALTER TABLE book DROP COLUMN author;

DESC book;

-- book 테이블에 author_id 컬럼 추가
-- author.author_id를 참조하는 컬럼 author.author_id 컬럼과 같은 형태여야 한다.
ALTER TABLE book ADD(author_id NUMBER(10));
DESC book;
DESC author;

-- book 테이블의 book_id도 author 테이블의 PK와 같은 데이터 타입 NUMBER(10)으로 변경
ALTER TABLE book MODIFY (book_id NUMBER(10));
DESC book; -- book_id NUMBER(5) -> book_id NUMBER(10)

-- book 테이블의 book_id 컬럼에는 PRIMARY KEY 제약 조건을 부여
ALTER TABLE book 
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id);
DESC book;

-- book 테이블의 author_id 컬럼과 author 테이블의 author_id를 fk로 연결
ALTER TABLE book 
ADD CONSTRAINT fk_author_id 
    FOREIGN KEY(author_id)      
REFERENCES author(author_id);
DESC book;