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
<div class="container" id="detail-page" style="display: none;">
    <h1>게시글 상세보기</h1>

    <div class="post-detail">
        <div class="post-header">
            <h2>게시글 제목이 여기에 표시됩니다</h2>
            <div class="post-meta">
                <span>작성자: 홍길동</span>
                <span>작성일: 2024-01-15</span>
                <span>조회수: 123</span>
            </div>
        </div>

        <!-- 첨부파일 -->
        <div class="attached-files">
            <h4>📎 첨부파일</h4>
            <a href="#" class="file-download">
                <span class="file-icon">📄</span>
                문서파일.pdf
            </a>
            <a href="#" class="file-download">
                <span class="file-icon">🖼️</span>
                이미지.jpg
            </a>
        </div>

        <div class="post-content">
            게시글 내용이 여기에 표시됩니다.
        </div>

        <div class="post-footer">
            <div class="btn-group">
                <a href="#" class="btn btn-secondary">목록</a>
                <a href="#" class="btn btn-success">수정</a>
                <button type="button" class="btn btn-danger">삭제</button>
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
</html>
