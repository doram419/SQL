-- 02-09-연습
-- 사원의 이름(first_name)과 전화번호, 입사일, 급여를 출력해 봅시다
Select 
    first_name "이름",
    phone_number "전화번호",
    hire_date "입사일",
    salary "급여"
From
    employees;
    
-- 사원의 이름(first_name)과 성(last_name), 급여, 전화번호, 입사일을 출력해 봅시다
Select
    first_name "이름",
    last_name "성",
    salary "급여",
    phone_number "전화번호",
    hire_date "입사일"
From 
    employees;
    
/*   
-- 02-15-연습
[예제] hr.employees 전체 튜플에 다음과 같이 Column Alias를 붙여 출력해 봅니다
 이름 : first_name last_name
 입사일: hire_date
 전화번호 : phone_number
 급여 : salary
 연봉 : salary * 12
*/ 
Select 
    first_name || ' ' || last_name "이름",
    hire_date "입사일",
    phone_number "전화번호",
    salary "급여",
    salary * 12 "연봉"
From 
    hr.employees;
    
/* 02-22-연습
[예제] hr.employees
 급여가 15000 이상인 사원들의 이름과 연봉을 출력하십시오
*/
Select 
    emp.first_name ||
    ' ' ||
    emp.last_name "이름",
    emp.salary "연봉"
From 
    employees emp
Where 
    salary >= 15000;

--  07/01/01일 이후 입사자들의 이름과 입사일을 출력하십시오. 
Select 
    em.first_name || ' ' || em.last_name "이름",
    em.hire_date "입사일"
From
    employees em
Where 
    em.hire_date >= '07/01/01';

--  이름이 'Lex'인 사원의 연봉과 입사일, 부서 ID를 출력하십시오. 
Select 
    emp.first_name "이름",
    emp.salary * 12 "연봉",
    emp.hire_date "입사일",
    emp.department_id "부서 ID"
From 
    employees emp
Where
    emp.first_name = 'Lex';

--  부서 ID가 10인 사원의 명단이 필요합니다
Select
    *
From 
    employees em
Where 
    em.department_id = 10;

/* 02-26-연습
[예제] hr.employees
 급여가 14000 이하이거나 17000 이상인 사원의 이름과 급여를 출력하십시오. 
*/
Select 
    emp.first_name "이름",
    emp.salary "급여"
From 
    employees emp
Where 
    emp.salary <= 14000 OR 
    emp.salary >= 17000;

/*
 부서 ID가 90인 사원 중, 급여가 20000 이상인 사원은 누구입니까?
*/
Select 
    *
From  
    employees emp
Where
    emp.department_id = 90 AND
    emp.salary >= 20000;
  
/* 02-27-연습  
[예제] hr.employees
 입사일이 17/01/01 ~ 17/12/31 구간에 있는 사원의 목록을 출력해 봅시다
*/ 
-- 논리 연산자
Select
    *
From 
    employees emp
Where
    emp.hire_date >= '17/01/01' And
    emp.hire_date <= '17/12/31';

-- BETWEEN
Select
    *
From 
    employees emp
Where
    emp.hire_date Between '17/01/01' And '17/12/31';
  
/*  
[예제] 02-28-연습 
--  부서 ID가 10, 20, 40인 사원의 명단을 출력해 봅시다
-- 비교연산자+논리연산자를 이용하여 출력
*/
Select 
    *
From 
    employees emp
Where 
    emp.department_id = 10 OR
    emp.department_id = 20 OR
    emp.department_id = 40;

-- IN 연산자를 이용해 출력해 봅시다
Select 
    *
From 
    employees emp
Where 
    emp.department_id IN (10,20,40); 

--  MANAGER ID가 100, 120, 147 인 사원의 명단을 출력해 봅시다
-- 비교연산자+논리연산자를 이용하여 출력
Select
    *
From 
    employees emp
Where
    emp.manager_id = 100 OR
    emp.manager_id = 120 OR
    emp.manager_id = 147;

-- IN 연산자를 이용해 출력해 봅시다
Select
    *
From 
    employees emp
Where
    emp.manager_id In (100, 120, 147);
    
/*  
[예제] 02-29-연습 
 이름에 am을 포함한 사원의 이름과 급여를 출력해 봅시다
*/
Select 
    first_name || ' ' || last_name "이름",
    salary "급여"
From 
    employees emp
Where 
    emp.first_name Like '%am%';

--  이름의 두 번째 글자가 a인 사람의 이름과 급여를 출력해 봅시다
Select 
    first_name "이름",
    salary "급여"
From 
    employees
Where
    first_name Like '_a%';

--  이름의 네 번째 글자가 a인 사원의 이름을 출력해 봅시다
Select
    first_name "이름"
From 
    employees
Where   
    first_name Like '___a%';

--  이름이 4글자인 사원 중 끝에서 두 번째 글자가 a 인 사원의 이름을 출력해 봅시다
Select
    first_name "이름"
From 
    employees
Where
    first_name Like '____' AND
    first_name Like'%a_';
    
/*  
[예제] 02-33-연습 
--  [연습] hr.employees
 부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하십시오
*/
Select 
    emp.department_id "부서번호",
    emp.salary "급여",
    emp.first_name "이름"
From employees emp
Order By emp.department_id Asc;

--  급여가 10000 이상인 직원의 이름을 급여 내림차순(높은 급여 -> 낮은 급여)으로 출력하십시오
Select 
    emp.first_name "이름",
    emp.salary "임금"
From employees emp
Where emp.salary >= 10000
Order By emp.salary Desc;

--  부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력하십시오
Select 
    emp.department_id "부서번호",
    emp.salary "급여",
    emp.first_name "이름"
From employees emp
Order By
    emp.department_id Asc,
    emp.salary Desc;
    
/*  
[예제] 02-58-연습 
 [연습] hr.employees
 직원의 이름, 부서, 팀을 출력하십시오
 팀은 코드로 결정하며 다음과 같이 그룹 이름을 출력합니다
 부서 코드가 10 ~ 30이면: 'A-GROUP'
 부서 코드가 40 ~ 50이면: 'B-GROUP'
 부서 코드가 60 ~ 100이면 : 'C-GROUP'
 나머지 부서는 : 'REMAINDER'
*/
Select 
    emp.first_name "이름",
    emp.department_id "부서",
    Case 
        When emp.department_id >= 10 AND emp.department_id <= 30 Then 'A-GROUP'
        When emp.department_id >= 40 AND emp.department_id <= 50 Then 'B-GROUP'
        When emp.department_id >= 60 AND emp.department_id <= 100 Then 'C-GROUP'
    End "부서 코드"
From employees emp
Order By "부서 코드" Asc;
