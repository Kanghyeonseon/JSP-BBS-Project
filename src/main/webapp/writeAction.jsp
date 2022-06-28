<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO" %>
<%@page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

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
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해 주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			
			if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(),userID, bbs.getBbsContent());
				if(result ==-1){
					// -1 리턴값은 데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}
		
		
	
	%>


</body>
</html>