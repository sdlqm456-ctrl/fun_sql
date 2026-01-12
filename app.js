// app.js(수정)

// 1. 기본작업 (모듈, 인스턴트 생성)

// 모듈 생성
const express = require("express");
const BD = require("./DB");

// 인스턴트 생성
const app = express();

app.use(express.static("public"));
app.use(express.json());

//2. 상품목록 가져오기

// "/"
app.get("/", (req, res) => {
  // 요청정보, 웹페이지 정보 (실행함수)
  res.send("/홈페이지에 오신걸 환영합니다");
});
app.get("/boards", async (req, res) => {
  const qry = "select * from board";
  try {
    const connection = await DB.getConnection();
    const result = await connection.execute(qry);
    console.log("연결 성공");
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("연결 실패");
  }
});
app.post("/add_board", async (req, res) => {
  console.log(req.body);
  const qry = `INSERT INTO board (product_no, category, name, price, stock, img)
              VALUES ('1001','음료', '코카콜라 1.5L', 1200, 10, 'cola.webp')`;
  try {
    const connection = await DB.getConnection();
    const result = await connection.execute(qry, [
      product_no,
      category,
      name,
      price,
      stock,
      img,
    ]);
    console.log(result);
    connection.commit();
    res.json({ product_no, category, name, price, stock, img });
  } catch (err) {
    console.log(err);
    res.json({ retCode: "NG", retMsg: "DB 에러" });
  }
});

// 서버실행
app.listen(3000, () => {
  console.log("server 실행 http://localhost:3000"); // 서버실행 포트가 3000
});
