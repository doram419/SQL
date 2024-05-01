--------------------------------------------------------------
-- DCL and DDL
--------------------------------------------------------------
-- 사용자 생성
-- CREATE USER 권한이 있어야 한다.
-- system 계정으로 수행
connect system/manager

-- himedia라는 이름의 계정을 만들고 비밀번호 himedia로 설정
-- CREATE USER himedia IDENTIFIED BY himedia;
-- ㄴOracle 18버전부터 Container Database 개념이 도입되어서 실행이 안됨
-- 방법 1. 사용자 계정 C##
CREATE USER C##himedia IDENTIFIED BY himedia;

-- 비밀번호 변경 : ALTER USER
ALTER USER C##himedia IDENTIFIED BY new_password;

-- 계정 삭제 : DROP USER
DROP USER C##himedia CASCADE; -- CASCADE : 폭포수 or 연결된 것을 의미함

-- 연습이니까 하는 것, 원래는 X
-- 계정 생성 방법 2. CD 기능 무력화
-- 연습상태, 방법 2를 사용자 생성 (추천하지 않음)
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER himedia IDENTIFIED BY himedia;

-- GRANT 시스템권한목록 TO 사용자|역할|PUBLIC [WITH ADMIN OPTION] -> 시스템 권한 부여
-- REVOKE 회수할권한 FROM 사용자|역할|PUBLIC

-- GRANT 객체개별권한|ALL ON 객체명 TO 사용자|역할|PUBLIC [WITH ADMIN OPTION]
-- REVOKE 회수할권한 ON 객체명 FROM 사용자|역할|PUBLIC

-- 아직 접속 불가능하다
-- 데이터베이스 접속, 테이블 생성 데이터베이스 객체 작업을 수행 -> COMMIT, RESOURCE ROLE
GRANT CONNECT, RESOURCE TO himedia;
-- cmd : sqlplus himedia/himedia
CREATE TABLE test(a NUMBER);
-- DESC test;   -- 테이블 test의 구조 보기

-- himedia 사용자로 진행
-- 데이터 추가
DESCRIBE test;
INSERT INTO test VALUES (2024); 
-- USERS (테이블 스페이스에 대한 권한이 없다)
-- 18이상
-- system 계정으로 수행
ALTER USER himedia DEFAULT TABLESPACE USERS 
    QUOTA UNLIMITED on USERS;
-- himedia 복귀
INSERT INTO test VALUES (2024); 
SELECT * FROM test;

SELECT * FROM USER_USERS; -- 현재 로그인한 사용자 정보(나)
SELECT * FROM ALL_USERS; -- 모든 사용자 정보
-- DBA 전용 (sysdba로 로그인 해야 확인 가능)
-- cmd : sqlpuls sys/oracle as sysdba ->sysdba로 접속
SELECT * FROM DBA_USERS;

-- 시나리오 : HR 스키마의 employees table 조회 권한을 himedia에서 부여하려고 한다
-- HR 스키마의 owner -> HR
-- HR로 접속
GRANT SELECT ON employees TO himedia;

-- himedia 권한
SELECT * FROM hr.employees; -- hr.employees에 select 할 수 있는 권한
-- 권한을 부여받은거지 himedia 안에는 employees table이 없음
SELECT * FROM hr.departments;   -- departments는 권한을 받지 않음. 그래서 접근 불가

--------------------------------------------------------------
-- DDL
--------------------------------------------------------------

-- 스키마 내의 모든 테이블을 확인
SELECT * FROM tabs;     -- tabs : 테이블 정보 DICTIONARY

-- 테이블 생성 : CREATE TABLE
CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
);

DESC book;

-- Subquery를 이용한 테이블 생성
SELECT * FROM hr.employees;

-- HR.employees 테이블에서 job_id가 IT 관련된 직원의 목록으로 새 테이블 생성
SELECT *
FROM HR.employees
WHERE job_id Like 'IT_%';

CREATE TABLE emp_it AS (
    SELECT *
    FROM HR.employees
    WHERE job_id LIKE 'IT_%'
);
-- NOT NULL 제약 조건만 돌려받음

SELECT * FROM tabs;

-- 테이블 삭제
DROP TABLE emp_it;

SELECT * FROM tabs;

DESC book;




































































































































































































































































































































;