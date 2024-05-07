/*
---------------------------------------------------------------------
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저 아이디, 커미션 비율, 월급을 출력하세요.
(45건)
---------------------------------------------------------------------
*/

SELECT
    emp.first_name     이름,
    emp.manager_id     매니저아이디,
    emp.commission_pct 커미션비율,
    emp.salary         월급
FROM
    employees emp
WHERE
    emp.manager_id IS NOT NULL
    AND emp.commission_pct IS NULL
    AND emp.salary > 3000
ORDER BY
    emp.salary;

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
    emp.employee_id                          직원번호,
    emp.first_name                           이름,
    emp.salary                               급여,
    to_char(emp.hire_date, 'YYYY-MM-DD DAY') 입사일,
    replace(emp.phone_number, '.', '-')      전화번호,
    emp.department_id                        부서번호
FROM
    employees emp,
    (
        SELECT
            department_id,
            MAX(salary)   max_salary
        FROM
            employees
        GROUP BY
            department_id
    )         maxsalarys
WHERE
    emp.department_id = maxsalarys.department_id
    AND emp.salary = maxsalarys.max_salary
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
        round(AVG(salary), 1) avg_salary,
        MIN(salary)           min_salary,
        MAX(salary)           max_salary
    FROM
        employees
    WHERE
        hire_date >= '15/01/01'
    GROUP BY
        manager_id
);

SELECT
    *
FROM
    managers;

SELECT
    emp.employee_id,
    emp.manager_id  매니저아이디,
    emp.first_name  이름,
    emp.hire_date,
    mgrs.avg_salary 평균임금,
    mgrs.min_salary 최저급여,
    mgrs.max_salary 최대급여
FROM
    employees emp
    JOIN managers mgrs
    ON emp.employee_id = mgrs.manager_id
WHERE
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

SELECT
    emp.employee_id      사번,
    emp.first_name       이름,
    dept.department_name 부서명,
    mgr.first_name       매니저
FROM
    employees   emp
    JOIN employees mgr
    ON emp.manager_id = mgr.employee_id
    LEFT OUTER JOIN departments dept
    ON emp.department_id = dept.department_id;
    
/*
---------------------------------------------------------------------
문제5. 2015년 이후 입사한 직원 중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
---------------------------------------------------------------------
*/

SELECT
    emp.Employee_Id,
    emp.first_name,
    DEPT.department_name,
    emp.salary,
    emp.hire_date
FROM
    (
        SELECT
            RANK() OVER(ORDER BY hire_date ASC) rw,
            employee_id,
            first_name,
            department_id,
            salary,
            hire_date
        FROM
            employees
        WHERE
            hire_date >= '15/01/01'

    ) emp
JOIN 
    departments dept
ON 
    emp.department_id = dept.department_id
WHERE 
    emp.rw >= 11 AND emp.rw <= 20
ORDER BY
    emp.hire_date;

/*
---------------------------------------------------------------------
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
(department_name)은?
---------------------------------------------------------------------
*/
    

/*
---------------------------------------------------------------------
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.
---------------------------------------------------------------------
*/

CREATE TABLE avgsalarys AS(
    SELECT
        department_id,
        AVG(salary)   avg_salary
    FROM
        employees
    GROUP BY
        department_id
);

SELECT
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.salary,
    j.job_title
FROM
    employees emp,
    (
        SELECT
            rownum        rn,
            department_id
        FROM
            avgsalarys
        ORDER BY
            avg_salary DESC
    )         name,
    jobs      j
WHERE
    name.rn = 1
    AND emp.department_id = name.department_id
    AND j.job_id = emp.job_id;

-- 공동저자 : 신예은, 정우찬

SELECT
    employee_id                               직원번호,
    first_name                                이름,
    last_name                                 성,
    job_title                                 업무,
    salary                                    급여,
    avg(salary) OVER (ORDER BY department_id) 평균급여
FROM
    employees
    JOIN jobs
    USING (job_id)
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            (
                SELECT
                    department_id
                FROM
                    employees
                GROUP BY
                    department_id
                ORDER BY
                    AVG(salary)DESC
            )
        WHERE
            ROWNUM = 1
    );

-- 예은 누나 코드