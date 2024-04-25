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