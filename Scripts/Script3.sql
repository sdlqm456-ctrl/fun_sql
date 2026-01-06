SELECT * FROM tab;

SELECT empno 
	  ,ename
	  ,sal
	  ,nvl (comm, 0) AS commission 
FROM emp;

SELECT initcap(POSITION) AS "initcap" -- 앞글자만 대문자로 표현/ upper: 모두 대문자로 변경
	  , lower (upper(position)) AS "uppercase" -- lower():소문자로 모두 변경
	  , length(position) langth_position -- 문자의 크기를 반환
	  , lengthb('홍길동')lengthb -- byte의 크기를 반환
	  ,POSITION
	  , name
FROM professor
WHERE LENGTH(name) < 10; -- name이 10글자 이하인 사람을 찾을 때  

SELECT ename || ',' || job AS "name and job" -- job 사이에 ,를 주고 싶을 때
	  ,concat(concat(ename, ','), job) AS "Name job" -- concat 두 단어를 연결해서 사용 
	  ,substr(e.job, 1, 3) AS "short job" 
	  , e.* -- 모든 컬럼을 보고 싶을때 (해당 컬럼.*)  
FROM emp e -- 컬럼이 너무 길때: ;앞에 첫 글자만 써서 사용
WHERE substr(e.ename, 1, 1) = 'J'; 

-- abcde 구문에서 원하는 단어만큼 가지고 옴 ('abcde' 시작위치, 크기)
SELECT substr ('abcbe', 3, 3)
	  ,substr ('hello, world',-3, 3) -- sudstr('단어', -숫자,숫자): 뒤에서 부터 가져옴
FROM dual;

-- 책 p.78 사용예시 전공 1의 값이 201인 사람, 연락처(tel 컬럼')'
SELECT name 
--	  ,instr(tel, ')', 1) "location of"
-- 지역 번호가 3자리 인경우 substr 안에 instr를 사용, 괄호를 빼고 가져올려면 -1를 붙혀서 사용
	  , tel 
-- 학생의 전화번호 중 가운데 번호만 가지고 오고 싶을때
	  ,substr(tel, 1, instr(tel, ')', 1) -1) AS "area code" -- 지역번호
	 
	  ,instr(tel, ')', 1) + 1 AS "from" -- from: 전화번호 시작하는 부분 
	  ,instr(tel, '-', 1) AS "to" -- to: 전화번호의 끝
-- from에서 to를 빼면 tel의 가운데 번호만 나오게 됨
	  ,substr(tel, instr (tel,')', 1) +1,
	  			   (instr(tel, '-', 1) - (instr(tel, ')', 1) +1))) AS "국번" 
FROM student
WHERE deptno1 = 201
AND substr (tel, 1, instr(tel, ')', 1) - 1) = '02';

-- lpad (컬럼, 자리수, 채울값): 왼쪽부터 채우기 / rpad: 오른쪽 부터 채우기

-- 빈곳이 생길 시 왼쪽부터 -로 체우기
SELECT lpad ('abc', 5, '-')
FROM dual;

-- 사용예시 p.80: 전공번호가 201인 학과 학생들의 id는 10자, 왼쪽 빈자리는 *로 출력 
SELECT studno
	  ,name
	  ,id
	  ,lpad(id, 10, '*') "lpad with *"
FROM student
WHERE deptno1 = 201;

-- 사용예시 p.81: deptno가 101인 사원이름을 9바이트로 출력
SELECT lpad(ename, 9, '123456789') 
	  ,rpad(ename, 9, '-')
	  ,RPAD(ename, 9, substr('12345678', LENGTH(ename) +1))
FROM emp
WHERE deptno = 10;

-- 문자 공백제거: ltrim (왼쪽부터 자름), rtrim(오른쪽부터 자름)
SELECT ltrim('abcde', 'abc')
	  ,rtrim('abcde', 'cde')
-- 좌우 공백제거
	  ,rtrim(ltrim(' hello ', ' '), ' ')
-- ' '안의 단어에서 공백을 찾고 공백 사이에 * 채우기
	  ,REPLACE(' hello ', ' ' , '*')
FROM dual;

-- 이름의 공백을 * 와 - 로 표현
SELECT replace(e.ename, substr(e.ename, 1, 2), '**') "rep"
	  ,REPLACE(e.ename, substr(e.ename, 2, 2), '--') "rep2"
	  ,e.job
	  ,e.*
FROM emp e
WHERE deptno = 10;

-- 연습문제 p.84: 20번 부서에 소속된 직원이름 2~3번째 글자를 -로 표현
SELECT replace(e.ename, substr (e.ename,2,2), '--') "ename"
	  ,ename
FROM emp e
WHERE deptno = 20;

-- 연습문제 p.84: 전공번호 101인 학생들의 이름, 주민번호 출력 (주민번호 뒷자리는 -,/로 표현)
SELECT name
	   ,jumin
	  ,rpad(substr(jumin, 1,6), LENGTH(jumin), '-/')
FROM student
WHERE deptno1 = 101;

-- 연습문제 p.85: 전공번호 102인 학생이름, 전화번호 (국번부분은 * 처리)
SELECT name
      ,tel
	  ,REPLACE(tel -- 대상컬럼
	  	      ,substr(tel -- 대상컬럼
	                 ,instr(tel, ')', 1) + 1 -- 시작위치
	  				 ,instr(tel, '-', 1) - instr(tel, ')', 1) -1) -- 크기
	  		  ,substr('****'
	  		  , 1
	  		  , instr(tel, '-', 1) - instr(tel, ')', 1) -1)) replacea
FROM student 
WHERE deptno1 = 201;

-- 숫자함수
-- 소수점 뒷자리부터 반올림
SELECT round (12.345, 1) -- 첫째자리 반올림
	  ,round (12.345, 2) -- 둘째자리 반올림
	  ,round (12.345, 3) -- 셋째자리 반올림
	  ,round (12.345, -1)
	  ,trunc(12.345, 2) -- 소수점 뒷자리 삭제
	  ,mod(12, 5) -- 괄호 안의 수 나눈 나머지 값
	  ,ceil(12/5)
	  ,floor(12/5)
	  ,power(3,3) -- 곱하기
FROM dual;

-- 날짜 
-- hiredate + 1: 다음날 / sysdate: 현재날짜 => 시,분,초 보여줌 
--,months_between(sysdate, hiredate) "monthbetween" -- 두 시간 사이의 몇달 차/ 현재시간 ~ 기준인 날로부터 흐른시간
--,ADD_MONTHS(sysdate, 1) -- 한달뒤의 값을 가져옴/ 월정보추가 
--,next_day(sysdate -7, '수') -- 현재날짜기준 다음 요일의 정보를 가져옴/ -7을 넣으면 전주로 넘어가서 계산
--,last_day(add_months (sysdate, -1)) -- 달의 마지막날/ -1은 저번달
SELECT ename
	  ,hiredate
	  ,sysdate 
-- 오늘 날짜 기준 밤 12시 이후의 시간 (주어진 날짜 반올림)
	  ,round(sysdate - (3/24)) 
-- 주어진 날짜를 버림 (주어진 날의 1일)
	  ,trunc(sysdate, 'mm')
FROM emp;

-- 근무년도 구하기
SELECT * FROM professor
WHERE hiredate < sysdate;

UPDATE professor 
SET hiredate = add_months(hiredate, 15 * 12)
WHERE 1 = 1;

-- 교수번호 (profno), 이름 (name), 급여 (pay), 보너스(bonus)
-- 근무년수가 20년이 넘는 교수 + 근무근수
-- 근무년수가 10년 이상 20년 미만의 교수 => 15년 3개월
SELECT profno
      , name
	  , pay
	  , bonus
	  ,trunc(months_between(sysdate, hiredate) /12) -- 년도
	  ,MOD(trunc(months_between(sysdate,hiredate)), 12) -- 개월수
FROM professor
WHERE months_between(sysdate, hiredate) >= 10 * 12 -- 근무수가 10년이상
and months_between(sysdate, hiredate) < 20 * 12 -- 근무수가 20년미만
order BY hiredate;

-- 숫자 -> 문자변환
select sysdate -- date 값
-- 값 YYYY:년도, MM:월, DD:일, HH:시간/HH24:24시간제, MI:분, SS:초
	   ,to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') -- varchar2의 값
	   ,TO_char(123456789.12, '00999,999,999.99') -- varchar2의 값/ 숫자를 ,로 끊어서 표현, 남는 자리는 0으로 표현
	   ,to_date('2024-05-06 10:10:10', 'YYYY-MM-DD HH:MI:SS' ) -- date값  
FROM dual
WHERE to_date ('2025-12-31', 'YYYY-MM_DD' )< sysdate + 1;

-- 일반함수

-- nvl(): null을 만나면 다른값으로 치완해서 표현(조건문)
SELECT nvl(NULL, '0')
FROM dual;

SELECT ename 
	  ,sal + nvl(comm, 0) AS "총급여"
	  ,sal + nvl2(comm, comm, 0) AS "전체급여"
	  ,sal + nvl2(comm, sal + comm, sal) AS "토탈급여"
	  ,sal + comm AS "급여"
FROM emp;

-- decode() 함수: ()안에 문자가 같은지 다른지 판별
-- 'null': 문자 그대로 표현
SELECT decode(null, 'null', '같다', '다르다')
FROM dual;

select deptno1
	  ,decode(deptno1, 101, 'Compter Eng.',
					   102, 'Multimedia Eng.',
					   103, 'Coftware Eng.','ETC') AS "decode1"
	  ,decode(deptno1, 101, 'Computer Eng.',
	  decode (deptno1, 102, 'Mulit Eng.',
	  decode (deptno1, 103, 'Software Eng.', 'ETC'))) AS "decode2"
FROM student;

SELECT * FROM tab;
-- 연습문제 p.120: 전공번호 101의 학생들의 이름 + 주민번호 성별 판별 (뒷자리 1 = 남자, 2 = 여자)
SELECT name
	  ,jumin
	  ,decode(substr(jumin, 7, 1), 1,'man', 2, 'woman') "gender"
-- case when then end 구문으로 변경
	  ,CASE substr(jumin, 7, 1) WHEN '1' THEN 'man'
	  	        				WHEN '2' THEN 'woman'
	   END "gender2"
FROM student
WHERE deptno1 = 101;

-- 연습문제 p.120: 전공번호 101의 학생이름 + 연락처 + 지역 출력하기
SELECT name 
	  ,decode (substr(tel, 1, instr(tel, ')', 1) -1)
	  ,'02', 'seoul' 
	  ,'031', 'gyeonggl'
	  ,'051', 'busan'
	  ,'052', 'ulsan'
	  ,'055', 'gyeongnam'
	  ,'etc') loc
-- case (컬럼) when (조건) then (출력) 구문 end (컬럼명): case 구문은 ,를 쓰지 않음
	  ,CASE substr(tel, 1, instr(tel, ')', 1) -1) WHEN '02' THEN 'seoul'
	  											  WHEN '031' THEN 'gyeonggl'
	  											  WHEN '051' THEN 'busan'
	  											  WHEN '052' THEN 'ulsan'
	  											  WHEN '055' THEN 'gyeongnam'
	  											  else 'etc'
	  END loc2  											  
FROM student
WHERE deptno1 = 101;

-- case 구문활용: 조건의 범위를 지정
-- 1월 ~ 3월 (1/4), 4월 ~ 6월 (2/4) ....10월 ~ 12월 (4/4)
select name 
	  ,substr(jumin, 3,2) "Month"
	  ,CASE when substr(jumin, 3,2) BETWEEN '01' AND '03' THEN '1/4'
	  		when substr(jumin, 3,2) BETWEEN '04' AND '06' THEN '2/4'
	  		when substr(jumin, 3,2) BETWEEN '07' AND '09' THEN '3/4'
	  		when substr(jumin, 3,2) BETWEEN '10' AND '12' THEN '4/4'
	  END "Quater"
FROM student;

-- 연습문제 p.123: 사원의 급여를 등급별 level로 표시
-- order by 칼럼명 desc: 내림차순 정렬 / desc 없이 쓰는경우는 오름차순 정렬
SELECT empno 
	  ,ename
	  ,sal
	  ,CASE WHEN sal BETWEEN '1' AND '1000' THEN 'level 1'
	  	    WHEN sal BETWEEN '1001' AND '2000' THEN 'level 2'
	  	    WHEN sal BETWEEN '2001' AND '3000' THEN 'level 3'
	  	    WHEN sal BETWEEN '3001' AND '4000' THEN 'level 4'
	  	    ELSE 'level 5'
	  	END "level"
FROM emp
ORDER BY sal desc;

-- 복수행 함수(group함수): 데이터를 그룹으로 묶음, 그룹외의 값을 적으면 x 
-- count(): 입력데이터의 총 건수 반환 /count(*): null값 포함 전체/ count(comm): null값 제외
-- sum(): 입력데이터의 합계 
SELECT deptno, ename, count(*) "인원", SUM(sal) "부서별 급여" 
FROM emp
GROUP BY deptno, ename; -- 부서번호별 그룹

-- group by 함수: 특정조건으로 세부적인 그룹을 만드는 함수
-- round: 소수점 아래부터 반올림
-- count(1): 모든 행 
SELECT deptno, job
	  ,count(1) "건수" -- 1을 기준으로 count
	  ,sum(sal + nvl(comm, 0)) "직무별 급여합계"
	  ,round(sum(sal + nvl(comm, 0)) / count(1)) "직무별 평균급여"
	  ,round(avg(sal + nvl(comm, 0))) "직무별 평균급여1"
	  ,min(sal + nvl(comm, 0)) "최저급여"
	  ,max(sal + nvl(comm, 0)) "최고급여"
	  -- ,stddev(sal) "표준편차"
	  -- ,variance(sal) "분산"
FROM emp
GROUP BY deptno, job; -- 부서, 직무

-- 직무별 그룹
SELECT job
	  ,sum(sal)
	  ,round(avg(sal)) "직무별 평균급여"
FROM emp
-- where sal > 1500 where절 조건문 
GROUP BY job 
-- having: 그룹별 집계된 결과중 원하는 조건의 결과만 알고싶을때 사용
HAVING round(avg(sal)) > 1500;

SELECT ename, job, hiredate
FROM emp
ORDER BY 3 desc; -- 출력되는 컬럼 중 1번

-- 부서,직무,정보조회(평균급여, 사원수 등)
-- 1. 부서별 직무별 평균급여, 사원수
SELECT deptno || '', job, avg(sal), count(1)
FROM emp
GROUP BY deptno, job
-- 2. 부서별 평균급여, 사원수
UNION all
SELECT deptno || '', '소계', round(avg(sal)), count(1)
FROM emp
GROUP BY deptno
-- 3. 전체평균급여, 사원수
UNION ALL
SELECT '전체', '',round(avg(sal)), count(1)
FROM emp
ORDER BY 1,2;

-- rollup 함수: 그룹간의 합계 계산
SELECT nvl(deptno || '','전체') dept
	  ,decode(deptno, NULL, ' ', nvl(job, '소계')) job
	  ,round(avg(sal)) avg_sal
	  ,count(1) cnt_emp
FROM emp
GROUP BY ROLLUP (deptno,job)
ORDER BY nvl(deptno,1), 1, 2;


-- emp, dept 테이블 => join: 중복값이 있는 테이블을 서로 연결 시켜주는 명령어
-- 앞에 명령어가 길때: 해당명령어 앞글자.가져오고 싶은 내용
SELECT ename, ename, dname, loc, e.deptno
FROM emp e -- driving 테이블
JOIN dept d ON e.deptno = d.deptno -- join 기준
WHERE dname = 'ACCOUNTING'; -- ANSI 조인

SELECT ename, ename, e.deptno,ename,loc, e.deptno
FROM emp e -- driving 테이블
     ,dept d 
WHERE e.deptno = d.deptno
AND dname = 'ACCOUNTING'; -- ORACLE 조인

SELECT * FROM dept;

-- 학생, 교수, 학과 join결과
-- equl join(등가 join): 앞에서 데이터를 가져오고 확인후 뒤의 동일한 조건의 데이터를 가져오는 방법 
-- p.234 연습문제: 학생학번, 이름, 학과명, 담당교수이름
SELECT s.studno "학번"
	  ,s.name " 학생이름"
	  ,p.name " 교수이름"
	  ,d.dname "학과명"
FROM student s
JOIN professor p ON s.profno = p.profno  -- 학생과 교수 테이블의 join조건
JOIN department d ON s.deptno1 = d.deptno -- 학생과 학과 테이블 join조건
;  

SELECT * FROM professor;

SELECT * FROM department;

-- 고객테이블 () => 비등가조인 (non-equi join) 
-- 연습문제 p. 237: 고객 마일리지 포인트 조회 후 고객명 + 받을수 있는 상품목록 조회
SELECT * 
FROM customer c
JOIN gift g ON c.point >= g.g_start AND c.point <= g.g_end
-- JOIN gift g ON c.point between g.g_start AND g.g_end
;

SELECT * FROM gift; 

-- 학생, 학점
SELECT s.studno "학번"
	  ,s.name "학생이름"
	  ,c. total "점수"
FROM student s
JOIN score c ON s.studno = c.studno;


SELECT * 
FROM hakjum;

-- 학생점수의 총합 구하기
SELECT s.studno "학번"
	  ,s.name "학생이름"
	  ,c.total "점수"
FROM hakjum s 
JOIN score c ON s.studno = c.studno 
JOIN hakjum h ON c.total >= h.min_point AND c.total <= h.max_point;

SELECT * FROM score;

SELECT * FROM student;
-- p. 254 문제 1: 학생이름, 1전공학과 번호 + 이름 출력
SELECT s.name "학생이름"
	  ,d.deptno "학과번호"
	  ,d.dname "학과명"
FROM student s 
JOIN department d ON s.deptno1 = d.deptno;

SELECT * FROM department;


-- p. 254 문제 2: 사원명, 직급, 현재연봉, 해당직급의 하한, 상한 금액을 표현
SELECT NAME 
	  ,e.POSITION
	  ,pay
	  ,s_pay "low pay"
	  ,e_pay " high pay"
FROM emp2 e
JOIN p_grade p ON e.POSITION = p. position;

SELECT * FROM p_grade;

-- p. 255 연습문제 3: 사원의 이름, 나이, 현재직금, 예상직급 출력 
-- months_between: 시스템과 birthday사이 날짜를 반환
SELECT NAME 
	  ,trunc(MONTHS_BETWEEN(sysdate, birthday)/12) "AGE"
	  ,e.POSITION curr_position
	  ,p.POSITION be_position
FROM emp2 e
JOIN p_grade p ON trunc(months_between(sysdate, birthday) /12) BETWEEN p.s_age AND p.e_age;
-- 아우터 조인 (outer join) vs 이너 조인 (inner join)  
-- inner join: 각 테이블에서 동등한 조건이 있을때 원하는 칼럼을 가져옴 => 반드시 컬럼명이 같아야 함 
-- outer join: inner 조인에서 원하는 부분 추가로 가져오는 방법 => left,rigth,full
-- left outer join: 왼쪽 테이블의 데이터를 추가로 가져옴 / rigth : 각 테이블 사이 동일하지 않은 데이터 가져오기
-- full outer join: null 값까지 모두 보여줌

-- p.243 연습문제: 학생 + 교수테이블을 join하여 학생이름 + 교수이름 출력하기 (지도교수가 없는 사람도 출력)

SELECT s.studno "학번"
	  ,s.name "학생이름"
	  ,p.profno "교수번호"
	  ,p.name "교수번호"
from student s
full OUTER JOIN professor p ON s.profno = p.profno;

SELECT * FROM p_grade;

UPDATE EMP2 
SET birthday = add_months(birthday, 5)  -- 1살을 더하고 싶으면 birthday에 -12
WHERE 1 = 1;

--self join: 1개의 테이블을 복사하여 역활이 다른 2개의 테이블을 만들어서 join하는것
SELECT e1.ename "사원번호"
	  ,e2.ename "사원이름"
	  ,e2.empno "관리자번호"
	  ,e2.ename "관리자이름"
FROM emp e1
LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

SELECT * FROM customer;

-- p. 255 연습문제 4: 고객의 포인트 보다 낮은 포인트의 gift 상품 한가지 선택시 노트북을 선택할 수 있는 고객명, 포인트, 상품명 출력 
SELECT c.GNAME 
	  ,c.POINT
	  ,g.GNAME
FROM customer c
LEFT OUTER JOIN  gift ON c.POINT = g.GNAME;

SELECT * FROM gift;

-- p. 256 연습문제 5: 교수의 번호, 이름, 입사일 출력 (입사일이 빠른사람 오름차순 출력)

SELECT profno 
	  ,name
	  ,round(avg(hiredate))  
FROM professor
HAVING round(avg(hiredate)) > hiredate
ORDER BY hiredate desc;

-- p. 257 연습문제 6: 사원번호, 이름, 입사일 (자신보다 먼저 입사한 사람의 인원수) 출력

-- ansl join으로 표현
SELECT  e1.empno
	   ,e1.ename
	   ,e1.hiredate
	-- e2.정보
	-- e2.empno
	-- e2.ename
	-- ,e2.hiredate
	   ,count(e2.empno) count
from emp e1, emp e2
LEFT OUTER JOIN emp e2
ON e1.hiredate > e2.HIREDATE  
GROUP BY e1.EMPNO 
		,e1.ename
		,e1.HIREDATE 
ORDER BY 4;

-- oracle의 outer join 표현 방법
SELECT  e1.empno
	   ,e1.ename
	   ,e1.hiredate
	   ,count(e2.empno) count
from emp e1, emp e2
where e1.HIREDATE > e2.HIREDATE(+) 
GROUP BY e1.EMPNO 
		,e1.ename
		,e1.HIREDATE 
ORDER BY 4; 


