-- 다중행 서브 쿼리
-- 서브 쿼리 결과가 둘 이상의 레코드일 때 단일행 비교연산자는 사용할 수 없다.
-- 집합 연산에 관련된 In, Any, All, Exists 등을 사용해야 한다.

-- In 예제) 직원들 중,
-- 110번 부서 사람들이 받는 급여와 같은 급여를 받는 직원들의 목록
-- 서브 쿼리부터 알아보자!
-- A1. 110번 부서의 사람들은 얼마나 받는가? (12008, 8300)
Select 
    salary
From employees
Where department_id = 110;

-- A2. 급여가 12008, 8300인 직원 목록
Select 
    first_name,
    salary
From employees
Where salary In (12008, 8300);

-- A3. 110번 부서가 가지고 있는 급여의 목록과 하나라도 일치하는 사람의 이름과 급여
Select 
    first_name,
    salary
From employees
Where salary In (Select salary
    From employees
    Where department_id = 110);
    
-- ALL 예제) 직원들 중,
-- 110번 부서의 모든 사람들이 받는 급여들보다 많은 급여를 받는 직원들의 목록
-- B1. 110번 부서 사람들은 얼마나 급여를 받는가? (12008, 8300)
Select 
    salary
From employees
Where department_id = 110;

-- B2. B1 쿼리 전체보다 많은 급여를 받는 직원들의 목록 
Select 
    first_name,
    salary
From 
    employees
Where 
    salary > ALL(12008, 8300);

-- B3. 110번 부서 사람들이 받는 급여보다 많은 급여를 받는 직원들의 목록
Select 
    first_name,
    salary
From 
    employees
Where 
    salary > ALL(Select salary
        From employees
        Where department_id = 110)
Order By salary Desc;
-- ㄴ salary > 12008

-- ANY 예제) 직원들 중,
-- 110번 부서 사람들이 받는 급여들 중, 한 명이라도 많은 급여를 받는 직원들의 목록
-- C1. 110번 부서 사람들은 얼마나 급여를 받는가? (12008, 8300)
Select 
    salary
From employees
Where department_id = 110;

-- C2. C1 쿼리 중 하나보다 많은 급여를 받는 사람들의 목록
Select 
    first_name,
    salary
From 
    employees
Where 
    salary > ANY(12008, 8300);
    
-- C3. 110번 부서 사람들중 하나보다 많은 급여를 받는 직원들의 목록
Select 
    first_name,
    salary
From 
    employees
Where 
    salary > ANY(Select salary
        From employees
        Where department_id = 110)
Order By salary Desc;
-- salary > 12008 Or salary > 8300
-- ㄴsalary >= 8300