// express 모듈
const OracleDB = require("oracledb"); // 모듈 임팩트
const DB = require("./db");

// 조회된 데이터 => 객체방식
OracleDB.outFormat = OracleDB.OUT_FORMAT_OBJECT;

const dbconfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.26:1521/xe", // 집에서 할땐 집 ip주소 입력
};
// db 접속하기위한 session을 얻어오는 함수
async function getConnection() {
  try {
    const connection = await OracleDB.getConnection(dbconfig);
    return connection; // 연결(session)을 반환 , 위에서 받아온 내용을 반환
  } catch (err) {
    return err; // 에러를 반환
  }
}

// 비동기처리 => 동기방식처리
async function execute() {
  // session 획득
  const qry = `insert into board (board_no, title, content, writer)
              values(5, 'db입력', '연습중입니다', 'user01' )`;
  try {
    const connection = await OracleDB.getConnection(dbconfig);
    const result = await connection.execute(qry);
    connection.commit(); // 커밋

    console.log("db 등록성공");
    console.log(result);
  } catch (err) {
    console.log(`예외 발생 => ${err}`);
  }
} // end of execut().
// execute();

// 외부 js 파일에서 사용할 수 있도록 익스포트
module.exports = { getConnection, execute };
