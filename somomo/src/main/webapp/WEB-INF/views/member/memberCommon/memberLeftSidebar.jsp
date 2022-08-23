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
					<a href="chat.ch">
						<i class="uil uil-comment"></i>
						<span class="link-name">CHAT</span>
					</a>
				</li>
				<li>
					<a href="groupRoom.gr">
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
				
			
				<!-- 나중에 margin으로 조절-->
				<br><br><br><br>
				
				<li>
					<a href="updateInfo.me" class="community">
						<i class="uil uil-clipboard-notes"></i>
						<span class="link-name">정보 변경</span>
					</a>
				</li>
				
				<c:if test="${loginUser.kakaoLogin eq 'N' }">
					<li>
						<a href="updatePwd.me" class="">
							<i class="uil uil-lock-open-alt"></i>
							<span class="link-name">비밀번호 변경</span>
						</a>
					</li>
				</c:if>
				
				<li>
					<a href="deleteMem.me" class="">
						<i class="uil uil-user-minus"></i>
						<span class="link-name">회원탈퇴</span>
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