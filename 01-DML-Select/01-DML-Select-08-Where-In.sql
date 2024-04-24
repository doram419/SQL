-- IN 연산자 : 특정 집합의 요소와 비교
-- 사원들 중 10, 20, 40번 부서에서 근무하는 직원들의 이름과 부서 아이디 출력
Select 
    first_name, department_id
From 
    employees
Where
    department_id In (10, 20, 40); 

-- OR로 작성
Select 
    first_name, department_id
From 
    employees
Where
    department_id = 10 OR
    department_id = 20 OR
    department_id = 40; 