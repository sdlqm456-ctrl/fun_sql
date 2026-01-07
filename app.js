// express 서버모듈
// const : 함수를 선언
const express = require("express"); // 모듈 임포드
const db = require("./db");

const app = express(); // 인스턴스 생성

// URL 주소 - 실행함수 => 라우팅
// "/"
app.get("/", (req, res) => {
  // 요청정보,웹페이지 정보 (실행함수)
  res.send("/장수연 홈에 오신걸 환영합니다"); // 웹페이지에 ( )안 내용을 출력해서 보여줌 => 라우팅 정보
});

// 제약조건 오류 생성
app.get("/add_board", async (req, res) => {
  const qry = `INSERT into board (board_no, title, content, writer)
              VALUES(6,'test', 'content', 'user01')`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    req.send("처리완료");
  } catch (err) {
    console.log(err);
    res.send("처리중 에러");
  }
});
// "/student" -> 화면에 출력
app.get("/student/:studno", async (req, res) => {
  console.log(req.params.studno);
  const studno = req.params.studno;
  const qry = " select * from student where studno = 9411"; // 9411을 값으로 받겠다
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows); // 반환되는 결과값에서 rows 속성의 결과만
});

// '/employee' 사원의 목록을 출력하는 라우팅
app.get("/employee/:empno", async (req, res) => {
  console.log(req.empno);
  const qry = "select * from emp where empno = 7566";
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

// 서버실행
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000"); // 서버실행 포트가 3000
});
