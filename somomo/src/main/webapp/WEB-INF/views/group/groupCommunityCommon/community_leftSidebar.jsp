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
			</ul>
		</div>

		<div class="nav-col">
			<h3 class="m1">관리중인그룹</h3>
			<div class="myGroup adminGroup"></div>

			<h3 class="m2">가입한 그룹</h3>
			<div class="myGroup memberGroup"></div>                
		</div>
		
		<c:forEach var="mg" items="${myGroupList}">
			<script>
                var result = '<div class="nav-group-list">'
                                + '<input type="hidden" value="${mg.groupNo}">'
                                + '<img src="${mg.groupImg}" alt="">'
                                + '<span class="admingroup-name">${mg.groupName}</span>'
                            + '</div>';


                if('${mg.userRank}' == 'A'){
                    $('.adminGroup').append(result);
                } 
                else{
                    $('.memberGroup').append(result);
                }
            </script>
		</c:forEach>
		
        <script>
            
            $('.adminGroup').css({'disply':'flex', 'flex-direction':'column', 'width':'100%'})
            $('.memberGroup').css({'disply':'flex', 'flex-direction':'column', 'width':'100%'})
            
            var guide = "";

            if($('.adminGroup').html() == ""){
                guide = "<br><span>현재 관리중인 그룹이 없습니다.</span><br>";
                $('.adminGroup').append(guide);
            }
            if($('.memberGroup').html() == ""){
                guide = "<br><span>가입한 그룹이 없습니다.</span><br>";
                $('.memberGroup').append(guide);
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