-- INSERT : 테이블에 새 레코드(튜플) 추가
-- 제공된 컬럼 목록의 순서와 타입, 값 목록의 순서와 타입이 일치해야 함
-- 컬럼 목록을 제공하지 않으면 테이블 생성시 정의된 컬럼의 순서와 타입을 따른다

-- 컬럼 목록이 제시되지 않았을 DELETE
INSERT INTO author
VALUES(1, '박경리', '토지 작가');

SELECT * FROM author;

-- 컬럼 목록을 제시했을 때,
-- 제시한 컬럼의 순서와 타입대로 값 목록을 제공해야 함.
INSERT INTO author(author_id, author_name)
VALUES(2, '김영하');

SELECT * FROM author;

-- 컬럼 목록을 제공했을 때,
-- 테이블 생성시 정의된 컬럼의 순서와 상관 없이 데이터 제공 가능
INSERT INTO author(author_name, author_id, author_desc)
VALUES('류츠신', 3,'삼체 작가');

-- ROLLBACK; -- 반영 취소

COMMIT; -- 반영