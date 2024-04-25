-- nvl1 function
SELECT 
    first_name, 
    salary, 
    nvl(salary * commission_pct, 0) as "commission"  -- nvl(표현식, 대체값)
FROM employees;

-- nvl2 function
Select 
    first_name,
    salary,
    nvl2(commission_pct, salary * commission_pct, 0) as "Commission" 
    -- nvl2(조건문, null이 아닐때의 값, null이 아닐때의 값)
From employees;