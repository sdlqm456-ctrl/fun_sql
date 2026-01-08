select * from tab;

create table employees2
as
select * from employees;

-- 직원목록
select e.employee_id "사원번호"
      ,e.first_name || '-' || e.last_name "사원이름"
      ,e.department_id
      ,d.department_name 
from employees2 e
join departments d
on e.department_id = d.department_id
where job_id = 'IT_PROG';

-- 직무코드
select * from jobs;