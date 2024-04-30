-- 집합 연산
-- 쿼리 1) 15/01/01 이전 입사자 (24행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where hire_date < '15/01/01'; 

 -- 쿼리 2) 12000초과 급여를 받는 직원 목록 (8행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where salary > 12000;  

-- 합집합 (26행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where hire_date < '15/01/01'
Union -- 중복 레코드 한 개로 취급
Select 
    first_name,
    salary,
    hire_date
From employees
Where salary > 12000
Order By hire_date Asc;

-- 합집합(중복 포함) (32행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where hire_date < '15/01/01'
Union All -- 중복 레코드는 별개로 취급
Select 
    first_name,
    salary,
    hire_date
From employees
Where salary > 12000
Order By hire_date Asc;

-- 교집합 -> Inner Join과 동일한 결과 (6행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where hire_date < '15/01/01'
Intersect 
Select 
    first_name,
    salary,
    hire_date
From employees
Where salary > 12000
Order By hire_date Asc;

-- 차집합 (18행)
Select 
    first_name,
    salary,
    hire_date
From employees
Where hire_date < '15/01/01'
Minus 
Select 
    first_name,
    salary,
    hire_date
From employees
Where salary > 12000
Order By hire_date Asc;