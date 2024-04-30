-- Top-K Query
-- 질의의 결과로 부여된 가상 컬럼 rownum값을 사용해서 쿼리 순서 반환
-- rownum 값을 활용, 상위 K개의 값을 얻어오는 쿼리

-- 2017년 입사자 중에서 연봉 순위 5위까지 출력

-- 1. 2017년 입사자가 누구?
Select * From employees
Where hire_date Like '17%'
Order By salary Desc;

-- 2. 1번 쿼리를 활용, rownum 값까지 확인, rownum <= 5이하인 레코드 -> 상위 5개의 레코드
Select rownum,
    first_name,
    salary
From (Select * From employees
      Where hire_date Like '17%'
      Order By salary Desc)
Where 
    rownum <= 5;