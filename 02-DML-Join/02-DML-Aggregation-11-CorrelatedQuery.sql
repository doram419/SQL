-- Correlated Query : 연관 쿼리
-- 바깥쪽 쿼리(Outer Query)와 안쪽 쿼리(Inner Query)가 서로 연관된 쿼리
Select 
    first_name,
    salary,
    department_id
From 
    employees outer
Where
    salary > (Select Avg(salary)
              From employees 
              Where department_id = outer.department_id);
-- 외부 쿼리 : 급여를 특정 값보다 많이 받는 직원의 이름, 급여, 부서 아이디

-- 내부 쿼리 : 특정 부서에 소속된 직원의 평균 급여

-- 자신이 속한 부서의 평균 급여보다 많이 받는 직원의 목록을 구하라는 의미
-- 외부 쿼리가 내부 쿼리에 영향을 미치고
-- 내부 쿼리 결과가 다시 외부 쿼리에 영향을 미침

-- 서브쿼리 연습
-- A) 조건절을 이용한 방법
-- 각 부서별로 최고 급여를 받는 사원의 목록 (조건절에서 서브쿼리 활용)
-- A1. 각 부서의 최고 급여를 출력하는 쿼리
Select 
    department_id, 
    Max(salary)
From employees
Group By department_id;

-- A2. 1번 쿼리에서 나온 department_id, max(salary)값을 이용하여 외부 쿼리를 작성 
Select
    department_id,
    employee_id,
    first_name,
    salary
From employees
Where 
    (department_id, salary) In (Select department_id, 
                                       Max(salary)
                                From employees
                                Group By department_id)
Order By department_id;

-- B) 서브쿼리를 이용하여, 임시 테이블을 생성하고 테이블 조인 결과 뽑기
-- 각 부서별로 최고 급여를 받는 사원의 목록 (조건절에서 서브쿼리 활용)
-- B1) 각 부서의 최고 급여를 출력하는 쿼리
Select 
    department_id, 
    Max(salary)
From employees
Group By department_id;

-- B2) B1 쿼리에서 생성한 임시 테이블과 외부 쿼리를 Join하는 쿼리
Select emp.department_id,
    emp.employee_id,
    emp.first_name,
    emp.salary
From employees emp,
    (Select department_id, 
            Max(salary) salary
     From employees
     Group By department_id) sal
Where 
     emp.department_id = sal.department_id  --Join 조건
     AND emp.salary = sal.salary
Order By
    emp.department_id Asc;
-- Simple Join