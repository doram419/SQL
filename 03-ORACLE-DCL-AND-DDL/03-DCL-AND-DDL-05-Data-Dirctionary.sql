CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author_id NUMBER(10),
    pub_date DATE DEFAULT SYSDATE
);

CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY(author_id) 
);