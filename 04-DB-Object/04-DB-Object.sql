-------------------------------------
-- DB OBJECTS
-------------------------------------

-- SYSTEM으로 진행
-- VIEW  생성을 위한 SYSTEM 권한
GRANT CREATE VIEW TO himedia;

GRANT SELECT, UPDATE, INSERT, DELETE ON hr.employees TO himedia;

GRANT SELECT ON hr.departments TO himedia;

GRANT SELECT ON hr.emp123 TO himedia;

-- himedia
-- SIMPLE VIEW
-- 단일 테이블 혹은 단일 뷰를 베이스로 만든 뷰
-- 함수, 연산식을 포함하지 않는다

-- emp123
DESC hr.emp123;

-- emp123 테이블 기반, department_id = 10 부서 소속 사원만 조회하는 뷰
CREATE OR REPLACE VIEW emp10 AS
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM
        hr.emp123
    WHERE
        department_id = 10;

SELECT
    *
FROM
    tabs;

-- 일반 테이블처럼 활용할 수 있음
DESC emp10;

SELECT
    *
FROM
    emp10;

SELECT
    first_name
    || ' '
    || last_name,
    salary
FROM
    hr.emp123;

-- SIMPLE VIEW는 제약 사항에 걸리지 않는다면 INSERT, UPDATE, DELETE을 할 수 있다.
UPDATE himedia.emp10
SET
    salary = salary * 2;

SELECT
    *
FROM
    emp10;

ROLLBACK;

-- 가급적 VIEW는 조회용으로만 활용하자
-- WITH READ ONLY : 읽기 전용 뷰
CREATE OR REPLACE VIEW emp10 AS
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM
        hr.emp123
    WHERE
        department_id = 10 WITH READ ONLY;

UPDATE himedia.emp10
SET
    salary = salary * 2;

-- READ ONLY니까 UPDATE 안 되는게 당연해. 바부였구나

-- Complex View
-- 한 개 혹은 여러 개의 테이블 혹은 뷰에 JOIN, 함수, 연산식 등을 활용한 VIEW
-- 특별한 경우가 아니면 INSERT, UPDATE, DELETE 작업 수행 불가능
CREATE OR REPLACE VIEW emp_detail (
    employee_id,
    employee_name,
    manager_id,
    department_id
) AS
    SELECT
        emp.employee_id,
        emp.first_name
        || emp.last_name,
        man.first_name
        || man.last_name,
        department_name
    FROM
        hr.employees   emp
        JOIN hr.employees man
        ON emp.manager_id = man.manager_id
        JOIN hr.departments dept
        ON emp.department_id = dept.department_id;

DESC emp_detail;

SELECT
    *
FROM
    emp_detail;

-- VIEW를 위한 DICTIONARY : VIEWS
SELECT
    *
FROM
    user_views;

SELECT
    *
FROM
    user_objects;

-- VIEW 삭제 : emp_detail
-- VIEW 삭제해도 기반 테이블 데이터는 삭제되지 않는다
DROP VIEW emp_detail;

SELECT
    *
FROM
    user_views;

-----------------------------------------------------------------------------
-- INDEX
-----------------------------------------------------------------------------

-- hr.employees 테이블 복사 s_emp 테이블 생성
CREATE TABLE s_emp AS (
    SELECT
        *
    FROM
        hr.employees
);

DESC s_emp;

SELECT
    *
FROM
    s_emp;

-- s_emp 테이블의 employee_id에 UNIQUE INDEX를 거는 코드
CREATE UNIQUE INDEX s_emp_id_pk
    ON s_emp(employee_id);

-- 그러나 데이터가 적어서 성능 테스트는 좀 힘들듯
-- 인덱스가 생성됬는지 확인
SELECT
    *
FROM
    user_indexes;

-- 어느 인덱스가 어느 컬럼에 걸려 있는지 확인
SELECT
    *
FROM
    user_ind_columns;

-- 어느 인덱스가 어느 컬럼에 걸려있는지 JOIN해서 알아봄
SELECT
    t.index_name,
    c.column_name,
    c.column_position
FROM
    user_indexes     t
    JOIN user_ind_columns c
    ON t.index_name = c.index_name
WHERE
    t.table_name = 's_emp';

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