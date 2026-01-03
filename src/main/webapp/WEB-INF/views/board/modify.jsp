<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2026-01-03
  Time: 오후 4:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>수정</title>
    <link rel="stylesheet" href="/css/board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container" id="edit-page">
  <h1>게시글 수정</h1>

  <form method="post" action="" enctype="multipart/form-data">
    <input type="hidden" name="id" value="">

    <div class="form-group">
      <label for="edit-title">제목</label>
      <input type="text" id="edit-title" name="title" class="form-control" value="기존 제목" required>
    </div>

    <div class="form-group">
      <label for="edit-writer">작성자</label>
      <input type="text" id="edit-writer" name="writer" class="form-control" value="홍길동" readonly>
    </div>

    <div class="form-group">
      <label for="edit-content">내용</label>
      <textarea id="edit-content" name="content" class="form-control" required>기존 내용</textarea>
    </div>

    <div class="form-group">
      <label>기존 첨부파일</label>
      <div class="attached-files">
        <div class="file-item">
          <span>📄 문서파일.pdf</span>
          <button type="button" class="file-remove">삭제</button>
        </div>
        <div class="file-item">
          <span>🖼️ 이미지.jpg</span>
          <button type="button" class="file-remove">삭제</button>
        </div>
      </div>
    </div>

    <div class="form-group">
      <label>새 파일 추가</label>
      <div class="file-upload" onclick="document.getElementById('editFileInput').click()">
        <p>📎 파일을 선택하거나 드래그하세요</p>
        <input type="file" id="editFileInput" name="files" multiple style="display: none;">
      </div>
      <div class="file-list" id="editFileList">
      </div>
    </div>

    <div class="btn-group">
      <button type="button" class="btn btn-secondary">취소</button>
      <button type="submit" class="btn btn-success">수정완료</button>
    </div>
  </form>
</div>
</body>
</html>
