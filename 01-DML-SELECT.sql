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

----------------
-- WHERE
----------------
-- 특정 조건을 기준으로 레코드를 선택 (SELECTION)
-- 비교연산 : =, <>, >=, <=, <=
-- 예제 : 사원들 중에서 급여가 15000 이상인 직원의 이름과 급여를 표시
Select 
    first_name || ' ' || last_name as "이름",
    salary as "급여"
From 
    employees
Where 
    salary >= 15000;

-- 예제 : 입사일이 07/01/01 이후인 직원들의 이름과 입사일 표시
Select
    first_name || ' '|| last_name as "이름",
    hire_date as "입사일"
From 
    employees
Where
    hire_date >= '17/01/01';
-- 날짜도 대소 비교가 가능하다

-- 예제 : 급여가 14000 이하이거나, 17000 이상인 사원의 이름과 급여
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary <= 4000 
    OR salary >= 17000;
    
-- 예제 : 급여가 14000 이상이고, 17000 미만인 사원의 이름과 급여
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary >= 14000 AND salary < 17000;
    
-- BETWEEN : 범위 비교
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary Between 14000 and 17000;

-- NULL 체크 =, <> 사용하면 안 됨
-- IS NULL, IS NOT NULL

-- commission을 받지 않는 사람들 (-> commision_pct가 NULL인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct IS NULL;
-- NULL 체크

-- commission을 받는 사람들 (-> commission_pct가 Not Null인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct Is Not Null;

-- IN 연산자 : 특정 집합의 요소와 비교
-- 사원들 중 10, 20, 40번 부서에서 근무하는 직원들의 이름과 부서 아이디 출력
Select 
    first_name, department_id
From 
    employees
Where
    department_id In (10, 20, 40); 

-- OR로 작성
Select 
    first_name, department_id
From 
    employees
Where
    department_id = 10 OR
    department_id = 20 OR
    department_id = 40; 
    
--------------------------
-- Like 연산
--------------------------
-- 와일드카드(%,_)를 이용한 부분 문자열 매핑
-- % : 0개 이상의 정해지지 않은 문자열 매핑
-- _ : 1개의 정해지지 않은 문자

-- 이름에 am을 포함하고 있는 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '%am%';
    
-- 이름의 두 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '_a%';
    
-- 이름의 네 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '___a%';

-- 이름이 네 글자인 사원들 중에서 두 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '_a__';
    
-- 부서 ID가 90인 사원 중, 급여가 20000 이상인 사원 이름, 급여
Select 
    first_name as "이름",
    salary as "급여",
    department_id as "부서 ID"
From 
    employees
Where 
    department_id In (90) -- 조건1 : 부서가 90
AND 
    salary >= 20000;      -- 조건 2 : 급여가 20000이상

-- 입사일이 11/01/01 ~ 17/12/31 구간에 있는 사원의 목록 이름, 입사일
Select 
    first_name as "이름",
    salary as "급여",
    hire_date as "입사일"
From 
    employees
Where 
    hire_date >= '11/01/01'
AND 
    hire_date <= '17/12/31';

-- manager_id가 100, 120, 147인 사원의 명단의 이름, manager_id
-- 1. 비교연산자 + 논리연산자의 조합
Select 
    manager_id as "사번",
    first_name as "이름",
    salary as "급여"
From 
    employees
Where 
    manager_id = 100 
OR  manager_id = 120
OR  manager_id = 147;

-- 2. IN 연산자 이용
Select 
    manager_id as "사번",
    first_name as "이름",
    salary as "급여"
From 
    employees
Where 
    manager_id IN (100, 120, 147);

--------------------------------
-- ORDER BY
--------------------------------
-- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드 정렬
-- ASC(오름차순 : default), DESC(내림차순)
-- 여러 개의 칼럼에 적용할 수 있고 ,로 구분

-- 부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하십시오
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc;  -- ASC 생략 가능

-- 급여가 10000 이상인 직원의 이름을 급여 내림차순(높은 급여 -> 낮은 급여)으로 출력하십시오
Select 
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Where 
    salary >= 10000
Order By 
    salary Desc;
    
-- 부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력하십시오.
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc,
    salary Desc;
-- 정렬 기준을 어떻게 세우냐에 따라 성능, 출력 결과 영향을 미칠 수 있다.