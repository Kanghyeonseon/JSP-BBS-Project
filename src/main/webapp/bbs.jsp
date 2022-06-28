<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<!-- 반응형 웹에 사용하는 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<meta charset="EUC-KR">
<title>JSP게시판 웹사이트</title>
<style type="text/css">
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}


</style>
</head>
<body>
	<!-- 로그인이 된 사람들은 로그인 정보를 담을 수 있게 한다. -->
	<%
	 	String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		// 페이지 번호를 처음에 1로 정의한다. 기본페이지.
		int pageNumber = 1;
		// 만약에 parameter로 페이지 번호가 넘어왔다면 그 parameter를 넣어준다.
		if(request.getParameter("pageNumber")!=null) {
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
			data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			/* 로그인이 되어있지 않을 때만 접속하기 탭이 표시되도록한다. */
			if(userID==null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role="button" aria-haspopup="true" 
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>			
			</ul>
			<%
			/* 로그인이되어있는사람들은 접속하기 대신 회원관리가 나타난다. */
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role="button" aria-haspopup="true" 
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>			
			</ul>
			
			<%
			}
			%>
			
		</div>
	</nav>
	
	<!-- 게시판을 보여주기위한 테이블 추가 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						// 글을 뽑아올 수 있도록 인스턴스 추가
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						//현재 페이지에서 가져온 리스트를 의미한다.
						for(int i=0; i<list.size(); i++) {
							%>
								<tr>
									<td><%=list.get(i).getBbsID() %></td>
									<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt").replaceAll("\n","<br>") %></a></td>
									<td><%=list.get(i).getUserID() %></td>
									<td><%=list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
								</tr>
							<%
						}
					%>
				</tbody>
			</table>
			<%
				//페이지 번호가 1이 아니라면 이전페이지로 돌아가는 버튼이 무조건 있어야함.
				if (pageNumber!=1) {
			%>
					<a href="bbs.jsp?pageNumber<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				// 다음 페이지가 존재한다면 다음페이지론 넘어가는 버튼이 있어야함
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>