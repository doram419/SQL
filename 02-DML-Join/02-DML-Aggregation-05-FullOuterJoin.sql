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