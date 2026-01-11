const express = require("express");
const app = express();
const path = require("path");

app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

app.get("/boards", (req, res) => {
  res.json();
});

app.post("/add_board", (req, res) => {
  res.json({ result: "success" });
});

app.listen(3000, () => {
  console.log("서버 실행중 http://localhost:3000");
});
