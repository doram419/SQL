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