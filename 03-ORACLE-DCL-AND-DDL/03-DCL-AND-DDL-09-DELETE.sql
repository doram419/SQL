-- DELETE
-- 테이블로부터 특정 레코드를 삭제
-- WHERE 절이 없으면 모든 레코드 삭제(주의)

-- 연습
-- hr.employees 테이블을 기반으로 department_id 10, 20, 30인 직원들만 새 테이블 emp123으로 생성

CREATE TABLE emp123 AS(
    SELECT *
    FROM employees
    WHERE department_id IN (10, 20, 30)
);
DESC emp123;

SELECT 
    first_name,
    salary,
    department_id
FROM emp123;

-- 부서가 30인 직원들의 급여를 10% 인상
UPDATE emp123
SET salary = salary + salary * 0.1
WHERE department_id = 30;

SELECT * FROM emp123;

-- JOB_ID가 'MK_'로 시작하는 직원들 삭제
DELETE FROM emp123
WHERE JOB_ID LIKE 'MK_%';

SELECT * FROM emp123;

DELETE FROM emp123;

SELECT * FROM emp123;

ROLLBACK;

SELECT * FROM emp123;