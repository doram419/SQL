-------------------------------
-- SUBQUERY
-------------------------------

-- 모든 직원 급여의 중앙값보다 많은 급여를 받는 사원의 목록

-- 1) 직원 급여의 중앙값?
-- 2) 1번의 결과보다 많은 급여를 받는 직원의 목록?

-- 1) 직원 급여의 중앙값?
Select Median(salary)
From employees;

-- 2) 1번 결과(6200)보다 많은 급여를 받는 직원의 목록
Select first_name, salary
From employees
Where salary >= 6200;

-- 1), 2)쿼리 합치기
Select first_name, salary
From employees
Where 
    salary >= (Select Median(salary)
        From employees)
Order By salary Desc;

-- Susan보다 늦게 입사한 사원의 정보
-- 1) Susan의 입사일
-- 2) 1번의 결과보다 늦게 입사한 사원의 정보

-- 1) Susan의 입사일
Select hire_date
From employees
Where first_name = 'Susan';

-- 2) 1번의 결과보다 늦게 입사한 사원의 정보
Select hire_date, first_name
From employees
Where hire_date > '12/06/07'
Order By hire_date;

-- 두 개 쿼리 합치기
Select hire_date, first_name
From employees
Where hire_date > (Select hire_date
    From employees
    Where first_name = 'Susan')
Order By hire_date;

-- 연습문제
-- 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 수잔보다 늦게 입사한 직원의 목록

-- 급여를 모든 직원 급여의 중앙값보다 많이 받는 직원!
-- A1. 모든 직원 급여의 중앙값 (6200)
Select 
    median(salary)
From 
    employees;
    
-- A2. 6200보다 많이 급여를 받는 직원
Select 
    first_name, 
    salary
From 
    employees
Where 
    salary >= 6200
Order By
    salary Asc;
    
-- A3. 급여를 모든 직원 급여의 중앙값보다 많이 받는 직원!  
Select 
    first_name, 
    salary
From 
    employees
Where 
    salary >= (Select median(salary)
        From employees)
Order By
    salary Asc;

-- B1. 수잔의 입사일
Select 
    hire_date
From employees
Where 
    first_name = 'Susan';
    
-- B2. 12/06/07보다 늦게 입사한 사원
Select 
    hire_date,
    first_name
From employees
Where 
    hire_date > '12/06/07'
Order By
    hire_date Asc;
    
-- B3. 수잔보다 늦게 입사한 직원
Select 
    hire_date,
    first_name
From employees
Where 
    hire_date > (Select hire_date
        From employees
        Where first_name = 'Susan')
Order By
    hire_date Asc;

-- AB. 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 수잔보다 늦게 입사한 직원의 목록
Select 
    first_name,
    salary,
    hire_date
From employees
Where 
    hire_date > (Select hire_date
        From employees
        Where first_name = 'Susan') AND
    salary >= (Select median(salary)
        From employees)
Order By
    hire_date Asc,
    salary Asc;