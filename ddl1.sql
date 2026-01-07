-- table (게시판) / 칼럼: 제목, 내용, 작성자, 작성시간, 조회수, 수정시간, .... 등등 
DROP TABLE board; -- 테이블 삭제

CREATE TABLE board (
  board_no NUMBER PRIMARY KEY -- 프라이머리키에는 null값이 포함
 ,title varchar2(100) NOT NULL -- 100바이트까지 입력가능, 입력값이 null을 제약 (컬럼명 타입 제약조건)
 ,content varchar2(1000) NOT NULL -- 내용 / varchar2: 문자열 지정 데이터 타입
 ,writer varchar2(50) NOT NULL  -- 작성자
 ,write_date DATE DEFAULT sysdate   -- 작성시간
);
-- 새로운 컬럼 추가 (add)
ALTER TABLE board ADD (click_cnt number);

-- 컬럼명 변경 (rename column)
ALTER TABLE board RENAME COLUMN click_cnt TO VIEW_cnt;

--컬럼의 타입변경 (modlfy)
ALTER table board MODIFY writer varchar2(100); 

SELECT * 
from board;

-- DML: 지정된 컬럼에 삽입
INSERT INTO board (title, content, writer, board_no)
VALUES ('신규회원등록관련', '신규회원 아이디는 50글자 미만으로 작성해주세요', 'admin', 4);

INSERT INTO board (title, content, writer ,write_date)
VALUES ('신규회원등록관련', '신규회원 아이디는 50글자 미만으로 작성해주세요', 'admin', '2026-01-06');


-- 등록, 수정, 삭제, 조회: C(reate) R(ead) U(padate) D(elete) 기능
-- CREATE table: 테이블 생성
-- indert: 테이블에 새로운 데이터 입력

select * FROM dept2;

-- insert into: 데이터 1개씩 입력할때 사용
INSERT INTO DEPT2 
values('9000','temp_1','1006','temp area');

SELECT * FROM product;
-- 상품코드 999, 상품명: potato chip, 가격: 1,200원

INSERT INTO product
values('999', 'poteto chip', '1200');

-- commit(영구적 반영) 
-- rollbake (취소): 취소 이전commit으로 되돌리기
rollback;

-- ctas:CREATE TABLE AS SELECT의 약자 => 새 테이블 생성
CREATE table professor2
AS
SELECT * FROM professor;

SELECT * FROM professor2;
delete * FROM professor2; -- 테이블 삭제

-- ITAS: 전체 데이터 입력 
INSERT INTO professor2
SELECT * FROM professor;

-- update: 데이터변경
SELECT * FROM professor2;

-- pay와 bouns 변경
UPDATE professor2
SET pay = 650
   ,bonus = 200
WHERE profno = 1001;

--데이터 delete(삭제)
DELETE FROM PROFESSOR2 
WHERE profno = 1001; 

-- board
SELECT * FROM board;

-- 글번호: 5,  제목: 게시글 연습입니다. 내용: 신규글을 등록합니다. user01 => 등록
INSERT INTO board (title, content, writer, board_no)
values('게시글 연습입니다', '신규글을 등록합니다', 'user01', 5);

-- 글번호: 5, 제목: 게시글 수정입니다. 내용: 신규글을 수정합니다 => 수정 
UPDATE board 
SET title = '게시글 수정입니다'
   ,content = '신규글을 수정합니다'
WHERE board_no = 5;

-- 5번글 삭제
delete FROM board
WHERE board_no = 5;


-- student 테이블 -> student2 테이블을 새로 만들기 (정보 그대로)
CREATE TABLE student2 
AS
SELECT * FROM student
WHERE 1 = 2;

-- Anthony Hopkins의 담당교수로 Jodie Foster로 지정

INSERT INTO student2
SELECT * FROM student;

SELECT * FROM student2; 

UPDATE student2
SET profno = (SELECT profno FROM professor2 WHERE name = 'Jodie Foster');
WHERE name = 'Anthony Hopkins';

SELECT * FROM professor; 

-- 3학년 중에서 2전공이 없는 사람들의 전공을 computer Engineering으로 지정 
-- deptno 101 Computer Engineering
SELECT * FROM DEPARTMENT; 
SELECT * FROM student2; 

UPDATE student2 
SET deptno2 = (SELECT deptno FROM DEPARTMENT WHERE dname = '101')
WHERE grade = 3
AND deptno2 IS null; -- 값이 null인 사람들에게 Computer Engineering으로 지정
