-- SQL 문장의 주석
-- 마지막에 세미콜론(;)으로 끝난다
-- 키워드들은 대소문자 구분하지 않는다
-- 그러나 강사님은 명령어는 대문자, 데이터는 소문자로 쓰시는 편
-- 실제 데이터의 경우 대소문자를 구분

-- 테이블 구조 확인 (DESCRIBE)
DESCRIBE employees;
-- describe EMPLOYEES;
DESCRIBE departments;
DESCRIBE locations;

-- DML(Data Manipulation Language)
-- SELECT

-- * : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로 
select * from employees;

-- 특정 컬럼만 Projection 하고자 하면 열 목록을 명시
-- employees 테이블의 first_name 과 phone_number 과 hire_date, salary만 보고 싶다면
select first_name, phone_number, hire_date, salary from Employees;

-- 사원의 이름, 성, 급여, 전화번호, 입사일 정보 출력
select first_name,
    last_name,
    salary,
    phone_number,
    hire_date 
    from employees;

-- 사원 정보로부터 사번, 이름, 성 정보 출력
SELECT employee_id,
    first_name,
    last_name
    from employees;
    
-- 산술연산 : 기본적인 산술연산을 수행할 수 있다.
-- 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할때 : dual(가상 테이블)
select 3.14159 * 10 * 10 from dual;

-- 특정 컬럼의 값 산술 연산에 포함시키고자 할 경우
select first_name,
    salary,
    salary * 12
    FROM employees;
    
-- 다음 문장을 실행해봅시다.
select first_name,
    job_id,
    job_id * 12
    FROM employees;
-- 오류의 원인 : job_id 는 문자열(VARCHAR2),
--             문자열을 산술 계산 할 수 없음

desc employees;

-- NULL
-- 이름, 급여, 커미션 비율를 츨력해보자
Select first_name, salary, commission_pct 
From employees;

-- 이름, 커미션까지 포함한 급여를 출력
Select first_name, salary, commission_pct,
salary + salary * commission_pct
From employees;
-- NULL이 포함된 연산식의 결과는 NULL
// NULL을 처리하기 위한 함수 NVL필요
// NVL(표현식1, 표현식1이 널일경우 그의 대체값);

-- NVL 활용 대체값 계산
Select first_name, salary, commission_pct,
    salary + salary * NVL(commission_pct, 0)
From employees;

-- NULL은 0이나 ""와 다르게 빈 값이다.
-- NULL은 산술 연산 결과, 혹은 통계 결과를 왜곡시킨다.
-- ㄴ> 그래서 NULL에 대한 처리는 철저할 필요 있음

-- 별칭 Alias
-- : Projection 단계에서 출력용으로 표시되는 임시 컬럼 제목
-- < Alias 사용법 >
-- > 컬럼명 뒤에 별칭
-- > 컬럼명 뒤에 as 별칭
-- !! 표시명에 특수문자가 포함된 경우 " " 로 묶어서 표현하기

-- 예제1 : 직원 아이디, 이름, 급여를 출력하자
--        직원 아이디는 empNO, 이름은 f-name, 급여는 월 급으로 표시하라.
Select employee_id empNo,
    first_name "f-name",
    salary as "월 급"
From employees;

-- 예제2 : first_name과 last_name을 합쳐서 Full Name이라고 출력하고
--        commission_pct가 포함된 salary를 급여라고 출력하며,
--        급여 * 12를 하여 연봉으로 출력해라
Select first_name || ' ' || last_name as "Full Name",
-- 오라클에서는 자바처럼 + 연산을 문자에서 사용할 수 없다!
       salary + salary * NVL(commission_pct, 0) as "급여(커미션 포함)",
       salary * 12 as "연봉"
       From employees;
       
-- [연습 예제] hr.employees 전체 튜플에 다음과 같이 Column Alias를 붙여 출력해 봅니다
--  이름 : first_name last_name
--  입사일: hire_date
--  전화번호 : phone_number
--  급여 : salary
--  연봉 : salary * 12
Select first_name || ' ' || last_name as "이름",
       hire_date as "입사일",
       phone_number as "전화번호",
       salary as "급여",
       salary * 12 as "연봉"
       From employees;

----------------
-- WHERE
----------------
-- 특정 조건을 기준으로 레코드를 선택 (SELECTION)
-- 비교연산 : =, <>, >=, <=, <=
-- 예제 : 사원들 중에서 급여가 15000 이상인 직원의 이름과 급여를 표시
Select 
    first_name || ' ' || last_name as "이름",
    salary as "급여"
From 
    employees
Where 
    salary >= 15000;

-- 예제 : 입사일이 07/01/01 이후인 직원들의 이름과 입사일 표시
Select
    first_name || ' '|| last_name as "이름",
    hire_date as "입사일"
From 
    employees
Where
    hire_date >= '17/01/01';
-- 날짜도 대소 비교가 가능하다

-- 예제 : 급여가 14000 이하이거나, 17000 이상인 사원의 이름과 급여
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary <= 4000 
    OR salary >= 17000;
    
-- 예제 : 급여가 14000 이상이고, 17000 미만인 사원의 이름과 급여
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary >= 14000 AND salary < 17000;
    
-- BETWEEN : 범위 비교
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary Between 14000 and 17000;

-- NULL 체크 =, <> 사용하면 안 됨
-- IS NULL, IS NOT NULL

-- commission을 받지 않는 사람들 (-> commision_pct가 NULL인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct IS NULL;
-- NULL 체크

-- commission을 받는 사람들 (-> commission_pct가 Not Null인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct Is Not Null;

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
    
-- 부서 ID가 90인 사원 중, 급여가 20000 이상인 사원 이름, 급여
Select 
    first_name as "이름",
    salary as "급여",
    department_id as "부서 ID"
From 
    employees
Where 
    department_id In (90) -- 조건1 : 부서가 90
AND 
    salary >= 20000;      -- 조건 2 : 급여가 20000이상

-- 입사일이 11/01/01 ~ 17/12/31 구간에 있는 사원의 목록 이름, 입사일
Select 
    first_name as "이름",
    salary as "급여",
    hire_date as "입사일"
From 
    employees
Where 
    hire_date >= '11/01/01'
AND 
    hire_date <= '17/12/31';

-- manager_id가 100, 120, 147인 사원의 명단의 이름, manager_id
-- 1. 비교연산자 + 논리연산자의 조합
Select 
    manager_id as "사번",
    first_name as "이름",
    salary as "급여"
From 
    employees
Where 
    manager_id = 100 
OR  manager_id = 120
OR  manager_id = 147;

-- 2. IN 연산자 이용
Select 
    manager_id as "사번",
    first_name as "이름",
    salary as "급여"
From 
    employees
Where 
    manager_id IN (100, 120, 147);

--------------------------------
-- ORDER BY
--------------------------------
-- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드 정렬
-- ASC(오름차순 : default), DESC(내림차순)
-- 여러 개의 칼럼에 적용할 수 있고 ,로 구분

-- 부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하십시오
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc;  -- ASC 생략 가능

-- 급여가 10000 이상인 직원의 이름을 급여 내림차순(높은 급여 -> 낮은 급여)으로 출력하십시오
Select 
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Where 
    salary >= 10000
Order By 
    salary Desc;
    
-- 부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력하십시오.
Select 
    department_id as "부서 번호",
    salary as "급여",
    first_name || ' ' || last_name as "이름"
From 
    employees
Order By 
    department_id Asc,
    salary Desc;
-- 정렬 기준을 어떻게 세우냐에 따라 성능, 출력 결과 영향을 미칠 수 있다.

--------------------------
-- 단일행 함수
--------------------------
-- 단일 레코드를 기준으로 특정 컬럼에 값이 적용되는 함수
-- 문자열 단일행 함수 1
Select 
    first_name, last_name,
    Concat(first_name, Concat(' ', last_name)),  -- 문자열 연결 함수
    first_name || ' ' || last_name,              -- 문자열 연결 연산
    Initcap(first_name || ' ' || last_name)      -- 각 단어의 첫 글자를 대문자로 만듦
From 
    employees;
    
-- 문자열 단일행 함수 2
Select 
    first_name, last_name,
    Lower(first_name),  -- 모두 소문자
    Upper(first_name),  -- 모두 대문자
    Lpad(first_name, 20, '*'),  -- 왼쪽 빈 자리 채움
    Rpad(first_name, 20, '*')   -- 오른쪽 빈 자리 채움
From 
    employees;
    
-- 문자열 단일행 함수 3
Select 
    '       Oracle     ',
    '*****Database*****',
    Ltrim('       Oracle     '),        -- 왼쪽의 빈 공간(화이트 스페이스) 삭제
    Rtrim('       Oracle     '),        -- 오른쪽의 빈 공간(화이트 스페이스) 삭제
    Trim('*' From '*****Database*****'),-- 앞뒤의 잡음 문자 제거
    Substr('Oracle Database', 8, 4),    -- 선택한 인덱스부터 숫자만큼 세서 출력 가능
    Substr('Oracle Database', -8, 4),   -- 기준을 뒤부터 세서 하는 것도 가능
    Length('Oracle Database')           -- 문자열의 길이
From 
    dual;   -- 어딘가에서 들고 오는 건 아니라서 dual
-- 이런 것들을 전처리 과정이라고 함
-- 머신러닝, 딥러닝 할 때 자주 하게 될 것이다
-- 데이터 사이언스의 80% 작업이 데이터 수집, 정제과정

-- 수치형 단일행 함수 
Select 
    3.141592,
    Abs(-3.14),              -- 절댓값
    Ceil(3.14),              -- 동일하거나 큰, 가장 가까운 정수
    Floor(3.14),             -- 동일하거나 작은, 가장 가까운 정수
    Round(3.5),              -- 반올림
    Round(3.14159, 3),       -- 소숫점 3번째 자리까지 반올림
    Trunc(3.5),              -- 버림
    Trunc(3.14159, 3),       -- 소수점 4번째 이상부터 싹 버림(즉 3번째까지 보여줌)
    Sign(-3.14159),          -- 부호 (-1: 음수, 0: 0, 1: 양수)
    Mod(7,3),                -- 7을 3으로 나눈 나머지
    Power(2,4)               -- 2의 4 제곱
From 
    dual;

--------------------------
-- DATE FORMAT
--------------------------

-- 현재 세션 정보 확인
Select PARAMETER ,
VALUE 
From nls_session_parameters;

-- 현재 날짜 포맷이 어떻게 되는가?
-- 딕셔너리를 확인
Select Value From 
    nls_session_parameters
Where parameter = 'NLS_DATE_FORMAT';

-- 현재 날짜 : SYSDATE
Select sysdate 
From dual;  -- 가상 테이블 dual로부터 받아오므로 1개의 레코드

Select sysdate 
From employees; -- employees 테이블로부터 받아오므로 employees 테이블 레코드
                -- 개수만큼 출력됨
                
-- 날짜 관련 단일 행 함수
Select 
    sysdate,                             -- 현재 날짜
    Add_Months(sysdate, 2),              -- 현재 날짜로부터 2개월이 지난 후
    Last_Day(sysdate),                   -- 현재 달의 마지막 날짜
    Months_Between('12/09/24',sysdate),  -- 12년 9월 24일부터 지금까지의 개월 차이
    Next_Day(sysdate, 7),                -- 1:일 ~ 7:토
    Next_Day(sysdate, '화'),             -- NLS_DATE_LANGUAGE의 설정에 따름
    Round(sysdate, 'Month'),             -- Month를 기준으로 반올림
    Trunc(sysdate, 'Month')              -- Month를 기준으로 버림
From dual;

Select 
    first_name, hire_date,
    Round(Months_Between(sysdate, hire_date)) as "근속월수"
From employees;

--------------------------
-- 변환함수
--------------------------

-- TO_NUMBER(s, fmt) : 문자열 -> 숫자
-- TO_DATE(s, fmt) : 문자열 -> 날짜
-- TO_CHAR(s, fmt) : 숫자, 날짜 -> 문자

-- TO_CHAR
Select 
    first_name,
    To_Char(hire_date, 'yyyy-MM-DD')
From employees;

-- 현재 시간을 년-월-일 시:분:초로 표기
Select 
    To_Char(sysdate, 'yyyy-MM-DD HH:MI:SS')
From 
    dual;
    
Select 
    To_Char(3000000, 'L999,999,999.99')
From 
    dual;
    
-- 모든 직원의 이름과 연봉 정보 표시
Select
    first_name, 
    To_Char(salary, '$999,999,999') as "월급",
    To_Char(((salary + salary * nvl(commission_pct, 0)) *12), '$999,999,999.99') 
        as "연봉"
from 
    employees;
    
-- 문자 -> 숫자 : TO_NUMBER
Select 
    '$57,600',
    To_Number('$57,600', '$999,999') / 12 as "월급" 
From dual;

-- 문자열 -> 날짜
Select '2012-09-24 13:48:00',
    To_Date('2012-09-24 13:48:00', 'YYYY-MM-DD HH24:MI:SS') as "RR 포맷으로 변환"
From dual;


