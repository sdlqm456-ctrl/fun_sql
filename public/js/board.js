//fetch를 통해 게시글 정보 가져오기

fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
  })
  .then((result) => {
    console.log(result);
    // 반복처리
    result.forEach((elem) => {
      //tobody sudject
      // totoLocaleString(): 현재 시간대와 날짜, 시간을 문자열로 변환
      // querySelector(): 테그 반환
      // insertAdjacentHTML(): 테그변경
      const inserHTML = `</tr>
                        <td>${elem.BOARD_NO}</td>
                        <td> ${elem.TITLE}</td>
                        <td>${elem.WRITER}</td>
                        <td>${new Date(elem.WRITE_DATE).toDateString()}</td>
                        <td><buttonn onclick = 'deleteRow(${
                          elem.BOARD_NO
                        })'class = 'delete'/>삭제</td>
                        </tr>`;
      const sudject = document.querySelector("tbody");
      sudject.insertAdjacentHTML("beforeend", inserHTML);
    }); // end of forech
  })
  .catch((err) => {
    console.lpg(err);
  });

// from에 submit 이벤트 등록
// preventDefault: 이벤트 발생(폼제출 등) 시 브라우저의 기본동작 (링크이동, 새로고침 등)을 막음
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  const board_no = document.querySelector("#postNo").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const writer = document.querySelector("#writer").value;

  // 입력값 체크
  if (!board_no || !title || !content || !writer) {
    alert("필수값을 입력하세요");
    return;
  }
  const dete = { board_no, title, content, writer };

  // post 요청 / fetch: 가져오다 (서버 요청)
  // 1. ULR 2. option object
  // stringify: 겍체나 데이터를 문자열로 반환
  // then: 그다음
  fetch("./add_board", {
    // 경로추적
    method: "post",
    headers: { "content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      console.log(date);
      return data, json();
    }) // fetch구문의 실행 성공 => then 메소드 안 구문 실행
    .then((result) => {
      console.log(result);
      const inserHTML = `</tr>
                        <td>${result.board_no}</td>
                        <td> ${result.title}</td>
                        <td>${result.writer}</td>
                        <td>${new Date(result.writer_date).toDateString()}</td>
                        <td><buttonn onclick = 'deleteRow(${
                          result.BOARD_NO
                        })'class = 'delete'/>삭제</td>
                        </tr>`;
      const sudject = document.querySelector("tbody");
      sudject.insertAdjacentHTML("beforeend", inserHTML);
    })
    .catch((err) => {
      console.log(err);
    }); // fatch 구문 실행 실패 => catch 안 구문 실행
});
// 글 삭제
function deleteRow(postNo) {
  console.log(postNo);
}

