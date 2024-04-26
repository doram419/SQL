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