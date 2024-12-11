<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
    String loginId = (String) session.getAttribute("ID");
    
    // 로그인 체크
    if(loginId == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 공지사항 작성 권한 체크
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
    <title>게시글 작성</title>
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
        <h2>게시글 작성</h2>
        <form action="writePost.do" method="post" enctype="multipart/form-data">
            <!-- 카테고리 선택 -->
            <label for="category">카테고리</label>
            <select name="category" id="category" required>
			    <option value="">-- 게시판 선택 --</option>
			    <% if("admin".equals(loginId)) { %>
			        <option value="notice_post">공지사항</option>
			    <% } %>
			    <option value="free_post">자유게시판</option>
			    <option value="secret_post">비밀게시판</option>
			    <option value="game_post">게임게시판</option>
			</select>

            <!-- 제목 입력 -->
            <label for="title">제목</label>
            <input type="text" name="title" id="title" placeholder="제목을 입력하세요" required>

            <!-- 본문 작성 -->
            <label for="content">내용</label>
            <textarea name="content" id="content" rows="10" placeholder="본문 내용을 입력하세요" required></textarea>

            <!-- 파일 첨부 -->
            <div class="file-input">
                <label for="file">파일 첨부</label>
                <input type="file" name="file" id="file">
            </div>

            <!-- 등록/취소 버튼 -->
            <div class="buttons">
                <button type="submit" class="submit">등록</button>
                <button type="button" class="cancel" onclick="window.history.back();">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
