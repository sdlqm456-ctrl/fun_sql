-- student 테이블의 전체목록 조회
-- 구문이 끝나면 ;를 넣어야 명령에 실행
-- || 문자열을 연결 ''는 문자열 추가
-- " "앞의 값을 name으로 지정 (alias: 별칭지정)
-- 따옴표 X = 대문자로 표현 / 따옴표 O = 대소문자 구문 X
SELECT 'hello, ' || name as "name"
from student;

-- '''s' : 문자열에 ' 를 넣어주는 명령어

-- 연습문제 1번 p.39(학생이름, 아이디, 채중)을 한줄에 표현
select name || '''s ID: '|| ' weghr is ' || weight || 'kg' as "ID AND WELGHT"
from student;

select * from department;

-- distinct: 중복값 제거
-- 결과값에 부서번호 + 이름을 연결
-- , : 분리해서 보여줌 / || : 연결된 문장
select ' 부서번호: ' || deptno, ', 이름은 ' || ename as "name with Dept"
from emp
-- order: 데이터 정렬
order by ename; 

-- 부서정보
select * from dept; 

-- 연습문제 2. 모든 사람의 이름 + 직업 출력
select ename || '('|| job ||'),' || ename || job || ''''as "name and job"
from emp; 

-- 연습문제 3번 (모든 사원의 이름, 급여 한줄에 출력)
SELECT ename ||'''s is $' || sal AS "ename and sal" 
FROM emp;
