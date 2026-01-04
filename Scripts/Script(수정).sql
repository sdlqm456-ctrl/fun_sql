-- 기본 구조
-- select * from: 표현식 출력
SELECT * FROM tab;

SELECT empno
	  ,ename 
	  ,sal
	  ,nvl (comm, 0) AS commission
FROM emp;

-- 1. 대소문자 변경구문
-- initcap: 첫글자만 대문자변경 / upper: 모두 대문자변경 / lower: 모두 소문자변경
-- length: 문자크기 반환 / lengthb: byte의 크기 반환
SELECT initcap (position) AS "initcap" 
	  ,lower (upper(position)) AS "uppercase"
	  ,LENGTH('홍길동')lengthb 
	  ,POSITION
	  ,name
FROM professor
-- 2. 이름이 10글자 이하인 사람 찾기
WHERE length(name) < 10;

-- ',': 단어사이, 넣기
SELECT ename || ',' || job AS "name job" 
-- concat: 두 단어 연결 
	  ,concat (concat(ename, ','), job) AS "name job"
-- substr: 원하는 위치 문자열 자르기 => substr(시작위치,길이)
	  ,substr(e.job, 1,3) AS "short job"
-- 해당컬럼.* : 모든 컬럼보기 
	  ,e.*
-- 컬럼이름 생략시 앞글자만 사용
FROM emp e
WHERE substr(e.ename, 1, 1) = 'J';

-- 3.원하는 단어만 가져오기
SELECT substr ('abcde', 3, 3)
-- substr (-숫자,숫자): 뒤에서부터 가져오기
	  ,substr ('hello, world', -3, 3)
FROM dual;

-- 연습문제 (책 p.78) 전공번호가 201인 학생의 이름 + 전화번호 출력
SELECT name
	  -- ,instr(tel, ')', 1) "location of"
	  ,tel
-- 지역번호가 3자리일때: substr(instr()) / -숫자: 괄호 빼고가져오기
-- 전화번호 중 가운데 번호만 가지고 오고 싶을때 / area code: 지역번호
	  ,substr(tel, 1, instr(tel,')', 1) -1) AS "area code"
-- from: 전화번호 시작부분
	  ,instr(tel, ')', 1) + 1 AS "from"
-- to: 전화번호의 끝
	  ,instr(tel, '-', 1) AS "to"
-- from - to = 전화번호의 가운데 번호
	  ,substr(tel, instr (tel, ')', 1) +1,
	  			 (instr (tel, '-', 1) - (instr(tel, ')', 1)+1))) AS "국번"
FROM student
WHERE deptno1 = 201
AND substr(tel, 1, instr (tel, ')', 1) -1) = '02';

-- 연습문제 p. 79: 전공번호가 101인 학생이름, 전화번호 (3이 첫번째로 나오는 이름, 전화번호 함께 출력)
SELECT name
	  ,TEL 
	  ,instr(tel, '3')
FROM student
WHERE deptno1 = 101;

-- 연습문제 p.79: 전공 1이 201번인 학생이름, 전화번호, 지역번호 출력 (숫자로만)
SELECT NAME 
	  ,TEL 
	  ,substr(tel, 1, instr(tel, ')', 1) -1) AS "area code"
FROM student;




