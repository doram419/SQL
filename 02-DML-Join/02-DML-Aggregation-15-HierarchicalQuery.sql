-- Hierarchical Query (Oracle 특화)
-- 트리 형태 구조 표현
-- Level 가상 컬럼 활용 쿼리
Select level, first_name, manager_id
From employees
Start With manager_id Is Null               -- 트리 형태의 Root가 되는 조건 명시
Connect By Prior employee_id = manager_id   -- 상위 레벨과 하위 레벨의 연결조건(가지 치기 조건)
Order By level;                             -- 트리의 깊이를 나타내는 Oracle의 가상 Column
