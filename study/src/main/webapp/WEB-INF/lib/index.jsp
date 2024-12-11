<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="post.*" %>
<%
    // 캐시 컨트롤
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>자유게시판</title>
<style>
    /* 기본 스타일 */
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 0;
    }

    /* 헤더 */
    header {
        background-color: #232323;
        color: white;
        padding: 20px 0;
        text-align: center;
        position: relative;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    header .logo {
        font-size: 36px;
        font-weight: bold;
        letter-spacing: -1px;
    }

    /* 로그인 / 로그아웃 영역 */
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

    /* 메뉴 테이블 */
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

    /* 게시글 리스트 테이블 */
    .board-table {
        margin: 20px auto;
        max-width: 1000px;
        text-align: center;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .board-table th,
    .board-table td {
        padding: 12px;
        font-size: 16px;
        border: 1px solid #ddd;
    }

    .board-table th {
        background-color: #f4f4f4;
        font-weight: bold;
    }

    .board-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .board-table tr:hover {
        background-color: #f1f1f1;
    }

    /* 페이징 */
    .paging {
        text-align: center;
        margin-top: 20px;
    }

    .paging a {
        margin: 0 5px;
        padding: 6px 12px;
        background-color: #3498db;
        color: white;
        border-radius: 4px;
        text-decoration: none;
    }

    .paging a:hover {
        background-color: #2980b9;
    }

    .paging strong {
        font-weight: bold;
        color: #3498db;
    }

    /* 글쓰기 버튼 */
    .write-button {
        margin: 20px auto;
        text-align: right;
        max-width: 1000px;
    }

    .write-button button {
        background-color: #2ecc71;
        padding: 10px 20px;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .write-button button:hover {
        opacity: 0.8;
    }
</style>
</head>
<body>

    <%
        String loginmsg = (String) session.getAttribute("LOGIN_MESSAGE");
        String logoutmsg = (String) session.getAttribute("LOGOUT_MESSAGE");

        if (loginmsg != null || logoutmsg != null) {
    %>
    <script>
        <% if (loginmsg != null && loginmsg.equals("success")) { %>
            alert("로그인 성공!");
        <% } else if (loginmsg != null && loginmsg.equals("failure")) { %>
            alert("로그인 실패! 아이디와 비밀번호를 확인해주세요.");
        <% } else if (logoutmsg != null && logoutmsg.equals("logout")) { %>
            alert("로그아웃 되었습니다.");
        <% } %>
    </script>
    <%
            // 메시지 처리 후 세션에서 해당 메시지를 제거하여 새로고침 시 알림창이 반복되지 않게 함
            session.removeAttribute("LOGIN_MESSAGE");
            session.removeAttribute("LOGOUT_MESSAGE");
        }
    %>
    <header>
     <a href="index.jsp" style="text-decoration: none; color: white;">
        <div class="title">자유게시판</div>
     </a>
        <div class="login-section">
        <%
            // 세션에서 ID 가져오기
            String id = (String) session.getAttribute("ID");
            if (id == null) {
         %>
        <form action="login.do" method="post">
            <input type="text" name="ID" placeholder="아이디" required>
            <input type="password" name="PWD" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
            <a href="register.jsp"><button type="button" class="signup-button">회원가입</button></a>
        </form>
        <%
            } else {
        %>
        <span><b><%= id %></b>님</span>
        <a href="logout.do"><button type="submit" class="logout-button">로그아웃</button></a>
        <% } %>
        </div>
    </header>
    <section>
    <table class="menu-table">
        <tr>
            <td onclick="location.href='postList.do?category=notice_post'">공지사항</td>
            <td onclick="location.href='postList.do?category=free_post'">자유게시판</td>
            <td onclick="location.href='postList.do?category=secret_post'">비밀게시판</td>
            <td onclick="location.href='postList.do?category=game_post'">게임게시판</td>
        </tr>
    </table>
     <%
            String body = request.getParameter("BODY");
            if (body != null) {
        %>
        <jsp:include page="<%= body %>" />
        <%
            }
        %>
       <!-- 검색 폼 -->
<div style="text-align: right; margin: 20px auto; max-width: 800px;">
    <form action="postList.do" method="get">
        <input type="hidden" name="category" value="<%= request.getAttribute("category") %>">
        <select name="searchType">
            <option value="title">제목</option>
            <option value="popular">인기글</option>
        </select>
        <input type="text" name="searchKeyword">
        <button type="submit">검색</button>
    </form>
</div>

<!-- 게시글 리스트 테이블 -->
<table class="board-table">
    <thead>
        <tr>
            <th>번호</th>
            <th width="400">제목</th>
            <th>글쓴이</th>
            <th>등록일</th>
            <th>추천</th>
            <th>조회수</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<PostDTO> postList = (List<PostDTO>)request.getAttribute("postList");
            if(postList != null) {
                for(PostDTO post : postList) {
        %>
            <tr>
                <td><%= post.getPostId() %></td>
                <td>
    			<a href="viewPost.do?category=<%= post.getCategory() %>&postId=<%= post.getPostId() %>">
        		<%= post.getTitle() %>
    			</a>
			</td>
                <td><%= post.getAuthor() %></td>
                <td> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(post.getCreatedAt()) %></td>
                <td><%= post.getLikes() %></td>
                <td><%= post.getViewCount() %></td>
            </tr>
        <%
                }
            }
        %>
    </tbody>
</table>
	<% if (id != null){ %>
    <div style="text-align: right; margin-bottom: 10px; margin-right: 10px;">
            <a href="write.jsp"><button>글쓰기</button></a>
    </div>
    <%} %>

<!-- 페이징 -->
<div style="text-align: center; margin-top: 20px;">
    <%
        Integer currentPageObj = (Integer)request.getAttribute("currentPage");
        Integer totalPagesObj = (Integer)request.getAttribute("totalPages");
        Integer startPageObj = (Integer)request.getAttribute("startPage");
        Integer endPageObj = (Integer)request.getAttribute("endPage");
        
        if(currentPageObj != null && totalPagesObj != null && 
           startPageObj != null && endPageObj != null) {
            int currentPage = currentPageObj.intValue();
            int totalPages = totalPagesObj.intValue();
            int startPage = startPageObj.intValue();
            int endPage = endPageObj.intValue();
            
            String category = (String)request.getAttribute("category");
            String searchType = (String)request.getAttribute("searchType");
            String searchKeyword = (String)request.getAttribute("searchKeyword");
            
            if(category == null) category = "notice_post";
            if(searchType == null) searchType = "";
            if(searchKeyword == null) searchKeyword = "";
            
            // 이전 10페이지
            if(startPage > 1) {
    %>
            <a href="postList.do?category=<%= category %>&page=<%= startPage-1 %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>">이전</a>
    <%
            }
            
            // 페이지 번호
            for(int i = startPage; i <= endPage; i++) {
                if(i == currentPage) {
    %>
                    <strong><%= i %></strong>
    <%
                } else {
    %>
                    <a href="postList.do?category=<%= category %>&page=<%= i %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>"><%= i %></a>
    <%
                }
            }
            
            // 다음 10페이지
            if(endPage < totalPages) {
    %>
            <a href="postList.do?category=<%= category %>&page=<%= endPage+1 %>&searchType=<%= searchType %>&searchKeyword=<%= searchKeyword %>">다음</a>
    <%
            }
        }
    %>
</div>
    </section>
</body>
</html>
