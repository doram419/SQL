-----------------------------------------------------------------------------
-- SEQUENCE
-----------------------------------------------------------------------------

SELECT
    *
FROM
    author;

-- 새로운 레코드를 추가, 겹치지 않는 유일한 pk가 필요
INSERT INTO author (
    author_id,
    author_name
) VALUES (
    (SELECT MAX(author_id+1) FROM author),
    '이문열'
);

SELECT
    *
FROM
    author;

ROLLBACK;

-- 순차 객체 SEQUENCE
CREATE SEQUENCE seq_author_id
    START WITH 4
    INCREMENT BY 1
    MAXVALUE 1000000;

-- PK는 SEQUENCE 객체로부터 생성
INSERT INTO author(
    author_id,
    author_name,
    author_desc
) VALUES(
    seq_author_id.NEXTVAL,
    '스티븐 킹',
    '쇼생크 탈출'
);

SELECT
    *
FROM
    author;

SELECT
    seq_author_id.currval
FROM
    dual;

-- 새 시퀀스 생성
CREATE SEQUENCE my_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10;

-- 다음 시퀀스를 추출하는 가상 칼럼
SELECT
    my_seq.nextval
FROM
    dual;

-- 현재 시퀀스의 상태
SELECT
    my_seq.currval
FROM
    dual;

-- 시퀀스 수정
ALTER SEQUENCE my_seq INCREMENT BY 2 MAXVALUE 100000;

SELECT
    my_seq.currval
FROM
    dual;

SELECT
    my_seq.nextval
FROM
    dual;

-- 시퀀스를 위한 딕셔너리
SELECT
    *
FROM
    user_sequences;

SELECT
    *
FROM
    user_objects
WHERE
    object_type = 'SEQUENCE';

-- 시퀀스 삭제
DROP SEQUENCE my_seqs;

SELECT
    *
FROM
    user_sequences;

-- book 테이블 pk의 현재 값 확인
SELECT
    MAX(book_id)
FROM
    book;

CREATE SEQUENCE seq_book_id
    START WITH 3
    INCREMENT BY 1
    MAXVALUE 1000000
    NOCACHE;

SELECT
    *
FROM
    user_sequences;