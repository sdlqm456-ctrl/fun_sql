-- 1. 사원 테이블에서 급여가 7000이상 12,000 이하이며, 이름이 H로 시작하는 사원의 사원번호, 이름 (last_name) 급여, 부서번호를 출력
select employee_id
       ,last_name
       ,department_id
FROM employees 
where salary BETWEEN 7000 and 12000
and last_name like 'H%';

-- 2. 50번과 60번 부서 직원 가운데 급여가 5000보다 많은 사원의 사원번호, 이름 업부 급여, 부서번호를 출력
select employee_id
       ,last_name
       ,job_id
       ,salary
       ,DEPARTMENT_ID
from employees
where DEPARTMENT_ID in (50,60)
and salary > 5000;

-- 3. 사원번호를 입력하면 사원이름, 급여, 인상된 급여가 출력되도록 표시 
-- 조건: 급여가 5000이하면 20% 인상된 급여, 급여가 10000이하면 15% 인상된 급여, 
--      급여가 15000이하면 10% 인상된 급여, 급여가 15001이상이면 급여만 출력

SELECT last_name 
       ,salary 
FROM employees
where employee_id = 사원번호 입력;

UPDATE employees
SET salary =
    CASE
        WHEN salary <= 5000 THEN salary * 1.20  -- 급여가 5000 이하면 20% 인상
        WHEN salary <= 10000 THEN salary * 1.15 -- 급여가 10000 이하면 15% 인상
        when salary <= 15000 then salary * 1.0 -- 급여가 15000이하면 10% 인상된 급여
        ELSE salary                         -- 급여가 15001이상
    END;
       
-- 4. departments 테이블과 loclation 테이블에 대하여 join을 수행하여 부서번호, 부서이름, 도시명을 출력
select * from DEPARTMENTS;
select * from locations;

SELECT d.department_id 
       ,d.department_name
       ,l.city
FROM DEPARTMENTs d
JOIN LOCATIONS L ON d.LOCATION_ID = l.LOCATION_ID;

-- 5. 서브쿼리를 사용하여 IT 부서에서 근무하는 사원들의 사원번호 이름, 업무를 표시
select employee_id
       ,last_name
where departure_id in (SELECT department_id
    FROM departments
    WHERE department_name = 'IT'); 

-- 

-- 8. 요구사항 대로 prof 테이블 생성 하고 생성 명령어 적기
select * from prof;

create table prof(
    prof_no NUMBER(4) PRIMARY KEY
    ,name varchar2(15) not null
    ,id varchar2(15) not null
    ,hiredate DATE 
    ,pay number(4) 
);
-- 9. DML을 발생하고 해당 명령문을 기록 
INSERT INTO prof (prof_no, name, id, hiredate, pay)
VALUE(1001, 'mark', 'm1001', '07/03/01', 800);

INSERT INTO prof (prof_no, name, id, hiredate, pay)
VALUE(1003, 'Adam', 'a1003', '11/03/02');

update prof 
set pay = 1200;

delete from prof 
where prof_id = 1003;
-- 10. prof 테이블에 대하여 지시사항 실행

--1) 프라이머리키 추가
ALTER TABLE prof ADD PRIMARY KEY (prof_no);

--2) 성별추가
ALTER TABLE prof ADD COLUMN gender char(3);

-- 3) name열의 길이변경
alter table prof modify name varchar2(20);




