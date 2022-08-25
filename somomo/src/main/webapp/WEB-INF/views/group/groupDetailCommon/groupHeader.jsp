<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wrapper">
    <div>
        <header>
            <div class="web-header">
                <div class="logo-name">
                    <div class="logo-image">
                        <a href="groupRoom.gr"><img src="resources/img/web_logo.jpg" alt=""></a>
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
            </div>

            <div class="group-header">
                <div class="main-header">
                    <ul class="main-header-bar">
                        <li class="forward">
                            <a onclick="postForm(1);"><span class="header-name">게시글</span></a>
                        </li>
                        <li class="forward">
                            <a onclick="postForm(2);"><span class="header-name">사진첩</span></a>
                        </li>
                        <li class="forward">
                            <a onclick="postForm(3);"><span class="header-name">일정</span></a>
                        </li>
                        <!-- <li class="forward">
                            <a onclick="postForm(4);"><span class="header-name">멤버</span></a>
                        </li> -->
                    </ul>
                </div>
            </div>
        </header>
    </div>
</div>




<form id="postForm" method="post" action="">
    <input type="hidden" name="groupNo" value="${g.groupNo}">
    <input type="hidden" name="gno" value="${g.groupNo}">
</form>

<script>
    function postForm(num){
        switch(num){
            case 1 : $('#postForm').attr('action', 'detail.gr').submit();
            break;
            case 2 : $('#postForm').attr('action', 'gallery.gr').submit();
            break
            case 3 : $('#postForm').attr('action', 'calendar.gr').submit();
            break 
            case 4 : $('#postForm').attr('action', 'member.gr').submit();
        }
    }
</script>
