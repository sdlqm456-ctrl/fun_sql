-- scott 계정 소유의 테이블 목록 조회
-- sql: structured Query Language 데이터베이스 접근 언어 
-- select: 선택하다 => ted 그룹의 내용을 선택
SELECT * FROM tab; 
-- table/ column: 열 (table의 열을 보여줘)

-- 테이블의 구조 
desc customer; -- desc: 내림차순으로 정렬 
-- gno: 문자열의 길이, jumin: 주민번호
SELECT gno, gname, jumin, point from customer;
-- professor 테이블의 전체 목록 조회
SELECT * from professor;

-- student 테이블의 전체목록 조회
-- 구문이 끝나면 ;를 입력해야 명령어가 실행이 됨
-- || 문자열 연결 ''는 문자열 추가
-- "" 앞에 값을 name으로 지정 (alias: 별칭지정)
-- 따옴표 없이 쓰면 대문자로 표현 됨 (따옴표가 있으면 대소문자 구분 x)
SELECT 'hello, ' || name as "name"
FROM student; 

-- '''s': 문자열에 '를 나타내는 명령어 
-- 연습문제 1번 p.39 (학생의 이름, 아이디, 체중을 한 줄에 표현)
SELECT name || '''s ID: ' || ID || ' weighr is ' || weight || 'kg' as "ID AND WELGHT"
FROM student;

select * from department; -- 학과

-- distinct: 중복값을 제거해서 보여달라는것
-- 결과값에 부서번호와 이름을 연결해서 보여주는 명령어
-- ,를 넣으면 분리해서 보여주고 ||를 쓰면 하나의 컬럼으로 처리함
select ' 부서번호는' || deptno, ', 이름은 ' || ename as "name with Dept" 
from emp
order by ename; -- 사원 / order by: 데이터를 정렬해서 보여주는 것 

select * from dept; -- 부서정보 

-- 연습문제 2번 (모든사람의 이름과 직업을 출력)
select ename || '('||job||'), ' || ename || '''' || job || '''' as "NAME AND JOB" 
from emp;

