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
    