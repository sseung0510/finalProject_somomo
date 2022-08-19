<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!----------- CSS --------------->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css?version=1.0.0">
        <!----------- 아이콘 CSS 링크 ------->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
        <!----------- 아이콘 CSS 링크 version 2------->
        <title>메인 페이지</title>
    </head>
    <body>
        <!--------------------- 왼쪽 사이드 바 ------------------------>

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
                        <a href="#">
                            <i class="uil uil-estate"></i>
                            <span class="link-name">HOME</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
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
                        <a href="#" class="community">
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
            
            </div>
            <!-- 메인 피드 끝 -->
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
                        <li><a href="logout.me"><i class="uil uil-signout"></i> 로그아웃</a></li>
                    </ul>
                </i>
            </div>
        </div>
        <!-- 오른쪽 사이드 바 -->
        <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    </body>
</html>