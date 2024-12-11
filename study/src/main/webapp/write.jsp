<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    String loginId = (String) session.getAttribute("ID");
    
    // �α��� üũ
    if(loginId == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // �������� �ۼ� ���� üũ
    String selectedCategory = request.getParameter("category");
    if(selectedCategory != null && "notice_post".equals(selectedCategory) && !"admin".equals(loginId)) {
        response.sendRedirect("postList.do");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>�Խñ� �ۼ�</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
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
        input[type="text"], textarea, select {
		    width: calc(100% - 20px);
		    padding: 10px;
		    margin-bottom: 20px;
		    margin-right: 20px; 
		    border: 1px solid #ccc;
		    border-radius: 4px;
		}
        .file-input {
            margin-bottom: 20px;
        }
        .buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        .buttons .submit {
            background-color: #007bff;
            color: white;
        }
        .buttons .cancel {
            background-color: #dc3545;
            color: white;
        }
        .buttons button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>�Խñ� �ۼ�</h2>
        <form action="writePost.do" method="post" enctype="multipart/form-data">
            <!-- ī�װ� ���� -->
            <label for="category">ī�װ�</label>
            <select name="category" id="category" required>
			    <option value="">-- �Խ��� ���� --</option>
			    <% if("admin".equals(loginId)) { %>
			        <option value="notice_post">��������</option>
			    <% } %>
			    <option value="free_post">�����Խ���</option>
			    <option value="secret_post">��аԽ���</option>
			    <option value="game_post">���ӰԽ���</option>
			</select>

            <!-- ���� �Է� -->
            <label for="title">����</label>
            <input type="text" name="title" id="title" placeholder="������ �Է��ϼ���" required>

            <!-- ���� �ۼ� -->
            <label for="content">����</label>
            <textarea name="content" id="content" rows="10" placeholder="���� ������ �Է��ϼ���" required></textarea>

            <!-- ���� ÷�� -->
            <div class="file-input">
                <label for="file">���� ÷��</label>
                <input type="file" name="file" id="file">
            </div>

            <!-- ���/��� ��ư -->
            <div class="buttons">
                <button type="submit" class="submit">���</button>
                <button type="button" class="cancel" onclick="window.history.back();">���</button>
            </div>
        </form>
    </div>
</body>
</html>
