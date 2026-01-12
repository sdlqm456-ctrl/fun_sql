// DB 서버생성

// 모듈 임포트
const OracleDB = require("oracledb");

// 조회된 데이터를 객체방식으로 바꾸기
OracleDB.outFormat = OracleDB.OUT_FORMAT_OBJECT;

const DBconfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.26:1521/xe",
};

// DB 접속을 위한 세션을 받아오기ㄴ
async function getConnection() {
  try {
    const connection = await OracleDB.getConnection(DBconfig);
    return connection;
  } catch (err) {
    console.log("DB 연결 실패:", err);
    throw err;
  }
}

// 테스트용: 비동기 처리에서 동기 방식 처리
async function execute() {
  const qry = `INSERT INTO board (product_no, category, name, price, stock, img)
              VALUES ('1001','음료', '코카콜라 1.5L', 1200, 10, 'cola.webp')`;
  try {
    const connection = await OracleDB.getConnection(DBconfig);
    const result = await connection.execute(qry);
    await connection.commit();

    console.log("DB 등록 OK");
    console.log(result);
    await connection.close(); // 연결 종료
  } catch (err) {
    console.log(`예외발생 => ${err}`);
  }
}

module.exports = { getConnection };
