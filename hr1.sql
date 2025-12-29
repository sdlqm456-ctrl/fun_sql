-- scott계정에 있는 테이블은 접근을 할 수가 없고 해당 하는 목록에 있는 테이블만 접근 가능
-- 관계형 데이터 베이스: 사원이름, 부서명, 월급 등을 불러와서 사원들을 관리하는 형태를 말함
SELECT
    * FROM tab;

-- employees: 사원번호  
SELECT
    * FROM employees
    -- where job_id = 'IT_PROG'
    where employee_id = 103; 

-- 직업
SELECT
    * FROM jobs;

-- 부서정보
select * 
from departments;
    

    
