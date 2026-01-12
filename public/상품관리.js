// 상품관리.js (최종본)

// 1. 요소 가져오기
const tbody = document.querySelector("#productBody");
const searchBtn = document.querySelector("#searchBtn");
const searchInput = document.querySelector("#searchInput");

// 상품 목록 저장용 배열
let productList = [];

// 2. 서버에서 상품 목록 가져오기
fetch("/boards")
  .then((response) => response.json())
  .then((list) => {
    console.log(list);
    productList = list;
    renderTable(productList);
    checkStock(productList);
  })
  .catch((err) => console.error("상품 불러오기 오류:", err));

// 3. 테이블 출력 함수
function renderTable(list) {
  tbody.innerHTML = "";

  if (list.length === 0) {
    tbody.innerHTML = `<tr><td colspan="6">상품이 없습니다</td></tr>`;
    return;
  }

  list.forEach((item) => {
    let buttonHTML = "";

    // 재고 0 → 품절 버튼 생성
    if (item.stock === 0) {
      buttonHTML = `<button class="delete" data-id="${item.productNo}">품절</button>`;
    }

    const rowHTML = `
      <tr>
        <td>${item.productNo}</td>
        <td>${item.category}</td>
        <td>${item.name}</td>
        <td> <img src="img/${item.image}" class="product-img"></td>
        <td>${item.price}</td>
        <td>${buttonHTML}</td>
      </tr>
    `;

    tbody.insertAdjacentHTML("beforeend", rowHTML);
  });
}

// 4. 검색 버튼 클릭
searchBtn.addEventListener("click", () => {
  const keyword = searchInput.value.trim();

  if (!keyword) {
    alert("검색어를 입력하세요");
    return;
  }

  const filtered = productList.filter(
    (item) => item.name.includes(keyword) || item.productNo.includes(keyword)
  );

  renderTable(filtered);
});

// 5. 품절 버튼 클릭 처리 (이벤트 위임)
tbody.addEventListener("click", (e) => {
  if (e.target.classList.contains("delete")) {
    const productNo = e.target.dataset.id;

    if (confirm("해당 상품을 품절 처리하시겠습니까?")) {
      // 배열에서 제거
      productList = productList.filter((item) => item.productNo !== productNo);

      // 화면 다시 그리기
      renderTable(productList);

      console.log("품절 처리된 상품:", productNo);
    }
  }
});

// 6. 재고 상태 확인 함수
function checkStock(list) {
  list.forEach((item) => {
    if (item.stock <= 5) {
      console.log("⚠ 재고 부족:", item.name);
    } else if (item.stock >= 20) {
      console.log("✅ 재고 충분:", item.name);
    }
  });
}
