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