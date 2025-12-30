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

-- lpad (컬럼, 자리수, 채울값)
SELECT lpad ('abc', 5, '-') -- 빈곳이 생기면 왼쪽부터 채운다는 뜻
FROM dual;

SELECT studno
	 ,name
	 ,id
	 ,lpad(id, 10, '*') "lpad with *"
FROM student
WHERE deptno1 = 201;

SELECT lpad (ename, 9, '12345678') lpad 
	   ,rpad (ename, 9, '-') rpad -- 오른쪽부터 빈곳에 - 로 채움
	   , rpad (ename, 9, substr('12345678', LENGTH(ename)+1)) rpad2 -- 책 p.82 퀴즈 문제: 이름의 오른쪽부터 숫자 채우기
FROM emp
WHERE deptno = 10;

-- 문자의 공백제거 
SELECT ltrim ('abcde', 'abc') -- 왼쪽부터 자름
	   ,rtrim ('abcde', 'cde') -- 오른쪽부터 자름
	   ,rtrim(ltrim(' hello ', ' '), ' ') -- 좌우 공백제거
	   ,REPLACE(' hello ', ' ' , '*') -- hello라는 문장에서 공백찾기 / 공백사이에 *로 표시하기
FROM dual; 

-- 첫번째 문자열에서 **,--로 바꿔서 표시하는 방법
SELECT REPLACE(e.ename, substr(e.ename, 1, 2), '**') "rep"
	  , replace(e.ename, substr(e.ename, 2, 2), '--') "rep2"
	  ,e.job
	  ,e.*
FROM emp e  
WHERE deptno = 10;

-- p.84 퀴즈 이름의 2~3글짜를 '-'으로 변경해서 출력
SELECT REPLACE(e.ename, substr (e.ename, 2,2), '--') "ename"
	  ,e.ename
FROM emp e
WHERE deptno = 20;

-- p.84 퀴즈 학생이름, 주민번호, replace = 주민번호를 출력하되 '-','/'로 표시되게 표현
SELECT name 
       ,jumin
       ,replace()
from student;

-- p.84 퀴즈 학생 전공에 국번 부분만 * 처리
SELECT name
      ,tel
	  ,REPLACE(tel -- 대상컬럼
	  	      ,substr(tel -- 대상컬럼
	                 ,instr(tel, ')', 1) + 1 -- 시작위치
	  				 ,instr(tel, '-', 1) - instr(tel, ')', 1) -1) -- 크기
	  		  ,substr('****'
	  		  , 1
	  		  , instr(tel, '-', 1) - instr(tel, ')', 1) -1) ) replacea
FROM student 
WHERE deptno1 = 201;

-- 숫자함수
-- 소수점 뒷 자리의 수를 반올림
SELECT round(12.345, 1) -- 첫째자리를 반올림 (결과값: 12.3) 
	  ,round(12.345, 2) -- 결과값: 12.35
	  ,round(12.345, 3) -- 결과값: 12.345 
	  ,round(12.345, -1) -- 10
	  ,trunc(12.345, 2) -- 소수점 뒷자리를 삭제
	  ,MOD(12, 5) -- ()의 수 나누기 = 나머지값 2 
	  ,ceil(12/5)  -- 3 <2.4 <2 
	  ,floor(12/5) -- 2
	  ,power(3,3) -- ()의 수 곱하기
FROM dual;

-- 날짜
SELECT ename
	  ,hiredate
	  --,hiredate + 1 -- 다음날표현
	  ,sysdate -- 현재날짜를 시,분,초로 보여줌
	  --,months_between(sysdate, hiredate) "monthbetween" -- 두 시간 사이의 몇달 차/ 현재시간 ~ 기준인 날로부터 흐른시간
	  --,ADD_MONTHS(sysdate, 1) -- 한달뒤의 값을 가져옴/ 월정보추가 
	  --,next_day(sysdate -7, '수') -- 현재날짜기준 다음 요일의 정보를 가져옴/ -7을 넣으면 전주로 넘어가서 계산
	  --,last_day(add_months (sysdate, -1)) -- 달의 마지막날/ -1은 저번달
	  ,round(sysdate -(3/24)) -- 오늘날짜 밤 12시 이후 => 12월 31일/ 주어진 날짜를 반올림
	  ,trunc(sysdate, 'mm') -- 주어진 날짜를 버림 (일을 버리고 12월 1일로 표현)
FROM emp;  

-- 근무년도 구하기
select * 
FROM professor
WHERE hiredate < sysdate; -- 2025, 1982

UPDATE professor 
SET    hiredate = add_months(hiredate, 15 * 12)
WHERE 1 = 1;

-- 교수번호(profno), 이름 (name), 급여 (pay), 보너스 (bonus)
-- 근무년수가 20년이 넘는 교수 + 근무근수
-- 근무년수가 10년 이상 20년 미만의 교수의 "15년 3개월"
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

-- 형변환 함수(자동, 수동)
SELECT 2 + '2' -- 자동형변환
	  ,2 + to_number('2') -- 수동형변환
FROM dual; 

-- 숫자 -> 문자 변환
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





