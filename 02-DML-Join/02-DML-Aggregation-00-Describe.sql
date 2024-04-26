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