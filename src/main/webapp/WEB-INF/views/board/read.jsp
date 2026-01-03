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
        <div class="comment-list">
            <div class="comment-item">
                <div class="comment-header">
                    <div>
                        <span class="comment-author">김철수</span>
                        <span class="comment-date">2024-01-15 10:30</span>
                    </div>
                    <div class="comment-actions">
                        <button class="comment-edit-btn">수정</button>
                        <button class="comment-delete-btn">삭제</button>
                    </div>
                </div>
                <div class="comment-content">
                    좋은 정보 감사합니다!
                </div>
            </div>

            <div class="comment-item">
                <div class="comment-header">
                    <div>
                        <span class="comment-author">이영희</span>
                        <span class="comment-date">2024-01-15 11:20</span>
                    </div>
                    <div class="comment-actions">
                        <button class="comment-edit-btn">수정</button>
                        <button class="comment-delete-btn">삭제</button>
                    </div>
                </div>
                <div class="comment-content">
                    도움이 많이 되었습니다.
                </div>
            </div>

            <div class="comment-item">
                <div class="comment-header">
                    <div>
                        <span class="comment-author">박민수</span>
                        <span class="comment-date">2024-01-15 14:15</span>
                    </div>
                    <div class="comment-actions">
                        <button class="comment-edit-btn">수정</button>
                        <button class="comment-delete-btn">삭제</button>
                    </div>
                </div>
                <div class="comment-content">
                    추가 질문이 있는데, 이 부분은 어떻게 처리하면 될까요?
                </div>

                <div class="comment-reply">
                    <div class="comment-item">
                        <div class="comment-header">
                            <div>
                                <span class="comment-author">홍길동</span>
                                <span class="comment-date">2024-01-15 15:00</span>
                            </div>
                            <div class="comment-actions">
                                <button class="comment-edit-btn">수정</button>
                                <button class="comment-delete-btn">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            ↳ 그 부분은 다음과 같이 처리하시면 됩니다.
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

    $(function () {
       addButtonEvent();
    });
</script>
</html>
