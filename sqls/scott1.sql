 CREATE TABLE board (
  board_no NUMBER PRIMARY KEY -- 프라이머리키에는 null값이 포함
 ,title varchar2(100) NOT NULL -- 100바이트까지 입력가능, 입력값이 null을 제약 (컬럼명 타입 제약조건)
 ,content varchar2(1000) NOT NULL -- 내용
 ,writer varchar2(50) NOT NULL  -- 작성자
 ,write_date DATE DEFAULT sysdate   -- 작성시간
);
-- 새로운 컬럼 추가
ALTER TABLE board ADD (click_cnt number);

-- 컬럼명 변경
ALTER TABLE board RENAME COLUMN click_cnt TO VIEW_cnt;

--컬럼의 타입변경
ALTER table board MODIFY writer varchar2(100); 

SELECT * 
from board;

select * from student;

select * from emp;

-- DML 
INSERT INTO board (title, content, writer, board_no)
VALUES ('신규회원등록관련', '신규회원 아이디는 50글자 미만으로 작성해주세요', 'admin', 2);

INSERT INTO board (title, content, writer ,write_date)
VALUES ('신규회원등록관련', '신규회원 아이디는 50글자 미만으로 작성해주세요', 'admin', '2026-01-06');

insert into board (title, content, writer, board_no)
VALUES ('2026년도 프로야구 개막일까지 85일','신규회원 아이디는 50글자 미만으로 작성해주세요','admin',3);
