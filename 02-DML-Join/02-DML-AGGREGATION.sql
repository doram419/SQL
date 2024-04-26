---------------------------
-- Join
---------------------------

-- employees와 departments
DESC "HR"."EMPLOYEES";
DESC "HR"."DEPARTMENTS";

-- 107
Select 
    *
From 
    employees;
    
-- 27
Select 
    *
From 
    departments;
    
-- 2600???
-- 특정한 조건을 명시하지 않으면 Cartesian Product가 생성됨
-- Cartesian Product는 두 테이블의 쌍이 출력됨.
Select 
    * 
From
    employees, departments;

-- 기본적인 Join 
-- Inner Join, Equi-Join이라고도 함
Select 
    *
From 
    employees, departments
Where 
    employees.department_id = departments.department_id;

-- alias를 이용한 원하는 필드의 Projection
-------------------------------
-- Simple Join or Equi-Join
-------------------------------
Select 
    emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
From 
    employees emp, 
    departments dept
Where
    emp.department_id = dept.department_id;
-- 결과 106명, Join의 기준인 Department_id에 null인 항목 하나가 배제됨

Select * From employees
Where department_id IS NULL;
--  Department_id에 null인 항목 확인

Select 
    emp.first_name,
    dept.department_name
From
    employees emp 
Join
    departments dept 
Using 
    (department_id);

-------------------------------
-- Theta Join
-------------------------------

-- Join조건이 = 아닌 다른 조건들

-- 평균 급여보다 급여가 낮은 직원들 목록
Select 
    emp.employee_id,
    emp.first_name,
    emp.salary,
    emp.job_id,
    j.job_id,
    j.job_title
From
    employees emp
    Join jobs j 
        On emp.job_id = j.job_id
Where emp.salary <= (j.min_salary + j.max_salary) / 2;

-------------------------------
-- Outer Join
-------------------------------

-- 조건을 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과 출력 참여시키는 방법
-- 모든 결과를 표현한 테이블이 어느 쪽에 위치하는가에 따라 Left, Right, Full Outer Join으로
-- 구분됨
-- ORACLE SQL의 경우 Null이 출력되는 쪽에 (+)를 붙인다.

-------------------------------
-- Left Outer Join
-------------------------------

Select * From employees Where department_id Is Null;
-- 왜인지는 모르지만 Department_id가 null, 즉 부서에 소속되지 않은 사람

-- Oracle SQL
Select
    emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
From
    employees emp,
    departments dept
Where
    emp.department_id = dept.department_id(+);  -- Null이 포함된 테이블 쪽에 (+)표시
-- Kimberely씨까지 포함해서 출력하기 위해서 Left Outer Join

-- 표준 SQL(ASSI SQL)의 경우 명시적으로 Join방법을 정해준다.
Select
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
From
    employees emp
    Left Outer Join departments dept
        On emp.department_id = dept.department_id;
    