--Case function
-- 보너스를 지급하기로 했습니다.
-- AD관련 직종에게는 20%, SA 관련 직원에게는 10%, IT관련 직원들에겐 8%, 나머지는 5%
Select 
    first_name, 
    job_id, 
    salary,
    Substr(job_id, 1, 2),
    Case Substr(job_id, 1, 2) When 'AD' Then salary * 0.2
                              When 'SA' Then salary * 0.1
                              When 'IT' Then salary * 0.08
                              Else salary * 0.05
    End as "Bonus"
From employees;

-- Decode 함수
Select 
    first_name, 
    job_id, 
    salary,
    Substr(job_id, 1, 2),
    Decode(Substr(job_id, 1, 2), 'AD', salary * 0.2,
                                 'SA', salary * 0.1,
                                 'IT', salary * 0.08,
                                       salary * 0.05)
    as "bonus"
From employees;

-- 연습문제
-- 직원의 이름, 부서, 팀을 출력
-- 팀은 부서 ID로 결정
-- 만약 부서 ID가 10 ~ 30이면 A-GROUP
--              40 ~ 50이면 B-GROUP
--              60 ~ 100이면 C-GROUP
--              나머지 부서 : REMAINDER
Select 
    first_name || ' ' || last_name as "이름",
    department_id as "부서 id",
    Case When department_id >= 10 AND department_id <= 30 Then 'A-GROUP'
         When department_id >= 40 AND department_id <= 50 Then 'B-GROUP'
         When department_id >= 60 AND department_id <= 100 Then 'C-GROUP'
                                                           Else 'Remainder'
    End as "팀"
From employees
Order By
    "팀" Asc,
    department_id Asc;