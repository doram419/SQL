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
