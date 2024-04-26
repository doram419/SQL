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