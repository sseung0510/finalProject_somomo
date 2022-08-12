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
    <link rel="stylesheet" href="resources/css/header.css?ver=1.0.1">
    <link rel="stylesheet" href="resources/css/groupList.css?ver=1.3.3">
    <link rel="stylesheet" href="resources/css/applyModal.css?ver=1.0.2">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
    <title>그룹리스트</title> 
</head>
<body>
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
    
                <div class="create-newGroup">
                    <a href="insertForm.gr">
                        <button class="learn-more">
                            <i class="uil uil-plus"></i>
                            <span class="circle"></span>
                            <span class="button-text">새그룹 만들기</span>
                        </button>
                    </a>
                </div>

                <div class="horizontal"></div>

            </div>

            <div class="nav-col">
                <h2 class="m1">관리중인그룹</h2>
                <div class="adminGroup"></div>
                
                <div class="horizontal"></div>

                <h2>가입한 그룹</h2>
                <div class="memberGroup"></div>                
            </div>
        </nav>
		
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
                guide = "<span>현재 관리중인 그룹이 없습니다.</span>";
                $('.adminGroup').append(guide);
            }
            else if($('.memberGroup').html() == ""){
                guide = "<span>가입한 그룹이 없습니다.</span>";
                $('.memberGroup').append(guide);
            }
        </script>
		
		
		<!-- 메인  (그룹방 리스트) -->
        <main class="content">
            <div class="list-outer">
                <div class="tag-group">
                    <ul class="tag-body">
                        <li class="all-category-list">그룹 전체</li>
                        <c:forEach var="gc" items="${cList}">
                        <li class="category-list" value="${gc.categoryName}">#${gc.categoryName}</li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="group-outer">
                
                </div>
            </div>
        </main>
    
    
    
    
    <script>
    	<!--무한스크롤 페이징-->
	    $(function(){
			let currentPage = ${pi.currentPage};
			console.log('시작:'+currentPage);
			selectGroupList(currentPage);
			
			//스크롤 할 때마다 호출되는 함수
			$(window).on('scroll', function(){
				if(${pi.maxPage eq 0}){
					return; //등록된 게시글이 없을 경우 종료
				}
				//위로 스크롤된 길이
				let scrollTop = $(window).scrollTop();
				//웹 브라우저 창의 높이
				let windowHeight = $(window).height();
				//문서 전체의 높이
				let documentHeight = $(document).height();
				//바닥까지 스크롤
				let isBottom = scrollTop + windowHeight  >= documentHeight;
				
				if(isBottom){
					if(currentPage == ${pi.maxPage}){
						return; //마지막 페이지라면 끝
					}
					
					currentPage ++;//요청 페이지 번호 1증가
					
					selectGroupList(currentPage);
				
				}
	    	});
	    });
	    
	    <!-- 그룹 리스트 ajax -->
	    function selectGroupList(currentPage){
	    	
	    	console.log('요청'+currentPage);
	    	
	    	$.ajax({
	    		url:'list.gr',
	    		method:'POST',
	    		data : {
    				userId : '${loginUser.userId}',
    				cpage : currentPage
    			},
    			success : function(result){
    				
    				$('.group-outer').append(result);
    				
    				
	    			//카테고리 클릭시 카테고리별 리스트 ??????? 고민중
   					/*$('.tag-group ul li').click(function(){
   						
	    				//클릭하는 li의 catgoryNo와 게시물의 categoryNo가 같다면  ????
	    				if('${g.categoryNo}' == $(this).val()){ 
	    					$('.group-outer *').remove();
		    				$('.group-outer').append(result);
	    				}
	    				
   					})*/
   					
    					
    				//관리자면 게시글 삭제 가능
    				
    			}
	    	});
	    }
	    
    </script>
    
    <script>
    	
        $('.nav-group-list').click(function(){
            location.href = "detail.gr?gno=" + $(this).children().eq(0).val();
        })
    </script>

	</section>
    </body>
</html>
