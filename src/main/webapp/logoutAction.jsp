<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%@page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP게시판 웹사이트</title>
</head>
<body>
	<%
		session.invalidate();
		// 현재 페이지에 접속 한 회원이 세션을 잃어버리도록한다(userID정보가 없어짐)
	%>
		<!-- 세션을 잃어버린 뒤에는 메인페이지로 돌아가게 한다. -->
		<script>
			location.href = 'main.jsp';		
		</script>
</body>
</html>