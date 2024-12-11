<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="post.PostDTO" %>
<%
PostDTO post = (PostDTO)request.getAttribute("post");
if(post == null) {
    response.sendRedirect("postList.do");
    return;
}
String loginId = (String)session.getAttribute("ID");
if(loginId == null || !loginId.equals(post.getAuthor())) {
    response.sendRedirect("postList.do");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 수정</title>
<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 800px;
        margin: 20px auto;
        background: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        margin-bottom: 20px;
    }
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }
    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    textarea {
        height: 300px;
        resize: vertical;
    }
    .buttons {
        text-align: center;
        margin-top: 20px;
    }
    .buttons button {
        padding: 10px 20px;
        margin: 0 5px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .submit {
        background-color: #007bff;
        color: white;
    }
    .cancel {
        background-color: #6c757d;
        color: white;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>게시글 수정</h2>
        <form action="updatePost.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
            <input type="hidden" name="category" value="<%= post.getCategory() %>">
            
            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="<%= post.getTitle() %>" required>
            
            <label for="content">내용</label>
            <textarea id="content" name="content" required><%= post.getContent() %></textarea>
            
            <% if(post.getFilePath() != null && !post.getFilePath().isEmpty()) { %>
                <div>
                    <p>현재 파일: <%= post.getFilePath() %></p>
                    <label>
                        <input type="checkbox" name="deleteFile" value="true"> 파일 삭제
                    </label>
                </div>
            <% } %>
            
            <label for="file">새 파일 첨부</label>
            <input type="file" id="file" name="file">
            
            <div class="buttons">
                <button type="submit" class="submit">수정완료</button>
                <button type="button" class="cancel" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>
</body>
</html>