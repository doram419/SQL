-- 별칭 Alias
-- : Projection 단계에서 출력용으로 표시되는 임시 컬럼 제목
-- < Alias 사용법 >
-- > 컬럼명 뒤에 별칭
-- > 컬럼명 뒤에 as 별칭
-- !! 표시명에 특수문자가 포함된 경우 " " 로 묶어서 표현하기

-- 예제1 : 직원 아이디, 이름, 급여를 출력하자
--        직원 아이디는 empNO, 이름은 f-name, 급여는 월 급으로 표시하라.
Select employee_id empNo,
    first_name "f-name",
    salary as "월 급"
From employees;

-- 예제2 : first_name과 last_name을 합쳐서 Full Name이라고 출력하고
--        commission_pct가 포함된 salary를 급여라고 출력하며,
--        급여 * 12를 하여 연봉으로 출력해라
Select first_name || ' ' || last_name as "Full Name",
-- 오라클에서는 자바처럼 + 연산을 문자에서 사용할 수 없다!
       salary + salary * NVL(commission_pct, 0) as "급여(커미션 포함)",
       salary * 12 as "연봉"
       From employees;
       
-- [연습 예제] hr.employees 전체 튜플에 다음과 같이 Column Alias를 붙여 출력해 봅니다
--  이름 : first_name last_name
--  입사일: hire_date
--  전화번호 : phone_number
--  급여 : salary
--  연봉 : salary * 12
Select first_name || ' ' || last_name as "이름",
       hire_date as "입사일",
       phone_number as "전화번호",
       salary as "급여",
       salary * 12 as "연봉"
       From employees;