// farch를 통해서 게시글 데이터 가져오기
fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
    // 반복처리
    result.forEach((elem) => {
      // tboby subject
      // toLocaleString(): 현재 시간대와 로컬에 따라 날짜, 시간를 문자열로 변환
      // querySelector(): 괄호안의 테그를 반환
      // insertAdjacentHTML(): html테그를 ()안의 테그로 변경
      const insertHTML = `</tr>
                    <td>${elem.BOARD_NO}</td>
                    <td>${elem.TITLE}</td>
                    <td>${elem.WRITER}</td>
                    <td>${new Date(elem.WRITE_DATE).toLocaleString()}</td>
                    <td><button onclick = 'deleteRow(${
                      elem.BOARD_NO
                    })' calss = 'delete'/>삭제</td>
                  </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHTML);
    }); // end of forech
  })
  .catch((err) => {
    console.log(err);
  });
// from에다가 submit 이벤트 등록
// preventDefault: 링크 클릭, 폼제출 등의 특정 이벤트 발생이 브라우저의 기본동작 (링크이동, 새로고침 등)이 실행되지 않도록 막음
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  const board_no = document.querySelector("#postNo").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const writer = document.querySelector("#writer").value;

  // 입력값 체크
  if (!board_no || !title || !content || !writer) {
    alert("필수값 입력");
    return;
  }
  const data = { board_no, title, content, writer };

  // post 요청 / fetch: 가져오다 (서버 요청)
  // 1. ULR 2. option object
  // stringify: 겍체나 데이터를 문자열로 반환
  // then: 그다음
  fetch("./add_board", {
    // 경로 추적
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      console.log(data);
      return data.json();
    }) // fetch() 실행이 성공하면 tnen 메소드 안의 구문 실행
    .then((result) => {
      console.log(result);
      const insertHTML = `</tr>
                      <td>${result.board_no}</td>
                      <td>${result.title}</td>
                      <td>${result.writer}</td>
                      <td>${new Date(result.writer_date).toLocaleString()}</td>
                      <td><button onclick = 'deleteRow(${
                        result.board_no
                      })' calss = 'delete'/>삭제</td>
                    </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHTML);
    })
    .catch((err) => {
      console.log(err);
    }); // fatch() 실행이 실패하면 catch 메소드 안의 구문 실행
});

// 글 삭제
function deleteRow(postNo) {
  console.log(postNo);
}
