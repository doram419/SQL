-- 날짜 연산
-- Date +/- Number : 특정 일수를 더하거나 뺄 수 있다.
-- Date - Date : 두 날짜의 경과 일수
-- Date + Number /24 : 특정 시간이 지난 후의 날짜 
Select
    sysdate,
    sysdate + 1,
    sysdate - 1,
    sysdate - To_Date('20120924'),
    sysdate + 48 / 24           -- 48시간 후의 날짜, 24로 나눈건 안 나누면 
                                -- 48일 후의 날짜가 나오기 때문
From Dual;