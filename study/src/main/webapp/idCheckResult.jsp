<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>계정 중복 확인</title>
</head>
<body>
<h2 align="center">계정 중복 확인</h2>
<%
    String id = (String) request.getAttribute("ID");
    String dup = (String) request.getAttribute("DUP");
%>
<form action="idCheck.do">
    계정: <input type="text" name="userId" value="<%= id %>">
    <input type="submit" value="중복검사">
</form>
<%
    if ("YES".equals(dup)) {
%>
<p><%= id %>는 사용 중입니다.</p>
<script type="text/javascript">
    opener.document.frm.userId.value = ""; // 사용 불가 시 초기화
    opener.document.getElementById("idChecked").value = "no";
</script>
<%
    } else {
%>
<p><%= id %>는 사용 가능합니다.</p>
<input type="button" value="사용" onclick="idOk('<%= id %>')">
<%
    }
%>
<script type="text/javascript">
function idOk(userId) {
    opener.document.frm.userId.value = userId;
    opener.document.frm.userId.readOnly = true; // 편집 불가
    opener.document.getElementById("idChecked").value = "yes";
    self.close();
}
</script>
</body>
</html>
