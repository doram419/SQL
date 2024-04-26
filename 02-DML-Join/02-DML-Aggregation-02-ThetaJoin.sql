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