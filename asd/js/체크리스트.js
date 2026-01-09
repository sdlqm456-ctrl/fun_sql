// 체크리스트.js
// 1. 입력상자에 목록입력 => 추가버튼 클릭시 입력값 배열에 추가
let list = [];
document.querySelector("#add").addEventListener("click", (e) => {
  console.log("abc");
  const item = document.querySelector("#item").value;
  console.log(item);
  if (list.indexOf(item) == -1) {
    list.push(item);
  } else {
    // 2. 중복값 입력시 메세지 출력 + 초기화 후 focus 주기
    alert("중복된 값이 있습니다");
    document.querySelector("#item").value = "";
    document.querySelector("#item").focus();
    return;
  }
  let ulTag = document.createElement("ul");
  // 3. ui, li 테그 동적으로 추가
  for (let item of list) {
    console.log(ulTag);
    let liTag = document.createElement("li");
    liTag.innerText = item;
    let span = document.createElement("span");
    span.innerHTML = "X";
    span.className = "close";
    liTag.appendChild(span);
    console.log(liTag);
    ulTag.appendChild(liTag);
  }
  document.querySelector("#itemList").appendChild(ulTag);

  // list 항목에 item 값 => hello, world

  // 4. 삭제표시 클릭시 목록 제거 , 화면표시 X
  console.log(list);
});
