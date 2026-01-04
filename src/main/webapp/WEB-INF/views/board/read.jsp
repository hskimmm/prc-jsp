<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2026-01-03
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>상세</title>
    <link rel="stylesheet" href="/css/board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container" id="detail-page">
    <h1>게시글 상세보기</h1>
    <div class="post-detail">
        <div class="post-header">
            <h2>${board.title}</h2>
            <div class="post-meta">
                <span>작성자: ${board.regUserName}</span>
                <span>작성일: ${board.regDate.toString().substring(0, 16).replace('T', ' ')}</span>
                <span>조회수: ${board.viewCount}</span>
            </div>
        </div>

        <!-- 첨부파일 -->
        <div class="attached-files">
            <h4>📎 첨부파일</h4>
            <c:forEach var="file" items="${board.fileList}">
                <a href="#" class="file-download">
                    <span class="file-icon">📄</span>
                    ${file.originalName}
                </a>
            </c:forEach>
        </div>

        <div class="post-content">${board.content}</div>

        <div class="post-footer">
            <div class="btn-group">
                <a href="#" class="btn btn-secondary btn-cancel">목록</a>
                <a href="/board/modify/${board.id}?pageNum=${pagination.pageNum}&searchType=${pagination.searchType}&keyword=${pagination.keyword}" class="btn btn-success">수정</a>
                <button type="button" class="btn btn-danger btn-delete">삭제</button>
            </div>
        </div>
    </div>

    <!-- 댓글 영역 -->
    <div class="comment-section">
        <h3>💬 댓글 <span style="color: #007bff;">(3)</span></h3>

        <!-- 댓글 작성 -->
        <div class="comment-write">
            <form method="post" action="">
                <textarea name="comment" placeholder="댓글을 입력하세요" required></textarea>
                <div class="comment-write-footer">
                    <input type="text" name="commentWriter" placeholder="작성자" required>
                    <button type="submit" class="btn btn-primary">댓글 등록</button>
                </div>
            </form>
        </div>

        <!-- 댓글 목록 -->
        <div class="comment-list"></div>
    </div>
</div>
</body>
<form id="pageForm">
    <input type="hidden" name="pageNum" value="${pagination.pageNum}"/>
    <input type="hidden" name="searchType" value="${pagination.searchType}"/>
    <input type="hidden" name="keyword" value="${pagination.keyword}"/>
</form>
<script>

    const pageForm = $("#pageForm");

    const formatDate = d =>
        new Date(d).toISOString().slice(0,16).replace('T',' ');

    function addButtonEvent() {
        $(".btn-cancel").on("click", function (e) {
           e.preventDefault();
           let pageNum = $("input[name='pageNum']").val();
           let searchType = $("input[name='searchType']").val();
           let keyword = $("input[name='keyword']").val();
           window.location.href = '/board?pageNum=' + pageNum + '&searchType=' + searchType + '&keyword=' + keyword;
        });

        $(".btn-delete").on("click", function (e) {
           e.preventDefault();
           if (confirm("게시글을 삭제하시겠습니까?")) {
               deleteBoard();
           }
        });
    }

    //게시글 삭제
    function deleteBoard() {
        $.ajax({
            url: `/board/${board.id}`,
            method: 'delete',
            success: function (response) {
                if (response.success) {
                    alert(response.message);
                    pageForm.attr('action', '/board');
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
                if (xhr.status === 500) {
                    alert(errorMessage);
                }
            }
        })
    }

    //댓글 데이터 불러오기
    function loadCommentList() {
        $.ajax({
           url: `/comment/${board.id}`,
           method: 'get',
           success: function (response) {
               if (response.success) {
                   loadCommentHTML(response.data);
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
               if (xhr.status === 404) {
                   alert(errorMessage);
               } else if (xhr.status === 500) {
                   alert(errorMessage);
               }
           }
        });
    }

    //댓글 HTML VIEW
    function loadCommentHTML(data) {
        let str = '';
        $.each(data, function (i, value) {
            str += `<div class="comment-item" data-comment-id=\${value.id}>
                        <div class="comment-header">
                            <div>
                                <span class="comment-author">\${value.regUserName}</span>
                                <span class="comment-date">\${formatDate(value.regDate)}</span>
                            </div>
                            <div class="comment-actions">
                                <button class="comment-edit-btn">수정</button>
                                <button class="comment-delete-btn">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">\${value.content}</div>
                    </div>`;
        });
        $(".comment-list").html(str);
    }

    $(function () {
       addButtonEvent();
       loadCommentList();
    });
</script>
</html>
