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
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.0">
    <link rel="stylesheet" href="resources/css/groupList.css?ver=1.1.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <title>그룹리스트</title> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <div class="wrapper">
        <div>
            <header>
                <div class="logo-name">
                    <div class="logo-image">
                        <a href="index.html"><img src="resources/img/web_logo.jpg" alt=""></a>
                    </div>
                    <span class="logo_name">SoMoMo</span>
                </div>
        
                <div class="top">
                    <form action="">
                        <div class="search-box">
                            <button type="submit"><i class="uil uil-search"></i></button>
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

    <section>
        <nav>
            <div class="nav-col">
                <h1 class="nav-title">Group</h1>
                <div class="nav-col-group">
                    <i class="fas fa-clipboard-list"></i>
                    <span>그룹 목록</span>
                </div>
                <div class="nav-col-group">
                    <i class="uil uil-search"></i>
                    <span>찾아보기</span>
                </div>
    
                <div class="create-newGroup"><a href="insertForm.gr">새 그룹 만들기</a></div>
                <div class="horizontal"></div>
            </div>

            <div class="nav-col">
                <h2>관리중인그룹</h2>
                <c:forEach var="gl" items="${myGroupList}">
                    <div class="nav-col-group">
                        <input type="hidden" value="${gl.groupNo}">
                        <img src="${gl.groupImg}" alt="">
                        <span>${gl.groupName}</span>
                    </div>
                </c:forEach>
                
                <!--...............아 진짜 똑같아서 바꾸고 싶다................ -->
                <div class="horizontal"></div>

                <h2>가입한 그룹</h2>
                <c:forEach var="jl" items="${myJoinList}">
                    <div class="nav-col-group">
                        <input type="hidden" value="${jl.groupNo}">
                        <img src="${jl.groupImg}" alt="">
                        <span>${jl.groupName}</span>
                    </div>
                </c:forEach>
            </div>
        </nav>
		
        <main class="content">
            
            <div class="list-outer">
                <div class="tag-group">
                    <ul class="tag-body">
                        <li class="category-list">그룹 전체</li>
                        <li class="category-list">#개발</li>
                        <li class="category-list">#여행</li>
                        <li class="category-list">#운동</li>
                    </ul>
                </div>

                <div class="group-outer">

                    <c:forEach var="g" items="${list}">
                        <div class="group">
                            <input type="hidden" value="${g.groupNo}">
                            <div class="group-header">
                                <img src="${g.groupImg}" alt="rover" />
                            </div>
                            <div class="group-body">
                                <span class="tag tag-development">${g.categoryNo}</span>
                                <h4>
                                    ${g.groupName}
                                </h4>
                                <div class="group-info">
                                    <span class="group-member">멤버 ${g.memberCount}명</span>
                                    <span>${g.groupType}</span>
                                </div>
                            </div>
                            <div class="group-foot">
                                <div class="group-btn">
                                    <button>그룹 가입</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
        </main>
    </section>
    
    <script>
        $('.group').click(function(){
            const groupNo = $(this).children().eq(0).val();

            location.href = "groupDetail.gr?groupNo=" + groupNo;
        })

        $('.nav-col-group').click(function(){
            const groupNo = $(this).children().eq(0).val();

            location.href = "groupDetail.gr?groupNo=" + groupNo;
        })
    </script>


    </body>
</html>
