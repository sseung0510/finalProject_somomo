<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>       
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/style2.css">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <title>소모모</title> 
</head>
<body>

 
	

    <!--------------------- 헤더 ------------------------>
    <div class="wrapper">
        <div>
            <header>
                <div class="logo-name">
                    <div class="logo-image">
                        <img src="resources/img/web_logo.jpg" alt="">
                    </div>
                    <span class="logo_name">SoMoMo</span>
                </div>
        
                <div class="top">
                    <form action="">
                        <div class="search-box">
                            <i class="uil uil-search"></i>
                            <input type="text" placeholder="검색">
                        </div>
                    </form>
                </div>
    
                <ul class="menu-list">
                    <li><a href=""><i class="uil uil-bell"></i></a></li>
                    <li><a href=""><i class="uil uil-comment-dots"></i></a></li>
                    <li><a href=""><i class="uil uil-user"></i></a></li>
                </ul>
            </header>
        </div>
    </div>

    <!----------------------- 메인 컨텐츠 ------------------------------>
    <div class="main-section">
        <!-------------------- 메인 컨텐츠 헤더 --------------------->
        <div class="main-header-container">
            <div class="main-header">
                <ul class="main-header-bar">
                    <li class="forward">
                        <a href=""><span class="header-name">게시글</span></a>
                    </li>
                    <li class="forward">
                        <a href=""><span class="header-name">사진첩</span></a>
                    </li>
                    <li class="forward">
                        <a href=""><span class="header-name">일정</span></a>
                    </li>
                    <li class="forward">
                        <a href=""><span class="header-name">멤버</span></a>
                    </li>
                </ul>
            </div>
        </div>

        <!-------------------- 메인 컨텐츠 헤더 끝--------------------->
        
        
        <!-------------------- 왼쪽 사이드 바--------------------->
       <jsp:include page="groupDetailCommon/leftSidebar.jsp"/>
       
       
       

        <!------------------ 그룹 설정 ---------------------->
        <div class="main-middle">
       
		 	 <!---------------------- 글쓰기 Modal 창 --------------------->
           
		
		 	 <jsp:include page="groupDetailCommon/modal.jsp"/>
       
		 	 
		 	 
		 	 
            <div class="setting">
                <div class="setting-title">
                    <h3>그룹 설정</h3>
                </div>

                <div class="setting-container">
                    <ul class="setting-list">
                        <li class="setting-item">
                            <div class="itemContent">
                                <span class="label">그룹 이름 및 커버</span>
                            </div>
                            <div class="itemSide">
                                <a href="">
                                    변경
                                </a>
                            </div>
                        </li>
                        <li class="setting-item">
                            <div class="itemContent">
                                <span class="label">그룹 공개</span>
                                <span class="label-data">공개</span>
                            </div>
                            <div class="itemSide">
                                <a href="">
                                    변경
                                </a>
                            </div>
                        </li>
                        <li class="setting-item">
                            <div class="itemContent">
                                <span class="label">그룹 탈퇴</span>
                            </div>
                            <div class="itemSide delete">
                                <a href="">
                                    탈퇴하기
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
            
            
		
		
		
		
		
		
		
    </div>
    
     <!---------------------- 오른쪽 사이드 바 --------------------->
		<jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
    
   </div>
    
    
</body>
</html>
