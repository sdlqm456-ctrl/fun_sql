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