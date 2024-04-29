-------------------------------
-- Group Aggregation
-------------------------------

-- 집계 : 여러 행으로부터 데이터를 수집, 하나의 행으로 반환

-- COUNT : 갯수 세기 함수
-- employees 테이블의 총 레코드 갯수를 구해보자
Select 
    Count(*)    -- 107개
From 
    employees;
-- Count(*)는 모든 행의 수를 반환해줌 
-- 특정 컬럼 내에 Null 값이 포함되어 있는 지의 여부는 중요하지 않다

-- Commission을 받는 직원의 수를 알고 싶은 경우,
-- 즉, Commission_pct가 null인 경우를 제외하고 싶다면 *로 세면 안됨
Select 
    Count(emp.commission_pct)
From 
    employees emp;
-- 컬럼 내에 포함된 null 데이터를 카운트 하지 않는다

-- 위 커리는 아래 커리와 같다
Select 
    Count(*)
From 
    employees emp
where 
    emp.commission_pct Is Not Null;
    
-- Sum : 합계 함수
-- 모든 사원의 급여의 합계
Select
    Sum(emp.salary) "모든 사원의 급여 합계"
From 
    employees emp;
    
-- Avg :평균 함수
-- 사원들의 평균 급여?
Select 
    Avg(salary)
From 
    employees;
    
-- 사원들이 받는 평균 커미션 비율은?
Select
    Avg(emp.commission_pct) -- 22%
From
    employees emp;
-- 평균 함수(AVG)의 경우, Null값이 포함 되어 있을 경우, 그 값을 집계 수치에서 제외
-- Null값을 집계 결과에 포함 시킬 것에 대한 여부는 정책으로 결정하고 수행해야 함
Select
    Avg(NVL(emp.commission_pct,0))  -- 7%
From
    employees emp;
    
-- Min / Max : 최솟값 / 최댓값
-- Avg / Median : 산술평균 / 중앙값
Select
    Min(salary) 최소급여,
    Max(salary) 최대급여,
    Avg(salary) 평균급여,
    Median(salary) 급여중앙값
From
    employees emp;
    
-- 흔히 범하는 오류
-- 부서별로 평균 급여를 구하고자 할 때
Select 
    emp.department_id,
    Avg(emp.salary)
From
    employees emp; -- 여러 개의 레코드
    
Select 
    Avg(emp.salary)
From
    employees emp;  -- 단일 레코드
-- 부서별과 같은 내용이 필요할 때는 GROUP BY 절 사용해야 한다!

Select 
    department_id, salary
From 
    employees
Order by 
    department_id Asc;
