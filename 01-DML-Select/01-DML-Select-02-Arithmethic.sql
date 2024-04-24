-- 산술연산 : 기본적인 산술연산을 수행할 수 있다.
-- 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할때 : dual(가상 테이블)
select 3.14159 * 10 * 10 from dual;

-- 특정 컬럼의 값 산술 연산에 포함시키고자 할 경우
select first_name,
    salary,
    salary * 12
    FROM employees;
    
-- 다음 문장을 실행해봅시다.
select first_name,
    job_id,
    job_id * 12
    FROM employees;
-- 오류의 원인 : job_id 는 문자열(VARCHAR2),
--             문자열을 산술 계산 할 수 없음

desc employees;