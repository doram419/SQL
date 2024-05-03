/*
---------------------------------------------------------------------
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저 아이디, 커미션 비율, 월급을 출력하세요.
(45건)
---------------------------------------------------------------------
*/

SELECT 
    emp.first_name 이름,
    emp.manager_id 매니저아이디,
    emp.commission_pct 커미션비율,
    emp.salary 월급
FROM
    employees emp
WHERE
    emp.manager_id IS NOT NULL AND
    emp.commission_pct IS NULL AND
    emp.salary > 3000
ORDER BY emp.salary;

/*
---------------------------------------------------------------------
문제2.
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id)를 조회하세
요
- 조건절 비교 방법으로 작성하세요 ✓
- 급여의 내림차순으로 정렬하세요 ✓
- 입사일은 2001-01-13 토요일 형식으로 출력합니다 ✓
- 전화번호는 515-123-4567 형식으로 출력합니다 ✓
(11건)
---------------------------------------------------------------------
*/

-- 각 부서별로 최고의 급여를 받는 사원의 정보를 조회
SELECT 
    emp.employee_id 직원번호,
    emp.first_name 이름,
    emp.salary 급여,
    TO_CHAR(emp.hire_date, 'YYYY-MM-DD DAY') 입사일,
    REPLACE(emp.phone_number, '.','-') 전화번호,
    emp.department_id 부서번호 
FROM 
    employees emp, 
    (
    SELECT 
        department_id,
        MAX(salary) max_salary 
    FROM employees
    GROUP BY department_id
    ) maxSalarys
WHERE
    emp.department_id = maxSalarys.department_id AND
    emp.salary = maxSalarys.max_salary
ORDER BY
    emp.salary ASC;
    
/*
---------------------------------------------------------------------
문제 3.
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2015년 이후의 입사자 입니다.
-매니저별 평균급여가 5000 이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저 아이디, 매니저 이름(first_name), 매니저별 평균급여, 매니저별 최소급여,
 매니저별 최대급여 입니다.
(9건)
---------------------------------------------------------------------
*/

CREATE TABLE managers AS(
    SELECT 
        manager_id,
        ROUND(AVG(salary),1) avg_salary,
        MIN(salary) min_salary,
        MAX(salary) max_salary
    FROM
        employees
    GROUP BY
        manager_id
);

select * FROM managers;
    
SELECT 
    emp.employee_id,
    emp.manager_id 매니저아이디,
    emp.first_name 이름,
    emp.hire_date,
    mgrs.avg_salary 평균임금,
    mgrs.min_salary 최저급여,
    mgrs.max_salary 최대급여
FROM employees emp
    JOIN managers mgrs
        ON emp.employee_id = mgrs.manager_id
WHERE
    hire_date >= '15/01/01' AND
    mgrs.avg_salary >= 5000 
ORDER BY
    mgrs.avg_salary;
    
DROP TABLE managers;
    
/*
---------------------------------------------------------------------
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
---------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
문제7.평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(first_name), 
성(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.
---------------------------------------------------------------------
*/

CREATE TABLE avgSalarys AS(
    SELECT 
        department_id,
        AVG(salary) avg_salary
    FROM 
        employees
    Group By
        department_id
);

select 
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.salary,
    j.job_title
    
FROM 
    employees emp,
        (SELECT
            rownum rn,
            department_id
        FROM 
            avgSalarys
        ORDER BY
            avg_salary DESC) name,
    jobs j
        
WHERE
    name.rn = 1 AND
    emp.department_id = name.department_id AND
    j.job_id = emp.job_id;

-- 공동저자 : 신예은, 정우찬

