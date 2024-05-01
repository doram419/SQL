-- p53
-- 애스터리스크와 열을 함께 사용하려면 애스터리스크를 테이블로 한정해야 한다.
Select 
    dept.department_id,
    dept.*
from departments dept;

-- 오라클 DB는 에러 발생 시 에러 코드와 에러 메시지를 반환한다.
-- 에러 원인과 권장 조치 확인 가능.

Select 
    emp.first_name "이름",
    emp.department_id "부서id"
From
    employees emp 
Where 
    emp.department_id = 100;
-- From에서 붙힌 테이블 별칭은 Where과 Select 모두 사용가능


    