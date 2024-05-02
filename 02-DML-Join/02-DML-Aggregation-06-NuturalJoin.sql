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

