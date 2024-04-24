-- NULL 체크 =, <> 사용하면 안 됨
-- IS NULL, IS NOT NULL

-- commission을 받지 않는 사람들 (-> commision_pct가 NULL인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct IS NULL;
-- NULL 체크

-- commission을 받는 사람들 (-> commission_pct가 Not Null인 레코드)
Select 
    first_name, commission_pct
From
    employees
Where
    commission_pct Is Not Null;