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