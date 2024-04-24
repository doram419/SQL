-- SQL 문장의 주석
-- 마지막에 세미콜론(;)으로 끝난다
-- 키워드들은 대소문자 구분하지 않는다
-- 그러나 강사님은 명령어는 대문자, 데이터는 소문자로 쓰시는 편
-- 실제 데이터의 경우 대소문자를 구분

-- 테이블 구조 확인 (DESCRIBE)
DESCRIBE employees;
-- describe EMPLOYEES;
DESCRIBE departments;
DESCRIBE locations;

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

-- NULL
-- 이름, 급여, 커미션 비율를 츨력해보자
Select first_name, salary, commission_pct 
From employees;

-- 이름, 커미션까지 포함한 급여를 출력
Select first_name, salary, commission_pct,
salary + salary * commission_pct
From employees;
-- NULL이 포함된 연산식의 결과는 NULL
// NULL을 처리하기 위한 함수 NVL필요
// NVL(표현식1, 표현식1이 널일경우 그의 대체값);

-- NVL 활용 대체값 계산
Select first_name, salary, commission_pct,
    salary + salary * NVL(commission_pct, 0)
From employees;

-- NULL은 0이나 ""와 다르게 빈 값이다.
-- NULL은 산술 연산 결과, 혹은 통계 결과를 왜곡시킨다.
-- ㄴ> 그래서 NULL에 대한 처리는 철저할 필요 있음

-- 별칭 Alias
-- : Projection 단계에서 출력용으로 표시되는 임시 컬럼 제목
-- < Alias 사용법 >
-- > 컬럼명 뒤에 별칭
-- > 컬럼명 뒤에 as 별칭
-- !! 표시명에 특수문자가 포함된 경우 " " 로 묶어서 표현하기

-- 예제1 : 직원 아이디, 이름, 급여를 출력하자
--        직원 아이디는 empNO, 이름은 f-name, 급여는 월 급으로 표시하라.
Select employee_id empNo,
    first_name "f-name",
    salary as "월 급"
From employees;

-- 예제2 : first_name과 last_name을 합쳐서 Full Name이라고 출력하고
--        commission_pct가 포함된 salary를 급여라고 출력하며,
--        급여 * 12를 하여 연봉으로 출력해라
Select first_name || ' ' || last_name as "Full Name",
-- 오라클에서는 자바처럼 + 연산을 문자에서 사용할 수 없다!
       salary + salary * NVL(commission_pct, 0) as "급여(커미션 포함)",
       salary * 12 as "연봉"
       From employees;
       
-- [연습 예제] hr.employees 전체 튜플에 다음과 같이 Column Alias를 붙여 출력해 봅니다
--  이름 : first_name last_name
--  입사일: hire_date
--  전화번호 : phone_number
--  급여 : salary
--  연봉 : salary * 12
Select first_name || ' ' || last_name as "이름",
       hire_date as "입사일",
       phone_number as "전화번호",
       salary as "급여",
       salary * 12 as "연봉"
       From employees;



