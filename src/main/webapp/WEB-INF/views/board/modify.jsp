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
    <input type="hidden" name="id" value="${board.id}">

    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" class="form-control" value="${board.title}" required>
    </div>

    <div class="form-group">
      <label for="writer">작성자</label>
      <input type="text" id="writer" name="writer" class="form-control" value="${board.regUserName}" readonly>
    </div>

    <div class="form-group">
      <label for="content">내용</label>
      <textarea id="content" name="content" class="form-control" required>${board.content}</textarea>
    </div>

    <div class="form-group">
      <label>기존 첨부파일</label>
      <div class="attached-files">
        <c:forEach var="file" items="${board.fileList}">
          <div class="file-item">
            <span>📄 ${file.originalName}</span>
            <button type="button" class="file-remove" data-file-id="${file.id}" onclick="removeExistingFile(this)">삭제</button>
          </div>
        </c:forEach>
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
      <button type="button" class="btn btn-secondary btn-cancel">취소</button>
      <button type="button" class="btn btn-success btn-modify">수정완료</button>
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

  const pageForm = $("#pageForm");

  let fileList = [];
  let deletedFileIds = [];

  function addButtonEvent() {
    $(".btn-cancel").on("click", function (e) {
      e.preventDefault();
      history.back();
    });

    $(".btn-modify").on("click", function (e) {
      e.preventDefault();
      modifyBoard();
    });

    $("#editFileInput").on("change", function () {
      let files = this.files;
      for (let i = 0; i < files.length; i++) {
        fileList.push(files[i]);
      }

      showFileList();
      $(this).val('');
    });
  }

  //게시글 수정
  function modifyBoard() {
    let titleValue = $("input[name='title']").val();
    let contentValue = $("textarea[name='content']").val();

    if (!titleValue) {
      alert("수정할 게시글의 제목을 입력하세요");
      $("#title").focus();
      return;
    }

    if (!contentValue) {
      alert("수정할 게시글의 내용을 입력하세요");
      $("#content").focus();
      return;
    }

    let totalSize = 0;
    for (let i = 0; i < fileList.length; i++) {
      totalSize += fileList[i].size;
    }

    if (totalSize > 10 * 1024 * 1024) {
      alert("파일 전체 크기는 10MB를 초과할 수 없습니다");
      return;
    }

    const formData = new FormData();
    formData.append("id", $("input[name='id']").val());
    formData.append("title", titleValue);
    formData.append("content", contentValue);
    formData.append("regUserName", $("input[name='regUserName']").val());

    //새로 추가할 파일
    for (let i = 0; i < fileList.length; i++) {
      formData.append("files", fileList[i]);
    }

    //삭제할 파일 ID
    if (deletedFileIds.length > 0) {
      for (let i = 0; i < deletedFileIds.length; i++) {
        formData.append("deletedFileIds", deletedFileIds[i]);
      }
    }

    $.ajax({
      url: '/board',
      method: 'put',
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        if (response.success) {
          alert(response.message);
          pageForm.attr('action', `/board/${board.id}`);
          pageForm.submit();
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
          if (errors['id']) {
            alert(errors['id']);
            return false;
          } else if (errors['title']) {
            alert(errors['title']);
            return false;
          } else if (errors['content']) {
            alert(errors['content']);
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
    $("#editFileList").empty();

    for (let i = 0; i < fileList.length; i++) {
      let file = fileList[i];
      let size = (file.size / 1024).toFixed(1) + "KB";

      let html = '<div style="display:flex; padding:10px; border:1px solid #ddd; margin-top:10px; border-radius:5px;">';
      html += '<span style="flex:1;">📄 ' + file.name + '</span>';
      html += '<span style="color:#999; margin-right:10px;">' + size + '</span>';
      html += '<button type="button" onclick="removeFile(' + i + ')" style="background:#e74c3c; color:white; padding:5px 10px; border:none; border-radius:3px; cursor:pointer;">삭제</button>';
      html += '</div>';

      $("#editFileList").append(html);
    }
  }

  //파일 VIEW 삭제
  function removeFile(index) {
    fileList.splice(index, 1);
    showFileList();
  }

  //기존 파일 삭제
  function removeExistingFile(element) {
    let fileId = $(element).data('file-id');
    deletedFileIds.push(fileId);
    $(element).closest(".file-item").remove();
  }

  $(function () {
    addButtonEvent();
  });
</script>
</html>
