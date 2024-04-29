-- Group By 절 이후에는 Group By에 참여한 컬럼과 집계 함수만 남는다.

-- 평균 급여가 $ 7,000 이상인 부서만 출력해야 한다.
Select emp.department_id, Round(Avg(emp.salary),2)
From employees emp
Where Avg(emp.salary) >= 7000   -- 아직 집계 함수 시행되지 않은 상태 -> 집계 함수의 비교 불가
Group By emp.department_id
Order By emp.department_id;

Select emp.department_id, Round(Avg(emp.salary),2)
From employees emp
Where Avg(emp.salary) >= 7000   -- 아직 집계 함수 시행되지 않은 상태 -> 집계 함수의 비교 불가
Group By emp.department_id
Order By emp.department_id;

-- 집계 함수 이후 조건 비교 Having절을 이용해야한다.
Select department_id, Round(Avg(salary),2)
From employees 
Group By department_id 
Having Avg(salary) >= 7000  -- Group By Aggregation의  조건처리
Order By department_id;

-- RollUp
-- Group By 절과 함께 사용
-- 그룹지어진 결과에 대한 좀 더 상세한 요약을 제공하는 기능 수행
-- 일종의 Item Total
Select 
    department_id,
    job_id,
    Sum(salary)
From
    employees
Group By RollUp(department_id, job_id)
Order By department_id Asc;

-- Cube
-- CrossTab에 대한 Summary를 함께 추출하는 함수
-- Rollup 함수에 의해 출력되는 Item Total 값과 함께
-- Column Total 값을 함께 추출
Select 
    department_id,
    job_id,
    Sum(salary)
From
    employees
Group By Cube(department_id, job_id)
Order By department_id Asc;