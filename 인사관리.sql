select /* + index_desc (e EMP_EMP_ID_PK) */ e.rowid, e.*
from employees e;

-- employee_ID 컬럼의 인덱스테이블에 저장

-- 데이터 정렬 후 조회
select e.rowid, e.*
from employees e
order by e.employee_id;

create index emp_hiredate_ix
on employees(hire_date);

-- 뷰(view): 복잡한 데이터를 만들어 한눈에 볼수 있게 가져오는 명령어
select *from employees;

-- view 테이블 생성하기 => employee를 통해서 
-- department_name 담당직무명
create or REPLACE view employee_v
as
select employee_id, first_name, last_name
      ,email, hire_date,job_title, d.department_name
from employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id;

select * from departments;

-- employee 테이블에 'programmer' 라는 내용이 없어서 오류발생  
SELECT
    * FROM employee_v
     where job_title = 'programmer'
     and salary > 1000;
     
-- inline view  
select e.department_id, department_name, max_sal -- department를 가져올때 연결하는 테이블의 앞글자.를 적어야 정보를 어디서 가져오는지 인식가능 
from (select department_id, max(salary) max_sal -- 메인커리: 부서별 최고임금을 받는 사람 찾기
      from employees 
      group by department_id) e -- 서브커리
join departments d on e.department_id = d.department_id;

