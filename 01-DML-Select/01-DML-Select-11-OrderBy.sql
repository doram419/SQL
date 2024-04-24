--------------------------------
-- ORDER BY
--------------------------------
-- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드 정렬
-- ASC(오름차순 : default), DESC(내림차순)
-- 여러 개의 칼럼에 적용할 수 있고 ,로 구분

-- 부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하십시오
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc;  -- ASC 생략 가능

-- 급여가 10000 이상인 직원의 이름을 급여 내림차순(높은 급여 -> 낮은 급여)으로 출력하십시오
Select 
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Where 
    salary >= 10000
Order By 
    salary Desc;
    
-- 부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력하십시오.
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc,
    salary Desc;
-- 정렬 기준을 어떻게 세우냐에 따라 성능, 출력 결과 영향을 미칠 수 있다.