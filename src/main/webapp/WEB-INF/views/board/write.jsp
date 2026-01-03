<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2026-01-03
  Time: 오후 4:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>등록</title>
    <link rel="stylesheet" href="/css/board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container" id="write-page">
  <h1>게시글 작성</h1>

  <form method="post" action="" enctype="multipart/form-data">
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="writer">작성자</label>
      <input type="text" id="writer" name="writer" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="content">내용</label>
      <textarea id="content" name="content" class="form-control" required></textarea>
    </div>

    <div class="form-group">
      <label>파일 첨부</label>
      <div class="file-upload" onclick="document.getElementById('fileInput').click()">
        <p>📎 파일을 선택하거나 드래그하세요</p>
        <input type="file" id="fileInput" name="files" multiple style="display: none;">
      </div>
      <div class="file-list" id="fileList">
      </div>
    </div>

    <div class="btn-group">
      <button type="button" class="btn btn-secondary">취소</button>
      <button type="submit" class="btn btn-primary">등록</button>
    </div>
  </form>
</div>
</body>
</html>
