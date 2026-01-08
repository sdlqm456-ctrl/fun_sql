
-- P. 429: Anthony Hopkins 학생과 전공1이 동일안 학생의 이름과 전공1을 출력
select name stud_name
      ,dname dept_name
from student s
join department d on s.deptno1 = deptno
where deptno1 = (select deptno1 -- where절에 정확한 테이블 명이 있어야 자료를 찾아옴
                 from student
                 where name = 'Anthony Hopkins');
                 
-- P. 429 연습문제: Meg Ryan교수의 입사일 2000/09/18 보다 나중에 입사한 사람의 입사일, 학과명 출력 
select name prof_name
      ,dname dept_name
from professor p
join department d on prof;
select * from department;

select * from professor;

-- 서브쿼리


-- 여러 정보를 가져오는 서브쿼리
-- p.432: 근무지역이 Pohang Main Office인 모든 사원의 사번, 이름, 부서번호 출력
select empno, name, deptno
from emp2
where deptno in (select dcode from dept2 where area = 'Pohang Main Office'); -- 이 테이블에 해당하는 모든 건수를 가져오기

-- exists 연산자: 존재한다라는 의미 
-- 서브쿼리의 결과가 있으면 결과에 상관없이 메인쿼리의 수행여부 결정
select * from dept 
where exists (select deptno 
              from dept 
              where deptno = :dno); -- 값이 존재할때 실행 :를 넣으면 null값으로 인식해 내용이 나오지 않음
              
-- emp2테이블의 전체 직원중 Section head 직급의 최소연봉자 ↑ 급여를 받는 사람의 이름, 직급, 연봉 출력
-- < all: 모든 조건을 만족할데 최소값을 반환 / > any: 조건 중 하나만 만족하면 최소값 반환 
select name, position,  to_char(pay, '$999,999,999') salary
from emp2
where pay > any (select pay from emp2 where position = 'Section head' ); -- pay: 490000 보다 높은 사람들을 조회

-- 최소값보다 작은 학생의 값 출력
select name,grade, weight
from student
where weight < all (select weight from student where grade = 2 );

select * from emp2;
select * from dept2;

-- 각 부서별 평균연봉을 구하고 평균연봉보다 적게 받는 사람의 부서명, 직원명, 연봉
-- 테이블의 join 조건은 테이블 조건보다 -1개 적게 해야 적용이 됨
select * from emp2;


select name, pay
from emp2
where pay >all (select pay from emp2 where  );
select * from dept2;


