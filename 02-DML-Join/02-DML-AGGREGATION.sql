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
-- Left 테이블의 모든 레코드가 출력 결과에 참여

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

-------------------------------
-- Right Outer Join
-------------------------------
-- Right 테이블의 모든 레코드가 출력 결과에 참여

-- Oracle SQL
Select
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
From
    employees emp,
    departments dept
Where
    emp.department_id(+) = dept.department_id;  -- departments 테이블 레코드 전부를 출력에 참여
    
-- 표준 SQL(ANSI SQL)  
Select
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
From
    employees emp
    Right Outer Join departments dept
        On emp.department_id = dept.department_id;
        
-------------------------------
-- Full Outer Join
-------------------------------
-- Join에 참여한 모든 테이블의 모든 레코드를 출력 결과에 참여
-- 짝이 없는 레코드들은 Null을 포함해서 출력에 참여

-- Oracle X, ANSI SQL만 사용 가능
Select
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
From
    employees emp
    Full Outer Join departments dept
        On emp.department_id = dept.department_id;
        
-------------------------------
-- Natual Join
-------------------------------
-- Join할 테이블에 같은 이름의 컬럼이 있을 경우, 해당 컬럼을 기준으로 Join
-- 실제 본인이 Join할 조건과 일치하는지 확인해야 한다.
Select * 
From employees emp 
Natural Join departments dept;
-- 주의! 정확하지 않을 수 있음
-- 1. 이것만 보고 우리가 어떤 컬럼을 가지고 Join이 되는지 알기 힘듦
-- 2. 똑같은 항목이 둘 이상 있으면 예상한 것과 다른 결과가 나올 수 있다

Select * 
From employees emp 
Join departments dept
On emp.department_id = dept.department_id;

Select * 
From employees emp 
Join departments dept
On emp.manager_id = dept.manager_id;

Select * 
From employees emp 
Join departments dept
On emp.manager_id = dept.manager_id
AND emp.manager_id = dept.manager_id;

-- 그래서 Natual Join을 쓰는 거보다 명시적으로 해주는게 나을 수 있다.
