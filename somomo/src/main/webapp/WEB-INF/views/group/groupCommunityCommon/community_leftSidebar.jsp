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
				<a href="main.fd">
					<img src="${pageContext.request.contextPath}/resources/img/web_logo.jpg" alt="peach">
				</a>
			</div>
			<span class="logo_name">SoMoMo</span>
		</div>
		
		<div class="menu-items">
			<ul class="nav-links">
				<li>
					<a href="insertForm.gr">
						<i class="uil uil-plus"></i>
						<span class="link-name">Create Group</span>
					</a>
				</li>
				<li>
					<a href="groupRoom.gr">
						<i class="fas fa-clipboard-list"></i>
						<span class="link-name">Group List</span>
					</a>
				</li>
				<li>
					<a onclick="privateJoinModal();" style="cursor: pointer;">
						<i class="fa-solid fa-key"></i>
						<span class="link-name">Join Group</span>
					</a>
				</li>
			</ul>
		</div>

		<div class="nav-col">
			<div class="manage-area">
				<div class="manage-title">
					<i class="fa-solid fa-crown"></i>
					<span class="title-name">관리중인 그룹</span>
				</div>
				<ul class="group-list g1"></ul>
			</div>
			<div class="manage-area">
				<div class="manage-title">
					<i class="fa-solid fa-user-group"></i>
					<span class="title-name">가입한 그룹</span>
				</div>
				<ul class="group-list g2"></ul>
			</div>
		</div>
		
		<c:forEach var="mg" items="${myGroupList}">
			<script>
                var result = '<li data-gno="${mg.groupNo}">'
							+	'<div class="nav-group-list">'
							+		'<div class="img-div">'
							+			'<img src="${mg.groupImg}" alt="" >'
							+		'</div>'
							+		'<input type="hidden" value="${mg.groupNo}">'
							+		'<span class="admingroup-name">'+ '${mg.groupName}' +'</span>'
							+	'</div>'
							+'</li>';


                if('${mg.userRank}' == 'A'){
                    $('.g1').append(result);
                } 
                else{
                    $('.g2').append(result);
                }
            </script>
		</c:forEach>
		
        <script>
            
			var guide1 = '<div class="no-group">'
						+ 	'<div class="no-img-div">'
						+		'<img src="resources/img/apeach2.png" alt="">'
						+	'</div>'
						+	'<span>관리중인 그룹이 없어요...</span>'
						+'</div>';

            var guide2 = '<div class="no-group">'
						+ 	'<div class="no-img-div">'
						+		'<img src="resources/img/apeach.png" alt="">'
						+	'</div>'
						+	'<span>가입한 그룹이 없어요...</span>'
						+'</div>';

            if($('.g1').html() == ""){
                $('.g1').append(guide1);
            }
            if($('.g2').html() == ""){
                $('.g2').append(guide2);
            }
        </script>

		<div class="menu-items">
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