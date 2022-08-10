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
    <link rel="stylesheet" href="resources/css/style2.css?ver=1.0.3">
    <!----------- 아이콘 CSS 링크 ------->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <script src="https://kit.fontawesome.com/567fbbaed5.js" crossorigin="anonymous"></script>
    <!----------- 아이콘 CSS 링크 version 2------->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>소모모 - ${gr.groupName}</title> 
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
		<jsp:include page="groupDetailCommon/leftSidebar.jsp"/>
		
		
		
		<script>
			function postFormSubmit(){
				$('#postForm').attr('action', 'setting.gr').submit();
			}
		</script>

        <div class="main-middle">
        
        
		  <!---------------------- 글쓰기 Modal 창 --------------------->
             
             <jsp:include page="groupDetailCommon/modal.jsp"/>
		
           
             
            <c:choose>
                <c:when test="${not empty fList}">
                    <div class="feed-profile">
                        <img src="../src/img/kh.jpeg">
                        <div>
                            <p>Test</p>
                            <small>지금 막</small>
                        </div>
                        <div class="form-icon">
                            <i class='bx bx-dots-vertical-rounded feed'>
                                <ul class="feed-link">
                                    <li><a href=""> 글 수정</a></li>
                                    <li><a href="">삭제하기</a></li>
                                    <li><a href="">공지로 등록</a></li>
                                </ul>
                            </i>
                        </div>
                    </div>

                    <div class="feed-content">
                        8월 2일 로즈애플입니다  <br>
                        🏖 8/7~8/9 휴무 <br>
                            👉 가락공판장 휴가에 맞춰 저희도 쉬어갑니다 <br>
                            👉 휴가 갈 생각에 벌써부터 설래 설램  <br>
                        📢 오늘의특가 <br>
                    </div>

                    <div class="postCount">
                        <div class="postCountLeft">
                            <span class="likeCountBtn"><img src="../src/img/redheart.png">좋아요
                                <span class="likeCount">2</span>
                            </span>
                        
                            <span class="commentCountBtn">댓글
                                <span class="commentCount">2</span>
                                <i class="uil uil-angle-up"></i>
                            </span>
                        </div>
                        <div class="postCountRight">
                            <i class="uil uil-heart"></i>
                        </div>
                    </div>

                    <div class="commentBox">
                        <div class="commnetWrap">
                            <div class="writeInfo">몽키스패너
                                <a class="upProfile">
                                    <span class="upProfileImg">
                                        <img src="../src/img/food.jpeg">
                                    </span>
                                </a>
                            </div>
                            <div class="text">몽키스패너 특가로 구매했어요!!!
                                <div class="twiceComment">
                                    <time class="time">8월 2일 오후 5:20</time>
                                    <div class="reply-replyBtn">답글쓰기</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-content">
                        <div class="group-board">
                            <i class="uil uil-clipboard-alt"></i>
                        </div>
                        <div class="board-text">
                            <h3>그룹게시판</h3>
                            <small>첫 게시글을 작성해보세요  <br>
                            나와 멤버가 쓴 글이 여기에 표시됩니다.</small>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        
        
        <!---------------------- 오른쪽 사이드 바 --------------------->
        <jsp:include page="groupDetailCommon/rightSidebar.jsp"/>
        
        
        
        

    </div>
    
    
     <form method="post" id="postForm">
             <input type="hidden" name="groupNo" value="${gr.groupNo}"/>
      </form>

    <script src="resources/js/GroupDetail.js"></script>
</body>
</html>
