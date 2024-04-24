--------------------------
-- Like 연산
--------------------------
-- 와일드카드(%,_)를 이용한 부분 문자열 매핑
-- % : 0개 이상의 정해지지 않은 문자열 매핑
-- _ : 1개의 정해지지 않은 문자

-- 이름에 am을 포함하고 있는 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '%am%';
    
-- 이름의 두 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '_a%';
    
-- 이름의 네 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '___a%';

-- 이름이 네 글자인 사원들 중에서 두 번째 글자가 a인 사원의 이름과 급여 출력
Select 
    first_name, salary
From 
    employees
Where
    Lower(first_name) Like '_a__';
    