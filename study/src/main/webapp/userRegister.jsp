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
	setTimeout(function(){alert("���ԵǾ����ϴ�");}, 100);//�ð� ���� �Լ� 0.1�� ������
</script>
<%
	    } else if(result.equals("NO")){
%>
<script type="text/javascript">
	alert("���Ե��� �ʾҽ��ϴ�. �����ڿ��� ���ǹٶ��ϴ�.");
</script>
<% 
	    }
	}
%>
</body>
</html>
