<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 이 import는 스크립트 문장을 실행할 수 있도록한다. -->
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<!-- 반응형 웹에 사용하는 메타태그 -->
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<meta charset="EUC-KR">
<title>JSP게시판 웹사이트</title>
</head>
<body>
	<!-- 로그인이 된 사람들은 로그인 정보를 담을 수 있게 한다. -->
	<%
	 	String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
			/* 로그인이 되어있지 않을 때만 접속하기 탭이 표시되도록한다. */
			if(userID==null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			/* 로그인이되어있는사람들은 접속하기 대신 회원관리가 나타난다. */
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

			<%
			}
			%>

		</div>
	</nav>

	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹사이트 소개</h1>
				<p>이 사이트는 부트스트랩으로 만든 JSP 웹 사이트입니다. 최소한의 로직만을 이용해서 개발했습니다. 디자인 탬플릿으로는 부트스트랩4를 다운받아 사용했습니다.</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>

	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active">
				<li data-target="#myCarousel" data-slide-to="1">
				<li data-target="#myCarousel" data-slide-to="2">
				<li data-target="#myCarousel" data-slide-to="3">
			</ol>
			<div class="carouselinner">
				<div class="item active">
					<img src="images/img1.jpg">
				</div>
				<div class="item">
					<img src="images/img2.jpg">
				</div>
				<div class="item">
					<img src="images/img3.jpg">
				</div>
				<div class="item">
					<img src="images/img4.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphiicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphiicon-chevron-right"></span>
			</a>
		</div>
	
	</div>



	<!-- 애니메이션을 넣어주기 위해서 부트스랩의 기본 라이브러리를 사용했다. 첫째줄은 jquery를 불러온다. -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>