-- DML(Data Manipulation Language)
-- SELECT

-- * : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로 
select * from employees;

-- 특정 컬럼만 Projection 하고자 하면 열 목록을 명시
-- employees 테이블의 first_name 과 phone_number 과 hire_date, salary만 보고 싶다면
select first_name, phone_number, hire_date, salary from Employees;

-- 사원의 이름, 성, 급여, 전화번호, 입사일 정보 출력
select first_name,
    last_name,
    salary,
    phone_number,
    hire_date 
    from employees;

-- 사원 정보로부터 사번, 이름, 성 정보 출력
SELECT employee_id,
    first_name,
    last_name
    from employees;