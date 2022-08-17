<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${not empty alertMsg}">
		<script>
			alert('${alertMsg}');
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
	
    <!-- nav 태그에 나중에 자바스크립트로 close 클래스 추가해준다 (열고닫고 할 수 있게) -->
	<nav>
		<div class="logo-name">
			<div class="logo-image">
				<img src="${pageContext.request.contextPath}/resources/img/web_logo.jpg" alt="peach">
			</div>
			
			<span class="logo_name">SoMoMo</span>
		</div>
		
		<div class="menu-items">
			<ul class="nav-links">
				<li>
					<a href="main.fd">
						<i class="uil uil-estate"></i>
						<span class="link-name">HOME</span>
					</a>
				</li>
				<li>
					<a href="chat">
						<i class="uil uil-comment"></i>
						<span class="link-name">CHAT</span>
					</a>
				</li>
				<li>
					<a href="#">
						<i class="uil uil-user"></i>
						<span class="link-name">My Page</span>
					</a>
				</li>
           		
				<!-- 나중에 margin으로 조절-->
				<br><br><br><br>
				
				<li>
					<a href="groupRoom.gr" class="community">
						<i class="uil uil-comments"></i>
						<span class="link-name">Community</span>
					</a>
				</li>
				
				<!-- 커뮤니티 이름 나타내기 -->
				<li>
					<a href="#" class="">
						<img src="${pageContext.request.contextPath}/resources/img/test1.jpg">
						<span class="community-name">서핑</span>
					</a>
				</li>
				
				<li>
					<a href="#" class="">
						<img src="${pageContext.request.contextPath}/resources/img/test2.jpg">
						<span class="community-name">유적 탐사</span>
					</a>
				</li>
				
				<li>
					<a href="#" class="">
						<img src="${pageContext.request.contextPath}/resources/img/test3.jpg">
						<span class="community-name">자동차</span>
					</a>
				</li>
			</ul>
		
			<ul class="logout-mode">
				<li>
					<a href="logout.me">
						<i class="uil uil-signout"></i>
						<span class="link-name">Logout</span>
					</a>
				</li>
			</ul>
		</div>
	</nav>
	
</body>
</html>