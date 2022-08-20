<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <!----------- CSS --------------->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feedstyle2.css?ver=1.1.4">
   <!----------- 아이콘 CSS 링크 ------->
   <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
   <!----------- 아이콘 CSS 링크 version 2------->
   <!-- Boxicons CSS -->
   <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
   
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- Bootstrap-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>메인 페이지</title>
<style>
	body{
		position : relative;
	}
	#updateBtn{
		width:150px;
		height:35px;
		background-color:#FCD9D7;
		border:1px solid #FEC8C6;
		border-radius:5px;
		margin-top:30px;
		margin-left:120px;
	}
	#updateBtn:hover{
		background-color:#FEC8C6;
	}
	
    .form-group{
    	margin-top:20px;
    }
	.card{
		border:2px solid rgba(252, 217, 215, .9);
		border-radius:10px;
		display: flex;
	}
	.img-cover{
		display: flex;
		justify-content: center;
	}
	.card-img-top{
		width:500px;
		height:500px;
		
	}
	.card-body{
		background-color:rgba(252, 217, 215, .4);
		padding-left:10%;
		padding-top:5%;
		height:250px;
	}
	.card-title{
		font-weight:bold;
		display:inline-block;	
	}
	</style>
</head>
<body>
	<!--------------------- 왼쪽 사이드 바 ------------------------>
	<jsp:include page="memberCommon/memberLeftSidebar.jsp"/>
	<!--------------------- 왼쪽 사이드 바 끝 ------------------------>

	<!----------- 헤더 , 메인 컨텐츠 ---------->
	<section class="main-content">
		<!------- 헤더 --------->
		<div class="top">
			<i class="uil uil-bars sidebar-toggle"></i>

			<div class="search-box">
            	<i class="uil uil-search"></i>
                <input type="text" placeholder="검색">
            </div>
		</div>
        <!------- 헤더 끝--------->



		<!------ 메인 피드----------->
        <div class="main-feed">
           	
           	
			<!-----------글 목록 띄워지는 공간----------->
			<div class="card">
				<div class="img-cover">
					<img class="card-img-top" src="${loginUser.profileImg }" alt="Card image">
				</div>
				<div class="card-body">
					<h2 class="card-title">${loginUser.nickname}</h2>
					<h5 class="card-title">(${loginUser.userId})</h5> <br>
					<span class="card-text">${loginUser.age} / </span>
					<c:choose>
						<c:when test="${loginUser.gender eq 'F'}">
							<span class="card-text">여성</span>
						</c:when>
						<c:otherwise>
							<span class="card-text">남성</span>
						</c:otherwise>
					</c:choose> 
					<br><br>
					<p class="card-text">${loginUser.email}</p>
					<p class="card-text">${loginUser.phone}</p>
					<p class="card-text">${loginUser.enrollDate}</p>
					
				</div>
			</div>
        </div>
        <!------ 메인 피드 끝----------->
        
    <!----------- 헤더 , 메인 컨텐츠 끝---------->        
    </section>

    <!------ 오른쪽 사이드 바 --------->
    <div class="right-sidebar">
        <div class="right-top">
            <i class="uil uil-bell"></i>
            <i class="uil uil-comment-dots"></i>
            <i class="uil uil-user-circle profile">
                <ul class="profile-link">
                    <li><a href=""><i class="uil uil-user-circle"></i> 프로필</a></li>
                    <li><a href=""><i class="uil uil-setting"></i> Settings</a></li>
                    <li><a href=""><i class="uil uil-signout"></i> 로그아웃</a></li>
                </ul>
            </i>
        </div>
		<div class="right-main">
			<jsp:include page="myLikes_Favorites.jsp"/>
		</div>
    </div>
    <!-- 오른쪽 사이드 바 끝-->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
	
</body>
</html>