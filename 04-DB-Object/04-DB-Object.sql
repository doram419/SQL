-------------------------------------
-- DB OBJECTS
-------------------------------------

-- SYSTEM으로 진행
-- VIEW  생성을 위한 SYSTEM 권한
GRANT CREATE VIEW TO himedia;

GRANT SELECT,UPDATE,INSERT,DELETE ON hr.employees TO himedia;
GRANT SELECT ON hr.departments TO himedia;
GRANT SELECT ON hr.emp123 TO himedia;

-- himedia
-- SIMPLE VIEW
-- 단일 테이블 혹은 단일 뷰를 베이스로 만든 뷰
-- 함수, 연산식을 포함하지 않는다

-- emp123
DESC hr.emp123;

-- emp123 테이블 기반, department_id = 10 부서 소속 사원만 조회하는 뷰
CREATE OR REPLACE VIEW emp10 
    AS SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
        FROM hr.emp123
        WHERE DEPARTMENT_ID = 10;

SELECT * FROM tabs;
-- 일반 테이블처럼 활용할 수 있음
DESC emp10;

SELECT * FROM emp10;
SELECT FIRST_NAME || ' ' || LAST_NAME, salary FROM hr.emp123;

-- SIMPLE VIEW는 제약 사항에 걸리지 않는다면 INSERT, UPDATE, DELETE을 할 수 있다.
UPDATE himedia.emp10 
SET salary = SALARY * 2;

SELECT * FROM emp10;

ROLLBACK;

-- 가급적 VIEW는 조회용으로만 활용하자
-- WITH READ ONLY : 읽기 전용 뷰
CREATE OR REPLACE VIEW emp10
    AS SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM hr.emp123
    WHERE DEPARTMENT_ID = 10
    WITH READ ONLY;

UPDATE himedia.emp10 SET SALARY = SALARY * 2;
-- READ ONLY니까 UPDATE 안 되는게 당연해. 바부였구나

-- Complex View
-- 한 개 혹은 여러 개의 테이블 혹은 뷰에 JOIN, 함수, 연산식 등을 활용한 VIEW
-- 특별한 경우가 아니면 INSERT, UPDATE, DELETE 작업 수행 불가능
CREATE OR REPLACE VIEW emp_detail
    (employee_id, employee_name, MANAGER_ID, DEPARTMENT_ID)
AS SELECT 
    emp.EMPLOYEE_ID, 
    emp.FIRST_NAME || emp.LAST_NAME,
    man.FIRST_NAME || man.LAST_NAME,
    DEPARTMENT_NAME
FROM HR.EMPLOYEES emp
    JOIN HR.employees man ON emp.MANAGER_ID = man.manager_id
    JOIN HR.departments dept ON emp.DEPARTMENT_ID = dept.department_id;

DESC emp_detail;

SELECT * FROM emp_detail;

-- VIEW를 위한 DICTIONARY : VIEWS
SELECT * FROM USER_VIEWS;

SELECT * FROM USER_OBJECTS;

-- VIEW 삭제 : emp_detail
-- VIEW 삭제해도 기반 테이블 데이터는 삭제되지 않는다
DROP VIEW emp_detail;
SELECT * FROM USER_VIEWS;

-----------------------------------------------------------------------------
-- INDEX
-----------------------------------------------------------------------------

-- hr.employees 테이블 복사 s_emp 테이블 생성
CREATE TABLE s_emp AS
(
    SELECT * FROM hr.EMPLOYEES
);

DESC s_emp;

SELECT * FROM s_emp;

-- s_emp 테이블의 employee_id에 UNIQUE INDEX를 거는 코드
CREATE UNIQUE INDEX s_emp_id_pk
ON s_emp(employee_id);

-- 그러나 데이터가 적어서 성능 테스트는 좀 힘들듯
-- 인덱스가 생성됬는지 확인
SELECT * FROM USER_INDEXES;

-- 어느 인덱스가 어느 컬럼에 걸려 있는지 확인
SELECT * FROM USER_IND_COLUMNS;

-- 어느 인덱스가 어느 컬럼에 걸려있는지 JOIN해서 알아봄
SELECT 
    t.INDEX_NAME, c.COLUMN_NAME, c.COLUMN_POSITION
FROM USER_INDEX t
    JOIN USER_IND_COLUMNS c
        ON t.INDEX_NAME = c.INDEX_NAME;
WHERE t.TABLE_NAME = 's_emp';

