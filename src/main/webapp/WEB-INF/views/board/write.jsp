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

  <form id="writeForm" enctype="multipart/form-data">
    <div class="form-group">
      <label class="required">구분</label>
      <select name="boardType">
        <option value="NORMAL">일반</option>
        <option value="IMPORTANT">중요</option>
      </select>
    </div>

    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="regUserName">작성자</label>
      <input type="text" id="regUserName" name="regUserName" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="content">내용</label>
      <textarea id="content" name="content" class="form-control" required></textarea>
    </div>

    <div class="form-group">
      <label>파일 첨부</label>
      <div class="file-upload" onclick="document.getElementById('fileInput').click()">
        <p>📎 파일을 선택하거나 드래그하세요</p>
        <input type="file" id="fileInput" name="files" multiple style="display: none;" accept="image/*, .pdf, .doc, .docx, .xls, .xlsx">
      </div>
      <div class="file-list" id="fileList">
      </div>
    </div>

    <div class="btn-group">
      <button type="button" class="btn btn-secondary btn-cancel">취소</button>
      <button type="submit" class="btn btn-primary btn-create">등록</button>
    </div>
  </form>
</div>
</body>
<form id="pageForm">
  <input type="hidden" name="pageNum" value="${pagination.pageNum}">
  <input type="hidden" name="searchType" value="${pagination.searchType}"/>
  <input type="hidden" name="keyword" value="${pagination.keyword}"/>
</form>
<script>

  let fileList = [];

  function addButtonEvent() {
    $(".btn-cancel").on("click", function (e) {
      e.preventDefault();
      let pageNum = $("input[name='pageNum']").val();
      let searchType = $("input[name='searchType']").val();
      let keyword = $("input[name='keyword']").val();
      window.location.href = '/board?pageNum=' + pageNum + '&searchType=' + searchType + '&keyword=' + keyword;
    });

    $(".btn-create").on("click", function (e) {
      e.preventDefault();
      createBoard();
    });

    $("#fileInput").on("change", function () {
      let files = this.files;

      for (let i = 0; i < files.length; i++) {
        fileList.push(files[i]);
      }

      showFileList();
      $(this).val('');
    });
  }

  //게시글 생성
  function createBoard() {
    let boardTypeValue = $("select[name='boardType']").val();
    let titleValue = $("input[name='title']").val();
    let regUserNameValue = $("input[name='regUserName']").val();
    let contentValue = $("textarea[name='content']").val();

    if (!boardTypeValue) {
      alert("공지사항 타입을 선택하세요");
      return;
    }

    if (!titleValue) {
      alert("게시글 제목을 입력하세요");
      $("#title").focus();
      return;
    }

    if (!regUserNameValue) {
      alert("게시글 작성자를 입력하세요");
      $("#regUserName").focus();
      return;
    }

    if (!contentValue) {
      alert("게시글 내용을 입력하세요");
      $("#content").focus();
      return;
    }

    //파일 크기 체크
    let totalSize = 0;
    for (let i = 0; i < fileList.length; i++) {
      totalSize += fileList[i].size;
    }

    if (totalSize > 10 * 1024 * 1024) {
      alert("전체 파일 크기는 10MB를 초과할 수 없습니다");
      return;
    }

    const formData = new FormData();
    formData.append("boardType", boardTypeValue);
    formData.append("title", titleValue);
    formData.append("regUserName", regUserNameValue);
    formData.append("content", contentValue);

    for (let i = 0; i < fileList.length; i++) {
      formData.append("files", fileList[i]);
    }

    $.ajax({
      url: '/board',
      method: 'post',
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.success) {
          alert(response.message);
          window.location.href = '/board';
        }
      },
      error: function (xhr, status, error) {
        let response;
        try {
          response = JSON.parse(xhr.responseText);
        } catch (e) {
          alert("응답 데이터 처리 중 오류가 발생하였습니다");
          return e;
        }

        const errorMessage = response.message;
        if (xhr.status === 400) {
          let errors = response.items;
          if (errors['title']) {
            alert(errors['title']);
            return false;
          } else if (errors['content']) {
            alert(errors['content']);
            return false;
          } else if (errors['boardType']) {
            alert(errors['boardType']);
            return false;
          } else if (errors['regUserName']) {
            alert(errors['regUserName']);
            return false;
          }
        } else if (xhr.status === 500) {
          alert(errorMessage);
        }
      }
    });
  }

  //파일 VIEW
  function showFileList() {
    $("#fileList").empty();

    for (let i = 0; i < fileList.length; i++) {
      let file = fileList[i];
      let size = (file.size / 1024).toFixed(1) + "KB";

      let html = '<div style="display:flex; padding:10px; border:1px solid #ddd; margin-top:10px; border-radius:5px;">';
      html += '<span style="flex:1;">📄 ' + file.name + '</span>';
      html += '<span style="color:#999; margin-right:10px;">' + size + '</span>';
      html += '<button type="button" onclick="removeFile(' + i + ')" style="background:#e74c3c; color:white; padding:5px 10px; border:none; border-radius:3px; cursor:pointer;">삭제</button>';
      html += '</div>';

      $("#fileList").append(html);
    }
  }

  //파일 VIEW 삭제
  function removeFile(index) {
    fileList.splice(index, 1);
    showFileList();
  }

  $(function () {
    addButtonEvent();
  });
</script>
</html>
