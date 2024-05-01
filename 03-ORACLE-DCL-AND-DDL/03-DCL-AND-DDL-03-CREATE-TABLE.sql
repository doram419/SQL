-- 테이블 생성 : CREATE TABLE
CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
);

DESC book;

-- Subquery를 이용한 테이블 생성
SELECT * FROM hr.employees;

-- HR.employees 테이블에서 job_id가 IT 관련된 직원의 목록으로 새 테이블 생성
SELECT *
FROM HR.employees
WHERE job_id Like 'IT_%';

CREATE TABLE emp_it AS (
    SELECT *
    FROM HR.employees
    WHERE job_id LIKE 'IT_%'
);
-- NOT NULL 제약 조건만 돌려받음

SELECT * FROM tabs;

-- 테이블 삭제
DROP TABLE emp_it;

SELECT * FROM tabs;