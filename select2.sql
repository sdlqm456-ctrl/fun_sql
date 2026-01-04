select ename 
    ,sal "인상전 급여"
    ,sal "총급여"
    ,(sal + comm) *1.1 as "인상된 급여 (급여 + 보너스)"
FROM emp;

-- 조건이 있는 명령어 a조건 또는 b조건 중 하나 선택

-- sal의 값이 3000보다 작을때
SELECT * from emp
WHERE sal < 3000
AND job = 'SALESMAN' -- 조건절 (where) 작성
ORDER BY ename desc;
-- sal의 값이 2000보다 작을때 
select * from emp
where sal > 2000
or job = 'salesman'; 
-- 2000~3000 사이값 가져오기 :where sal between 2000 and 3000 order by sal 
select * from emp
where deptno in (10, 20) -- 10이상 20보다 크거나 작은 값 가져오기
and ename not in ('smith', 'ford'); -- smith, ford를 제외한 값 가져오기

-- (null: 값이 x) is null / is not null 
select * from emp
where comm is not null; -- null 제외한 모든 값

-- like 
select * from emp
where ename like '%_LA';  
-- %LA%: 글자수 제한 x, 글자 상관없음 (LA 포함 모든걸 가지고 오기)
-- clark, cla %: 한글자 이상에 대응 

-- bouns >= / bouns + pay >= 300
select * from professor
where pay + nvl(bonus, 0) >= 300;
-- where (bonus >= 300);
-- where bonus ins not null;
-- where name like '%an%';

select * from department;
