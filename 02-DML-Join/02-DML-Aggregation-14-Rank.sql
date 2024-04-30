-- RANK 관련 함수 (Oracle 특화 함수)
Select salary, first_name,
    Rank() Over(Order By salary Desc) as rank, -- 일반적인 순위
    Dense_Rank() Over(Order By salary Desc) as dense_link,
    Row_Number() Over(Order By salary Desc) as row_number, -- 정렬 했을 때 실제 행 번호
    rownum  -- 쿼리 결과의 행번호 (가상 컬럼)
From employees;