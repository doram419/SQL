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

-------------------------------
-- Theta Join
-------------------------------

-- Join조건이 = 아닌 다른 조건들

-- 평균 급여보다 급여가 낮은 직원들 목록
Select 
    emp.employee_id,
    emp.first_name,
    emp.salary,
    emp.job_id,
    j.job_id,
    j.job_title
From
    employees emp
    Join jobs j 
        On emp.job_id = j.job_id
Where emp.salary <= (j.min_salary + j.max_salary) / 2;

-------------------------------
-- Outer Join
-------------------------------

-- 조건을 만족하는 짝이 없는 튜플도 NULL을 포함해서 결과 출력 참여시키는 방법
-- 모든 결과를 표현한 테이블이 어느 쪽에 위치하는가에 따라 Left, Right, Full Outer Join으로
-- 구분됨
-- ORACLE SQL의 경우 Null이 출력되는 쪽에 (+)를 붙인다.

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


-------------------------------
-- Self Join
-------------------------------

-- 자기 자신과 Join
-- 자기 자신을 두 번 호출 -> 별칭을 반드시 부여해야 할 필요가 있는 Join 방법
Select * 
From employees emp ;    -- 107

Select 
     emp.employee_id,
     emp.first_name,
     emp.manager_id,
     man.first_name
From 
    employees emp, employees man
Where 
    emp.manager_id = man.manager_id;
    
-- 해봅시다. Steven (매니저 없는 분)까지 포함해서 출력

Select 
    emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
From 
    employees emp 
    Full Outer Join employees man
    On emp.manager_id = man.manager_id;

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

-- Group By
Select
    emp.department_id,
    Round(Avg(emp.salary), 2)
From 
    employees emp
Group By    
    emp.department_id   -- 집계를 위해 특정 컬럼을 기준으로 그룹핑
Order By
    emp.department_id;
    
-- 부서별 평균 급여에 부서명도 포함하여 출력
Select emp.department_id, dept.department_name, Round(Avg(emp.salary), 2)
From employees emp
    Join departments dept
        On emp.department_id = dept.department_id
Group By emp.department_id, dept.department_name
Order By emp.department_id Asc;

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

-------------------------------
-- SUBQUERY
-------------------------------

-- 모든 직원 급여의 중앙값보다 많은 급여를 받는 사원의 목록

-- 1) 직원 급여의 중앙값?
-- 2) 1번의 결과보다 많은 급여를 받는 직원의 목록?

-- 1) 직원 급여의 중앙값?
Select Median(salary)
From employees;

-- 2) 1번 결과(6200)보다 많은 급여를 받는 직원의 목록
Select first_name, salary
From employees
Where salary >= 6200;

-- 1), 2)쿼리 합치기
Select first_name, salary
From employees
Where 
    salary >= (Select Median(salary)
        From employees)
Order By salary Desc;

-- Susan보다 늦게 입사한 사원의 정보
-- 1) Susan의 입사일
-- 2) 1번의 결과보다 늦게 입사한 사원의 정보

-- 1) Susan의 입사일
Select hire_date
From employees
Where first_name = 'Susan';

-- 2) 1번의 결과보다 늦게 입사한 사원의 정보
Select hire_date, first_name
From employees
Where hire_date > '12/06/07'
Order By hire_date;

-- 두 개 쿼리 합치기
Select hire_date, first_name
From employees
Where hire_date > (Select hire_date
    From employees
    Where first_name = 'Susan')
Order By hire_date;

-- 연습문제
-- 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 수잔보다 늦게 입사한 직원의 목록

-- 급여를 모든 직원 급여의 중앙값보다 많이 받는 직원!
-- A1. 모든 직원 급여의 중앙값 (6200)
Select 
    median(salary)
From 
    employees;
    
-- A2. 6200보다 많이 급여를 받는 직원
Select 
    first_name, 
    salary
From 
    employees
Where 
    salary >= 6200
Order By
    salary Asc;
    
-- A3. 급여를 모든 직원 급여의 중앙값보다 많이 받는 직원!  
Select 
    first_name, 
    salary
From 
    employees
Where 
    salary >= (Select median(salary)
        From employees)
Order By
    salary Asc;

-- B1. 수잔의 입사일
Select 
    hire_date
From employees
Where 
    first_name = 'Susan';
    
-- B2. 12/06/07보다 늦게 입사한 사원
Select 
    hire_date,
    first_name
From employees
Where 
    hire_date > '12/06/07'
Order By
    hire_date Asc;
    
-- B3. 수잔보다 늦게 입사한 직원
Select 
    hire_date,
    first_name
From employees
Where 
    hire_date > (Select hire_date
        From employees
        Where first_name = 'Susan')
Order By
    hire_date Asc;

-- AB. 급여를 모든 직원 급여의 중앙값보다 많이 받으면서 수잔보다 늦게 입사한 직원의 목록
Select 
    first_name,
    salary,
    hire_date
From employees
Where 
    hire_date > (Select hire_date
        From employees
        Where first_name = 'Susan') AND
    salary >= (Select median(salary)
        From employees)
Order By
    hire_date Asc,
    salary Asc;