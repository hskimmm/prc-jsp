<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2026-01-03
  Time: 오후 4:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>목록</title>
    <link rel="stylesheet" href="/css/board.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container" id="list-page">
    <h1>게시판</h1>
    <div class="search-box">
        <select name="searchType">
            <option value="title">제목</option>
            <option value="content">내용</option>
            <option value="writer">작성자</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어를 입력하세요">
        <button type="button">검색</button>
    </div>

    <table>
        <thead>
        <tr>
            <th class="text-center" style="width: 10%">번호</th>
            <th style="width: 40%">제목</th>
            <th class="text-center" style="width: 15%">작성자</th>
            <th class="text-center" style="width: 15%">작성일</th>
            <th class="text-center" style="width: 10%">조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="list" items="${boardList}">
        <tr>
            <td class="text-center">${list.id}</td>
            <td><a href="<c:url value='/board/${list.id}'/>" class="post-title">${list.title}</a></td>
            <td class="text-center">${list.regUserName}</td>
            <td class="text-center">${list.regDate.toString().substring(0, 16).replace('T', ' ')}</td>
            <td class="text-center">${list.viewCount}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <a href="#">&laquo;</a>
        <a href="#">1</a>
        <span class="active">2</span>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">&raquo;</a>
    </div>

    <div class="btn-group">
        <a href="#" class="btn btn-primary btn-write">글쓰기</a>
    </div>
</div>
</body>
<script>
    function addButtonEvent() {
        $(".btn-write").on("click", function (e) {
           e.preventDefault();
           window.location.href = '/board/write';
        });
    }

    $(function (){
        addButtonEvent();
    });
</script>
</html>
