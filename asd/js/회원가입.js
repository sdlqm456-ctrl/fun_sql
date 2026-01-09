// 회원가입.js

// 1. 아이디에 이벤트 주기

// 회원가입 정보 받아오기
// 아이디: 3 이상 10 이하 값이 아니면 메사지 보내고 다시입력
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  const id = document.querySelector("#user-id").value;
  const email = document.querySelector("#email").value;
  const password = document.querySelector("#user_pw1").value;
  const pw2 = document.querySelector("#user-pw2").value;
  console.log(id.length);
  if (id.length < 4 || id.length > 15) {
    alert("4보다 크고 15보다 작은값을 입력하세요");
    document.querySelector("#user-id").focus();
    document.querySelector("#user-id").value = "";
    return;
  }
  if (password.length < 4) {
    alert("4자리 이상 입력해주세요");
    return;
  }
  if (pw2 !== password) {
    alert("비밀번호가 일치하지 않습니다");
    return;
  }
  alert("회원가입성공");
});
