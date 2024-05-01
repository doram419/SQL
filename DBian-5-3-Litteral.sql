-- 5.3.1.1
-- 문자 리터럴
SELECT 
    '1!A' c1,
    '2''B' c2,
    '3"c'
FROM DUAL;
-- 6번째 열은 Alias를 지칭하지 않아 참조할 수 없는 열

-- 인용방식 문자 리터럴 사용 가능
-- [],{},<>,() 사용 가능
SELECT q'[2'b]' AS c1,
       q'{[3c]}' AS c2
FROM DUAL;

-- 리터럴은 전체 행에서 동일한 값을 반환한다.
SELECT 'Department' AS c1,
       department_id 
FROM departments;