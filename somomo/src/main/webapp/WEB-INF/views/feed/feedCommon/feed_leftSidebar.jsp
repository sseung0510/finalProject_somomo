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
				<a href="main.fd">
					<img src="${pageContext.request.contextPath}/resources/img/web_logo.jpg" alt="peach">
				</a>
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
					<a href="chat.ch">
						<i class="uil uil-comment"></i>
						<span class="link-name">CHAT</span>
					</a>
				</li>
				<li>
					<a href="groupRoom.gr" class="community">
						<i class="uil uil-comments"></i>
						<span class="link-name">Community</span>
					</a>
				</li>
				<li>
					<a href="myPage.me">
						<i class="uil uil-user"></i>
						<span class="link-name">My Page</span>
					</a>
				</li>
				
				<!-- 로그인 유저 정보 나타내기 -->
				<li>
					<a href="javascript:void(0);" class="loginProfile">
						<img src="${loginUser.profileImg}">
						<span class="login-profile">${loginUser.nickname}<br>@${loginUser.userId}</span>
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
				
				<li class="mode">
						<a href="#">
							<i class="uil uil-moon"></i>
							<span class="link-name">Dark Mode</span>
						</a>
						<div class="mode-toggle">
						<span class="switch"></span>
					</div>
				</li>
			</ul>
		</div>
	</nav>
	
</body>
</html>