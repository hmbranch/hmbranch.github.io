<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �ߺ� Ȯ��</title>
</head>
<body>
<h2 align="center">���� �ߺ� Ȯ��</h2>
<%
    String id = (String) request.getAttribute("ID");
    String dup = (String) request.getAttribute("DUP");
%>
<form action="idCheck.do">
    ����: <input type="text" name="userId" value="<%= id %>">
    <input type="submit" value="�ߺ��˻�">
</form>
<%
    if ("YES".equals(dup)) {
%>
<p><%= id %>�� ��� ���Դϴ�.</p>
<script type="text/javascript">
    opener.document.frm.userId.value = ""; // ��� �Ұ� �� �ʱ�ȭ
    opener.document.getElementById("idChecked").value = "no";
</script>
<%
    } else {
%>
<p><%= id %>�� ��� �����մϴ�.</p>
<input type="button" value="���" onclick="idOk('<%= id %>')">
<%
    }
%>
<script type="text/javascript">
function idOk(userId) {
    opener.document.frm.userId.value = userId;
    opener.document.frm.userId.readOnly = true; // ���� �Ұ�
    opener.document.getElementById("idChecked").value = "yes";
    self.close();
}
</script>
</body>
</html>
