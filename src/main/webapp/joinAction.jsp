<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<%@page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!-- 원래 userID와 userPassword만 받았었는데 더 추가해준다. -->
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
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
		
		
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null || user.getUserGender()==null || user.getUserEmail()==null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result ==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				// 회원가입이 성공했을 때
				session.setAttribute("userID", user.getUserID());
				// session값으로 userID라는 변수를 쓸건데, 그 변수에 해당하는 값으로는 getUserID로 값을 받아올거임.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			
		}
	
	%>


</body>
</html>