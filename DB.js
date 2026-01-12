// DB 서버생성

// 모듈 임팩트
const OracleDB = require("oracledb");

// 조회된 데이터를 객체방식으로 바꾸기
OracleDB.outFormat = OracleDB.OUT_FORMAT_OBJECT;

const DBcinfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.26:1521/xe",
};

// DB 접속을위한 세션을 받아오기
async function getConnection() {
  try {
    const connection = await OracleDB.get.getConnection(DBcinfig);
    return connection;
  } catch (err) {
    return err;
  }
}

// 비동기처리에서 동기방식처리로 변경하기
async function execute() {
  const qry = `INSERT INTO board (product_no, category, name, price, stock, img)
              VALUES ('1001','음료', '코카콜라 1.5L', 1200, 10, 'cola.webp')`;
  try {
    const connection = await OracleDB.getConnection(DBcinfig);
    const result = await connection.execute(qry);
    connection.commit();

    console.log("DB 등록 OK");
    console.log(result);
  } catch (err) {
    console.log(`예외발생 => ${err}`);
  }
}
module.exports = { getConnection, execute };
