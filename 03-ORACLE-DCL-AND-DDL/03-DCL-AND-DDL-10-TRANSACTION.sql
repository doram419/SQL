--------------------------------
-- TRANSACTION
--------------------------------

-- 트랜잭션 테스트 테이블
CREATE TABLE t_test(
    log_text VARCHAR2(100)
);

-- 첫 번째 DML이 수행된 시점에서 TRANSACTION
INSERT INTO t_test VALUES('트랜잭션 시작');
SELECT * FROM t_test;
INSERT INTO t_test VALUES('데이터 INSERT');
SELECT * FROM t_test;

SAVEPOINT sp1;

INSERT INTO t_test VALUES('데이터 2 INSERT');
SELECT * FROM t_test;

SAVEPOINT sp2;  -- 세이브 포인트 설정

UPDATE t_test SET log_text = '업데이트';

SELECT * FROM t_test;  -- WHERE을 안 썼기에 모든 레코드가 '업데이트' 되어버림

ROLLBACK TO sp2;   -- sp2로 귀환

SELECT * FROM t_test;

ROLLBACK TO sp1;   -- sp2로 귀환

SELECT * FROM t_test;

INSERT INTO t_test VALUES('데이터 3 INSERT');

SELECT * FROM t_test;

-- 반영 : COMMIT or 취소 : ROLLBACK
-- 명시적인 TRANSACTION 종료

COMMIT;
SELECT * FROM t_test;