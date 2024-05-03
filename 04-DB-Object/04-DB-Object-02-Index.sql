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