-----------------------------------------------------------------------------
-- 문제 1.
-----------------------------------------------------------------------------
-- 직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 
-- 부서명(department_name)을 조회하여 부서이름(department_name) 오름차순, 
-- 사번(employee_id) 내림차순 으로 정렬하세요.(106건)

-- 조건 : 직원들의 사번, 이름, 성, 부서명이 나오게 하세요
-- 출력 항목 : 사번(employee_id), 이름(firt_name), 성(last_name), 부서명(department_name)
-- 정렬 : 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순
-- 출력 항목 수 : 106건
-- Simple Join
Select
    emp.employee_id, emp.first_name, emp.last_name,
    dept.department_name
From
    employees emp, departments dept
Where emp.department_id = dept.department_id    -- Join 조건
Order By dept.department_name Asc, emp.employee_id Desc;

-- ANSI
-- Join의 의도를 명확하게 하고, 조인 조건과 Selection 조건을 분리하는 효과
Select
    emp.employee_id, emp.first_name, emp.last_name,
    dept.department_name
From employees emp  -- 중심 테이블
    Join departments dept
        On emp.department_id = dept.department_id   -- 조인 조건
Order By dept.department_name Asc, emp.employee_id Desc;

-- My Code
Select
    emp.employee_id "사번",
    emp.first_name "이름",
    emp.last_name "성",
    dept.department_name "부서명"
From
    employees emp
Join
    departments dept
    On emp.department_id = dept.department_id
Order By
    dept.department_name Asc,
    emp.employee_id Desc;

    
-----------------------------------------------------------------------------
-- 문제 2.
-----------------------------------------------------------------------------
-- employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
-- 직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name),
-- 현재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
-- 부서가 없는 Kimberely(사번 178)은 표시하지 않습니다. (106건)

-- 조건 : 요청한 내용을 표시하시오.
--       부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
-- 출력 항목 : 직원들의 사번(employee_id), 이름(firt_name), 급여(salary),
--           부서명(department_name), 현재업무(job_title)
-- 정렬 : 사번(employee_id) 오름차순
-- 출력 항목 수 : 106건
-- Simple Join
Select emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
From employees emp, departments dept, jobs j
Where emp.department_id = dept.department_id And
    emp.job_id = j.job_id
Order By emp.employee_id ASC;

--ANSI Join
Select emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
From employees emp  -- 중심 테이블
    Join departments dept
        On emp.department_id = dept.department_id -- emp 테이블과 dept 테이블 Join 조건
    Join jobs j
        On emp.job_id = j.job_id
Order By emp.employee_id ASC;

-- My Code
Select
    emp.employee_id "사번",
    emp.first_name "이름",
    emp.salary "급여",
    dept.department_name "부서명",
    j.job_title "현재 업무"
From
    employees emp
Join 
    departments dept
    On emp.department_id = dept.department_id
Join 
    Jobs j
    On emp.job_id = j.job_id
Order By
    emp.employee_id Asc;
    
-----------------------------------------------------------------------------
-- 문제 2-1.
-----------------------------------------------------------------------------
-- 요구사항 : 문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
-- Select * From employees Where department_id Is Null;
-- Oracle Query
Select
    emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
From employees emp, departments dept, jobs j
Where 
    emp.department_id = dept.department_id (+) AND  -- NULL이 포함된 테이블 쪽에(+)
    emp.job_id = j.job_id
Order By emp.employee_id Asc;

--ANSI Query
Select emp.employee_id 사번,
    emp.first_name 이름,
    emp.salary 급여,
    dept.department_name 부서명,
    j.job_title 현재업무
From employees emp  -- 중심 테이블
    Left Outer Join  departments dept
        On emp.department_id = dept.department_id -- emp 테이블과 dept 테이블 Join 조건
    Join jobs j
        On emp.job_id = j.job_id
Order By emp.employee_id ASC;

-- MyCode
Select
    emp.employee_id "사번",
    emp.first_name "이름",
    emp.salary "급여",
    dept.department_name "부서명",
    j.job_title "현재 업무"
From
    employees emp
Left Outer Join 
    departments dept
    On emp.department_id = dept.department_id
Join 
    Jobs j
    On emp.job_id = j.job_id
Order By
    emp.employee_id Asc;
    
-----------------------------------------------------------------------------
-- 문제 3.
-----------------------------------------------------------------------------
-- 도시 별로 위치한 부서들을 파악하려고 합니다.
-- 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요
-- 부서가 없는 도시는 표시하지 않습니다.(27건)

-- 조건 : 요청한 내용을 표시하시오.
--       부서가 없는 도시는 표시하지 않습니다.
-- 출력 항목 : 도시 아이디, 도시명, 부서명, 부서아이디
-- 정렬 : 도시아이디(오름차순)
-- 출력 항목 수 : 27건
Select
    loc.location_id 도시아이디,
    loc.city 도시명,
    dept.department_name 부서명,
    dept.department_id 부서아이디
From locations loc
    Join departments dept
        On loc.location_id = dept.location_id
Order By loc.location_id Asc;

--My Query
Select
    loc.location_id "도시 id",
    loc.city "도시명",
    dept.department_name "부서명",
    dept.department_id "부서 id"
From
    locations loc
Join departments dept
    On loc.location_id = dept.location_id
Order By
    loc.location_id Asc;
    
-----------------------------------------------------------------------------
-- 문제 3-1.
-----------------------------------------------------------------------------
-- 요구사항 : 문제 3에서 부서가 없는 도시도 포함합니다.
Select
    loc.location_id 도시아이디,
    loc.city 도시명,
    dept.department_name 부서명,
    dept.department_id 부서아이디
From locations loc
    Join departments dept
        On loc.location_id = dept.location_id
Order By loc.location_id Asc;

-- My Query
Select
    loc.location_id "도시 id",
    loc.city "도시명",
    dept.department_name "부서명",
    dept.department_id "부서 id"
From
    locations loc
Left Outer Join departments dept
    On loc.location_id = dept.location_id
Order By
    loc.location_id Asc;
    
-----------------------------------------------------------------------------
-- 문제 4.
-----------------------------------------------------------------------------
-- 지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 
-- 출력하되 지역 이름(오름차순), 나라 이름(내림차순) 으로 정렬하세요 (25건)

-- 조건 : 지역(regions)에 있는 나라 테이블에서 요청한 내용을 표시하시오.
-- 출력 항목 : 지역이름(region_name), 나라이름(country_name)
-- 정렬 : 지역 이름(오름차순), 나라 이름(내림차순)
-- 출력 항목 수 : 25건
Select
    reg.region_name 지역이름,
    con.country_name 나라이름
From regions reg    -- 중심 테이블
    Join countries con
        On reg.region_id = con.region_id
Order By reg.region_name Asc,
    con.country_name Desc;

-- My Query
Select
    reg.region_name "지역 이름",
    cou.country_name "나라 이름"
From
    regions reg
Join
    countries cou
    On reg.region_id = cou.region_id
Order By
    reg.region_name Asc,
    cou.country_name Desc;

-----------------------------------------------------------------------------
-- 문제 5.
-----------------------------------------------------------------------------
-- 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 
-- 이름(first_name)과 채용일(hire_date), 매니저이름(first_name),
-- 매니저 입사일(hire_date)을 조회하세요 (37건)

-- 조건 : 자신의 매니저보다 채용일(hire_date)이 빠른 사원을 찾으시오.
-- 출력 항목 : 사번(employee_id), 이름(first_name)과 채용일(hire_date), 
--           매니저이름(first_name), 매니저 입사일(hire_date)
-- 출력 항목 수 : 37건
-- Self Join
Select emp.employee_id 사번,
    emp.first_name 이름,
    emp.hemp.hire_date 채용일,
    man.first_name 매니저이름,
    man.hire_date 매니저입사일
From employees emp
    Join employees man
        On emp.manager_id = man.employee_id -- Join 조건
Where emp.hire_date < man.hire_date;        -- Selection 조건

-- My Query
Select
    emp.employee_id "사번",
    emp.first_name "이름",
    emp.hire_date "채용일",
    mgr.first_name "매니저 이름",
    mgr.hire_date "매니저 입사일"
From
    employees emp
Join 
    employees mgr
    On emp.manager_id = mgr.employee_id
Where
    emp.hire_date < mgr.hire_date;
    
-----------------------------------------------------------------------------
-- 문제 6.
-----------------------------------------------------------------------------
-- 나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
-- 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여
-- 출력하세요.
-- 값이 없는 경우 표시하지 않습니다.(27건)

-- 조건 : 요구한 사항을 출력하시오
-- 출력 항목 : 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디
-- 출력 항목 수 : 27건
-- 정렬 : 나라명(오름차순)
Select
    con.country_name 나라명,
    con.country_id 나라아이디,
    loc.city 도시명,
    loc.location_id 도시아이디,
    dept.department_name 부서명,
    dept.department_id 부서아이디
From countries con
    Join locations loc
        On con.country_id = loc.country_id
    Join departments dept
        On loc.location_id = dept.location_id
Order By con.country_name Asc;

-- My Query
Select 
    cou.country_name "나라명",
    cou.country_id "나라 id",
    loc.city "도시명",
    dept.department_name "부서명",
    dept.department_id "부서 id"
From
    countries cou
Join 
    locations loc
    on cou.country_id = loc.country_id
Join
    departments dept
    on loc.location_id = dept.location_id
Order By
    cou.country_name Asc;
    
-----------------------------------------------------------------------------
-- 문제 7.
-----------------------------------------------------------------------------
-- job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
-- 과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 
-- 업무아이디, 시작일, 종료일을 출력하세요.
-- 이름은 first_name과 last_name을 합쳐 출력합니다.(2건)

-- 조건 : 과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원을 찾으시오
-- 출력 항목 : 사번, 이름(풀네임), 업무 아이디, 시작일, 종료일
-- 출력 항목 수 : 2건

-- My Query
Select
    emp.employee_id "사번",
    emp.first_name || ' ' || emp.last_name "이름(풀네임)",
    emp.job_id "업무 id",
    jhis.start_date "시작일",
    jhis.end_date "종료일"
From
    employees emp
Join
    job_History jHis 
    On emp.employee_id = jhis.employee_id
Where
    jhis.job_id In ('AC_ACCOUNT');
    
-----------------------------------------------------------------------------
-- 문제 8.
-----------------------------------------------------------------------------
-- 각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name),
-- 매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 
-- 나라(countries)의 이름(countries_name) 
-- 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.(11건)

-- 조건 : 각 부서(department)에 대한 정보를 출력하시오
-- 출력 항목 : 부서번호(department_id), 부서이름(department_name),
--            매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 
--            나라(countries)의 이름(countries_name), 지역구분(regions)의 이름(resion_name)
-- 출력 항목 수 : 11건    

select
    dept.department_id "부서번호",
    dept.department_name "부서이름",
    mgr.first_name "매니저 이름",
    loc.city "도시 이름",
    cou.country_name "나라 이름",
    reg.region_name "지역 이름"
From 
    departments dept
Join employees mgr
    On dept.manager_id = mgr.employee_id
Join locations loc
    On dept.location_id = loc.location_id
Join countries cou
    On loc.country_id = cou.country_id
Join regions reg
    On cou.region_id = reg.region_id;
    
-----------------------------------------------------------------------------
-- 문제 9.
-----------------------------------------------------------------------------
-- 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
-- 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
-- 부서가 없는 직원(Kimberely)도 표시합니다. (106명)

-- 조건 : 각 사원(employee)에 대한 정보를 출력하시오
--       부서가 없는 직원도 표시합니다
-- 출력 항목 : 사번(employee_id), 이름(first_name), 부서명(department_name), 
--           매니저(manager)의 이름(first_name)
-- 출력 항목 수 : 106명  
Select 
    emp.employee_id "사번",
    emp.first_name "이름",
    dept.department_name "부서명",
    mgr.first_name "매니저 이름"
From 
    employees emp 
Left Outer Join departments dept
    On emp.department_id = dept.department_id
Join employees mgr
    On emp.manager_id = mgr.employee_id;