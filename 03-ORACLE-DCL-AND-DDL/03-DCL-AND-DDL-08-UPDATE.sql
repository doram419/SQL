-- UPDATE
-- 특정 레코드의 컬럼 값을 변경한다
-- WHERE 절이 없으면 모든 레코드가 변경
-- 가급적 WHERE 절로 변경하고자 하는 레코드를 지정하도록 함

UPDATE author
SET author_desc = '알쓸신잡 출연';
-- 3개 행 이(가) 업데이트 되었습니다.
-- WHERE이 없어서 전부 변경됨..!!

ROLLBACK;

UPDATE author
SET author_desc = '알쓸신잡 출연'
WHERE author_name = '김영하';

SELECT * FROM author;

COMMIT;