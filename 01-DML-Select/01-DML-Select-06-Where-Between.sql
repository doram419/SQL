-- BETWEEN : 범위 비교
Select
    first_name || ' '|| last_name as "이름",
    salary as "급여"
From 
    employees
Where
    salary Between 14000 and 17000;