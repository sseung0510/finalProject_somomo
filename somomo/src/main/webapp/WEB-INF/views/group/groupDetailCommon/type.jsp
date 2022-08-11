<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!----------- CSS --------------->
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.0.0">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<title>Insert title here</title>
</head>
<body>
	<!--------------------- 헤더 ------------------------>
    <div class="wrapper">
        <div>
            <header>
                <div class="logo-name">
                    <div class="logo-image">
                        <a href="main.fd"><img src="resources/img/web_logo.jpg" alt=""></a>
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
		<jsp:include page="leftSidebar.jsp"/>
		

        <div class="main-middle">
            
            <div class="type-container">
                <div class="type-header">
                    밴드 공개
                </div>

                <br>
                <br>

                <form action="udateType.gr">
                    <div class="type-body">
                        <div class="groupType">
                            <div class="groupType-col">
                                <input id="private" type="radio" name="groupType" value="C">
                                <label for="private">비공개 그룹</label>
                            </div>
                            <div class="groupType-desc">그룹과 게시글이 공개되지 않습니다. 초대를 통해서만 가입할 수 있습니다.</div>
                        </div>
    
                        <br>
                        <br>
    
                        <div class="groupType">
                            <div class="groupType-col">
                                <input id="public" type="radio" name="groupType" value="B">
                                <label for="public">그룹명 공개 그룹</label>
                            </div>
                            <div class="groupType-desc">누구나 그룹을 검색으로 찾아 그룹 소개를 볼 수 있지만, 게시글은 멤버만 볼 수 있습니다.</div>
                        </div>
    
                        <br>
                        <br>
                    
                        <div class="groupType">
                            <div class="groupType-col">
                                <input id="public-toAll" type="radio" name="groupType" value="A">
                                <label for="public-toAll">공개 그룹</label>
                            </div>
                            <div class="groupType-desc">누구나 그룹을 검색해 찾을 수 있고, 그룹 소개와 게시글을 볼 수 있습니다.</div>
                        </div>
                    </div>

                    <div>
                        <button type="submit">저장</button>
                    </div>
                </form>
            </div>
        <!---------------------- 글쓰기 Modal 창 --------------------->    
            <jsp:include page="modal.jsp"/>
		
        </div>
        
        
        
        <!---------------------- 오른쪽 사이드 바 --------------------->
        <jsp:include page="rightSidebar.jsp"/>
    </div>
</body>
</html>