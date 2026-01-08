// express 서버 모듈
// const: 함수선언

const express = require("express"); // 모듈 임포드
const db = require("./db");

const app = express(); // 인스턴스 생성

app.use(express.static("public"));
app.use(express.json());

// URL 주소 - 실행함수 => 라우팅
// 요청방식(get) -> 'remove_board/:board_no'
// 반환되는 결과 ({retCode: 'OK' or 'NG'})

// "/"
app.get("/", (req, res) => {
  // 요청정보, 웹페이지 정보 (실행함수)
  res.send("/장수연 홈페이지에 오신걸 환영합니다");
});

// 댓글 전체목록을 반환
app.get("/boards", async (req, res) => {
  const qry = "select * from board";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    console.log("성공");
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("실패");
  }
});

// 요청방식: get vs post
// get: 단순조회 시 사용, 외부에 노출 O 적은 양의 데이터를 전달 가능
// post: 많은 양의 데이터 전달
// 내용등록, 제약조건 오류 생성
app.post("/add_board", async (req, res) => {
  console.log(req.body);
  //{ board_no: 10, title: 'text', content: 'sample', writle: 'user01' }
  const { board_no, title, content, writer } = req.body;
  // 숫자를 제외하고 문자열을 가지고 올때에는 ''를 써야 함
  const qry = `insert into board (board_no, title, content, writer)
               values(: board_no, :title, :content, :writer) `;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      board_no,
      title,
      content,
      writer,
    ]);
    console.log(result); // {}  => 교수님 내용 참고
    connection.commit();
    res.json({ board_no, title, content, writer });
  } catch (err) {
    console.log(err);
    // res.send("처리중 에러")
    res.json({ retCode: "NG", retMsg: "DB 에러" });
  }
});

// "/student" => 화면에 출력
app.get("student/:studno", async (req, res) => {
  console.log(req.empno);
  const empno = req.params.empno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows); // 반환되는 결과값에서 rows 속성의 결과만 출력
});

// '/employee' 사원의 목록을 출력하는 라우팅
app.get("/employee/:empno", async (req, res) => {
  console.log(req.empno);
  const empno = req.params.empno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

// 서버실행
app.listen(3000, () => {
  console.log("server 실행 http://localhost:3000"); // 서버실행 포트가 3000
});
