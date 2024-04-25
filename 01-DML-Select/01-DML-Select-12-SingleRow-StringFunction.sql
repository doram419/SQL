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