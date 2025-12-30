SELECT ename
    , sal "인상전 급여"
    , sal + comm "총급여"
    ,  (sal + comm) * 1.1 as "인상된 급여(급여+보너스)"
FROM emp
-- 조건이 있을때 

-- sal의 값이 3000 보다 작을때 
WHERE sal < 3000
AND job = 'SALESMAN'; -- 조건절 (where) 작성
ORDER BY ename desc;
-- sal의 값이 2000 보다 작을때
SELECT
    * FROM emp
    WHERE sal > 2000
    OR job = 'SALESMAN'; -- A조건 이거나 B 조건 중에 선택에서 가져오기
    
-- 2000 ~ 3000사이의 값을 가져오라는 명령어  
-- where sal between 2000 and 3000 order by sal

SELECT * 
From emp
-- 81년 ~ 82년 사이 입사한 사람을 찾아 오기 (hiredate: 입사일)
WHERE hiredate between '81/01/01' AND '82/12/31'
order by hiredate;
-- WHERE sal <= 3000
-- and sal >= 2000

-- in (a, b, c) 연산자
-- deptno: 부서번호 
SELECT
    * FROM emp
    WHERE deptno in (10, 20) -- deptno >= 10 and deptno <= 20 : 10번보다 크고 20번보다 크거나 작은 값을 가지고 온다
    and ename not in ('SMITH', 'FORD'); -- not in: 'SMITH', 'FORD'를 제외한 모두를 가지고 옴 
    
-- is null/ is not null (null: 값이 없는)
select * 
from emp
WHERE comm is not null; -- (null)을 제외한 값이 있는 걸 가지고 오는 것

-- like (= )
SELECT
    * FROM emp
    where ename like '%_LA%'; -- % =>%LA%: 글자수 제한x, 어떤 글자가 와도 상관없음, LA를 포함한 모든 걸 가자고 옴 
                              -- clark, cla % (없거나 한글자 이상)/ _ => 한글자 이상에 대응   
SELECT * 
FROM professor -- primary key (중복x)
where deptno in (101, 103)
AND position not in ('a full professor')
;

-- 보너스의 값이 300 보다 크거나 같고 보너스와 pay를 더한 값이 300보다 크거나 같은 경우 
SELECT
    * FROM professor 
    where pay + nvl(bonus, 0) >= 300; -- bonus의 값을 nvl로 지정, 0으로 간주하고 300이상의 값을 가지고 오겠다
    -- where (bonus is null and pay >= 300)
    -- or (pay + bonus >= 300);
-- where bonus is not null;
-- where name like '%an%';


SELECT
    * FROM department;
   

    



