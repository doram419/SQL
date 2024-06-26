-- Subquery 문제니까 되도록 Subquery로 풀기
-- 그리고 다른 방법으로 푼 뒤에, 다른 걸로 풀기

-----------------------------------------------------------------------------
-- 문제 1.
-----------------------------------------------------------------------------
-- 평균 급여보다 적은 급여을 받는 직원은 몇 명인지 구하시요.
-- (56건)

-- A1. 평균 급여를 구하자
Select Round(Avg(salary))
From employees;
-- ∴ 6462

-- A2. 해당 값(6462)보다 적은 급여을 받는 직원은 몇 명인지 구하자. 
Select Count(*)
From employees
Where salary < 6462;
-- ∴ 56명
--------------------------------------------------------------------------------
-- Answer A3. 평균 급여보다 적은 급여을 받는 직원은 몇 명인지 구하자.
Select Count(*)
From employees
Where salary < (Select Round(Avg(salary))
                From employees);
                
-- A4. Subquery가 아닌 다른 방법으로 풀 수 있는가?

--------------------------------------------------------------------------------
-- 문제 2.
--------------------------------------------------------------------------------
-- 평균급여 이상, 최대급여 이하의 월급을 받는 사원의
-- 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 
-- 오름차순으로 정렬 하여 출력하세요
-- (56건)
-----------------------------------------------------------------------------
-- 요구사항 : 평균 급여 이상, 최대 급여 이하의 월급을 받는 사원 찾기
-- 출력 : 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여
-- 정렬 : 급여의 오름차순으로 정렬
-- 건수 : 51건
-----------------------------------------------------------------------------
-- B1. 평균 급여 이상의 월급을 받는 사원 찾기
Select *
From employees
Where salary > Avg(salary);
-- 이 구문은 Where 이후에 Avg를 쓸 수 있어서 발생하는 문제

-- B1-1. 평균 급여 구하기
Select Avg(salary)
From employees;
-- ∴ 약 6461

-- B1-2. 평균 급여 이상의 월급을 받는 사원 찾기
Select *
From employees
Where salary >= (Select Avg(salary)
                From employees)
Order By salary Desc;
-- ∴ 51명

-- B2. 최대 급여(24000) 이하 월급 받는 사원 찾기
Select *
From employees
Where salary <= (Select Max(salary)
                From employees)
Order By salary Desc;
-- ∴ 107명
--------------------------------------------------------------------------------
-- Answer B3. 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 
--     급여의 오름차순으로 정렬 하여 출력하기
Select employee_id 직원번호,
       first_name 이름,
       salary 급여,
       (Select Round(Avg(salary)) from employees) 평균급여,
       (Select Max(salary) from employees) 최대급여
From employees
Where 
    salary >= (Select Avg(salary) From employees) 
    And salary <= (Select Max(salary) From employees)
Order By salary Asc;
-- ∴ 51명
-- B4. Subquery가 아닌 다른 방법으로 풀 수 있는가?
--------------------------------------------------------------------------------
-- 문제 3.
--------------------------------------------------------------------------------
-- 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 
-- 주소를 알아보려고 한다.
-- 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 
-- 주(state_province), 나라아이디(country_id) 를 출력하세요
--------------------------------------------------------------------------------
-- 요구사항 : 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments) 찾기
-- 출력 : 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 
--       주(state_province), 나라아이디(country_id)
-----------------------------------------------------------------------------
-- C1. 이름(first_name)이 'Steven'인 사람 찾기
Select first_name
From employees
Where lower(first_name) = 'steven';
-- ∴ 2명

-- C2. 성(last_name)이 'king'
Select last_name
From employees
Where lower(last_name) = 'king';
-- ∴ 2명

-- C2-1. 풀 네임이 'Steven king'인 사람 찾기
Select 
    first_name,
    last_name
From employees
Where 
    lower(first_name) = 'steven' And
    lower(last_name) = 'king';
-- ∴ 1명   

-- C2-2. 풀 네임이 'Steven king'인 사람을 employees에서 찾고
--       departments 테이블을 합쳐 location_id 출력하기
Select
    dept.department_id
From departments dept
Where department_id = (Select department_id
                              From employees
                       Where lower(first_name) = 'steven' And
                             lower(last_name) = 'king');
-- Steven King의 이름은 출력 불가능?
--------------------------------------------------------------------------------
-- Answer C3. 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)를 찾아
--         도시아이디(location_id), 거리명(street_address), 우편번호(postal_code),
--         도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하기
Select 
    location_id 도시아이디,
    street_address 거리명,
    postal_code 우편번호,
    city 도시명,
    state_province 주,
    country_id 나라아이디
From locations
Where 
    location_id = (Select dept.location_id From departments dept
                   Where department_id = (Select department_id From employees
                                          Where lower(first_name) = 'steven' And
                                                lower(last_name) = 'king')
    );
-- C4. Subquery가 아닌 다른 방법으로 풀 수 있는가?

--------------------------------------------------------------------------------
-- 문제 4.
--------------------------------------------------------------------------------
-- job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
-- 출력하세요 - ANY연산자 사용
--------------------------------------------------------------------------------
-- 요구사항 : job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원 찾기, ANY연산자 사용
-- 출력 : 사번, 이름, 급여
-- 정렬 : 급여의 내림차순
--------------------------------------------------------------------------------
-- D1. Job_id가 'ST_MAN'인 직원의 급여 찾기
Select     job_id,
    min_salary,
    max_salary
From jobs
Where job_id = 'ST_MAN';
-- jobs에는 salary가 없다!

-- D1-1. Job_id가 'ST_MAN'인 직원의 급여 찾기 위해 employees Join하기
Select 
    j.job_id,
    emp.salary
From jobs j
    Join employees emp
        On j.job_id = emp.job_id
Where j.job_id = 'ST_MAN';
-- ∴ 5800, 6500, 7900, 8000, 8200
--------------------------------------------------------------------------------
-- Answer D2. Job_id가 'ST_MAN'인 직원보다 급여가 낮은 직원 찾아 사번, 이름, 급여 출력하고
--     급여의 내림차순하기
Select 
    employee_id,
    first_name,
    salary
From 
    employees
Where 
    salary < ANY(Select emp.salary From jobs j
                    Join employees emp On j.job_id = emp.job_id
                 Where j.job_id = 'ST_MAN')
Order By
    salary Desc;
-- D3. Subquery가 아닌 다른 방법으로 풀 수 있는가?

--------------------------------------------------------------------------------
-- 문제 5.
--------------------------------------------------------------------------------
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 
-- 급여(salary) 부서번호(department_id)를 조회하세요
-- 단, 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.
-- 조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)
--------------------------------------------------------------------------------
-- 문제 5.1 조건절 비교
-- 요구사항 : 각 부서별로 최고의 급여를 받는 사원 찾기
-- 출력 : 직원번호(employee_id), 이름(first_name), 급여(salary) 부서번호(department_id)
-- 정렬 : 급여의 내림차순으로 정렬
-------------------------------------------------------------------------------- 
-- E1. 최고 급여 사원 찾기
Select 
    Max(salary)
From 
    employees;

-- E2. 각 부서별로 묶기
Select department_id
From employees
Group By 
    department_id
Order By 
    department_id Desc;
    
-- E3. 각 부서별 최고 급여 
Select 
    department_id,
    Max(salary)
From employees
Group By 
    department_id
Order By 
    Max(salary) Desc;
--------------------------------------------------------------------------------    
-- Answer E4-A. 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 
--            급여(salary) 부서번호(department_id)를 조회하세요
--            단, 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--            (조건절)
Select
    emp.employee_id, 
    emp.first_name,
    emp.salary,
    emp.department_id
From 
    employees emp,
    (Select department_id, Max(salary) maxSalary
     From employees Group By department_id) best
Where
    emp.department_id = best.department_id And 
    emp.salary >= maxSalary
Order By
    emp.salary desc;
-- 좀 야매같은데
   
--------------------------------------------------------------------------------
-- 문제 5.2 테이블 조인
-- 요구사항 : 각 부서별로 최고의 급여를 받는 사원 찾기
-- 출력 : 직원번호(employee_id), 이름(first_name), 급여(salary) 부서번호(department_id)
-- 정렬 : 급여의 내림차순으로 정렬
--------------------------------------------------------------------------------  
-- Answer E4-B. 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 
--            급여(salary) 부서번호(department_id)를 조회하세요
--            단, 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--            (테이블 조인)
Select
    emp.employee_id, 
    emp.first_name,
    emp.salary,
    emp.department_id
From 
    employees emp
    Join 
    (Select department_id, Max(salary) maxSalary
     From employees Group By department_id) best
     On emp.department_id = best.department_id And emp.salary >= maxSalary 
Order By
    emp.salary desc;
    
--------------------------------------------------------------------------------
-- 문제 6.
--------------------------------------------------------------------------------
-- 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
-- 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)
--------------------------------------------------------------------------------
-- 요구사항 : 각 업무(job) 별로 연봉(salary)의 총합 구하기
-- 출력 : 업무명(job_title)과 연봉 총합
-- 정렬 : 연봉 총합, 내림차순
--------------------------------------------------------------------------------
-- F1. 연봉의 총합 구하기
Select Sum(salary)
from employees emp
    Join jobs j
        On emp.job_id = j.job_id;
-- 691416

-- F2. 각 업무로 그룹화하기
Select job_id
From employees
Group By job_id;

--------------------------------------------------------------------------------
-- Answer F3. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다.
-- 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)
Select 
    j.job_id 업무, 
    Sum(emp.salary) 연봉총합
from employees emp
    Join jobs j
        On emp.job_id = j.job_id
Group By emp.job_id
Order By Sum(emp.salary) Desc;

--------------------------------------------------------------------------------
-- 문제 7.
--------------------------------------------------------------------------------
-- 자신의 부서 평균 급여보다 급여(salary)이 많은 직원의 직원번호(employee_id), 
-- 이름(first_name)과 급여(salary)을 조회하세요 (38건)
--------------------------------------------------------------------------------
-- 요구사항 : 자신의 부서 평균 급여보다 급여(salary)이 많은 직원 구하기
-- 출력 : 직원번호(employee_id), 이름(first_name), 급여(salary)
--------------------------------------------------------------------------------
-- G1. 평균 급여 구하기
Select Avg(salary)
from employees;

-- G2. 부서 나눠서 평균 급여 구하기
Select Avg(salary)
from employees
Group By 
    department_id;
    
--------------------------------------------------------------------------------
-- Answer G3. 자신의 부서 평균 급여보다 급여(salary)이 많은 직원의 직원번호(employee_id), 
--            이름(first_name)과 급여(salary)을 조회하세요 (38건)
Select 
    emp.employee_id 직원번호,
    emp.first_name 이름,
    emp.salary 급여,
    Round(avgSal) "부서 평균급여"
From 
    employees emp,
    (Select department_id, Avg(salary) avgSal from employees 
     Group By department_id) deptAvg
Where
    emp.department_id = deptAvg.department_id AND
    emp.salary > avgSal;
    
--------------------------------------------------------------------------------
-- 문제 8.
--------------------------------------------------------------------------------
-- 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
--------------------------------------------------------------------------------
-- 요구사항 : 직원 입사일이 11번째에서 15번째의 직원 찾기
-- 출력 : 사번, 이름, 급여, 입사일
-- 정렬 : 입사일 순서
--------------------------------------------------------------------------------
-- H1. 직원 입사일 순서대로 나열하기
Select 
    employee_id,
    first_name,
    salary,
    hire_date,
    Row_Number() Over(Order By hire_date) as row_number
From employees
Order By row_number;

--------------------------------------------------------------------------------
-- Answer H2. 직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 
--            입사일을 입사일 순서로 출력하세요
Select 
    employee_id 사번,
    first_name 이름,
    salary 급여,
    hire_date 입사일
From (Select employee_id, first_name, salary, hire_date,
    Row_Number() Over(Order By hire_date) as rowNumber From employees) rank
Where 
    rank.rownumber >= 11 And rank.rownumber <= 15;
