-- NULL
-- 이름, 급여, 커미션 비율를 츨력해보자
Select first_name, salary, commission_pct 
From employees;

-- 이름, 커미션까지 포함한 급여를 출력
Select first_name, salary, commission_pct,
salary + salary * commission_pct
From employees;
-- NULL이 포함된 연산식의 결과는 NULL
// NULL을 처리하기 위한 함수 NVL필요
// NVL(표현식1, 표현식1이 널일경우 그의 대체값);

-- NVL 활용 대체값 계산
Select first_name, salary, commission_pct,
    salary + salary * NVL(commission_pct, 0)
From employees;

-- NULL은 0이나 ""와 다르게 빈 값이다.
-- NULL은 산술 연산 결과, 혹은 통계 결과를 왜곡시킨다.
-- ㄴ> 그래서 NULL에 대한 처리는 철저할 필요 있음