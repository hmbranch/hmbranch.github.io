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
<title>�Խñ� ����</title>
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
        <h2>�Խñ� ����</h2>
        <form action="updatePost.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="postId" value="<%= post.getPostId() %>">
            <input type="hidden" name="category" value="<%= post.getCategory() %>">
            
            <label for="title">����</label>
            <input type="text" id="title" name="title" value="<%= post.getTitle() %>" required>
            
            <label for="content">����</label>
            <textarea id="content" name="content" required><%= post.getContent() %></textarea>
            
            <% if(post.getFilePath() != null && !post.getFilePath().isEmpty()) { %>
                <div>
                    <p>���� ����: <%= post.getFilePath() %></p>
                    <label>
                        <input type="checkbox" name="deleteFile" value="true"> ���� ����
                    </label>
                </div>
            <% } %>
            
            <label for="file">�� ���� ÷��</label>
            <input type="file" id="file" name="file">
            
            <div class="buttons">
                <button type="submit" class="submit">�����Ϸ�</button>
                <button type="button" class="cancel" onclick="history.back()">���</button>
            </div>
        </form>
    </div>
</body>
</html>