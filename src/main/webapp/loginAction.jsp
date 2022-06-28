<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 만들었던 DAO를 사용해야한다. -->
<%@page import="user.UserDAO" %>
<!-- 자바스크립트 문장을 사용하기위해 쓴다. -->
<%@page import="java.io.PrintWriter" %>
<!-- 건너오는 데이터를 모두 UTF8로 받을 수 있도록 한다. -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 유저 클래스를 자바빈즈로 사용한다. scope:현재 페이지 내에서만사용할 수 있게 한다. -->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- 유저 아이디와 비밀번호를 불러온다. -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP게시판 웹사이트</title>
</head>
<body>
	<%
		// 로그인 한 유저는 로그인과 회원가입 페이지에 들어갈 수 없도록 한다.
		String userID = null;
		// userID라는 세션이 존재한다면..
		if(session.getAttribute("userID") != null) {
			// userID라는 변수가 세션정보를 할당할 수 있도록 한다.
			userID = (String) session.getAttribute("userID");
		}
		// userID 정보가 존재한다면..
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result ==1){
			// 로그인이 성공했을 때
			session.setAttribute("userID", user.getUserID());
			// session값으로 userID라는 변수를 쓸건데, 그 변수에 해당하는 값으로는 getUserID로 값을 받아올거임.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result==-1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(result==-2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	%>


</body>
</html>