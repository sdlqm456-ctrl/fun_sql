// 상품관리 js (찐 최종본..이면 좋겠다)

// 1. 상품정보 불러오기
fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
    return result;
  })
  .then((result) => {
    // 반복처리
    result.forEach((elem) => {
      const insertHTML = `
        <tr>
          <td>${elem.PRODUCT_NO}</td>
          <td>${elem.CATEGORY}</td>
          <td>${elem.NAME}</td>
          <td>${elem.IMG}</td>
          <td>${elem.PRICE}</td>
          <td>${elem.PERSON}</td>
          <td>${elem.TIME}</td>
          <td>${elem.STATUS}</td>
          <td>
            <button class="delete" onclick="deleteRow(${elem.PRODUCT_NO})">
              발주완료
            </button>
          </td>
        </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHTML);
    });
  })
  .catch((err) => {
    console.log(err);
  });

// 2. 검색 버튼 클릭 이벤트
document.querySelector("#searchInput").addEventListener("click", (e) => {
  e.preventDefault();

  const board_no = document.querySelector("#product_no").value;
  const title = document.querySelector("#category").value;
  const content = document.querySelector("#name").value;
  const price2 = document.querySelector("#pricer").value;
  const stock2 = document.querySelector("#stock").value;
  const img2 = document.querySelector("#img").value;

  if (!product_no || !name) {
    alert("상품번호와 이름은 필수입니다.");
    return;
  }

  const data = { board_no, title, content, price2, stock2, img2 }; // ✅ 변수명 통일

  fetch("./add_board", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ product_no, category, name, price, stock, img }),
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.retCode === "OK") alert("상품 추가 완료");
      else alert("상품 추가 실패: " + data.retMsg);
    })
    .catch((err) => console.error(err));
});

// 글 삭제
function deleteRow(PRODUCT_NO) {
  console.log(PRODUCT_NO);
}
