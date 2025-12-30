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
SELECT tel 
	  ,instr(tel, ')', 1) "location of"
	  ,sudstr(tel, 1, instr(tel, ')', 1) -1) AS "local No"
FROM student
WHERE deptno1 = 201;