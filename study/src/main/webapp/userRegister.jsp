<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String result = request.getParameter("R");
	if(result != null) {
	    if(result.equals("YES")){
%>
<script type="text/javascript">
	setTimeout(function(){alert("가입되었습니다");}, 100);//시간 지연 함수 0.1초 딜레이
</script>
<%
	    } else if(result.equals("NO")){
%>
<script type="text/javascript">
	alert("가입되지 않았습니다. 관리자에게 문의바랍니다.");
</script>
<% 
	    }
	}
%>
</body>
</html>
