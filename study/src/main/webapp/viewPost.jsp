<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="post.PostDTO" %>
<%@ page import="comment.CommentDTO" %>
<%@ page import="java.util.List" %>
<%
PostDTO post = (PostDTO)request.getAttribute("post");
if(post == null) {
    response.sendRedirect("postList.do");
    return;
}
String loginId = (String)session.getAttribute("ID");

// ��� ��� �޽��� ó��
String commentMsg = (String) session.getAttribute("COMMENT_MESSAGE");
if(commentMsg != null && commentMsg.equals("success")) {
%>
<script>
    alert("����� ��ϵǾ����ϴ�.");
</script>
<%
    session.removeAttribute("COMMENT_MESSAGE");
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title><%= post.getTitle() %></title>
<style>
    /* �⺻ ��Ÿ�� */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }

    /* ��� ��Ÿ�� */
    header {
        background-color: #232323;
        color: white;
        padding: 20px 0;
        text-align: center;
        position: relative;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    header .title {
        font-size: 32px;
        font-weight: bold;
    }

    /* �α���/�α׾ƿ� ���� */
    .login-section {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 14px;
    }

    .login-section input[type="text"],
    .login-section input[type="password"] {
        padding: 6px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-right: 5px;
    }

    .login-section button {
        background-color: #3498db;
        border: none;
        color: white;
        padding: 6px 12px;
        cursor: pointer;
        border-radius: 4px;
    }

    .login-section button.signup-button {
        background-color: #2ecc71;
    }

    .login-section button:hover {
        opacity: 0.8;
    }

    /* �޴� ���̺� */
    .menu-table {
        margin: 20px auto;
        text-align: center;
        max-width: 1000px;
        border-collapse: collapse;
        background-color: #fff;
    }

    .menu-table td {
        padding: 15px;
        font-size: 18px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .menu-table td:hover {
        background-color: #f1f1f1;
    }

    /* �Խñ� �����̳� */
    .post-container {
        max-width: 1000px;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    /* �Խñ� ��� */
    .post-header {
        border-bottom: 2px solid #eee;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }

    .post-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .post-info {
        color: #666;
        display: flex;
        justify-content: space-between;
        font-size: 14px;
    }

    /* �Խñ� ���� */
    .post-content {
        min-height: 200px;
        margin: 30px 0;
        line-height: 1.6;
        word-break: break-all;
    }

    /* ��ư �׷� */
    .button-group {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin: 20px 0;
    }

    .button-group button {
        padding: 8px 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        background-color: #f8f9fa;
        transition: all 0.2s;
    }

    .button-group .like-button {
        background-color: #3498db;
        color: white;
    }

    .button-group button:hover {
        opacity: 0.8;
    }

    /* ��� ���� */
    .comment-section {
        margin-top: 40px;
        border-top: 2px solid #eee;
        padding-top: 20px;
    }

    .comment-form textarea {
        width: calc(100% - 20px); /* �θ� ��� �ʺ񿡼� ������ �� ũ�� */
	    height: 80px;
	    padding: 10px;
	    margin-bottom: 10px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    resize: vertical;
	    box-sizing: border-box; /* �е��� ������ �ʺ� ��꿡 ���� */
    }

    .comment-list {
        margin-top: 30px;
    }

    .comment-item {
        padding: 15px;
        background-color: #f8f9fa;
        border-radius: 4px;
        margin-bottom: 10px;
    }

    .comment-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        color: #666;
        font-size: 14px;
    }

    .comment-author {
        font-weight: bold;
        color: #333;
    }

    .comment-date {
        color: #888;
    }

    .comment-content {
        margin: 10px 0;
        line-height: 1.5;
    }

    .comment-actions {
        text-align: right;
        margin-top: 10px;
    }

    .comment-delete-btn {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 4px 8px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
    }

    .comment-delete-btn:hover {
        background-color: #c82333;
    }

    /* ���� �̹��� */
    .post-image {
        max-width: 100%;
        margin: 15px 0;
        border-radius: 4px;
    }
</style>
</head>
<body>
    <header>
        <a href="index.jsp" style="text-decoration: none; color: white;">
            <div class="title">�����Խ���</div>
        </a>
        <div class="login-section">
        <%
            if (loginId == null) {
         %>
            <form action="login.do" method="post">
                <input type="text" name="ID" placeholder="���̵�" required>
                <input type="password" name="PWD" placeholder="��й�ȣ" required>
                <button type="submit">�α���</button>
                <a href="register.jsp"><button type="button" class="signup-button">ȸ������</button></a>
            </form>
        <%
            } else {
        %>
            <span><b><%= loginId %></b>��</span>
            <a href="logout.do"><button type="button" class="logout-button">�α׾ƿ�</button></a>
        <% } %>
        </div>
    </header>

    <section>
        <table class="menu-table">
            <tr>
                <td onclick="location.href='postList.do?category=notice_post'">��������</td>
                <td onclick="location.href='postList.do?category=free_post'">�����Խ���</td>
                <td onclick="location.href='postList.do?category=secret_post'">��аԽ���</td>
                <td onclick="location.href='postList.do?category=game_post'">���ӰԽ���</td>
            </tr>
        </table>

        <div class="post-container">
            <div class="post-header">
                <div class="post-title"><%= post.getTitle() %></div>
                <div class="post-info">
                    <span>�ۼ���: <%= post.getAuthor() %></span>
                    <span>�ۼ���: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(post.getCreatedAt()) %></span>
                    <span>��ȸ��: <%= post.getViewCount() %></span>
                    <span class="like-count">��õ��: <%= post.getLikes() %></span>
                </div>
            </div>

            <div class="post-content">
                <%= post.getContent().replace("\n", "<br>") %>
                <% if(post.getFilePath() != null && !post.getFilePath().isEmpty()) { %>
                    <img src="upload/<%= post.getFilePath() %>" class="post-image" alt="÷�� �̹���">
                <% } %>
            </div>

            <div class="button-group">
                <button type="button" onclick="likePost()" class="like-button">��õ</button>
                <% if(loginId != null && loginId.equals(post.getAuthor())) { %>
				    <button type="button" onclick="location.href='editPost.do?category=<%= post.getCategory() %>&postId=<%= post.getPostId() %>'" class="button">����</button>
				    <button type="button" onclick="deletePost()" class="button">����</button>
				<% } %>
                <button type="button" onclick="location.href='postList.do?category=<%= post.getCategory() %>'" class="button">���</button>
            </div>

            <!-- ��� ���� -->
            <div class="comment-section">
                <% if(loginId != null) { %>
                    <form class="comment-form" action="addComment.do" method="post">
                        <input type="hidden" name="postId" value="<%= post.getPostId() %>">
                        <input type="hidden" name="category" value="<%= post.getCategory() %>">
                        <textarea name="content" class="comment-input" placeholder="����� �Է��ϼ���" required></textarea>
                        <button type="submit" class="button">��� �ۼ�</button>
                    </form>
                <% } %>

                <div class="comment-list">
                    <% 
                        List<CommentDTO> comments = (List<CommentDTO>)request.getAttribute("comments");
                        if(comments != null && !comments.isEmpty()) {
                            for(CommentDTO comment : comments) {
                    %>
                        <div class="comment-item">
                            <div class="comment-header">
                                <span class="comment-author"><%= comment.getAuthor() %></span>
                                <span class="comment-date">
                                    <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(comment.getCreatedAt()) %>
                                </span>
                            </div>
                            <div class="comment-content">
                                <%= comment.getContent().replace("\n", "<br>") %>
                            </div>
                            <% if(loginId != null && loginId.equals(comment.getAuthor())) { %>
                                <div class="comment-actions">
                                    <button onclick="deleteComment(<%= comment.getCommentId() %>)" 
                                            class="comment-delete-btn">����</button>
                                </div>
                            <% } %>
                        </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </section>

    <script>
    function likePost() {
        <% if(loginId == null) { %>
            alert("�α����� �ʿ��մϴ�.");
            return;
        <% } %>
        fetch('likePost.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'postId=<%= post.getPostId() %>&category=<%= post.getCategory() %>'
        })
        .then(response => {
            if(response.redirected) {
                window.location.href = response.url;
            } else {
                return response.json();
            }
        })
        .then(data => {
            if(data && data.success) {
                document.querySelector('.like-count').textContent = '��õ��: ' + data.likes;
                alert('��õ�Ǿ����ϴ�.');
            } else if(data) {
                alert(data.message || '�̹� ��õ�� �Խñ��Դϴ�.');
            }
        });
    }

    function deletePost() {
        if(confirm('���� �����Ͻðڽ��ϱ�?')) {
            location.href = 'deletePost.do?postId=<%= post.getPostId() %>&category=<%= post.getCategory() %>';
        }
    }

    function deleteComment(commentId) {
        if(confirm('����� �����Ͻðڽ��ϱ�?')) {
            location.href = 'deleteComment.do?commentId=' + commentId + 
                          '&postId=<%= post.getPostId() %>&category=<%= post.getCategory() %>';
        }
    }
    </script>
</body>
</html>